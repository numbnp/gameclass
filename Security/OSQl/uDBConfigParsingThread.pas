unit uDBConfigParsingThread;

interface

uses
  Classes;

resourcestring
{  DBCFG_ERR_INSTALL_FAILED = 'Failed install database!';
  DBCFG_ERR_GCDB_ALREADY_EXIST = 'GameClass Database already exists!'
      + Char(13) + 'First DELETE GameClass Database!';
  DBCFG_ERR_GCDB_NOT_EXIST = 'GameClass Database not exists!'
      + Char(13) + 'Run installation in create mode!';
  DBCFG_ERR_INSTALL_FAILED = 'Failed install database!';
//  DBCFG_LOCAL_SERVER_TUNING = 'Starting and tuning local SQLServer ...';
//  DBCFG_SERVER_TUNING = 'Starting and tuning SQLServer ...';
//  DBCFG_DEFAULT_SERVER_CONNECT = 'Connecting to default SQLServer ...';
//  DBCFG_OK = ' Ok';
//  DBCFG_FAILED = ' Failed';
}
  DBCFG_ERR_GCDB_ALREADY_EXIST = 'База данных GameClass уже существует!'#13#10
      + 'Необходимо сначала удалить базу данных GameClass!';
  DBCFG_ERR_GCDB_NOT_EXIST = 'База данных GameClass не найдена!'#13#10
      + 'Запустите инсталлятор в режиме "Главный управляющий компьютер"!';
  DBCFG_ERR_INSTALL_FAILED = 'Ошибка установки базы данных!';
  DBCFG_ERR_DONT_GET_VERSION =
      'Невозможно получить версию базы данных Gameclass!';
  DBCFG_LOCAL_SERVER_TUNING =
      'Запуск и настройка локального SQL-сервера ...'#13#10
      + 'Будут отключены все встроенные администраторы и пользователь sa';
  DBCFG_SERVER_TUNING = 'Запуск и настройка SQL-сервера ...'#13#10
      + 'Будут отключены все встроенные администраторы и пользователь sa';
  DBCFG_SERVER_CONNECT = 'Connecting to SQLServer ...';
  DBCFG_DEFAULT_SERVER_CONNECT = 'Подключение к SQL-серверу по-умолчанию ...';
  DBCFG_OK = ' Выполнено';
  DBCFG_FAILED = ' Ошибка';

const
  DBCFG_CREATE_DB_VERSION = 'Create';

type
  TDBConfigParsingThread = class(TThread)
  private
    FstrXMLConfigFileName: String;
    FbCreateBase: Boolean;
    FbUseLoginForm: Boolean;
    FbResult: Boolean;
    procedure MessageResultAppend(AbResult: Boolean);
  protected
    procedure Execute; override;
  public
    constructor Create(const AstrXMLConfigFileName: String;
        const AbCreateBase: Boolean;
        const AbUseLoginForm: Boolean);
    property Result: Boolean read FbResult;
  end;

implementation

uses
  ADODB,
  Variants,
  Windows,
  ActiveX,
  Forms,
  SysUtils,
  xmldom,
  XMLIntf,
  msxmldom,
  XMLDoc,
  ufrmMain,
  ufrmLogon,
  Controls,
  gcosqlexecute,
  uSQLTools,
  uY2KCommon,
  uGCDBTools,
  uCrossPlatformFunctions,
  uReportManager;



procedure TDBConfigParsingThread.Execute;
var
  NodeList: IXMLNodeList;
  Node: IXMLNode;
  i: Integer;
  strScriptBaseVersion : String;
  strFileName : String;
  strPath: String;
  strDescription : String;
  XMLDoc: TXMLDocument;
  strBaseVersion: String;
  bBaseExist: Boolean;
  cnnMain: TADOConnection;
  lstErrors: TStringList;
  strServerName, strLogin, strPassword: String;
  frmLogon: TfrmLogon;
  strBackupFileName: String;
  ReportManager: TReportManager;
  dbPassword,dbUserName: String;
