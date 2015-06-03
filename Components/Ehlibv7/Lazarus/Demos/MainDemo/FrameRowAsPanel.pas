unit FrameRowAsPanel;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  MemTableDataEh, Db, sqldb, DataDriverEh, MemTableEh, GridsEh, DBGridsEh,
  StdCtrls, ExtCtrls, DBAxisGridsEh;

type

  { TfrRowAsPanel }

  TfrRowAsPanel = class(TFrame)
    DBGridEh5: TDBGridEh;
    DataSource1: TDataSource;
    MemTableEh1: TMemTableEh;
    MemTableEh1Category: TStringField;
    MemTableEh1Common_name: TStringField;
    MemTableEh1Graphic: TGraphicField;
    MemTableEh1Length: TFloatField;
    MemTableEh1Notes: TMemoField;
    MemTableEh1SpeciesId: TAutoIncField;
    MemTableEh1Species_Name: TStringField;
    SQLDataDriverEh1: TSQLDataDriverEh;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label2: TLabel;
    SQLQuery1Category: TStringField;
    SQLQuery1Common_name: TStringField;
    SQLQuery1Graphic: TBlobField;
    SQLQuery1Length: TFloatField;
    SQLQuery1Notes: TMemoField;
    SQLQuery1SpeciesId: TAutoIncField;
    SQLQuery1Species_Name: TStringField;
    procedure PaintBox1Paint(Sender: TObject);
    procedure MemTableEh1AfterOpen(DataSet: TDataSet);
    procedure SQLDataDriverEh1AssignCommandParam(
      DataDriver: TBaseSQLDataDriverEh; Command: TBaseSQLCommandEh;
      MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh;
      Param: TParam);
    procedure SQLDataDriverEh1BuildDataStruct(DataDriver: TDataDriverEh;
      DataStruct: TMTDataStructEh);
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.lfm}

constructor TfrRowAsPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;
  Panel1.DoubleBuffered := True;
  MemTableEh1.Open;
//  if Form1.PixelsPerInch <> 96 then
//    ScaleBy(Form1.PixelsPerInch, 96);
end;

procedure TfrRowAsPanel.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrRowAsPanel.MemTableEh1AfterOpen(DataSet: TDataSet);
begin
  TBlobField(MemTableEh1.FieldByName('Graphic')).BlobType := ftGraphic;
  TBlobField(MemTableEh1.FieldByName('Notes')).BlobType := ftMemo;
end;

procedure TfrRowAsPanel.SQLDataDriverEh1AssignCommandParam(
  DataDriver: TBaseSQLDataDriverEh; Command: TBaseSQLCommandEh;
  MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh;
  Param: TParam);
begin

end;

procedure TfrRowAsPanel.SQLDataDriverEh1BuildDataStruct(
  DataDriver: TDataDriverEh; DataStruct: TMTDataStructEh);
begin
  DataDriver.DefaultBuildDataStruct(DataStruct);
//  TMTBlobDataFieldEh(DataStruct.FieldByName('Notes')).BlobType := ftGraphic;
//  TMTBlobDataFieldEh(DataStruct.FieldByName('Graphic')).BlobType := ftGraphic;
end;

end.
