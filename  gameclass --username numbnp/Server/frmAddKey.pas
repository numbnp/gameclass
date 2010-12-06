unit frmAddKey;

interface

uses
  GCLangUtils,
  StrUtils,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TformAddKey = class(TForm)
    butOk: TButton;
    butCancel: TButton;
    memoKey: TMemo;
    lblEnterKey: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure butOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAddKey: TformAddKey;

implementation

{$R *.dfm}

procedure TformAddKey.FormActivate(Sender: TObject);
begin
  ModalResult := mrCancel;
  Caption := translate('frmAddKeyCaption');
  butCancel.Caption := translate('butCancel');
  lblEnterKey.Caption := translate('lblEnterKey');
  memoKey.Text := '';
end;

procedure TformAddKey.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then ModalResult := mrCancel;
end;

procedure TformAddKey.butOkClick(Sender: TObject);
var
 s: string;
 i: integer;
begin
 if memoKey.Lines.Count>0 then begin
   s := '';
   for i:=0 to (memoKey.Lines.Count-1) do s := s + memoKey.Lines[i];
   memoKey.Text := s;
 end; //if
end;

end.
