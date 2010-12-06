unit frmCompManualPrint;

interface

uses
  GCLangUtils, GCComputers, GCCommon,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin;

type
  TformCompManualPrint = class(TForm)
    butOk: TButton;
    butCancel: TButton;
    editMoney: TEdit;
    lblSumma: TLabel;
    editComputer: TEdit;
    lblComputer: TLabel;
    timerAdd: TTimer;
    sePages: TSpinEdit;
    lblPages: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure butOkClick(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure editMoneyChange(Sender: TObject);
    procedure timerAddTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure sePagesChange(Sender: TObject);
  private
    { Private declarations }
    oldstring: string;
    oldcursor: integer;
    lock: boolean;
    sourceUID: string;
  public
    { Public declarations }
  end;

var
  formCompManualPrint: TformCompManualPrint;

implementation

uses
  frmGCMessageBox,
  GCSessions,
  uRegistry;

{$R *.dfm}

procedure TformCompManualPrint.FormActivate(Sender: TObject);
begin
  ModalResult := mrCancel;
  Caption := translate('mnuManualPrint');
  butCancel.Caption := translate('butCancel');
  lblComputer.Caption := translate('Computer');
  lblSumma.Caption := translate('lblSumma');
  lblPages.Caption := translate('lblPages');
  editMoney.Text := '';
  editMoney.Enabled := false;
  lock := false;  
  // Set Computer Number
  editComputer.Text := Comps[ComputersGetIndex(CompsSel[0])].GetStrNumber;
  sePages.Value := 1;
  sePages.SetFocus;
  sourceUID := Comps[ComputersGetIndex(CompsSel[0])].session.UID;
  timerAdd.Enabled := true;
  sePagesChange(nil); 
end;

procedure TformCompManualPrint.butOkClick(Sender: TObject);
//var
//  AddSumma: double;
begin
  // проверка, что введена сумма не меньше минимальной
  timerAddTimer(Sender);
  timerAdd.Enabled := false;
  ModalResult := mrOk;
  Hide;
end;

procedure TformCompManualPrint.butCancelClick(Sender: TObject);
begin
  timerAdd.Enabled := false;
  ModalResult := mrCancel;
  Hide;
end;

procedure TformCompManualPrint.editMoneyChange(Sender: TObject);
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
end;

procedure TformCompManualPrint.timerAddTimer(Sender: TObject);
var
  session: ^GCSessions.TGCSession;
begin
  session := @(Comps[ComputersGetIndex(CompsSel[0])].session);
  if (session^ = nil) then 
    butCancelClick(nil)
  else
   if session^.UID <> sourceUID then
     butCancelClick(nil);
end;

procedure TformCompManualPrint.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then
    butCancelClick(Nil);
end;

procedure TformCompManualPrint.sePagesChange(Sender: TObject);
begin
  editMoney.Text := FloatToStrGC(GRegistry.Options.PrintedPageCost * sePages.Value);
end;

end.
