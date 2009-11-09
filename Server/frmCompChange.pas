unit frmCompChange;

interface

uses
  GCLangUtils, GCComputers, GCCommon,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TformCompChange = class(TForm)
    butOk: TButton;
    butCancel: TButton;
    editComputer: TEdit;
    lblComputer: TLabel;
    timerChange: TTimer;
    cbComputer: TComboBox;
    lblComputer2: TLabel;
    lblVs: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure butOkClick(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure timerChangeTimer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cbComputerSelect(Sender: TObject);
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
  formCompChange: TformCompChange;

implementation

uses frmGCMessageBox,GCSessions;

{$R *.dfm}

procedure TformCompChange.FormActivate(Sender: TObject);
var
  i,n: Integer;
begin
  ModalResult := mrCancel;
  Caption := translate('MoveComp');
  butCancel.Caption := translate('butCancel');
  lblComputer.Caption := translate('Computer');
  lblComputer2.Caption := translate('Computer');
  lock := false;
  // Set Computer Number
  editComputer.Text := Comps[ComputersGetIndex(CompsSel[0])].GetStrNumber;
  cbComputer.SetFocus;
  sourceUID := Comps[ComputersGetIndex(CompsSel[0])].session.UID;
  timerChange.Enabled := true;
  cbComputer.Items.Clear;
  butOk.Enabled := False;
  for i:=0 to (CompsCount-1) do
    if (Comps[i].idGroup = Comps[ComputersGetIndex(CompsSel[0])].IdGroup) and
      (Comps[ComputersGetIndex(CompsSel[0])].session.TimeStop <= GSessions.GetMaxStopTime(Comps[i].id)) and
      ((Comps[i].session = Nil) or (Comps[i].session.TimeStop <= GSessions.GetMaxStopTime(Comps[ComputersGetIndex(CompsSel[0])].id))) and
      (ComputersGetIndex(CompsSel[0]) <> i)then begin
      n := cbComputer.Items.Add(Comps[i].GetStrNumber);
      cbComputer.Items.Objects[n] := Comps[i];
      if (CompsSelCount = 2) and (ComputersGetIndex(CompsSel[1]) = i) then begin
        cbComputer.ItemIndex := n;
        butOk.Enabled := True;
      end;
    end;
end;

procedure TformCompChange.butOkClick(Sender: TObject);
begin
  timerChangeTimer(Sender);
  timerChange.Enabled := false;
  ModalResult := mrOk;
  Hide;
end;

procedure TformCompChange.butCancelClick(Sender: TObject);
begin
  timerChange.Enabled := false;
  ModalResult := mrCancel;
  Hide;
end;


procedure TformCompChange.timerChangeTimer(Sender: TObject);
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

procedure TformCompChange.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then
     butCancelClick(Nil);
end;

procedure TformCompChange.cbComputerSelect(Sender: TObject);
begin
   butOk.Enabled := True;
end;

end.