begin
  dbUserName := 'sa';
  dbPassword := '1';
  frmMain.Invalidate;
  CoInitialize(Nil);
  cnnMain := TADOConnection.Create(Nil);
  lstErrors := TStringList.Create;
  if FbCreateBase then begin
    if not FbUseLoginForm then begin
      strServerName := SQL_LOCAL_NAME;
      frmMain.MessageAdd(DBCFG_LOCAL_SERVER_TUNING);
      FbResult := ConfigureServer(strServerName);
      MessageResultAppend(FbResult);
    end;
    if not FbResult then begin
      frmMain.MessageAdd(DBCFG_SERVER_TUNING);
      FbResult := ConfigureServerWithLogon(strServerName,dbUserName,dbPassword);
      MessageResultAppend(FbResult);
    end;
    if FbResult then begin
      frmMain.MessageAdd(DBCFG_SERVER_CONNECT);
      FbResult := ADOConnect(cnnMain, lstErrors, i, True, strServerName,
          '', dbUserName, dbPassword);
      MessageResultAppend(FbResult);
      if not FbResult and Assigned(lstErrors) then
        FreeAndNil(lstErrors);
    end;
    if not FbResult then
      Exit;
  end;
  XMLDoc := TXMLDocument.Create(Application);
  XMLDoc.LoadFromFile(FstrXMLConfigFileName);
  try
    NodeList := XMLDoc.DocumentElement.ChildNodes;
    // вообще этот способ не используется
    if not FbCreateBase then begin
      Node := NodeList.Nodes['Connection'];
      strLogin := IsNull(Node.Attributes['Login'], '');
      strPassword := IsNull(Node.Attributes['Password'], '');
      strServerName := IsNull(Node.Attributes['Server'], SQL_LOCAL_NAME);
      if (strServerName = 'localhost')
          or (strServerName = '127.0.0.1') then
         strServerName := SQL_LOCAL_NAME;
      if strLogin <> '' then begin
        frmMain.MessageAdd(DBCFG_DEFAULT_SERVER_CONNECT);
        FbResult := ADOConnect(cnnMain, lstErrors, i, True, strServerName,
            '', strLogin, strPassword);
        MessageResultAppend(FbResult);
        if not FbResult and Assigned(lstErrors) then
          FreeAndNil(lstErrors);
      end;
      if not FbResult then begin
        frmMain.MessageAdd(DBCFG_SERVER_CONNECT);
        frmLogon := TfrmLogon.Create(Nil, cnnMain, False, '');
        FbResult := (frmLogon.ShowModal = mrOk);
        MessageResultAppend(FbResult);
      end;
    end;
    if FbResult then begin
      //Подключены к серверу, но не к базе GameClass
      bBaseExist := UseGCDB(cnnMain);
      if (FbCreateBase and bBaseExist) then begin
        MessageBox(0, PChar(DBCFG_ERR_GCDB_ALREADY_EXIST),
            PChar(DBCFG_ERR_INSTALL_FAILED), MB_ICONERROR + MB_OK);
        FbResult := False;
      end;
      if (Not FbCreateBase and Not bBaseExist) then begin
        MessageBox(0, PChar(DBCFG_ERR_GCDB_NOT_EXIST),
            PChar(DBCFG_ERR_INSTALL_FAILED), MB_ICONERROR + MB_OK);
        FbResult := False;
      end;
      if bBaseExist then begin
        if not GetDatabaseVersion(cnnMain, strBaseVersion) then begin
          MessageBox(0, PChar(DBCFG_ERR_DONT_GET_VERSION),
              PChar(DBCFG_ERR_INSTALL_FAILED), MB_ICONERROR + MB_OK);
          FbResult := False;
        end;
      end else
        strBaseVersion := DBCFG_CREATE_DB_VERSION;
      //Принудительный бекап
      if FbResult and not FbCreateBase then begin
        strBackupFileName := GetTempDir + '\' + GenerateUniqueBackupFileName;
        frmMain.MessageAdd(
            'Выполняется резервное копирование базы в файл '#13#10'   '
            + strBackupFileName);
        MessageResultAppend(GCBackup(cnnMain,
            strBackupFileName, lstErrors));
      end;
      if FbResult then begin
        Node := NodeList.Nodes['Scripts'];
        NodeList := Node.ChildNodes;
        strPath := Node.Attributes['Path'];
        for i:=0 to (NodeList.Count-1) do // begin
          with NodeList.Nodes[i] do begin
            strFileName := Attributes['FileName'];
            strScriptBaseVersion := Attributes['DataBaseVersion'];
            strDescription := Attributes['Description'];
            if strScriptBaseVersion = strBaseVersion then begin
              frmMain.MessageAdd(strDescription);
              if DecryptAndExecute(cnnMain, strPath + strFileName) then begin
                MessageResultAppend(True);
                if not GetDatabaseVersion(cnnMain, strBaseVersion) then begin
                  MessageBox(0, PChar(DBCFG_ERR_DONT_GET_VERSION),
                  PChar(DBCFG_ERR_INSTALL_FAILED), MB_ICONERROR + MB_OK);
                  FbResult := False;
                  Break;
                end;
              end else begin
                MessageResultAppend(False);
                FbResult := False;
                Break;
              end;
            end;
          end;
        if FbResult then begin
          Node := XMLDoc.DocumentElement.ChildNodes.Nodes['Reports'];
          NodeList := Node.ChildNodes;
          if NodeList.Count > 0 then begin
            ReportManager := TReportManager.Create(cnnMain);
            for i:=0 to (NodeList.Count-1) do
              with NodeList.Nodes[i] do begin
                strFileName := Attributes['FileName'];
                strDescription := Attributes['Description'];
                if bBaseExist then begin
                  frmMain.MessageAdd(strDescription);
//                  if UpdateCustomReport(cnnMain, strPath + strFileName) then
                    if ReportManager.ImportReports(strPath + strFileName,
                       rimSQLotherwiseXMLParentId, 0) then
                    MessageResultAppend(True)
                  else begin
                    MessageResultAppend(False);
                    FbResult := False;
                    Break;
                  end;
                end;
              end;
            FreeAndNil(ReportManager);
          end;
        end;
      end;
    end;
  except
    on E: Exception do begin
      MessageBox(0,PChar(E.Message), PChar(E.HelpContext),MB_OK	);
      FbResult := False;
    end;
  end;
  FreeAndNil(lstErrors);
  FreeAndNil(cnnMain);
  XMLDoc.Free;
  CoUninitialize;
end;

constructor TDBConfigParsingThread.Create(const AstrXMLConfigFileName: String;
    const AbCreateBase: Boolean;
    const AbUseLoginForm: Boolean);
begin
  inherited Create(False);
  FbResult := False;
  FstrXMLConfigFileName := AstrXMLConfigFileName;
  FbCreateBase := AbCreateBase;
  FbUseLoginForm := AbUseLoginForm;
end;

procedure TDBConfigParsingThread.MessageResultAppend(AbResult: Boolean);
begin
  if AbResult then
    frmMain.MessageAppend(DBCFG_OK)
  else
    frmMain.MessageAppend(DBCFG_FAILED);
end;

end.
