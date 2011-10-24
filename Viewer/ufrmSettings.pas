unit ufrmSettings;

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
  StdCtrls,
  uOptions, ExtCtrls;

type
  TfrmSettings = class(TForm)
    FontDialog: TFontDialog;
    ColorDialog: TColorDialog;
    btnFontChange: TButton;
    lblFont: TLabel;
    edtFont: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    btnApply: TButton;
    lblBusyLimitMin: TLabel;
    edtBusyLimitMin: TEdit;
    cbxTime05: TCheckBox;
    cbxTime1: TCheckBox;
    cbxTime15: TCheckBox;
    cbxTime2: TCheckBox;
    cbxTime3: TCheckBox;
    cbxTime4: TCheckBox;
    pnlPassword: TGroupBox;
    lblPassword: TLabel;
    lblConfirmation: TLabel;
    edtPassword: TEdit;
    edtConfirmation: TEdit;
    pnlTable: TGroupBox;
    pnlTime: TGroupBox;
    pnlBottom: TPanel;
    pnlTop: TPanel;
    pnlRight: TPanel;
    pnlLeft: TPanel;
    pnlFree: TGroupBox;
    cbxUseLargeIcons: TCheckBox;
    rbtnSortByNumber: TRadioButton;
    rbtnSortByState: TRadioButton;
    Label1: TLabel;
    cbxMarkBusyLimited: TCheckBox;
    cbxMarkFreeLimited: TCheckBox;
    pnlMiddle: TPanel;
    pnlTimeSettings: TGroupBox;
    lblSpaceLimitMin: TLabel;
    edtSpaceLimitMin: TEdit;
    cbxTime: TCheckBox;
    cbxCustomFirstColumnTitle: TCheckBox;
    cbxCustomSecondColumnTitle: TCheckBox;
    edtFirstColumnTitle: TEdit;
    edtSecondColumnTitle: TEdit;
    pnlOnlyOneTimeColumnVisible: TGroupBox;
    pnlReleaseColumns: TGroupBox;
    pnlOther: TGroupBox;
    cbxShowTime: TCheckBox;
    cbxShowToolBar: TCheckBox;
    procedure btnFontChangeClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure _ControlValueChange(ASender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure btnApplyClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FbControlsEnabled: Boolean;
    FOptionsLink: TOptionsLink;

    procedure _OptionsChange(ASender: TObject; const AbChanged: Boolean);
    procedure _SubscribeToOptionsEvents();
    procedure _SetFont(const AFont: Tfont);
    procedure _ApplySettings;
  public
    procedure DoDesign;
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  end;

var
  frmSettings: TfrmSettings;

implementation

uses
  Math,
  ufrmMain,
  uViewerOptions,
  uY2KCommon,
  uCoder;

{$R *.dfm}

procedure TfrmSettings.btnFontChangeClick(Sender: TObject);
begin
  if FontDialog.Execute then begin
    _SetFont(FontDialog.Font);
    _ControlValueChange(edtFont);
  end;
end;

procedure TfrmSettings.Button2Click(Sender: TObject);
begin
//  if not ColorDialog.Execute then exit;
//    frmMain.SetBackColor(formMain.ColorDialog.Color);

end;

procedure TfrmSettings._SubscribeToOptionsEvents();
begin
  ASSERT(Assigned(Options),
      'TfrmSettings._SubscribeToOptionsEvents error! Options not created!');
  FOptionsLink := TOptionsLink.Create(Options);
  FOptionsLink.OnChange := _OptionsChange;
end; // TfrmMain._SubscribeToOptionsEvents

procedure TfrmSettings._OptionsChange(
    ASender: TObject; const AbChanged: Boolean);
begin
  btnOk.Enabled := AbChanged;
  btnApply.Enabled := AbChanged;
end; // TfrmMain._OptionsChange

procedure TfrmSettings._ControlValueChange(ASender: TObject);
var
  coder: TCoder;
begin
  if not ControlsEnabled then exit;
  if ASender = edtPassword then begin
    coder := TCoder.Create;
    Options.General.UnblockPasswordHash.Value :=
        coder.SimpleEncodeString(edtPassword.Text);
    coder.Free;
  end else if ASender = edtConfirmation then begin
  end else if ASender = edtFont then begin
    Options.General.Font.Value := FontToStr(edtFont.Font);
  end else if ASender = edtSpaceLimitMin then begin
    Options.General.SpaceLimitMin.Value :=
      StrToIntDef(edtSpaceLimitMin.Text,
      Options.General.SpaceLimitMin.DefValue);
  end else if ASender = edtBusyLimitMin then begin
    Options.General.BusyLimitMin.Value :=
      StrToIntDef(edtBusyLimitMin.Text,
      Options.General.BusyLimitMin.DefValue);
  end else if ASender = cbxTime05 then begin
    Options.General.Time05.Value := cbxTime05.Checked;
  end else if ASender = cbxTime1 then begin
    Options.General.Time1.Value := cbxTime1.Checked;
  end else if ASender = cbxTime15 then begin
    Options.General.Time15.Value := cbxTime15.Checked;
  end else if ASender = cbxTime2 then begin
    Options.General.Time2.Value := cbxTime2.Checked;
  end else if ASender = cbxTime3 then begin
    Options.General.Time3.Value := cbxTime3.Checked;
  end else if ASender = cbxTime4 then begin
    Options.General.Time4.Value := cbxTime4.Checked;
  end else if ASender = cbxTime then begin
    Options.General.Time.Value := cbxTime.Checked;
  end else if ASender = cbxUseLargeIcons then begin
    Options.General.UseLargeIcons.Value := cbxUseLargeIcons.Checked;
  end else if ASender = cbxMarkBusyLimited then begin
    Options.General.MarkBusyLimited.Value := cbxMarkBusyLimited.Checked;
  end else if ASender = cbxMarkFreeLimited then begin
    Options.General.MarkFreeLimited.Value := cbxMarkFreeLimited.Checked;
  end else if ASender = cbxCustomFirstColumnTitle then begin
    Options.General.CustomFirstColumnTitle.Value :=
        cbxCustomFirstColumnTitle.Checked;
  end else if ASender = cbxCustomSecondColumnTitle then begin
    Options.General.CustomSecondColumnTitle.Value :=
        cbxCustomSecondColumnTitle.Checked;
  end else if ASender = edtFirstColumnTitle then begin
    Options.General.FirstColumnTitle.Value := edtFirstColumnTitle.Text;
  end else if ASender = edtSecondColumnTitle then begin
    Options.General.SecondColumnTitle.Value := edtSecondColumnTitle.Text;
  end else if ASender = rbtnSortByNumber then begin
    Options.General.SortByNumber.Value := True;
  end else if ASender = rbtnSortByState then begin
    Options.General.SortByNumber.Value := False;
  end else if ASender = cbxShowTime then begin
    Options.General.ShowTime.Value := cbxShowTime.Checked;
  end else if ASender = cbxShowToolBar then begin
    Options.General.ShowToolBar.Value := cbxShowToolBar.Checked;
  end else begin
    ASSERT(FALSE,
        'TfrmMain.ControlValueChange error! Unknown sender!');
  end;
  DoDesign;
end; // TfrmMain.ControlValueChange

procedure TfrmSettings.DoDesign;
begin
  DisableControls;
  with Options.General do begin
    pnlOnlyOneTimeColumnVisible.Enabled := OnlyOneTimeColumnVisible;
    cbxTime.Enabled := OnlyOneTimeColumnVisible;
    cbxCustomFirstColumnTitle.Enabled := OnlyOneTimeColumnVisible;
    edtFirstColumnTitle.Enabled := OnlyOneTimeColumnVisible;
    edtFirstColumnTitle.Color := IfThen(OnlyOneTimeColumnVisible, clWindow,
        clBtnFace);
    cbxCustomSecondColumnTitle.Enabled := OnlyOneTimeColumnVisible;
    edtSecondColumnTitle.Enabled := OnlyOneTimeColumnVisible;
    edtSecondColumnTitle.Color := IfThen(OnlyOneTimeColumnVisible, clWindow,
        clBtnFace);
  end;
  EnableControls;
end; // TfrmMain.DoDesign

procedure TfrmSettings.EnableControls;
begin
  FbControlsEnabled := True;
end; // TfrmMain.EnableControls

procedure TfrmSettings.DisableControls;
begin
  FbControlsEnabled := False;
end; // TfrmMain.DisableControls

procedure TfrmSettings.FormCreate(Sender: TObject);
var
  coder: TCoder;
begin
  DisableControls;
  with Options.General do begin
    if (Length(UnblockPasswordHash.Value) > 0) then begin
      coder := TCoder.Create;
      edtPassword.Text := coder.SimpleDecodeString(
          UnblockPasswordHash.Value);
      coder.Free;
    end else begin
      edtPassword.Text := '';
    end;
    edtConfirmation.Text := edtPassword.Text;
    _SetFont(StrToFont(Font.Value));
    edtSpaceLimitMin.Text := IntToStr(SpaceLimitMin.Value);
    edtBusyLimitMin.Text := IntToStr(BusyLimitMin.Value);
    cbxTime.Checked := Time.Value;
    cbxTime05.Checked := Time05.Value;
    cbxTime1.Checked := Time1.Value;
    cbxTime15.Checked := Time15.Value;
    cbxTime2.Checked := Time2.Value;
    cbxTime3.Checked := Time3.Value;
    cbxTime4.Checked := Time4.Value;
    cbxUseLargeIcons.Checked := UseLargeIcons.Value;
    cbxMarkBusyLimited.Checked := MarkBusyLimited.Value;
    cbxMarkFreeLimited.Checked := MarkFreeLimited.Value;
    cbxCustomFirstColumnTitle.Checked := CustomFirstColumnTitle.Value;
    edtFirstColumnTitle.Text := FirstColumnTitle.Value;
    cbxCustomSecondColumnTitle.Checked := CustomSecondColumnTitle.Value;
    edtSecondColumnTitle.Text := SecondColumnTitle.Value;
    rbtnSortByNumber.Checked := SortByNumber.Value;
    rbtnSortByState.Checked := not SortByNumber.Value;
    cbxShowTime.Checked := ShowTime.Value;
    cbxShowToolBar.Checked := ShowToolBar.Value;
  end;
  DoDesign;
  btnOk.Enabled := False;
  _SubscribeToOptionsEvents();
  EnableControls;

end;

procedure TfrmSettings._SetFont(const AFont: Tfont);
begin
  edtFont.Text := AFont.Name + ' ' + IntToStr(AFont.Size);
  edtFont.Font.Assign(AFont);
end;

procedure TfrmSettings._ApplySettings;
begin
  if (edtPassword.Text <> edtConfirmation.Text) then begin
    MessageBox(Application.Handle,'¬веденные пароли не совпадают!', 'ќшибка',
        MB_OK or MB_ICONWARNING);
  end else begin
    Options.Save;
    frmMain.ApplySettings;
  end;
end;

procedure TfrmSettings.btnOkClick(Sender: TObject);
begin
  _ApplySettings;
  ModalResult := mrOk;
end;

procedure TfrmSettings.btnApplyClick(Sender: TObject);
begin
  _ApplySettings;
  btnApply.Enabled := False;
end;

procedure TfrmSettings.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmSettings.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FOptionsLink);
end;

end.
