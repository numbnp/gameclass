unit ufrmUnblockPassword;

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
{$IFDEF MSWINDOWS}
  {$R *.dfm}
{$ENDIF}
{$IFDEF LINUX}
  {$R *.xfm}
{$ENDIF}
uses
  uLocalCommandSender,
  uProtocol,
  uClientOptions,
  uClientInfo,
  uDebugLog,
  uCoder;
{
procedure TfrmUnblockPassword.Show;
begin
  ShowWindow(Application.Handle,SW_HIDE);  // Скрываем программу в таскбаре
  if FbBeforeFirstFormShow then begin
    frmMain.InitializeApplicationWindows;
    Application.NormalizeTopMosts;
    FormStyle := fsStayOnTop;
    FbBeforeFirstFormShow := False;
  end;
  inherited Show;
end;
}

procedure TfrmUnblockPassword.btnOkClick(Sender: TObject);
var
  Fcoder : TCoder;
  bUnblockedByPassword: Boolean;
begin
  Fcoder := TCoder.Create;
  bUnblockedByPassword := (GClientOptions.UnblockPasswordHash =
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
