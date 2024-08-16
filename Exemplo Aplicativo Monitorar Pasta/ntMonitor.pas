unit ntMonitor;

interface

uses
  System.SysUtils, System.Classes, Vcl.Forms, Vcl.Controls, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.IOUtils, Winapi.Windows, Winapi.Messages,
  Vcl.StdCtrls, Vcl.Dialogs, Vcl.Buttons, System.IniFiles, System.Types,
  System.Generics.Collections, System.DateUtils,Registry;

const
  WM_DIRECTORYCHANGE = WM_USER + 1;
  IniFileName = 'monitoramento.ini'; // Nome do arquivo INI
  IniSection = 'Configuração';
  IniKey = 'Diretorio';
  IniStatus = 'Estado de monitoramento';
  IniStart = '1';
  IniStop = '0';
  IniStatusCheckWin = 'Iniciar com Windows';
  iniCheckWinStart = '1';
  iniCheckWinStop = '0';

type
  TFileNotificationRecord = record
    FileName: string;
    LastNotificationTime: TDateTime;
  end;

  TFileNotificationList = TList<TFileNotificationRecord>;

  TFileNotifyInformation = packed record
    NextEntryOffset: DWORD;
    Action: DWORD;
    FileNameLength: DWORD;
    FileName: WideChar;
  end;

  PFileNotifyInformation = ^TFileNotifyInformation;

  TMonitorThread = class(TThread)
  private
    FDirectoryHandle: THandle;
    FNotificationList: TFileNotificationList;
    FBaseDirectory: string;
    const
      NotificationInterval = 1; // Tempo em segundos
    procedure ProcessNotification(const Notify: TFileNotifyInformation);
    function IsNotificationRecent(const FileName: string): Boolean;
    procedure AddNotificationToHistory(const FileName: string);
    function GetFileAction(Action: DWORD): string;
  protected
    procedure Execute; override;
  public
    constructor Create(const Directory: string);
    destructor Destroy; override;
  end;

  TForm1 = class(TForm)
    TrayIcon: TTrayIcon;
    Timer: TTimer;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    mmo1: TMemo;
    btnControl: TBitBtn;
    dtDir: TEdit;
    btDir: TBitBtn;
    lb1: TLabel;
    chkWindows: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure btnControlClick(Sender: TObject);
    procedure TrayIconClick(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure chkWindowsClick(Sender: TObject);
  private
    FMonitorThread: TMonitorThread;
    FMonitoring: Boolean;
    procedure UpdateMemo(const Msg: string);
    procedure LoadSettings;
    procedure SaveSettings;
    procedure MinimizeToTray;
    procedure RestoreFromTray;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure AddToStartup;
var
  Reg: TRegistry;
  ExePath: string;
begin
  Reg := TRegistry.Create(KEY_WRITE);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', True) then
    begin
      ExePath := ParamStr(0);  // Caminho do executável da aplicação
      Reg.WriteString('NomeDaSuaAplicacao', ExePath);
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;

procedure RemoveFromStartup;
var
  Reg: TRegistry;
begin
  Reg := TRegistry.Create(KEY_WRITE);
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('Software\Microsoft\Windows\CurrentVersion\Run', False) then
    begin
      if Reg.ValueExists('NomeDaSuaAplicacao') then
        Reg.DeleteValue('NomeDaSuaAplicacao');
    end;
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
  end;


function GetExecutablePath: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

function GetIniFilePath: string;
begin
  Result := TPath.Combine(GetExecutablePath, IniFileName);
end;

function LoadIniValue(const Section, Key, Default: string): string;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(GetIniFilePath);
  try
    Result := IniFile.ReadString(Section, Key, Default);
  finally
    IniFile.Free;
  end;
end;

procedure SaveIniValue(const Section, Key, Value: string);
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(GetIniFilePath);
  try
    IniFile.WriteString(Section, Key, Value);
  finally
    IniFile.Free;
  end;
end;

function ConditionalValue(const Condition: Boolean; const TrueValue, FalseValue: string): string;
begin
  if Condition then
    Result := TrueValue
  else
    Result := FalseValue;
end;

{ TMonitorThread }

constructor TMonitorThread.Create(const Directory: string);
begin
  inherited Create(False);
  FreeOnTerminate := True;
  FNotificationList := TFileNotificationList.Create;
  FBaseDirectory := Directory;

  FDirectoryHandle := CreateFile(
    PChar(Directory),
    FILE_LIST_DIRECTORY,
    FILE_SHARE_READ or FILE_SHARE_WRITE or FILE_SHARE_DELETE,
    nil,
    OPEN_EXISTING,
    FILE_FLAG_BACKUP_SEMANTICS or FILE_FLAG_OVERLAPPED,
    0
  );

  if FDirectoryHandle = INVALID_HANDLE_VALUE then
    RaiseLastOSError;
end;

destructor TMonitorThread.Destroy;
begin
  if FDirectoryHandle <> INVALID_HANDLE_VALUE then
    CloseHandle(FDirectoryHandle);
  FNotificationList.Free;
  inherited;
end;

procedure TMonitorThread.ProcessNotification(const Notify: TFileNotifyInformation);
var
  FileName: string;
  FileNameBuffer: array[0..255] of WideChar;
  NotificationAction: string;
begin
  if Notify.FileNameLength > Length(FileNameBuffer) * SizeOf(WideChar) then
  begin
    Synchronize(procedure begin
      Form1.UpdateMemo('Nome do arquivo muito grande para o buffer.');
    end);
    Exit;
  end;

  Move(Notify.FileName, FileNameBuffer[0], Notify.FileNameLength);
  FileNameBuffer[Notify.FileNameLength div SizeOf(WideChar)] := #0;

  FileName := WideCharToString(FileNameBuffer);
  FileName := TPath.Combine(FBaseDirectory, FileName);

  if not IsNotificationRecent(FileName) then
  begin
    AddNotificationToHistory(FileName);

    NotificationAction := GetFileAction(Notify.Action);

    Synchronize(procedure begin
      Form1.UpdateMemo(Format('Arquivo ou pasta %s: %s', [NotificationAction, FileName]));

      if not Form1.Visible then
      begin
        Form1.TrayIcon.BalloonHint := Format('Arquivo ou pasta %s: %s', [NotificationAction, FileName]);
        Form1.TrayIcon.ShowBalloonHint;
      end;
    end);
  end;
end;

function TMonitorThread.GetFileAction(Action: DWORD): string;
begin
  case Action of
    FILE_ACTION_ADDED: Result := 'adicionado';
    FILE_ACTION_REMOVED: Result := 'removido';
    FILE_ACTION_MODIFIED: Result := 'modificado';
    FILE_ACTION_RENAMED_OLD_NAME: Result := 'renomeado de';
    FILE_ACTION_RENAMED_NEW_NAME: Result := 'renomeado para';
  else
    Result := 'ação desconhecida';
  end;
end;

function TMonitorThread.IsNotificationRecent(const FileName: string): Boolean;
var
  Notification: TFileNotificationRecord;
begin
  Result := False;
  for Notification in FNotificationList do
  begin
    if (Notification.FileName = FileName) and
       (SecondsBetween(Now, Notification.LastNotificationTime) < NotificationInterval) then
    begin
      Result := True;
      Break;
    end;
  end;
end;

procedure TMonitorThread.AddNotificationToHistory(const FileName: string);
var
  Notification: TFileNotificationRecord;
begin
  Notification.FileName := FileName;
  Notification.LastNotificationTime := Now;
  FNotificationList.Add(Notification);
end;

procedure TMonitorThread.Execute;
var
  Buffer: array[0..1023] of Byte;
  BytesReturned: DWORD;
  I: Integer;
  Notify: PFileNotifyInformation;
begin
  while not Terminated do
  begin
    try
      if ReadDirectoryChangesW(
        FDirectoryHandle,
        @Buffer,
        SizeOf(Buffer),
        True,
        FILE_NOTIFY_CHANGE_FILE_NAME or FILE_NOTIFY_CHANGE_DIR_NAME or
        FILE_NOTIFY_CHANGE_ATTRIBUTES or FILE_NOTIFY_CHANGE_SIZE or
        FILE_NOTIFY_CHANGE_LAST_WRITE,
        @BytesReturned,
        nil,
        nil
      ) then
      begin
        I := 0;
        while I < BytesReturned do
        begin
          Notify := PFileNotifyInformation(@Buffer[I]);

          ProcessNotification(Notify^);

          if Notify.NextEntryOffset = 0 then
            Break;

          I := I + Notify.NextEntryOffset;
        end;
      end
      else
      begin
        Synchronize(procedure begin
          Form1.UpdateMemo('Erro ao ler as mudanças de diretório.');
        end);
        Sleep(1000); // Aguarda 1 segundo antes de tentar novamente
      end;
    except
      on E: Exception do
      begin
        Synchronize(procedure begin
          Form1.UpdateMemo('Exceção na thread: ' + E.Message);
        end);
        Sleep(1000); // Aguarda 1 segundo antes de tentar novamente
      end;
    end;
  end;
end;

{ TForm1 }

procedure TForm1.chkWindowsClick(Sender: TObject);
begin
  if chkWindows.Checked then
    begin
      AddToStartup;
      SaveIniValue(IniSection, IniStatusCheckWin,'1');
    end
  else
    begin
      RemoveFromStartup;
      SaveIniValue(IniSection, IniStatusCheckWin,'0');
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  pgc1.ActivePageIndex := 0;
  TrayIcon.Visible := True;
  TrayIcon.BalloonHint := 'Pasta de monitoramento...';
  TrayIcon.BalloonTimeout := 5000;

  Timer.Interval := 1000;
  Timer.Enabled := False;

  mmo1.Clear;

  LoadSettings;
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  if WindowState = wsMinimized then
  begin
    MinimizeToTray; // Esconde a janela e mostra o ícone na bandeja do sistema
  end;
end;

procedure TForm1.btnControlClick(Sender: TObject);
begin
  if FMonitoring then
  begin
    if Assigned(FMonitorThread) then
    begin
      FMonitorThread.Terminate;
      FMonitorThread.WaitFor;
      FMonitorThread := nil; // Libera a referência para evitar problemas de memória
    end;
    FMonitoring := False;
    btnControl.Caption := 'Iniciar monitoramento';
    SaveSettings;
  end
  else
  begin
    if Trim(dtDir.Text) = '' then
    begin
      ShowMessage('Por favor, selecione um diretório primeiro.');
      Exit;
    end;

    if DirectoryExists(dtDir.Text) then
    begin
      FMonitorThread := TMonitorThread.Create(dtDir.Text);
      FMonitoring := True;
      btnControl.Caption := 'Parar monitoramento';
      mmo1.Lines.Add('Monitorando alterações de pasta...');
      SaveSettings;
    end
    else
    begin
      ShowMessage('Diretório não encontrado.');
    end;
  end;
end;

procedure TForm1.UpdateMemo(const Msg: string);
begin
  mmo1.Lines.Add(Msg);
end;

procedure TForm1.LoadSettings;
begin
  dtDir.Text := LoadIniValue(IniSection, IniKey, '');
  chkWindows.Checked:=StrToBool(LoadIniValue(IniSection,IniStatusCheckWin,'0'));
  if LoadIniValue(IniSection, IniStatus, IniStop) = IniStart then
  begin
    if Trim(dtDir.Text) <> '' then
    begin
      FMonitoring := True;
      btnControl.Caption := 'Parar monitoramento';
      mmo1.Lines.Add('Monitorando alterações de pasta...');
      FMonitorThread := TMonitorThread.Create(dtDir.Text); // Usar o diretório carregado do INI
    end
    else
    begin
      FMonitoring := False;
      btnControl.Caption := 'Iniciar monitoramento';
    end;
  end
  else
  begin
    FMonitoring := False;
    btnControl.Caption := 'Iniciar monitoramento';
  end;
end;

procedure TForm1.SaveSettings;
begin
  SaveIniValue(IniSection, IniKey, dtDir.Text);
  SaveIniValue(IniSection, IniStatus, ConditionalValue(FMonitoring, IniStart, IniStop));
end;

procedure TForm1.MinimizeToTray;
begin
  Hide;
  TrayIcon.Visible := True;
end;

procedure TForm1.RestoreFromTray;
begin
  Show;
  WindowState := wsNormal;
  TrayIcon.Visible := False;
end;

procedure TForm1.TrayIconClick(Sender: TObject);
begin
  RestoreFromTray;
end;

procedure TForm1.TrayIconDblClick(Sender: TObject);
begin
  RestoreFromTray;
end;

end.

