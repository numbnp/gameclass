unit ufrmUnblockPassword;

interface

uses
  Messages,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  SysUtils,
  Variants,
  Classes,
  Types;

type
  TfrmUnblockPassword = class(TForm)
    edtUnblockPassword: TEdit;
    btnOk: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtUnblockPasswordKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FbBeforeFirstFormShow: Boolean;
  public
    { Public declarations }
//    procedure Show;
  end;

var
  frmUnblockPassword: TfrmUnblockPassword;

implementation
  {$R *.dfm}
uses
  uViewerOptions,
  uCoder;

procedure TfrmUnblockPassword.btnOkClick(Sender: TObject);
var
  Fcoder : TCoder;
  bUnblockedByPassword: Boolean;
begin
  Fcoder := TCoder.Create;
  bUnblockedByPassword := (Options.General.UnblockPasswordHash.Value =
      FCoder.SimpleEncodeString(edtUnblockPassword.Text));
  FCoder.Free;
  edtUnblockPassword.Text := '';
  if bUnblockedByPassword then
    ModalResult := mrOK
  else
    ModalResult := mrCancel;
end;

procedure TfrmUnblockPassword.FormShow(Sender: TObject);
begin
  edtUnblockPassword.Text := '';
end;

procedure TfrmUnblockPassword.FormCreate(Sender: TObject);
begin
  FbBeforeFirstFormShow := True;
end;

procedure TfrmUnblockPassword.edtUnblockPasswordKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (Key = 13{Enter}) then
    btnOkClick(Sender);
end;

end.
