unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Grids, TypInfo, EhLibVCL,
  Dialogs, DBGridEhGrouping, GridsEh, DBGridEh, ExtCtrls, DB, DBTables,
  StdCtrls, ToolCtrlsEh, DBGridEhToolCtrls, ImgList, EhLibBDE, Mask,
  DBCtrlsEh, PropFilerEh, MemTableDataEh, MemTableEh, EhLibMTE, ExtDlgs;

type
  TForm1 = class(TForm)
    Image1: TImage;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    Image2: TImage;
    ImageList1: TImageList;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    DBComboBoxEh1: TDBComboBoxEh;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBNumberEditEh1: TDBNumberEditEh;
    DBNumberEditEh2: TDBNumberEditEh;
    MemTableEh1: TMemTableEh;
    Button3: TButton;
    CBExcludeTitle: TCheckBox;
    CBExcludeFooter: TCheckBox;
    CBExcludeIndicator: TCheckBox;
    OpenPictureDialog1: TOpenPictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBComboBoxEh1Change(Sender: TObject);
    procedure DBNumberEditEh1Change(Sender: TObject);
    procedure DBNumberEditEh2Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CBExcludeTitleClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  DBGridEh1.BackgroundData.Picture.LoadFromFile('NetworkWorkgroupTrans.bmp');
  DBComboBoxEh1.Text := 'ipBottomRightEh';
  DBGridEh1.BackgroundData.Visible := True;
//  DBGridEh1.BackgroundData.ExcludeTitle := True;
//  DBGridEh1.BackgroundData.ExcludeIndicator := True;
//  DBGridEh1.BackgroundData.ExcludeFooter := True;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  DBGridEh1.BackgroundData.Picture.LoadFromFile('tutorial2.bmp');
  DBComboBoxEh1.Text := 'ipTileEh';
  DBGridEh1.BackgroundData.Visible := True;
//  DBGridEh1.BackgroundData.ExcludeTitle := False;
//  DBGridEh1.BackgroundData.ExcludeIndicator := False;
//  DBGridEh1.BackgroundData.ExcludeFooter := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
  TypeData: PTypeData;
  I: Integer;
begin
  PropInfo := GetPropInfo(DBGridEh1.BackgroundData, 'Placement');
  PropType := PropInfo_getPropType(PropInfo);
  TypeData := GetTypeData(PropType);

  for I := TypeData^.MinValue to TypeData^.MaxValue do
  begin
    DBComboBoxEh1.Items.Add(GetEnumName(PropType, I));
  end;

  Button1Click(nil);

//  DBGridEh1.BufferedPaint := True;
//  DBGridEhDebugDraw := True;
end;

procedure TForm1.DBComboBoxEh1Change(Sender: TObject);
begin
  SetOrdProp(DBGridEh1.BackgroundData, 'Placement', DBComboBoxEh1.ItemIndex);
end;

procedure TForm1.DBNumberEditEh1Change(Sender: TObject);
begin
  if DBNumberEditEh1.Value = null then
    DBGridEh1.BackgroundData.VertMargin := 0
  else
    DBGridEh1.BackgroundData.VertMargin := DBNumberEditEh1.Value;
end;

procedure TForm1.DBNumberEditEh2Change(Sender: TObject);
begin
  if DBNumberEditEh2.Value = null then
    DBGridEh1.BackgroundData.HorzMargin := 0
  else
    DBGridEh1.BackgroundData.HorzMargin := DBNumberEditEh2.Value;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    begin
      DBGridEh1.BackgroundData.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    end;
end;

procedure TForm1.CBExcludeTitleClick(Sender: TObject);
begin
  DBGridEh1.BackgroundData.ExcludeFooter := CBExcludeFooter.Checked;
  DBGridEh1.BackgroundData.ExcludeIndicator := CBExcludeIndicator.Checked;
  DBGridEh1.BackgroundData.ExcludeTitle := CBExcludeTitle.Checked;
end;

end.
