unit FrameMailBox;

{$MODE Delphi}

//{$I EhLib.Inc}

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF EH_LIB_16} System.UITypes, {$ENDIF}
  LCLType, LCLIntf,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, GraphUtil,
  MemTableDataEh, Db, sqldb, odbcconn, DataDriverEh, ImgList,
  MemTableEh, GridsEh, DBGridsEh, StdCtrls, DBCtrlsEh, ExtCtrls,
  DBAxisGridsEh, DynVarsEh, SQLDBDataDriverEh;

type

  { TfrMailBox }

  TfrMailBox = class(TFrame)
    Panel1: TPanel;
    Label1: TLabel;
    DBComboBoxEh1: TDBComboBoxEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    MemTableEh1post_id: TIntegerField;
    MemTableEh1topic_id: TIntegerField;
    MemTableEh1post_subject: TStringField;
    MemTableEh1topic_title: TStringField;
    MemTableEh1poster_id: TIntegerField;
    MemTableEh1username: TStringField;
    MemTableEh1post_time_d: TDateTimeField;
    MemTableEh1post_attachment: TIntegerField;
    MemTableEh1post_read: TIntegerField;
    MemTableEh1post_Mark: TIntegerField;
    MemTableEh1Importance: TIntegerField;
    ilImportance: TImageList;
    SQLDataDriverEh1: TSQLDataDriverEh;
    PaintBox1: TPaintBox;
    Label2: TLabel;
    Image1: TImage;
    function SQLConnectionProviderEh1ExecuteCommand(
      SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
      var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean
      ): Integer;
    procedure SQLConnectionProviderEh1InlineConnectionBeforeConnect(Sender: TObject);
    procedure DBComboBoxEh1Change(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEh1Columns4GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DBGridEh1Columns5GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DBGridEh1Columns7GetCellParams(Sender: TObject;
      EditMode: Boolean; Params: TColCellParamsEh);
    procedure DBGridEh1DataGroupGetRowParams(Sender: TCustomDBGridEh;
      GroupDataTreeNode: TGroupDataTreeNodeEh; Params: TGroupRowParamsEh);
    procedure DBGridEh1Columns5DataGroupFooterAggregateValue(
      Grid: TCustomDBGridEh; Column: TColumnEh;
      GroupFooter: TGridDataGroupFooterEh;
      FooterColumnItem: TGridDataGroupFooterColumnItemEh;
      var AValue: Variant; Node: TGroupDataTreeNodeEh;
      var Processed: Boolean);
  private
    { Private declarations }
  public
    ReadColumn: TColumnEh;
    ImportanceColumn: TColumnEh;
    post_MarkColumn: TColumnEh;
    post_readColumn: TColumnEh;
    FMailGridStyle: TDBGridEhStyle;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateColorSchema;


  end;

implementation

uses Unit1;

{$R *.lfm}

{ TfrMailBox }

constructor TfrMailBox.Create(AOwner: TComponent);
var
  H,L,S: Word;
  ARGB: LongWord;
begin
  inherited Create(AOwner);
  H := 0; L := 0; S := 0;
  FMailGridStyle := TDBGridEhStyle.Create(nil);
  Align := alClient;
  Panel1.DoubleBuffered := True;

  DBGridEh1.Style := FMailGridStyle;

  ReadColumn := DBGridEh1.FieldColumns['post_read'];
  ImportanceColumn := DBGridEh1.FieldColumns['Importance'];
  post_MarkColumn := DBGridEh1.FieldColumns['post_Mark'];
  post_readColumn := DBGridEh1.FieldColumns['post_read'];
  UpdateColorSchema;

  ARGB := ColorToRGB(clHighlight);
  ColorRGBToHLS(ARGB, H,L,S);
  if S > 170 then S := 170;
  if L < 192 then L := 192;

  FMailGridStyle.SelectionColor := ColorHLSToRGB(H, L, S);
  FMailGridStyle.SelectionFontColor := clWindowText;
  FMailGridStyle.SelectionInactiveColor := RGB(229, 229, 229);
  FMailGridStyle.SortMarkerStyle := smstThemeDefinedEh;

  DBGridEh1.DataGrouping.Font.Color := 10511415;
  DBGridEh1.DataGrouping.Font.Style := [fsBold];

  DBGridEh1.DataGrouping.GroupDataTree.Root[0].Expanded := True;
  MemTableEh1.Open;
  
  Label1.Font := Form1.FrameTitleFont;
  Label1.Left := Form1.FrameTitlePos.X;
  Label1.Top := Form1.FrameTitlePos.Y;
end;

destructor TfrMailBox.Destroy;
begin
  FreeAndNil(FMailGridStyle);
  inherited Destroy;
end;

procedure TfrMailBox.SQLConnectionProviderEh1InlineConnectionBeforeConnect(
  Sender: TObject);
begin
end;

function TfrMailBox.SQLConnectionProviderEh1ExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean
  ): Integer;
