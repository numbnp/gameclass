unit uframeDiscounts;

interface

uses  
  GCConst, GCLangUtils, GCComputers, ADODB, GCCommon,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ComCtrls, StdCtrls,
  ExtCtrls, Grids, DBGridEh, DB, ValEdit;

type
  TframeDiscounts = class(TFrame)
    dsrcDiscounts: TDataSource;
    gbRefers: TGroupBox;
    dsrcReferals: TDataSource;
    butReferalsUpdate: TButton;
    butReferalsDel: TButton;
    editLevel: TEdit;
    editBonus: TEdit;
    lblBonus: TLabel;
    lblLevel: TLabel;
    butReferalsAdd: TButton;
    grdReferals: TDBGridEh;
    pcDiscounts: TPageControl;
    tabDiscount: TTabSheet;
    gbOptions: TGroupBox;
    butGoAccounts: TButton;
    cbxDiscountAfterLimitDisabled: TCheckBox;
    cbxDiscountForPacketsEnabled: TCheckBox;
    pnlDiscountsTable: TGroupBox;
    lblDiscount: TLabel;
    lblSumma: TLabel;
    editDiscount: TEdit;
    grdDiscounts: TDBGridEh;
    editSumma: TEdit;
    butDiscountAdd: TButton;
    butDiscountUpdate: TButton;
    butDiscountDel: TButton;
    pnlDiscountsRecalc: TGroupBox;
    Label1: TLabel;
    dtpStart: TDateTimePicker;
    Button1: TButton;
    tabRefers: TTabSheet;
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
    procedure grdReferalsCellClick(Column: TColumnEh);
    procedure butReferalsAddClick(Sender: TObject);
    procedure butReferalsDelClick(Sender: TObject);
    procedure butReferalsUpdateClick(Sender: TObject);
    procedure editLevelChange(Sender: TObject);
    procedure editBonusChange(Sender: TObject);
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
  gbRefers.Enabled := cbxUseRefers.Checked;
  dsrcDiscounts.DataSet := GAccountSystem.AccountsDiscounts;
  grdDiscountsCellClick(Nil);
  dsrcReferals.DataSet := GAccountSystem.AccountsReferals;
  grdReferalsCellClick(Nil);
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
  bReferalsEnabled: Boolean;
begin
  bEnabled := GAccountSystem.Enabled;
  cbxDiscountAfterLimitDisabled.Enabled := bEnabled;
  cbxDiscountForPacketsEnabled.Enabled := bEnabled;
  grdDiscounts.Enabled := bEnabled;
  editSumma.Enabled := bEnabled;
  editDiscount.Enabled := bEnabled;

  bReferalsEnabled := GAccountSystem.RefersSystemEnabled;
  gbRefers.Enabled := cbxUseRefers.Checked;
  grdReferals.Enabled := bReferalsEnabled;
  editLevel.Enabled := bReferalsEnabled;
  editBonus.Enabled := bReferalsEnabled;
  butGoAccounts.Enabled := bReferalsEnabled;
{
  butDiscountDel.Enabled := (grdDiscounts.SelectedIndex <> -1) and bEnabled and bReferalsEnabled;
  butDiscountAdd.Enabled := ((editSumma.Text<>'') and (editDiscount.Text<>''))
      and bReferalsEnabled;
  butDiscountUpdate.Enabled := (butDiscountDel.Enabled and FbEdited)
      and bReferalsEnabled;
}
  butReferalsDel.Enabled := (grdReferals.SelectedIndex <> -1) and bEnabled and bReferalsEnabled;
  butReferalsAdd.Enabled := ((editLevel.Text<>'') and (editBonus.Text<>''))
      and bEnabled and bReferalsEnabled;
  butReferalsUpdate.Enabled := (butReferalsDel.Enabled and FbEdited)
      and bEnabled and bReferalsEnabled;


//  editSumma.Text := Format('%.*d', ['1.5']);
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
  DoDesign;
  EnableControls;
end;

procedure TframeDiscounts.grdReferalsCellClick(Column: TColumnEh);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  if (GAccountSystem.AccountsReferals.RecordCount > 0) then begin
    editLevel.Text := IntToStr(
        GAccountSystem.AccountsReferals.Current.Level );
    editBonus.Text := IntToStr(
        GAccountSystem.AccountsReferals.Current.Percent );
  end;
  DoDesign;
  EnableControls;

end;

procedure TframeDiscounts.butReferalsAddClick(Sender: TObject);
var
  nId: Integer;
  nLevel: Integer;
  nBonus: Integer;
begin
  // check level and bonus
  nLevel := StrToIntDef(editLevel.Text,0);
  nBonus := StrToIntDef(editBonus.Text, 0);
  with GAccountSystem.AccountsReferals do begin
    First;
    while not Eof do begin
      if ((Current.Level = nLevel) or
          (Current.Percent = nBonus)) then begin
        MessageBox(HWND_TOP,PChar(GClangutils.translate('ReferalWarning')),
            PChar(GClangutils.translate('Warning')),MB_OK);
        exit;
      end;
      Next;
    end;
  end;
  GAccountSystem.AccountsReferals.Append;
  GAccountSystem.AccountsReferals.Current.Level := nLevel;
  GAccountSystem.AccountsReferals.Current.Percent := nBonus;
  grdReferalsCellClick(Nil);
end;
procedure TframeDiscounts.butReferalsDelClick(Sender: TObject);
begin
  with GAccountSystem.AccountsReferals do
    Delete(Current.Id);
  grdReferalsCellClick(Nil);
end;

procedure TframeDiscounts.butReferalsUpdateClick(Sender: TObject);
var
  nId: Integer;
  nLevel: Integer;
  nBonus: Integer;
begin
  nLevel := StrToIntDef(editLevel.Text,0);
  nBonus := StrToIntDef(editBonus.Text, 0);
  with GAccountSystem.AccountsReferals do begin
    First;
    while not Eof do begin
      if ((Current.Level <> nLevel) and
          (Current.Percent = nBonus)) then begin
        MessageBox(HWND_TOP,PChar(GClangutils.translate('BonusInOtherLevel')),
            PChar(GClangutils.translate('Warning')),MB_OK);
        exit;
      end;
      Next;
    end;
  end;
  GAccountSystem.AccountsReferals.LocateByLevel(nLevel);
  GAccountSystem.AccountsReferals.Current.Level := nLevel;
  GAccountSystem.AccountsReferals.Current.Percent := nBonus;
  DoDesign;
end;

procedure TframeDiscounts.editLevelChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  FbEdited := true;
  DoDesign;
  EnableControls;
end;

procedure TframeDiscounts.editBonusChange(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  FbEdited := true;
  DoDesign;
  EnableControls;
end;

end.
