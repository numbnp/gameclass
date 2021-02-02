unit UnitTestConn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  ADODb,
  Forms, Dialogs, StdCtrls, Mask, DBCtrlsEh,
  Controls;

type
  TfTestConn = class(TForm)
    DBMemoEh1: TDBMemoEh;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    SecondActive: Boolean;
  end;

var
  fTestConn: TfTestConn;


function TestConnLines(ConnLines: String; PathsList: String): Boolean;

implementation

uses Unit1;

{$R *.dfm}

function TestConnLines(ConnLines: String; PathsList: String): Boolean;
var
  AConnectionString: WideString;
begin
  AConnectionString := Form1.CreateRealConnectionString(ConnLines, PathsList);
  //DBMemoEh1.Lines.Text
  fTestConn := TfTestConn.Create(Application);
  fTestConn.DBMemoEh1.Lines.Text := AConnectionString;
  fTestConn.ShowModal;
  fTestConn.Free;
  Result := False;
end;

procedure TfTestConn.FormActivate(Sender: TObject);
var
  TestADOConnection: TADOConnection;
begin
  if SecondActive then Exit;

  Application.ProcessMessages;
  TestADOConnection := TADOConnection.Create(nil);
  try
    TestADOConnection.LoginPrompt := False;
    TestADOConnection.ConnectionString := fTestConn.DBMemoEh1.Lines.Text;
    TestADOConnection.Open;
    ShowMessage('Test connetion succeeded');
  finally
    FreeAndNil(TestADOConnection);
  end;

  SecondActive := True;
end;

end.