begin
  Form1.SQLDBConnectionProviderEh1ExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed);
  Result := 0;
end;

procedure TfrMailBox.DBComboBoxEh1Change(Sender: TObject);
begin
  UpdateColorSchema;
end;

procedure TfrMailBox.UpdateColorSchema;
begin
  if DBComboBoxEh1.Value = 'Silver' then
  begin
    DBGridEh1.GridLineParams.DarkColor := RGB(111, 112, 116);
    DBGridEh1.FixedColor := RGB(212, 215, 219);
    DBGridEh1.TitleParams.VertLineColor := RGB(110, 109, 143);
    DBGridEh1.DataGrouping.Font.Color := RGB(112, 111, 145);
    DBGridEh1.DataGrouping.GroupRowDefValues.BottomLine.Color := RGB(165, 164, 189);
    DBGridEh1.TreeViewParams.GlyphStyle := tvgsDefaultEh;
    DBGridEh1.TitleParams.SecondColorStored := False;
    DBGridEh1.DataGrouping.GroupPanel.Color := clDefault;
    Panel1.Color := DBGridEh1.FixedColor;
  end else if DBComboBoxEh1.Value = 'Black' then
  begin
    DBGridEh1.GridLineParams.DarkColor := RGB(76, 83, 92);
    DBGridEh1.FixedColor := RGB(212, 215, 219);
    DBGridEh1.TitleParams.VertLineColor := RGB(145, 153, 164);
    DBGridEh1.DataGrouping.Font.Color := RGB(97, 106, 118);
    DBGridEh1.DataGrouping.GroupRowDefValues.BottomLine.Color := RGB(145, 153, 164);
    DBGridEh1.TreeViewParams.GlyphStyle := tvgsDefaultEh;
    DBGridEh1.TitleParams.SecondColorStored := False;
    DBGridEh1.DataGrouping.GroupPanel.Color := clDefault;
    Panel1.Color := DBGridEh1.FixedColor;
  end else if DBComboBoxEh1.Value = 'Blue' then
  begin
    DBGridEh1.GridLineParams.DarkColor := $00CF9365;
    DBGridEh1.FixedColor := $00FFDDC4;
    DBGridEh1.TitleParams.VertLineColor := $20FFC69A;
    DBGridEh1.DataGrouping.Font.Color := $00A06437;
    DBGridEh1.DataGrouping.GroupRowDefValues.BottomLine.Color := $00D99D6F;
    DBGridEh1.TreeViewParams.GlyphStyle := tvgsDefaultEh;
    DBGridEh1.TitleParams.SecondColorStored := False;
    DBGridEh1.DataGrouping.GroupPanel.Color := clDefault;
    Panel1.Color := DBGridEh1.FixedColor;
  end else if DBComboBoxEh1.Value = 'Blue 2010' then
  begin
    DBGridEh1.GridLineParams.DarkColor := RGB(132, 157, 189);
    DBGridEh1.FixedColor := RGB(225, 236, 250);
    DBGridEh1.TitleParams.VertLineColor := RGB(132, 157, 189);
    DBGridEh1.TitleParams.SecondColor := RGB(239, 245, 251);
    DBGridEh1.DataGrouping.GroupPanel.Color := RGB(207, 221, 238);
    DBGridEh1.DataGrouping.Font.Color := RGB(30, 57, 91);
    DBGridEh1.DataGrouping.GroupRowDefValues.BottomLine.Color := RGB(146, 163, 192);
    DBGridEh1.TreeViewParams.GlyphStyle := tvgsExplorerThemedEh;
    Panel1.Color := RGB(218, 230, 245);
  end;
