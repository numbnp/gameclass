unit ufrmMain;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  uY2KHTMLHelp,
  StdCtrls,
  uOptions,
  uY2KLinkLabel,
  uY2KHelpLabel,
  ExtCtrls,
  uY2KFileVersionInfo,
  uY2KFileVersionInfoLabel,
  Grids,
  DBGridEh,
  ADODB;

type
  TfrmMain = class(TForm)
    pnlTopAbout: TPanel;
    imageLogo: TImage;
    lblProductName: TLabel;
    lblVersion: TLabel;
    pnlContactInfo: TPanel;
    lblWWW: TLabel;
    lblEmail: TLabel;
    pnlButtons: TPanel;
    Image1: TImage;
    HelpLabel: TY2KHelpLabel;
    btnSaveSettings: TButton;
    btnRestartService: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    pnlOther: TGroupBox;
    GroupBox1: TGroupBox;
    edtConnectState: TEdit;
    btnAPITest: TButton;
    pnlOptions: TGroupBox;
    pnlSyncServers: TGroupBox;
    btnInsert: TButton;
    HTMLHelp: TY2KHTMLHelp;
    lblProductVersion: TY2KFileVersionInfoLabel;
    Y2KFileVersionInfo: TY2KFileVersionInfo;
    grdSyncServers: TDBGridEh;
    btnDelete: TButton;
    btnUpdate: TButton;
    labelServer: TLabel;
    btnServerList: TButton;
    edtServerName: TEdit;
    lblSyncInterval: TLabel;
    edtSyncInterval: TEdit;
    btnInitialize: TButton;
    edtInitialization: TEdit;
    cbxDebugLog: TCheckBox;
    cbxBeepOnFailedConnect: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnSaveSettingsClick(Sender: TObject);
    procedure btnRestartServiceClick(Sender: TObject);
    procedure btnInsertClick(Sender: TObject);
    procedure btnServerListClick(Sender: TObject);
    procedure btnAPITestClick(Sender: TObject);
    procedure _ControlValueChange(ASender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnUpdateClick(Sender: TObject);
    procedure btnInitializeClick(Sender: TObject);

  private
    FOptionsLink: TOptionsLink;
    FbControlsEnabled: Boolean;
    // events handlers
    procedure _OptionsChange(ASender: TObject; const AbChanged: Boolean);

    // private helper methods
    procedure _SubscribeToOptionsEvents();
    procedure _TryConnect();
    function _CheckServerName(const AstrServerName: String;
        const AbUpdate: Boolean = False): Boolean;
    procedure _Initialize;
    function _CopyAccountTables(const AstrLocalServerName: String;
        const AcnnSource: TADOConnection;
        const AcnnDestination: TADOConnection): Boolean;
  public
    procedure DoDesign;
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  DB,
  uSyncOptions,
  uServiceManager,
  udmMain,
  ufrmServerName,
  ufrmSQLServerList,
  Registry,
  uSQLTools,
  ufrmLogon,
  uLocalServer,
  uSyncConst,
  uGCDBTools;

{$R *.dfm}


procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Options.IsChanged then
    if (Application.MessageBox('Измененные настройки не сохранены!' + #13 + #10
        + 'Все равно выйти из программы?','Предупреждение',  MB_YESNO
        or MB_ICONQUESTION) <> IDYES) then
    Action := caNone;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  edtServerName.Text := ReadLocalServerName;
  _TryConnect;
  edtInitialization.Text := Options.General.InitializationDate.Value;
  edtSyncInterval.Text := IntToStr(Options.General.SyncInterval.Value);
  cbxDebugLog.Checked := Options.General.DebugLog.Value;
  cbxBeepOnFailedConnect.Checked := ReadBeepOnFailedConnect;
  if Length(Options.General.InitializationDate.Value) = 0 then
    edtInitialization.Text := NOT_INITIALIZED
  else
    edtInitialization.Text := INITIALIZED_AT
        + Options.General.InitializationDate.Value;
  DoDesign;
  btnSaveSettings.Enabled := False;
  _SubscribeToOptionsEvents();
  EnableControls;
end;

procedure TfrmMain._ControlValueChange(ASender: TObject);
var
  nValue: Integer;
begin
  if not ControlsEnabled then exit;
  if ASender = edtSyncInterval then begin
    Options.General.SyncInterval.Value := StrToIntDef(edtSyncInterval.Text,
        Options.General.SyncInterval.DefValue);
  end else if ASender = cbxDebugLog then begin
    Options.General.DebugLog.Value := cbxDebugLog.Checked
  end else if ASender = cbxBeepOnFailedConnect then begin
    WriteBeepOnFailedConnect(cbxBeepOnFailedConnect.Checked)
  end else begin
    ASSERT(FALSE,
        'TfrmMain.ControlValueChange error! Unknown sender!');
  end;
  DoDesign;
end; // TfrmMain.ControlValueChange

procedure TfrmMain._OptionsChange(
    ASender: TObject; const AbChanged: Boolean);
begin
  btnSaveSettings.Enabled := AbChanged;
end; // TfrmMain._OptionsChange

procedure TfrmMain._SubscribeToOptionsEvents();
begin
  ASSERT(Assigned(Options),
      'TfrmMain._SubscribeToOptionsEvents error! Options not created!');
  FOptionsLink := TOptionsLink.Create(Options);
  FOptionsLink.OnChange := _OptionsChange;
end; // TfrmMain._SubscribeToOptionsEvents

procedure TfrmMain._TryConnect();
var
  lstErrors: TStringList;
  nError: Integer;
  bConnected: Boolean;
  cursor: TCursor;
  cnnTest: TADOConnection;
begin
  cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  cnnTest := TADOConnection.Create(Self);
  lstErrors := TStringList.Create;
  if ADOConnect(cnnTest, lstErrors, nError, True,
      edtServerName.Text, DEF_DBNAME, DB_USER, DB_PASSWORD) then begin
    edtConnectState.Font.Color := clGreen;
    edtConnectState.Text := CONNECTED_SUCCESSFULLY;
    with dmMain do begin
      if GetClubName(cnnMain) <> GetClubName(cnnTest) then
        Application.MessageBox(PChar(DIFFERING_CLUB_NAMES), PChar(WARNING),
            MB_OK or MB_ICONWARNING);
    end;
  end else begin
    edtConnectState.Font.Color := clMaroon;
    edtConnectState.Text := lstErrors.Text;
    FreeAndNil(lstErrors);
  end;
  Screen.Cursor := cursor;
  FreeAndNil(cnnTest);
  FreeAndNil(lstErrors);
  DoDesign;
end; // TfrmMain._SubscribeToOptionsEvents

procedure TfrmMain.DoDesign;
begin
  DisableControls;
  with dmMain.cnnMain do begin
    grdSyncServers.Enabled := Connected;
    pnlOptions.Enabled := Connected;
    pnlSyncServers.Enabled := Connected;
    grdSyncServers.Enabled := Connected;
    lblSyncInterval.Enabled := Connected;
    edtSyncInterval.Enabled := Connected;
    cbxDebugLog.Enabled := Connected;
    btnSaveSettings.Enabled := Connected and Options.IsChanged;
    btnInsert.Enabled := Connected;
    btnDelete.Enabled := Connected
        and (dmMain.dstSyncServersSelect.RecordCount > 0);
    btnUpdate.Enabled := Connected
        and (dmMain.dstSyncServersSelect.RecordCount > 0);
  end;
{  cbxUseCache.Enabled := rbtnTariffTraffic.Checked;
  rbtnStartServiceAll.Enabled := cbxStartService.Checked;
  rbtnStartServiceOnlyGC.Enabled := cbxStartService.Checked;
  rbtnStopServiceAll.Enabled := cbxStopService.Checked;
  rbtnStopServiceOnlyGC.Enabled := cbxStopService.Checked;
}
  EnableControls;
end; // TfrmMain.DoDesign

procedure TfrmMain.EnableControls;
begin
  FbControlsEnabled := True;
end; // TfrmMain.EnableControls

procedure TfrmMain.DisableControls;
begin
  FbControlsEnabled := False;
end; // TfrmMain.DisableControls

procedure TfrmMain.btnSaveSettingsClick(Sender: TObject);
begin
  Options.Save;
  WriteLocalServerName(edtServerName.Text);
  btnSaveSettings.Enabled := False;
end;

procedure TfrmMain.btnRestartServiceClick(Sender: TObject);
var
  nRes: Integer;
begin
  with TServiceManager.Instance() do begin
    try
      nRes := StopService(SYNC_SERVICE);
      if nRes <> 0 then begin
//        Debug.Trace0('StopService error: ' + IntToStr(nRes));
      end;
      Sleep(2000);
      nRes := StartService(SYNC_SERVICE);
      if nRes <> 0 then begin
//        Debug.Trace0('StartService error: ' + IntToStr(nRes));
      end;
    finally
      Free();
    end;
  end;
end;

procedure TfrmMain.btnInsertClick(Sender: TObject);
var
  frmServerName: TfrmServerName;
begin
  frmServerName := TfrmServerName.Create(Self, dmMain.cnnDestination);
  frmServerName.Caption := INSERT;
  if frmServerName.ShowModal = mrOk then begin
    if _CheckServerName(frmServerName.ServerName) then begin
      with dmMain.dstSyncServersInsert do begin
        Parameters[1].Value := frmServerName.ServerName;
        Parameters[2].Value := dmMain.GetClubName(dmMain.cnnDestination);
        ExecProc;
      end;
      dmMain.dstSyncServersSelect.Requery([]);
    end;
  end;
  FreeAndNil(frmServerName);
end;

procedure TfrmMain.btnServerListClick(Sender: TObject);
var
  frmSQLServerList: TfrmSQLServerList;
begin
  frmSQLServerList := TfrmSQLServerList.Create(Self);
  if frmSQLServerList.ShowModal = mrOk then
    edtServerName.Text := frmSQLServerList.SelectedServer;
  FreeAndNil(frmSQLServerList);
end;

procedure TfrmMain.btnAPITestClick(Sender: TObject);
begin
  _TryConnect;
end;

procedure TfrmMain.btnDeleteClick(Sender: TObject);
begin
  with dmMain do begin
    if dstSyncServersSelect.RecordCount > 0 then begin
        dstSyncServersDelete.Parameters[1].Value :=
            dstSyncServersSelect.FieldValues['id'];
        dstSyncServersDelete.ExecProc;
        dstSyncServersSelect.Requery([]);
    end;
  end;
end;

procedure TfrmMain.btnUpdateClick(Sender: TObject);
var
  frmServerName: TfrmServerName;
begin
  if dmMain.dstSyncServersSelect.RecordCount > 0 then begin
    frmServerName := TfrmServerName.Create(Self, dmMain.cnnDestination,
        dmMain.dstSyncServersSelect.FieldValues['Name']);
    frmServerName.Caption := EDIT;
    if frmServerName.ShowModal = mrOk then begin
      if _CheckServerName(frmServerName.ServerName, True) then begin
        with dmMain.dstSyncServersUpdate do begin
          Parameters[1].Value := dmMain.dstSyncServersSelect.FieldValues['id'];
          Parameters[2].Value := frmServerName.ServerName;
          Parameters[3].Value := dmMain.GetClubName(dmMain.cnnDestination);
          ExecProc;
        end;
        dmMain.dstSyncServersSelect.Requery([]);
      end;
    end;
    FreeAndNil(frmServerName);
  end;
end;

function TfrmMain._CheckServerName(const AstrServerName: String;
    const AbUpdate: Boolean = False): Boolean;
var
  strClubName: String;
  strCurrentServerName: String;
  strCurrentClubName: String;
begin
  Result := True;
  strClubName := dmMain.GetClubName(dmMain.cnnDestination);
  strCurrentServerName := '';
  strCurrentClubName := '';
  with dmMain.dstSyncServersSelect do begin
    if RecordCount > 0 then begin
      strCurrentServerName := FieldValues['Name'];
      strCurrentClubName := FieldValues['ClubName'];
    end;
  end;
  if (dmMain.dstSyncServersSelect.Locate('Name', AstrServerName,
        [loCaseInsensitive]) and not (AbUpdate
      and (strCurrentServerName = AstrServerName)))
        or (edtServerName.Text = AstrServerName) then begin
      Result := False;
      Application.MessageBox(PChar(NAME_ALREADY_PRESENT), PChar(ERROR),
          MB_OK or MB_ICONERROR);
      exit;
  end;
  if (dmMain.dstSyncServersSelect.Locate('ClubName', strClubName,
      [loCaseInsensitive]) and not (AbUpdate
      and (strCurrentClubName = strClubName)))
      or (strClubName = dmMain.GetClubName(dmMain.cnnMain)) then begin
    if MessageBox(HWND_TOP,PChar(CLUB_NAME_ALREADY_PRESENT), PChar(ERROR),
        MB_YESNO or MB_ICONWARNING) <> IDYES then begin
      Result := False;
      exit;
    end;
  end;
{  if dmMain.GetUserName(dmMain.cnnDestination)
      = dmMain.GetUserName(dmMain.cnnMain) then begin
    Result := False;
    Application.MessageBox(PChar(KEY_ALREADY_PRESENT), PChar(ERROR),
        MB_OK or MB_ICONERROR);
  end; }
end;

procedure TfrmMain._Initialize;
var
  frmLogon: TfrmLogon;
  cnnBaseServer: TADOConnection;
  strCurrentServerName: String;
  strCurrentClubName: String;
  bComplete: Boolean;
begin
  bComplete := True;
  cnnBaseServer := TADOConnection.Create(Self);
  frmLogon := TfrmLogon.Create(frmMain, cnnBaseServer, False, DEF_DBNAME,
      False, True);
  frmLogon.ServerName := '';
  frmLogon.Caption := BASE_SERVER_CAPTION;
  if (frmLogon.ShowModal = mrOk) then begin
    Application.ProcessMessages;
    LogInsert(cnnBaseServer, 1, MSG_SYNC_CONNECTED + FOR_INITIALIZATION);
    if dmMain.IsManager(cnnBaseServer) then begin
      bComplete := _CopyAccountTables(edtServerName.Text,
          cnnBaseServer, dmMain.cnnMain);
    end else begin
      bComplete := False;
      Application.MessageBox(PChar(ISMANAGER_WARNING), PChar(WARNING),
          MB_OK or MB_ICONWARNING);
    end;
    LogInsert(cnnBaseServer, 1, MSG_SYNC_DISCONNECTED + FOR_INITIALIZATION);
    Application.ProcessMessages;
  end else
    bComplete := False;
  FreeAndNil(frmLogon);
  if bComplete then begin
    LogInsert(dmMain.cnnMain, 1, INITILIZATION_COMPLETE);
    Options.General.InitializationDate.Value := DateTimeToStr(Now);
    Options.Save;
    edtInitialization.Text := Options.General.InitializationDate.Value;
    Application.MessageBox(PChar(INITILIZATION_COMPLETE), PChar(WARNING),
        MB_OK or MB_ICONWARNING);
  end else begin
    LogInsert(dmMain.cnnMain, 1, INITILIZATION_NOT_COMPLETE);
    Application.MessageBox(PChar(INITILIZATION_NOT_COMPLETE), PChar(WARNING),
        MB_OK or MB_ICONERROR);
  end;
end;

function TfrmMain._CopyAccountTables(const AstrLocalServerName: String;
    const AcnnSource: TADOConnection;
    const AcnnDestination: TADOConnection): Boolean;
var
  nIdSyncServer: Int64;
begin
  Result := True;

  with dmMain do begin
    try
      with dstGetSyncServerIdByName do begin
//        Parameters.FindParam('Name').Value := AstrLocalServerName;
        dstGetSyncServerIdByName.SQL.Clear;
        dstGetSyncServerIdByName.SQL.Add ('select dbo.GetSyncServerIdByName('''+ AstrLocalServerName +''') as value');
        Connection := AcnnSource;
        Open;
        nIdSyncServer := dstGetSyncServerIdByName.FieldValues['value'];
        Close;
      end;
      with dstAccountsSelect do begin
        Parameters.FindParam('@idSyncServer').Value := 0;
        Connection := AcnnSource;
        Open;
      end;
      with dstAccountsHistorySelect do begin
        Parameters.FindParam('@idSyncServer').Value := 0;
        Connection := AcnnSource;
        Open;
      end;
    except
      Result := False;
    end;
    if Result then begin
      AcnnSource.BeginTrans;
      AcnnDestination.BeginTrans;
      try
        cmdAccountsDelete.Execute;
        dstAccountsSync.Connection := AcnnSource;
        dstAccountsInsert.Connection := AcnnDestination;
        dstAccountsSelect.First;
        while not dstAccountsSelect.Eof do begin
          dstAccountsInsert.Parameters.FindParam('@guid').Value :=
              dstAccountsSelect.FieldValues['guid'];
          dstAccountsInsert.Parameters.FindParam('@name').Value :=
              dstAccountsSelect.FieldValues['name'];
          dstAccountsInsert.Parameters.FindParam('@password').Value :=
              dstAccountsSelect.FieldValues['password'];
          dstAccountsInsert.Parameters.FindParam('@email').Value :=
              dstAccountsSelect.FieldValues['email'];
          dstAccountsInsert.Parameters.FindParam('@phone').Value :=
              dstAccountsSelect.FieldValues['phone'];
          dstAccountsInsert.Parameters.FindParam('@photo').Value :=
              dstAccountsSelect.FieldValues['photo'];
          dstAccountsInsert.Parameters.FindParam('@seccodes').Value :=
              dstAccountsSelect.FieldValues['seccodes'];
          dstAccountsInsert.Parameters.FindParam('@isenabled').Value :=
              dstAccountsSelect.FieldValues['isenabled'];
          dstAccountsInsert.Parameters.FindParam('@isblocked').Value :=
              dstAccountsSelect.FieldValues['isblocked'];
          dstAccountsInsert.Parameters.FindParam('@isprivileged').Value :=
              dstAccountsSelect.FieldValues['isprivileged'];
          dstAccountsInsert.Parameters.FindParam('@isdeleted').Value :=
              dstAccountsSelect.FieldValues['isdeleted'];
          dstAccountsInsert.Parameters.FindParam('@privilegedDiscount').Value :=
              dstAccountsSelect.FieldValues['privilegedDiscount'];
          dstAccountsInsert.Parameters.FindParam('@zeroBalance').Value :=
              dstAccountsSelect.FieldValues['zeroBalance'];
          dstAccountsInsert.Parameters.FindParam('@summary').Value :=
              dstAccountsSelect.FieldValues['summary'];
          dstAccountsInsert.Parameters.FindParam('@address').Value :=
              dstAccountsSelect.FieldValues['address'];
          dstAccountsInsert.Parameters.FindParam('@memo').Value :=
              dstAccountsSelect.FieldValues['memo'];
          dstAccountsInsert.Parameters.FindParam('@balance').Value :=
              dstAccountsSelect.FieldValues['balance'];
          dstAccountsInsert.Parameters.FindParam('@PeriodOfValidity').Value :=
              dstAccountsSelect.FieldValues['PeriodOfValidity'];
          dstAccountsInsert.Parameters.FindParam('@ExpirationDate').Value :=
              dstAccountsSelect.FieldValues['ExpirationDate'];
          dstAccountsInsert.Parameters.FindParam('@assigntarif').Value :=
              dstAccountsSelect.FieldValues['assigntarif'];
          dstAccountsInsert.Parameters.FindParam('@userlevel').Value :=
              dstAccountsSelect.FieldValues['userlevel'];
          dstAccountsInsert.Parameters.FindParam('@force_tariff').Value :=
              dstAccountsSelect.FieldValues['force_tariff'];
          dstAccountsInsert.Parameters.FindParam('@referal').Value :=
              dstAccountsSelect.FieldValues['referal'];
          dstAccountsInsert.Parameters.FindParam('@username').Value :=
              dstAccountsSelect.FieldValues['username'];
          dstAccountsInsert.Parameters.FindParam('@uname').Value :=
              dstAccountsSelect.FieldValues['uname'];
          dstAccountsInsert.Parameters.FindParam('@uotch').Value :=
              dstAccountsSelect.FieldValues['uotch'];
          dstAccountsInsert.Parameters.FindParam('@hardcode').Value :=
              dstAccountsSelect.FieldValues['hardcode'];
          dstAccountsInsert.Parameters.FindParam('@ignorehardcode').Value :=
              dstAccountsSelect.FieldValues['ignorehardcode'];    

          dstAccountsInsert.ExecProc;
          dstAccountsSync.Parameters.FindParam('@idSyncServer').Value :=
              nIdSyncServer;
          dstAccountsSync.Parameters.FindParam('@guid').Value :=
              dstAccountsSelect.FieldValues['guid'];
          dstAccountsSync.ExecProc;
          dstAccountsSelect.Next;
        end;
        cmdAccountsHistoryDelete.Execute;
        dstAccountsHistorySync.Connection := AcnnSource;
        dstAccountsHistoryInsert.Connection := AcnnDestination;
        dstAccountsHistorySelect.First;
        while not dstAccountsHistorySelect.Eof do begin
          dstAccountsHistoryInsert.Parameters.FindParam('@guid').Value :=
              dstAccountsHistorySelect.FieldValues['guid'];
          dstAccountsHistoryInsert.Parameters.FindParam('@guidAccounts').Value :=
              dstAccountsHistorySelect.FieldValues['guidAccounts'];
          dstAccountsHistoryInsert.Parameters.FindParam('@moment').Value :=
              dstAccountsHistorySelect.FieldValues['moment'];
          dstAccountsHistoryInsert.Parameters.FindParam('@what').Value :=
              dstAccountsHistorySelect.FieldValues['what'];
          dstAccountsHistoryInsert.Parameters.FindParam('@summa').Value :=
              dstAccountsHistorySelect.FieldValues['summa'];
          dstAccountsHistoryInsert.Parameters.FindParam('@comment').Value :=
              dstAccountsHistorySelect.FieldValues['comment'];
          dstAccountsHistoryInsert.Parameters.FindParam(
              '@initialization').Value := 1;
          dstAccountsHistoryInsert.ExecProc;
          dstAccountsHistorySync.Parameters.FindParam('@idSyncServer').Value :=
              nIdSyncServer;
          dstAccountsHistorySync.Parameters.FindParam('@guid').Value :=
              dstAccountsHistorySelect.FieldValues['guid'];
          dstAccountsHistorySync.ExecProc;
          dstAccountsHistorySelect.Next;
        end;
      except
        Result := False;
      end;
    end;
    if Result then begin
      AcnnSource.CommitTrans;
      AcnnDestination.CommitTrans;
    end else begin
      AcnnSource.RollbackTrans;
      AcnnDestination.RollbackTrans;
    end;
  end;
end;

procedure TfrmMain.btnInitializeClick(Sender: TObject);
begin
  if MessageBox(HWND_TOP,PChar(INITIALIZATION_WARNING), PChar(ERROR),
      MB_YESNO or MB_ICONWARNING) = IDYES then begin
    if Length(Options.General.InitializationDate.Value) > 0 then begin
      if MessageBox(HWND_TOP,PChar(ALREADY_INITIALIZED), PChar(ERROR),
          MB_YESNO or MB_ICONWARNING) <> IDYES then
        exit;
    end;
    _Initialize;
  end;
end;


end.
