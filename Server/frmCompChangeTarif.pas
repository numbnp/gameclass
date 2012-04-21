unit frmCompChangeTarif;

interface

uses
  GCLangutils, GCComputers, GCConst, DateUtils, GCCommon, frmGCMessageBox,
  Menus, ExtCtrls, StdCtrls, Controls, ComCtrls, Classes,
  StrUtils, Windows, Messages, SysUtils, Variants, Graphics, Forms,
  Dialogs, Grids, ValEdit, Mask;

type
  TformCompChangeTarif = class(TForm)
    butOk: TButton;
    butCancel: TButton;
    dtpNewStart: TDateTimePicker;
    dtpNewStop: TDateTimePicker;
    lblNewStart: TLabel;
    lblNewStop: TLabel;
    editMoneyLeft: TEdit;
    lblNewTariff: TLabel;
    editComputer: TEdit;
    lblComputer: TLabel;
    timerFrmCompChangeTarif: TTimer;
    cbPostPay: TCheckBox;
    lvTarifs: TListView;
    gbCurrentTariff: TGroupBox;
    lblCurStart: TLabel;
    lblCurStop: TLabel;
    lblCurTariff: TLabel;
    lblMoneyLeft: TLabel;
    dtpCurStart: TDateTimePicker;
    dtpCurStop: TDateTimePicker;
    editCurTariff: TEdit;
    gbNewTariff: TGroupBox;
    lblTimeLeft: TLabel;
    editTimeLeft: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure butOkClick(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure timerFrmCompChangeTarifTimer(Sender: TObject);
    procedure lvTarifsClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FnSelectedTarifIndex: Integer;
    procedure UpdateInformation;
  public
    { Public declarations }
    property SelectedTarifIndex: Integer read FnSelectedTarifIndex;
  end;

var
  formCompChangeTarif: TformCompChangeTarif;

implementation
{$R *.dfm}
uses
  GCSessions,
  uVirtualTime,
  uTariffication;

procedure TformCompChangeTarif.FormActivate(Sender: TObject);
begin
  ModalResult := mrCancel;
  Caption := translate('fnChangeTarifName');
  lblComputer.Caption := translate('Computer');
  lblMoneyLeft.Caption := translate('lblMoneyLeft');
  lblTimeLeft.Caption := translate('lblTimeLeft');
  lblCurTariff.Caption := translate('Tarif');
  lblNewTariff.Caption := translate('Tarif');
  lblCurStart.Caption := translate('lblStartDate');
  lblNewStart.Caption := translate('lblStartDate');
  lblCurStop.Caption := translate('lblEndDate');
  lblNewStop.Caption := translate('lblEndDate');
  butCancel.Caption := translate('butCancel');
  cbPostPay.Caption := translate('cbPostPay');
  butOk.Enabled := false;
  editComputer.Text := Comps[ComputersGetIndex(CompsSel[0])].GetStrNumber;
  lvTarifs.Clear;
  FnSelectedTarifIndex := -1;
  // Fill comps
  timerFrmCompChangeTarifTimer(Sender);
  timerFrmCompChangeTarif.Enabled := true;
end;

procedure TformCompChangeTarif.butOkClick(Sender: TObject);
var
  StartSumma: double;
begin
  timerFrmCompChangeTarifTimer(nil);
  timerFrmCompChangeTarif.Enabled := false;
  ModalResult := mrOk;
  Hide;
end;

procedure TformCompChangeTarif.butCancelClick(Sender: TObject);
begin
  timerFrmCompChangeTarif.Enabled := false;
  ModalResult := mrCancel;
  Hide;
end;


procedure TformCompChangeTarif.timerFrmCompChangeTarifTimer(Sender: TObject);
begin
  UpdateInformation;
end;

procedure TformCompChangeTarif.UpdateInformation;
var
  stop: TDateTime;
  dtLeft: TDateTime;
  old_lock: boolean;
  tdMoney: double;
  nCompIndex: integer;
  nTarifIndex: integer;
  session: GCSessions.TGCSession;
  i: integer;
  li: TListItem;
begin
  nCompIndex := ComputersGetIndex(CompsSel[0]);
  if (CompsSelCount<>1) or  Not(Comps[nCompIndex].busy) or
     (Comps[nCompIndex].a.number <> 0) or (Comps[nCompIndex].session.Whole <> 0) then
    butCancelClick(Self);
  session := Comps[nCompIndex].session;
  //Fill tariffs
  if (lvTarifs.Items.Count = 0) then begin
    for i:=1 to (TarifsCount-1) do
      if OperatorSecLevel >= Tarifs[i].operatorlevel then
        if ((Tarifs[i].idGroup = Comps[ComputersGetIndex(CompsSel[0])].IdGroup) and
          (Tarifs[i].id <> session.IdTarif)) then begin
          li := lvTarifs.Items.Add;
          li.Caption := Tarifs[i].name;
          li.Data := nil;
        end;
    if (lvTarifs.Items.Count >0) then begin
      lvTarifs.ItemIndex := 0;
      lvTarifsClick(Self);
    end;
  end;
  cbPostPay.Checked := session.PostPay;
  dtpCurStart.DateTime := session.TimeStart;
  dtpCurStop.DateTime := session.TimeStop;
  editTimeLeft.Text := DateTimeToTimeString(session.TimeStop-GetVirtualTime,True);
  editMoneyLeft.Text := session.GetStrMoneyLeft;
  editCurTariff.Text := session.GetStrTarif;

  dtpNewStart.DateTime := GetVirtualTime;
  //session.SetIdTarif(TarifsGetId(lbTarifs.Items.Strings[lbTarifs.ItemIndex]));
  if (SelectedTarifIndex <> -1) then begin
    dtLeft := Tarifs[SelectedTarifIndex].CalculateTimeLength(
      dtpNewStart.DateTime,
      StrToFloatGC(editMoneyLeft.Text),
      Comps[nCompIndex].IdGroup, 0);
    //dtLeft := Tarifs[SelectedTarifIndex].fnRoundTime(dtLeft,Tarifs[SelectedTarifIndex].roundtime, -1);
    dtLeft := IncMinute(dtLeft,-session.GetPenalty);
//      tdMoney := Tarifs[TarifsGetIndex(session.GetIdTarif)].CalculateCost(session.GetStart, session.GetStop, Comps[ComputersGetIndex(session.GetIdComp)].IdGroup,a s y s.GetDiscount(session.GetClient));
//      tdMoney := Tarifs[TarifsGetIndex(session.GetIdTarif)].fnRoundMoney(tdMoney, Tarifs[TarifsGetIndex(session.GetIdTarif)].roundmoney, 1);
    dtpNewStop.DateTime := dtpNewStart.DateTime + dtLeft;
    editTimeLeft.Text := DateTimeToTimeString(dtLeft,True);
    butOk.Enabled := (( HourOf(dtLeft)<>0 ) or ( MinuteOf(dtLeft) <> 0 ));
  end
  else
    butOk.Enabled := False;
end;

procedure TformCompChangeTarif.lvTarifsClick(Sender: TObject);
var
  Whole: TTarifVariants;
  index: integer;
  tm: TDateTime;
begin
  if (lvTarifs.ItemIndex = -1) then
    FnSelectedTarifIndex := -1
  else
    FnSelectedTarifIndex := TarifsGetIndex(TarifsGetId(lvTarifs.Items[lvTarifs.ItemIndex].Caption));
  UpdateInformation;
end;

procedure TformCompChangeTarif.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then
    butCancelClick(Nil);
end;

end.
