program gcosql;
// Версия 2.2 (pva)

uses
  Windows,
  Forms,
  Controls,
  SysUtils,
  ADODB,
  gcosqlexecute in 'gcosqlexecute.pas',
  uCoder in '..\..\Parts\Security\uCoder.pas',
  gcconst in '..\..\Server\gcconst.pas',
  uSystemRegistryTools in '..\..\Parts\Registry\uSystemRegistryTools.pas',
  uDBConfigParsingThread in 'uDBConfigParsingThread.pas',
  uY2KString in '..\..\Parts\Y2KCommon\uY2KString.pas',
  uY2KCommon in '..\..\Parts\Y2KCommon\uY2KCommon.pas',
  ufrmSQLServerList in '..\..\Parts\SQLTools\ufrmSQLServerList.pas' {frmSQLServerList},
  uSQLTools in '..\..\Parts\SQLTools\uSQLTools.pas',
  ufrmLogon in '..\..\Parts\SQLTools\ufrmLogon.pas' {frmLogon},
  ufrmMain in 'ufrmMain.pas' {frmMain},
  uGCDBTools in '..\..\Parts\SQLTools\uGCDBTools.pas',
  uErrors in '..\..\Parts\Errors\uErrors.pas',
  uCrossPlatformFunctions in '..\..\Parts\CrossPlatform\uCrossPlatformFunctions.pas',
  uCommon in '..\..\Parts\Common\uCommon.pas',
  uReportManager in '..\..\Parts\Reports\uReportManager.pas',
  uReportsDataSet in '..\..\Parts\Reports\uReportsDataSet.pas',
  uReport in '..\..\Parts\Reports\uReport.pas',
  uReportColumn in '..\..\Parts\Reports\uReportColumn.pas',
  uReportColumnsDataSet in '..\..\Parts\Reports\uReportColumnsDataSet.pas',
  uReportCommon in '..\..\Parts\Reports\uReportCommon.pas',
  uReportResultsDataSet in '..\..\Parts\Reports\uReportResultsDataSet.pas',
  uDebugLog in '..\..\Parts\Debug\uDebugLog.pas';

{$R *.res}

const
  GCOSQL_MODE_CONFIGURE = 'configure';
  GCOSQL_MODE_CUSTOMCONFIGURE = 'customconfigure';
  GCOSQL_MODE_ENCODE = 'encode';
  GCOSQL_MODE_CREATEDB = 'createdatabase';
  GCOSQL_MODE_CUSTOMCREATEDB = 'customcreatedatabase';
  GCOSQL_MODE_UPDATEDB = 'updatedatabase';
  GCOSQL_MODE_EXECUTE = 'execute';

var
  frmLogon: TfrmLogon;
  str: String;
  cnnResult: TADOConnection;
begin
  ExitCode := 1;
  Application.Initialize;
  ///////////////////////////////////////////////////////////////
  // gcosql [-login] <configure | encode | runscript | createdatabase
  //        | updatedatabase> [filename1] [filename2]
  //
  // gcosql configure
  // gcosql encode source.sql destination.sqp
  // gcosql createdatabase DBConfig.xml
  // gcosql updatedatabase DBConfig.xml
  // gcosql execute script.sqp

  if (ParamStr(1) = GCOSQL_MODE_CONFIGURE) and (ParamCount = 1) then begin
    if ConfigureServer(SQL_LOCAL_NAME) then
      ExitCode := 0;
  end else if (ParamStr(2) = GCOSQL_MODE_CUSTOMCONFIGURE)
      and (ParamCount = 1) then begin
    if ConfigureServerWithLogon(str) then
      ExitCode := 0;
  end else if (ParamStr(1) = GCOSQL_MODE_ENCODE)
      and (ParamCount = 3) then begin
    if EncodeScript(ParamStr(2), ParamStr(3)) then
      ExitCode := 0;
  end else if (ParamStr(1) = GCOSQL_MODE_CREATEDB)
      and (ParamCount = 2) then begin
    frmMain := TfrmMain.Create(Application, ParamStr(2), True, False);
    if frmMain.ShowModal = mrOk then
      ExitCode := 0;
    frmMain.Free;
  end else if (ParamStr(1) = GCOSQL_MODE_CUSTOMCREATEDB)
      and (ParamCount = 2) then begin
    frmMain := TfrmMain.Create(Application, ParamStr(2), True, True);
    if frmMain.ShowModal = mrOk then
      ExitCode := 0;
    frmMain.Free;
  end else if (ParamStr(1) = GCOSQL_MODE_UPDATEDB)
      and (ParamCount = 2) then begin
      frmMain := TfrmMain.Create(Application, ParamStr(2), False, True);
    if frmMain.ShowModal = mrOk then
      ExitCode := 0;
    frmMain.Free;
  end else if ((ParamStr(1) = GCOSQL_MODE_EXECUTE)
      and (ParamCount = 2)) then begin
    cnnResult := TADOConnection.Create(Nil);
    frmLogon := TfrmLogon.Create(Nil, cnnResult);
    if (frmLogon.ShowModal = mrOk)
        and GetDatabaseVersion(cnnResult, str)
        and DecryptAndExecute(cnnResult, ParamStr(2)) then begin
      ExitCode := 0;
      FreeAndNil(cnnResult);
    end;
    FreeAndNil(frmLogon);
  end else
    Application.MessageBox('Hello, World!', 'Message');
end.
