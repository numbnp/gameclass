unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uUsersDataSet, StdCtrls, Grids, DBGridEh, DB, ADODB,
  uAccountsDataSet, uAutoUpdate, RxGIF, ExtCtrls, jpeg;

type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    DBGridEh1: TDBGridEh;
    Button1: TButton;
    Button2: TButton;
    ADODataSet1: TADODataSet;
    Edit1: TEdit;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    imgAccountPhoto: TImage;
    Button6: TButton;
    Button7: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
  private
    { Private declarations }
    FAutoUpdate: TAutoUpdate;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
//  FdsMain: TUsersDataSet;
  FdsMain: TAccountsDataSet;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  ADOConnection1.Connected := True;
//  FdsMain := TUsersDataSet.Create(Self, ADOConnection1);
  FdsMain := TAccountsDataSet.Create(Self, ADOConnection1);
  DataSource1.DataSet := FdsMain;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  FdsMain.SelectAll;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  FdsMain.Select(StrToInt(Edit1.Text));
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  FdsMain.Update(StrToInt(Edit1.Text));
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  FdsMain.Delete(StrToInt(Edit1.Text));
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  FAutoUpdate := TAutoUpdate.Create(ADOConnection1);
  FAutoUpdate.Add(FdsMain, 'Accounts', 1);
  FAutoUpdate.Active := True;
end;

procedure TForm1.Button6Click(Sender: TObject);
var
  stream : TStringStream;
begin
  stream := TStringStream.Create('');
  try
    imgAccountPhoto.Picture.Graphic.SaveToStream(stream);
  except
  end;
  FdsMain.Edit;
  FdsMain.FieldValues['photo'] := stream.DataString;
  FdsMain.Post;
end;

procedure TForm1.Button7Click(Sender: TObject);
var
  stream : TStringStream;
begin
  stream := TStringStream.Create(FdsMain.FieldValues['photo']);
  imgAccountPhoto.Picture.Graphic.LoadFromStream(stream);
  Form1.Invalidate;
end;

end.
