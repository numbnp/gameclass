unit frmPassChange;

interface

uses
  GCLangUtils, GCCommon, GCConst, GCComputers,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TformPassChange = class(TForm)
    editOldPass: TEdit;
    lblOldPassword: TLabel;
    butOk: TButton;
    butCancel: TButton;
    editNewPass: TEdit;
    lblNewPassword: TLabel;
    lblRepeatPassword: TLabel;
    editRepeatPass: TEdit;
    Image1: TImage;
    procedure FormActivate(Sender: TObject);
    procedure editNewPassChange(Sender: TObject);
    procedure editRepeatPassChange(Sender: TObject);
    procedure butOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formPassChange: TformPassChange;

implementation

{$R *.dfm}

procedure TformPassChange.FormActivate(Sender: TObject);
begin
  ModalResult := mrCancel;
  editOldPass.Text := '';
  editNewPass.Text := '';
  editRepeatPass.Text := '';
  Caption := translate('mnuChangePass');
  butCancel.Caption := translate('butCancel');
  lblOldPassword.Caption := translate('lblOldPassword');
  lblNewPassword.Caption := translate('lblNewPassword');
  lblRepeatPassword.Caption := translate('lblRepeatPassword');
end;

procedure TformPassChange.editNewPassChange(Sender: TObject);
begin
  butOk.Enabled := (editNewPass.Text = editRepeatPass.Text);
end;

procedure TformPassChange.editRepeatPassChange(Sender: TObject);
begin
  butOk.Enabled := (editNewPass.Text = editRepeatPass.Text);
end;

procedure TformPassChange.butOkClick(Sender: TObject);
begin
  try
    dsDoCommandChangePass(DS_PASS_CHANGE + ' @oldpass=''' + formPassChange.editOldPass.Text + ''', @newpass=''' + formPassChange.editNewPass.Text + '''');
    formPassChange.editOldPass.Text := '';
    formPassChange.editNewPass.Text := '';
    formPassChange.editRepeatPass.Text := '';
    Console.AddEvent(EVENT_ICON_INFORMATION, LEVEL_0, translate('PassChanged') + ' ' + CurOperatorName);
  except
    raise;
  end;
end;

procedure TformPassChange.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then ModalResult := mrCancel;
end;

end.
