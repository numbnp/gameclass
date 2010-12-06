unit frmMail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TformMail = class(TForm)
    pnlRead: TPanel;
    lbMessaged: TListBox;
    lblNewMessages: TLabel;
    memoMessage: TMemo;
    lblMessage: TLabel;
    memoAnswer: TMemo;
    lblAnswer: TLabel;
    butMarkAsRead: TButton;
    butSend: TButton;
    butClose: TButton;
    butHelp: TButton;
    cbOnlyUnread: TCheckBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure DoDesign;
  public
    mode: integer; // 0 - read, 1 - create new 
    { Public declarations }
  end;

var
  formMail: TformMail;

implementation

{$R *.dfm}

procedure TformMail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  // if ESC then quit
  if (key = 27) then ModalResult := mrOk;
end;

procedure TformMail.FormActivate(Sender: TObject);
begin
  mode := 1;
  DoDesign;
end;

procedure TformMail.DoDesign;
begin
//
end;

end.
