unit uframeMessages;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TframeMessages = class(TFrame)
    Panel1: TPanel;
    Panel2: TPanel;
    memMessages: TMemo;
    Panel3: TPanel;
    edtMessage: TEdit;
    btnSend: TButton;
    lvUsers: TListView;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
    procedure btnSendClick(Sender: TObject);
    procedure edtMessageKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    strCurrentSelection: String;
    { Private declarations }
  public
    { Public declarations }
    procedure UpdateUserList;
  end;


implementation

uses
  GCComputers,
  frmMain,
  uProtocol,
  uClientInfoConst;
{$R *.dfm}
procedure TframeMessages.UpdateUserList;
var
  liCurrent: TListItem;
  i : Integer;
begin
  strCurrentSelection := '';
  for i:=0 to lvUsers.Items.Count-1 do
    with lvUsers.Items[i] do
      if Selected then
        strCurrentSelection := strCurrentSelection + ' ' + Caption + '('
        + SubItems[0] + ') ';
  lvUsers.Items.Clear;
  for i:=0 to CompsCount-1 do
    if Comps[i] <> nil then
      with Comps[i] do
        if (session <> Nil) or (a.state = ClientState_Order) then begin
          liCurrent := lvUsers.Items.Add;
          liCurrent.Caption := GetAccountName(a);
          liCurrent.SubItems.Add(IntToStr(number));
          liCurrent.SubItems.Add(ipaddr);
        end;
  for i:=0 to lvUsers.Items.Count-1 do
    with lvUsers.Items[i] do
      if Pos(' ' + Caption + '(' + SubItems[0] + ') ',strCurrentSelection)<>0 then
        Selected := TRUE;
end;

procedure TframeMessages.Timer1Timer(Sender: TObject);
begin
  UpdateUserList;
end;

procedure TframeMessages.btnSendClick(Sender: TObject);
var
  i : Integer;
begin
  memMessages.Lines.Add('-> '+ strCurrentSelection);
  memMessages.Lines.Add(edtMessage.Text);
  for i:=0 to lvUsers.Items.Count-1 do
    with lvUsers.Items[i] do
      if Selected then
        UDPSend(SubItems[1]{IP},STR_CMD_SENDMESSAGE + '='
          + CurOperatorName + '//' + edtMessage.Text);
  edtMessage.Text := '';
end;

procedure TframeMessages.edtMessageKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 13{Enter}) then
    btnSendClick(Sender);
end;

end.
