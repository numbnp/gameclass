unit uframeDiscounts;

interface

uses  
  GCConst, GCLangUtils, GCComputers, ADODB, GCCommon,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Grids, DBGridEh, DB, ValEdit;

type
  TframeDiscounts = class(TFrame)
    gbOptions: TGroupBox;
    butDiscountAdd: TButton;
    butDiscountUpdate: TButton;
    butDiscountDel: TButton;
    editSumma: TEdit;
    editDiscount: TEdit;
    lblSumma: TLabel;
    lblDiscount: TLabel;
    butGoAccounts: TButton;
    grdDiscounts: TDBGridEh;
    dsrcDiscounts: TDataSource;
    cbxDiscountAfterLimitDisabled: TCheckBox;
    cbxDiscountForPacketsEnabled: TCheckBox;
    pnlDiscountsTable: TGroupBox;
    pnlDiscountsRecalc: TGroupBox;
    dtpStart: TDateTimePicker;
    Button1: TButton;
    Label1: TLabel;
    gbRefers: TGroupBox;
    vleBonus: TValueListEditor;
    cbxUseRefers: TCheckBox;
    procedure editSummaChange(Sender: TObject);
    procedure editDiscountChange(Sender: TObject);
    procedure butDiscountAddClick(Sender: TObject);
    procedure butDiscountDelClick(Sender: TObject);
    procedure butDiscountUpdateClick(Sender: TObject);
    procedure butGoAccountsClick(Sender: TObject);
    procedure grdDiscountsCellClick(Column: TColumnEh);
    procedure cbxDiscountAfterLimitDisabledClick(Sender: TObject);
    procedure cbxDiscountForPacketsEnabledClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure cbxUseRefersClick(Sender: TObject);
  private
  { Private declarations }
    FbControlsEnabled: Boolean;
    FbLock: Boolean;
    FbEdited: boolean;
    procedure ResetFrame;
    procedure DoDesign;
  public
    function GetID: integer;
    procedure Activate(ID: integer);
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
    { Public declarations }
  end;

implementation

uses
  frmMain,
  uProtocol,
  frmGCMessageBox,
  uClientOptions,
  uAccountSystem,
  uAccountsDiscounts,
  uGCDataSet,
  uY2KString,
  udmMain,
  uSQLTools, DateUtils;

{$R *.dfm}

function TframeDiscounts.GetID: integer;
begin
  GetID := FRAME_DISCOUNTS;
end;

// процедура ставит все контролы в исходные позиции
procedure TframeDiscounts.ResetFrame;
begin
  DisableControls;
  cbxDiscountAfterLimitDisabled.Checked :=
      GAccountSystem.DiscountAfterLimitDisabled;
  cbxDiscountForPacketsEnabled.Checked :=
      GAccountSystem.DiscountForPacketsEnabled;
  cbxUseRefers.Checked := GAccountSystem.RefersSystemEnabled;
  dsrcDiscounts.DataSet := GAccountSystem.AccountsDiscounts;
  grdDiscountsCellClick(Nil);
  dtpStart.DateTime := DateOf(IncMonth(Now, -1));
  EnableControls;
end;

procedure TframeDiscounts.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
  gbOptions.Caption := translate('Options');
  grdDiscounts.Columns[1].Title.Caption := translate('TotalColumn');
  grdDiscounts.Columns[2].Title.Caption := translate('DiscountColumn');
  lblSumma.Caption := translate('Total');
  lblDiscount.Caption := translate('Discount');
  butGoAccounts.Caption := translate('Clients');
  butDiscountAdd.Caption := translate('Add');
  butDiscountDel.Caption := translate('Delete');
  butDiscountUpdate.Caption := translate('Update');
  DoDesign;
end;


procedure TframeDiscounts.DoDesign;
var
  bEnabled: Boolean;
begin
  bEnabled := GAccountSystem.Enabled;
  cbxDiscountAfterLimitDisabled.Enabled := bEnabled;
  cbxDiscountForPacketsEnabled.Enabled := bEnabled;
  grdDiscounts.Enabled := bEnabled;
  editSumma.Enabled := bEnabled;
  editDiscount.Enabled := bEnabled;
  butGoAccounts.Enabled := bEnabled;
   butDiscountDel.Enabled := (grdDiscounts.SelectedIndex <> -1) and bEnabled;
  butDiscountAdd.Enabled := ((editSumma.Text<>'') and (editDiscount.Text<>''))
      and bEnabled;
  butDiscountUpdate.Enabled := (butDiscountDel.Enabled and FbEdited)
      and bEnabled;
  editSumma.Text := Format('%.*d', ['1456dad']);
