unit ufrmServerName;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ADODB;

type
  TfrmServerName = class(TForm)
    Label1: TLabel;
    edtServerName: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    btnServerList: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnServerListClick(Sender: TObject);
  private
    FcnnResult: TADOConnection;
    function GetServerName: String;
    procedure SetServerName(const AstrValue: String);
  public
    constructor Create(const AOwner: TComponent;
        const AcnnResult: TADOConnection;
        const AstrServerName: String = ''); reintroduce;
    property ServerName: String
        read GetServerName write SetServerName;
  end;

var
  frmServerName: TfrmServerName;

implementation

uses
  uSQLTools,
  uSyncConst, ufrmSQLServerList;


{$R *.dfm}

constructor TfrmServerName.Create(const AOwner: TComponent;
    const AcnnResult: TADOConnection;
    const AstrServerName: String = '');
begin
  ASSERT(Assigned(AcnnResult));
  inherited Create(AOwner);
  FcnnResult := AcnnResult;
  SetServerName(AstrServerName);
end;

function TfrmServerName.GetServerName: String;
begin
  Result := edtServerName.Text;
end;

procedure TfrmServerName.SetServerName(const AstrValue: String);
begin
  edtServerName.Text := AstrValue;
end;

procedure TfrmServerName.btnOkClick(Sender: TObject);
var
  lstErrors: TStringList;
  nError: Integer;
  bConnected: Boolean;
  cursor: TCursor;
begin
  FcnnResult.Close;
  cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  lstErrors := TStringList.Create;
  if ADOConnect(FcnnResult, lstErrors, nError, True,
      edtServerName.Text, DB_NAME, DB_USER, DB_PASSWORD) then begin
    ModalResult := mrOk;
  end else
    Application.MessageBox(PChar(lstErrors.Text), PChar(ERROR));
  Screen.Cursor := cursor;
  FreeAndNil(lstErrors);
end;

procedure TfrmServerName.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmServerName.btnServerListClick(Sender: TObject);
var
  frmSQLServerList: TfrmSQLServerList;
begin
  frmSQLServerList := TfrmSQLServerList.Create(Self);
  if frmSQLServerList.ShowModal = mrOk then
    edtServerName.Text := frmSQLServerList.SelectedServer;
  FreeAndNil(frmSQLServerList);
end;

end.
