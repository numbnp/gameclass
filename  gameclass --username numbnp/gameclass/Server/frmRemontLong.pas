unit frmRemontLong;

interface

uses
  GCLangUtils, GCConst, GCComputers,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TformRemontLong = class(TForm)
    butOk: TButton;
    butCancel: TButton;
    editRemontReason: TEdit;
    lblInputReason: TLabel;
    lblComputer: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure editRemontReasonChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formRemontLong: TformRemontLong;

implementation

{$R *.dfm}

procedure TformRemontLong.FormActivate(Sender: TObject);
begin
  ModalResult := mrCancel;
  Caption := translate('GoRemontLong');
  butCancel.Caption := translate('butCancel');
  lblInputReason.Caption := translate('lblInputReason');
  lblComputer.Caption := translate('Computer')+' '+Comps[ComputersGetIndex(CompsSel[0])].GetStrNumber;
  editRemontReason.Text := '';
  editRemontReason.SetFocus;
  butOk.Enabled := false;
end;

procedure TformRemontLong.editRemontReasonChange(Sender: TObject);
begin
  butOk.Enabled := (
    (length(editRemontReason.Text)>4) and
    (StrScan(PChar(editRemontReason.Text),'''')=nil) and 
    (StrScan(PChar(editRemontReason.Text),'"')=nil)
  );
end;

procedure TformRemontLong.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then ModalResult := mrCancel;
end;

end.
