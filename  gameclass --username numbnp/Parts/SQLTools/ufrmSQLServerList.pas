unit ufrmSQLServerList;

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
  StdCtrls,
  ExtCtrls;

type
  TfrmSQLServerList = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Panel1: TPanel;
    lbxServers: TListBox;
    btnOk: TButton;
    btnCancel: TButton;
    Label2: TLabel;
  private
    function GetSelectedServer: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ShowModal: Integer; override;
    property SelectedServer: String read GetSelectedServer;
  end;

var
  frmSQLServerList: TfrmSQLServerList;

implementation

uses
  ComObj;


{$R *.dfm}
constructor TfrmSQLServerList.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

function TfrmSQLServerList.ShowModal: Integer;
var
  dmo: OleVariant;
  i: Integer;
  cur: TCursor;
begin
  try
    dmo := CreateOleObject('SQLDMO.SQLServer');
    dmo := dmo.Application;
    cur := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    dmo := dmo.ListAvailableSQLServers;
    Screen.Cursor := cur;
    for i := 1 to dmo.Count do
      lbxServers.Items.Add(AnsiUpperCase(dmo.Item(i)));
    dmo := null;
    if lbxServers.Count > 0 then
      lbxServers.Selected[0] := True;
    Result := inherited ShowModal;
  except
    MessageBox(Handle, 'Невозможно создать обьект SQLDMO.SQLServer!',
        'Ошибка',MB_OK or MB_ICONERROR);
    Result := mrCancel;
  end;
end;

destructor TfrmSQLServerList.Destroy;
begin
  inherited Destroy;
end;

function TfrmSQLServerList.GetSelectedServer: String;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to lbxServers.Count - 1 do
    if lbxServers.Selected[i] then
      Result := lbxServers.Items[i];
end;
end.
