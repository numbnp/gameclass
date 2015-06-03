unit FrameBackgroundImages;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Themes,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  MemTableDataEh, Db, DataDriverEh, MemTableEh, GridsEh,
  DBGridsEh, DBCtrlsEh, MaskEdit, ExtDlgs, TypInfo, EhLibLCL, DBAxisGridsEh;

type
  TfrBackgroundImages = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Splitter1: TSplitter;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    MemTableEh1: TMemTableEh;
    MemTableEh2: TMemTableEh;
    SQLDataDriverEh1: TSQLDataDriverEh;
    SQLDataDriverEh2: TSQLDataDriverEh;
    Panel2: TPanel;
    Label2: TLabel;
    DBComboBoxEh1: TDBComboBoxEh;
    Label3: TLabel;
    DBNumberEditEh1: TDBNumberEditEh;
    Label4: TLabel;
    DBNumberEditEh2: TDBNumberEditEh;
    btnSelectImage: TButton;
    OpenPictureDialog1: TOpenPictureDialog;
    CBExcludeTitle: TCheckBox;
    CBExcludeFooter: TCheckBox;
    CBExcludeIndicator: TCheckBox;
    procedure PaintBox1Paint(Sender: TObject);
    procedure btnSelectImageClick(Sender: TObject);
    procedure DBNumberEditEh1Change(Sender: TObject);
    procedure DBNumberEditEh2Change(Sender: TObject);
    procedure DBComboBoxEh1Change(Sender: TObject);
    procedure CBExcludeIndicatorClick(Sender: TObject);
    procedure CBExcludeTitleClick(Sender: TObject);
    procedure CBExcludeFooterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

implementation

uses Unit1;

{$R *.lfm}


procedure TfrBackgroundImages.btnSelectImageClick(Sender: TObject);
begin
  if OpenPictureDialog1.Execute then
    begin
      DBGridEh2.BackgroundData.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    end;
end;

procedure TfrBackgroundImages.CBExcludeFooterClick(Sender: TObject);
begin
  DBGridEh1.BackgroundData.ExcludeFooter := CBExcludeFooter.Checked;
  DBGridEh2.BackgroundData.ExcludeFooter := CBExcludeFooter.Checked;
end;

procedure TfrBackgroundImages.CBExcludeIndicatorClick(Sender: TObject);
begin
  DBGridEh1.BackgroundData.ExcludeIndicator := CBExcludeIndicator.Checked;
  DBGridEh2.BackgroundData.ExcludeIndicator := CBExcludeIndicator.Checked;
end;

procedure TfrBackgroundImages.CBExcludeTitleClick(Sender: TObject);
begin
  DBGridEh1.BackgroundData.ExcludeTitle := CBExcludeTitle.Checked;
  DBGridEh2.BackgroundData.ExcludeTitle := CBExcludeTitle.Checked;
end;

constructor TfrBackgroundImages.Create(AOwner: TComponent);
var
  PropInfo: PPropInfo;
  PropType: PTypeInfo;
  TypeData: PTypeData;
  I: Integer;
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.Height := 36;
  Panel1.DoubleBuffered := True;

  PropInfo := GetPropInfo(DBGridEh1.BackgroundData, 'Placement');
  PropType := PropInfo_getPropType(PropInfo);
  TypeData := GetTypeData(PropType);

  for I := TypeData^.MinValue to TypeData^.MaxValue do
  begin
    DBComboBoxEh1.Items.Add(GetEnumName(PropType, I));
  end;

  MemTableEh1.Open;
  MemTableEh2.Open;

//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);
end;

procedure TfrBackgroundImages.DBComboBoxEh1Change(Sender: TObject);
begin
  SetOrdProp(DBGridEh2.BackgroundData, 'Placement', DBComboBoxEh1.ItemIndex);
end;

procedure TfrBackgroundImages.DBNumberEditEh1Change(Sender: TObject);
begin
  if DBNumberEditEh1.Value = null then
    DBGridEh1.BackgroundData.VertMargin := 0
  else
    DBGridEh1.BackgroundData.VertMargin := DBNumberEditEh1.Value;
end;

procedure TfrBackgroundImages.DBNumberEditEh2Change(Sender: TObject);
begin
  if DBNumberEditEh2.Value = null then
    DBGridEh1.BackgroundData.HorzMargin := 0
  else
    DBGridEh1.BackgroundData.HorzMargin := DBNumberEditEh2.Value;
end;

procedure TfrBackgroundImages.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

end.
