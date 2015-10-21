unit frmCompTrafficAdd;

interface

uses
  GCLangUtils, GCComputers, GCCommon,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GCSessions, Mask, RxToolEdit, RxCurrEdit;

type
  TformCompTrafficAdd = class(TForm)
    butOk: TButton;
    butCancel: TButton;
    editMoney: TEdit;
    lblSumma: TLabel;
    editComputer: TEdit;
    lblComputer: TLabel;
    timerAdd: TTimer;
    editTraffic: TEdit;
    Label1: TLabel;
    lblKB: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure butOkClick(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure editMoneyChange(Sender: TObject);
    procedure timerAddTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editTrafficChange(Sender: TObject);
  private
    { Private declarations }
    oldstring: string;
    oldcursor: integer;
    lock: boolean;
    sourceUID: string;
    session: GCSessions.TGCSession;
  public
    { Public declarations }
  end;

var
  formCompTrafficAdd: TformCompTrafficAdd;

implementation

uses
  frmGCMessageBox,
  Math,
  uRegistry,
  uTariffication;

{$R *.dfm}

procedure TformCompTrafficAdd.FormActivate(Sender: TObject);
begin
  ModalResult := mrCancel;
  Caption := translate('mnuAdd');  
  butCancel.Caption := translate('butCancel');
  lblComputer.Caption := translate('Computer');
  lblSumma.Caption := translate('lblSumma');  
  editMoney.Text := '';
  lock := false;
  // Set Computer Number
  editComputer.Text := Comps[ComputersGetIndex(CompsSel[0])].GetStrNumber;
  editMoney.SetFocus;
  sourceUID := Comps[ComputersGetIndex(CompsSel[0])].session.UID;
  session := Comps[ComputersGetIndex(CompsSel[0])].session;
  timerAdd.Enabled := true;
end;

procedure TformCompTrafficAdd.butOkClick(Sender: TObject);
var
  AddSumma: double;
begin
  // проверка, что введена сумма не меньше минимальной
  AddSumma := StrToFloatGC(formCompTrafficAdd.editMoney.Text);
  if (AddSumma < GRegistry.Options.AddMoneyMinimum)
      or (AddSumma > GRegistry.Options.AddMoneyMaximum) then
  begin
    formGCMessageBox.memoInfo.Text := translate('ErrorCompAdd1') + ' '
        + FloatToStr(GRegistry.Options.AddMoneyMinimum) + ' '
        + translate('ErrorCompAdd2') + ' '
        + FloatToStr(GRegistry.Options.AddMoneyMaximum);
    formGCMessageBox.SetDontShowAgain(false);
    formGCMessageBox.ShowModal;
    exit;
  end;
  timerAddTimer(Sender);
  timerAdd.Enabled := false;
  ModalResult := mrOk;
  Hide;
end;

procedure TformCompTrafficAdd.butCancelClick(Sender: TObject);
begin
  timerAdd.Enabled := false;
  ModalResult := mrCancel;
  Hide;
end;

procedure TformCompTrafficAdd.editMoneyChange(Sender: TObject);
var
  cursor: integer;
  i: integer;
  s: string;
  quantity: integer;
  buffer: string;
begin
  if lock then exit;
  cursor := editMoney.SelStart;
  buffer := StringReplace(editMoney.Text,',','.',[rfReplaceAll]);
//  if (buffer <> editMoney.Text) then cursor := cursor + 1;
  for i:=1 to length(buffer) do
  begin
    s := buffer[i];
    if ( s <> '0') and ( s <> '1') and ( s <> '2') and ( s <> '3') and
       ( s <> '4') and ( s <> '5') and ( s <> '6') and ( s <> '7') and
       ( s <> '8') and ( s <> '9') and ( s <> '.')
       then
       begin
         buffer := StringReplace(buffer,s,'',[rfReplaceAll]);
         cursor := cursor - 1;
         break;
       end;
  end;
  if (length(buffer)>0)  then
    if (buffer[1] = '.') then
    begin
      buffer := '0' + buffer;
      cursor := cursor + 1;
    end;
  // если уже несколько точек, то возвращаем прошлую строку
  quantity := 0;
  for i:=1 to length(buffer) do
    if (buffer[i] = '.') then quantity := quantity + 1;
  if (quantity > 1) then
  begin
    lock := true;
    editMoney.Text := oldstring;
    editMoney.SelStart := oldcursor;
    lock := false;
  end
  else
  begin
    lock := true;
    oldcursor := cursor;
    oldstring := buffer;
    editMoney.Text := buffer;
    lock := false;
    editMoney.SelStart := cursor;
  end;
  with session do begin
    try
      editTraffic.Text := IntToStr(Round(StrToFloatGC(editMoney.Text)
          / KBTrafficCost));
    except
    end;
  end
//  editTraffic.Text := IntToStr(session.GetTrafficLimit);
end;

procedure TformCompTrafficAdd.timerAddTimer(Sender: TObject);
begin
  session := Comps[ComputersGetIndex(CompsSel[0])].session;
  if (session = nil) then
    butCancelClick(nil)
  else
   if session.UID <> sourceUID then
     butCancelClick(nil);
end;

procedure TformCompTrafficAdd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then
    butCancelClick(Nil);
end;



procedure TformCompTrafficAdd.editTrafficChange(Sender: TObject);
begin
  with session do begin
    try
      editMoney.Text := FloatToStr(RoundTo(StrToFloatGC(editTraffic.Text)
          * KBTrafficCost, -2));
    except
    end;
  end
end;

end.
