unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,
  uOptions, uY2KLinkLabel, uY2KHelpLabel, uY2KHTMLHelp, Mask, ToolEdit;

type
  TfrmMain = class(TForm)
    cbxStartService: TCheckBox;
    cbxDebugLog: TCheckBox;
    cbxNoAddUsers: TCheckBox;
    imageLogo: TImage;
    pnlTopAbout: TPanel;
    lblProductName: TLabel;
    lblVersion: TLabel;
    lblVersionInfo: TLabel;
    lblWWW: TLabel;
    lblEmail: TLabel;
    pnlStartServiceInner: TGroupBox;
    rbtnStartServiceAll: TRadioButton;
    rbtnStartServiceOnlyGC: TRadioButton;
    pnlTariff: TGroupBox;
    rbtnTariffTraffic: TRadioButton;
    rbtnTariffCost: TRadioButton;
    cbxUseCache: TCheckBox;
    pnlContactInfo: TPanel;
    pnlUserStopping: TGroupBox;
    pnlStopServiceInner: TGroupBox;
    rbtnStopServiceAll: TRadioButton;
    rbtnStopServiceOnlyGC: TRadioButton;
    cbxStopService: TCheckBox;
    pnlPassword: TGroupBox;
    edtPassword: TEdit;
    lblPassword: TLabel;
    edtConfirmation: TEdit;
    lblConfirmation: TLabel;
    pnlPasswordAndTarifs: TPanel;
    pnlOther: TGroupBox;
    pnlButtons: TPanel;
    btnSaveSettings: TButton;
    btnRestartService: TButton;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edtAPIState: TEdit;
    btnAPITest: TButton;
    HTMLHelp: TY2KHTMLHelp;
    Image1: TImage;
    HelpLabel: TY2KHelpLabel;
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox2: TGroupBox;
    lbxClients: TListBox;
    btnClear: TButton;
    Label1: TLabel;
    edtName: TEdit;
    Panel4: TPanel;
    GroupBox3: TGroupBox;
    edtPath: TFilenameEdit;
    procedure lblWWWClick(Sender: TObject);
    procedure lblEmailClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRestartServiceClick(Sender: TObject);
    procedure btnSaveSettingsClick(Sender: TObject);
    procedure _ControlValueChange(ASender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAPITestClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure edtPathChange(Sender: TObject);
  private
    FOptionsLink: TOptionsLink;
    FbControlsEnabled: Boolean;

    // events handlers
    procedure _OptionsChange(ASender: TObject; const AbChanged: Boolean);

    // private helper methods
    procedure _SubscribeToOptionsEvents;
    procedure _CheckLibrary;
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
  ShellAPI,
  uGCUGConst,
  uGCUGOPtions,
  uServiceManager,
  uCoder,
  ufrmLogin,
  uIPInformation,
  uUGConfig,


  uUGUtils;

{$R *.dfm}

procedure TfrmMain.lblWWWClick(Sender: TObject);
begin
  ShellExecute(0, 'open', pChar('http:// www.nodasoft.com/products/gc'),
      NIL, NIL, SW_SHOWNORMAL);
end;

procedure TfrmMain.lblEmailClick(Sender: TObject);
begin
  ShellExecute(0,'open',
      pChar('mailto:support@nodasoft.com?subject=GGTI&body=Version = '
      + APP_VERSION),
      NIL, NIL, SW_SHOWNORMAL);
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  lblVersionInfo.Caption := APP_VERSION;
  Options.Load;
  DisableControls;
  edtName.Text := Options.Genaral.Name.Value;
  edtPassword.Text := Options.Genaral.DecriptedPassword;
  edtConfirmation.Text := edtPassword.Text;
  if (Options.Genaral.TariffingMode.Value
      = Ord(TariffingModeTraffic)) then begin
    rbtnTariffTraffic.Checked := True;
  end else if (Options.Genaral.TariffingMode.Value
      = Ord(TariffingModeCost)) then begin
    rbtnTariffCost.Checked := True;
  end;
  cbxUseCache.Checked := Options.Genaral.TariffingUseCache.Value;
  cbxStartService.Checked := Options.Genaral.StoppingByStart.Value;
  cbxStopService.Checked := Options.Genaral.StoppingByStop.Value;
  if (Options.Genaral.StoppingByStartMode.Value
      = Ord(StoppingModeAll)) then begin
    rbtnStartServiceAll.Checked := True;
  end else if (Options.Genaral.StoppingByStartMode.Value
      = Ord(StoppingModeOnlyGC)) then begin
    rbtnStartServiceOnlyGC.Checked := True;
  end;
  if (Options.Genaral.StoppingByStopMode.Value
      = Ord(StoppingModeAll)) then begin
    rbtnStopServiceAll.Checked := True;
  end else if (Options.Genaral.StoppingByStopMode.Value
      = Ord(StoppingModeOnlyGC)) then begin
    rbtnStopServiceOnlyGC.Checked := True;
  end;
  cbxNoAddUsers.Checked := Options.Genaral.NoAddUsers.Value;
  cbxDebugLog.Checked := Options.Genaral.DebugLog.Value;
  IPInformations.SerializedString := Options.Genaral.SerializedString.Value;
  for i := 0 to IPInformations.Count - 1 do
    lbxClients.AddItem(IPInformations.GetItem(i).Name, Nil);
  edtPath.FileName := Options.Genaral.Path.Value;
  edtPath.InitialDir := ExtractFileDir(edtPath.Text);
  _CheckLibrary;
  DoDesign;
  btnSaveSettings.Enabled := False;
  _SubscribeToOptionsEvents();
  EnableControls;
end; // TfrmMain.FormCreate

procedure TfrmMain.DoDesign;
begin
  DisableControls;
  cbxUseCache.Enabled := rbtnTariffTraffic.Checked;
  rbtnStartServiceAll.Enabled := cbxStartService.Checked;
  rbtnStartServiceOnlyGC.Enabled := cbxStartService.Checked;
  rbtnStopServiceAll.Enabled := cbxStopService.Checked;
  rbtnStopServiceOnlyGC.Enabled := cbxStopService.Checked;
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

procedure TfrmMain.btnRestartServiceClick(Sender: TObject);
var
  nRes: Integer;
begin
  with TServiceManager.Instance() do begin
    try
      nRes := StopService(GCUG_SERVICE);
      if nRes <> 0 then begin
//        Debug.Trace0('StopService error: ' + IntToStr(nRes));
      end;
      Sleep(2000);
      nRes := StartService(GCUG_SERVICE);
      if nRes <> 0 then begin
//        Debug.Trace0('StartService error: ' + IntToStr(nRes));
      end;
    finally
      Free();
    end;
  end;

end; // TfrmMain.btnRestartServiceClick

procedure TfrmMain.btnSaveSettingsClick(Sender: TObject);
begin
  if (edtPassword.Text <> edtConfirmation.Text) then begin
    MessageBox(Application.Handle,'Введенные пароли не совпадают!', 'Ошибка',
        MB_OK or MB_ICONWARNING);
  end else begin
    Options.Save;
    btnSaveSettings.Enabled := False;
  end;
end;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmMain._OptionsChange(
    ASender: TObject; const AbChanged: Boolean);
begin
  btnSaveSettings.Enabled := AbChanged;
end; // TfrmMain._OptionsChange

procedure TfrmMain._ControlValueChange(ASender: TObject);
var
  coder: TCoder;
begin
  if not ControlsEnabled then exit;
  if ASender = edtPassword then begin
    coder := TCoder.Create;
    Options.Genaral.Password.Value :=
        coder.SimpleEncodeString(edtPassword.Text);
    coder.Free;
  end else if ASender = edtName then begin
    Options.Genaral.Name.Value := edtName.Text;
  end else if ASender = edtConfirmation then begin
  end else if ASender = rbtnTariffTraffic then begin
    Options.Genaral.TariffingMode.Value := Ord(TariffingModeTraffic)
  end else if ASender = rbtnTariffCost then begin
    Options.Genaral.TariffingMode.Value := Ord(TariffingModeCost)
  end else if ASender = cbxUseCache then begin
    Options.Genaral.TariffingUseCache.Value := cbxUseCache.Checked;
  end else if ASender = cbxStartService then begin
    Options.Genaral.StoppingByStart.Value := cbxStartService.Checked;
  end else if ASender = rbtnStartServiceAll then begin
    Options.Genaral.StoppingByStartMode.Value := Ord(StoppingModeAll)
  end else if ASender = rbtnStartServiceOnlyGC then begin
    Options.Genaral.StoppingByStartMode.Value := Ord(StoppingModeOnlyGC)
  end else if ASender = cbxStopService then begin
    Options.Genaral.StoppingByStop.Value := cbxStopService.Checked;
  end else if ASender = rbtnStopServiceAll then begin
    Options.Genaral.StoppingByStopMode.Value := Ord(StoppingModeAll)
  end else if ASender = rbtnStopServiceOnlyGC then begin
    Options.Genaral.StoppingByStopMode.Value := Ord(StoppingModeOnlyGC)
  end else if ASender = cbxNoAddUsers then begin
    Options.Genaral.NoAddUsers.Value := cbxNoAddUsers.Checked;
  end else if ASender = cbxDebugLog then begin
    Options.Genaral.DebugLog.Value := cbxDebugLog.Checked;
  end else begin
    ASSERT(FALSE,
        'TfrmMain.ControlValueChange error! Unknown sender!');
  end;
  DoDesign;
end; // TfrmMain.ControlValueChange

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmMain._SubscribeToOptionsEvents();
begin
  ASSERT(Assigned(Options),
      'TfrmMain._SubscribeToOptionsEvents error! Options not created!');
  FOptionsLink := TOptionsLink.Create(Options);
  FOptionsLink.OnChange := _OptionsChange;
end; // TfrmMain._SubscribeToOptionsEvents

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Options.IsChanged then
    if (Application.MessageBox('Измененные настройки не сохранены!' + #13 + #10
        + 'Все равно выйти из программы?','Предупреждение',  MB_YESNO
        or MB_ICONQUESTION) <> IDYES) then
    Action := caNone;
end;

procedure TfrmMain.btnAPITestClick(Sender: TObject);
var
  strErrorMessage: String;
  UG: TUGConfig;
begin
  UG := TUGConfig.Create(edtPath.FileName);
  if UG.Logon(edtName.Text, edtPassword.Text, strErrorMessage) then begin
    edtAPIState.Font.Color := clGreen;
    UG.Disconnect;
  end else begin
    edtAPIState.Font.Color := clMaroon;
  end;
  edtAPIState.Text := strErrorMessage;
  FreeAndNil(UG);
//  UGCreateMissingUsers;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  if Options.Genaral.PasswordNotEmpty then begin
     if (frmLogin.ShowModal = mrCancel) then
        Application.Terminate;
  end;
end;

procedure TfrmMain.btnClearClick(Sender: TObject);
begin
  Options.Genaral.SerializedString.Value := '';
  lbxClients.Clear;
end;

procedure TfrmMain.edtPathChange(Sender: TObject);
begin
  Options.Genaral.Path.Value := edtPath.FileName;
  _CheckLibrary;
end;

procedure TfrmMain._CheckLibrary;
var
  UG: TUGConfig;
begin
  UG := TUGConfig.Create(Options.Genaral.Path.Value);
  if UG.Active then begin
    edtAPIState.Text := 'Библиотека ug_config.dll загружена!';
    edtAPIState.Font.Color := clGreen;
    btnAPITest.Enabled := True;
  end else begin
    edtAPIState.Text := 'Невозможно загрузить ug_config.dll!';
    edtAPIState.Font.Color := clMaroon;
    btnAPITest.Enabled := False;
  end;
  FreeAndNil(UG);
end;

end.