end;

procedure TframeDiscounts.editSummaChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  FbEdited := true;
  DoDesign;
  EnableControls;
end;

procedure TframeDiscounts.editDiscountChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  FbEdited := true;
  DoDesign;
  EnableControls;
end;

procedure TframeDiscounts.butDiscountAddClick(Sender: TObject);
var
  nId: Integer;
  fSummary: Double;
  nDiscount: Integer;
begin
  // check summa and discount
  fSummary := StrToFloatDefWithReplace(editSumma.Text,0);
  nDiscount := StrToIntDef(editDiscount.Text, 0);
  with GAccountSystem.AccountsDiscounts do begin
    First;
    while not Eof do begin
      if ((Current.Summary = fSummary) or
          (Current.Discount = nDiscount)) then begin
        MessageBox(HWND_TOP,PChar(GClangutils.translate('DiscountWarning')),
            PChar(GClangutils.translate('Warning')),MB_OK);
        exit;
      end;
      Next;
    end;
  end;
  GAccountSystem.AccountsDiscounts.Append;
  GAccountSystem.AccountsDiscounts.Current.Summary := fSummary;
  GAccountSystem.AccountsDiscounts.Current.Discount := nDiscount;
  grdDiscountsCellClick(Nil);
end;

procedure TframeDiscounts.butDiscountDelClick(Sender: TObject);
begin
  with GAccountSystem.AccountsDiscounts do
    Delete(Current.Id);
  grdDiscountsCellClick(Nil);
end;

procedure TframeDiscounts.butDiscountUpdateClick(Sender: TObject);
var
  nId: Integer;
  fSummary: Double;
  nDiscount: Integer;
begin
  fSummary := StrToFloatDef(editSumma.Text,0);
  nDiscount := StrToIntDef(editDiscount.Text, 0);
  with GAccountSystem.AccountsDiscounts do begin
    nId := Current.Id;
    First;
    while not Eof do begin
      if ((Current.Summary = fSummary)
          or (Current.Discount = nDiscount))
          and (Current.Id <> nId) then begin
        MessageBox(HWND_TOP,PChar(GClangutils.translate('DiscountWarning')),
            PChar(GClangutils.translate('Warning')),MB_OK);
        exit;
      end;
      Next;
    end;
  end;
  GAccountSystem.AccountsDiscounts.LocateById(nId);
  GAccountSystem.AccountsDiscounts.Current.Summary := fSummary;
  GAccountSystem.AccountsDiscounts.Current.Discount := nDiscount;
  DoDesign;
end;

procedure TframeDiscounts.butGoAccountsClick(Sender: TObject);
begin
  formMain.mnuAccounts2Click(Sender);
end;

procedure TframeDiscounts.grdDiscountsCellClick(Column: TColumnEh);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  if (GAccountSystem.AccountsDiscounts.RecordCount > 0) then begin
    editSumma.Text := FloatToStr(
        GAccountSystem.AccountsDiscounts.Current.Summary);
    editDiscount.Text := IntToStr(
        GAccountSystem.AccountsDiscounts.Current.Discount);
  end;
  DoDesign;
  EnableControls;
end;

procedure TframeDiscounts.cbxDiscountAfterLimitDisabledClick(
  Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.DiscountAfterLimitDisabled :=
      cbxDiscountAfterLimitDisabled.Checked;
  EnableControls;
end;

procedure TframeDiscounts.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TframeDiscounts.DisableControls;
begin
  FbControlsEnabled := False;
end;


procedure TframeDiscounts.cbxDiscountForPacketsEnabledClick(Sender: TObject);
begin
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.DiscountForPacketsEnabled :=
      cbxDiscountForPacketsEnabled.Checked;
  EnableControls;
end;

end;

procedure TframeDiscounts.Button1Click(Sender: TObject);
begin
  if uSQLTools.dsDoCommand(dmMain.cnnMain, 'exec DiscountsRecalc @dtStart='''
      + DateTimeToSQLStr(dtpStart.Date) + '''') then
    Application.MessageBox('Переасчет выполнен успешно!', 'Сообщение', MB_OK)
  else
    Application.MessageBox('При выполнении переасчета возникла ошибка!',
        'Ошибка', MB_OK or MB_ICONERROR);
end;

procedure TframeDiscounts.cbxUseRefersClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  GAccountSystem.RefersSystemEnabled  :=
      cbxUseRefers.Checked;
  EnableControls;
end;

end.
