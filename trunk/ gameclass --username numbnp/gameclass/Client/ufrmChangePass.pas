unit ufrmChangePass;

interface

uses
{$IFDEF MSWINDOWS}
  Messages,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
{$ENDIF}
{$IFDEF LINUX}
  QForms,
  QDialogs,
  QStdCtrls,
  QControls,
{$ENDIF}
  SysUtils,
  Variants,
  Classes,
  Types;

type
  TfrmChangePass = class(TForm)
    editOldPass: TEdit;
    editNewPass: TEdit;
    editRepeat: TEdit;
    butOk: TButton;
    butCancel: TButton;
    lblOldPass: TLabel;
    lblNewPass: TLabel;
    lblRepeat: TLabel;
    procedure butOkClick(Sender: TObject);
    procedure butCancelClick(Sender: TObject);
    procedure editNewPassChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmChangePass: TfrmChangePass;

implementation

{$IFDEF MSWINDOWS}
  {$R *.dfm}
{$ENDIF}
{$IFDEF LINUX}
  {$R *.xfm}
{$ENDIF}

procedure TfrmChangePass.butOkClick(Sender: TObject);
begin
  ModalResult := mrOK;
end;

procedure TfrmChangePass.butCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmChangePass.editNewPassChange(Sender: TObject);
begin
   if (editNewPass.Text <> editRepeat.Text) then
      butOk.Enabled := False
   else
      butOk.Enabled := True;
end;

end.
