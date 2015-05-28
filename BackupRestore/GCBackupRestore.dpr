program GCBackupRestore;

uses
  Classes,
  DateUtils,
  SysUtils,
  Forms,
  ADODB,
  ufrmMain in 'ufrmMain.pas' {frmMain},
  uSQLTools in '..\Parts\SQLTools\uSQLTools.pas',
  uY2KString in '..\Parts\Y2KCommon\uY2KString.pas',
  ufrmLogon in '..\Parts\SQLTools\ufrmLogon.pas' {frmLogon},
  ufrmSQLServerList in '..\Parts\SQLTools\ufrmSQLServerList.pas' {frmSQLServerList},
  uCommon in '..\Parts\Common\uCommon.pas',
  uSystemRegistryTools in '..\Parts\Registry\uSystemRegistryTools.pas',
  uErrors in '..\Parts\Errors\uErrors.pas';

{$R *.res}

const
  GCBR_PARAM_CUSTOM = '-custom';

var
  AstrFileName: String;     // for auto-backup
  AstrServer: String;
  AbCustomMode: Boolean;
  cnnResult: TADOConnection;
  lstMessages: TStringList;
  i, nError: Integer;

procedure LogWrite(info: string);
var
  ftext: textfile;
  ws: string;
begin
  AssignFile(ftext, ExtractFilePath(Application.ExeName) + '\GCBackupRestore.log');
  try
   Append(ftext);
  except
   Rewrite(ftext);
  end;
  DateTimeToString(ws, 'dd.mm.yy hh:mm:ss', Now);
  ws := ws + ' ' + info;
  Writeln(ftext, ws);
  CloseFile(ftext);
end;

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  AbCustomMode := False;
  if (ParamCount = 1) and (ParamStr(1) = GCBR_PARAM_CUSTOM) then begin
    AbCustomMode := True;
  end else if (ParamCount > 0) and (ParamCount <= 2) then begin
    // auto-backup section
    AstrFileName := ExtractFileDir(ParamStr(1)) + '\'
      + GenerateUniqueBackupFileName;
    AstrServer := ParamStr(2);
    if (AstrServer = '') then
      AstrServer := SQL_LOCAL_NAME;
    cnnResult := TADOConnection.Create(Nil);
    lstMessages := TStringList.Create;
    if ADOConnect(cnnResult, lstMessages, nError, True, AstrServer, '',
        'gcbackupoperator','j4hhf6kd') then
      GCBackup(cnnResult, AstrFileName, lstMessages);
    for i := 0 to lstMessages.Count - 1 do
      LogWrite(lstMessages[i]);
    FreeAndNil(cnnResult);
    FreeAndNil(lstMessages);
    ExitCode := 0;
    Exit;
  end;
  frmMain.SetCustomeMode(AbCustomMode);
  Application.Run;
end.