end;

procedure TfrMailBox.DBGridEh1CellClick(Column: TColumnEh);
begin
  if (Column = ImportanceColumn) or
     (Column = post_MarkColumn) or
     (Column = post_readColumn) then
  begin
    Column.Field.DataSet.Edit;
    if Column.Field.AsInteger = 0
      then Column.Field.AsInteger := 1
      else Column.Field.AsInteger := 0;
    Column.Field.DataSet.Post;
  end;
end;

procedure TfrMailBox.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if MemTableEh1post_read.AsInteger = 0 then
    AFont.Style := AFont.Style + [fsBold];
end;

procedure TfrMailBox.DBGridEh1Columns4GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  if MemTableEh1post_attachment.AsInteger = 1 then
    Params.ImageIndex := 5
  else
    Params.ImageIndex := -1;
end;

procedure TfrMailBox.DBGridEh1Columns5GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  if MemTableEh1post_read.AsInteger = 1 then
    Params.ImageIndex := 3
  else
    Params.ImageIndex := 2;
end;

procedure TfrMailBox.DBGridEh1Columns7GetCellParams(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
begin
  if MemTableEh1Importance.AsInteger = 1 then
    Params.ImageIndex := 4
  else
    Params.ImageIndex := -1;
end;

procedure TfrMailBox.DBGridEh1DataGroupGetRowParams(
  Sender: TCustomDBGridEh; GroupDataTreeNode: TGroupDataTreeNodeEh;
  Params: TGroupRowParamsEh);
var
  AgrValue: Variant;
begin
  if ReadColumn = nil then Exit;

  AgrValue := GroupDataTreeNode.FooterItems[0].FooterValues[ReadColumn.Index];
  Params.GroupRowText := '';
  if Assigned(GroupDataTreeNode.DataGroupLevel.Column) then
    Params.GroupRowText := TColumnEh(GroupDataTreeNode.DataGroupLevel.Column).Title.Caption + ': ';
  Params.GroupRowText := Params.GroupRowText + GroupDataTreeNode.DisplayValue;
  Params.GroupRowText := Params.GroupRowText + ' ('+IntToStr(GroupDataTreeNode.Count)+' Item(s)';
  if AgrValue[1] > 0 then
  begin
    Params.GroupRowText := Params.GroupRowText + ', ' + IntToStr(AgrValue[1]) + ' unread)';
    Params.Font.Style := Params.Font.Style + [fsBold];
  end else
  begin
    Params.GroupRowText := Params.GroupRowText + ')';
    Params.Font.Style := Params.Font.Style - [fsBold];
  end;

//  Params.GroupRowText := Params.GroupRowText +
//    ' Read: ' + IntToStr(AgrValue[0]) + '  Undread: ' + IntToStr(AgrValue[1]);

end;

procedure TfrMailBox.DBGridEh1Columns5DataGroupFooterAggregateValue(
  Grid: TCustomDBGridEh; Column: TColumnEh;
  GroupFooter: TGridDataGroupFooterEh;
  FooterColumnItem: TGridDataGroupFooterColumnItemEh; var AValue: Variant;
  Node: TGroupDataTreeNodeEh; var Processed: Boolean);
begin
  if VarIsEmpty(AValue) then
  begin
    AValue := VarArrayCreate([0,1], varInteger);
    AValue[0] := 0;
    AValue[1] := 0;
  end;
  if MemTableEh1post_read.AsInteger = 1
    then AValue[0] := AValue[0] + 1
    else AValue[1] := AValue[1] + 1;
  Processed := True;
end;

end.
