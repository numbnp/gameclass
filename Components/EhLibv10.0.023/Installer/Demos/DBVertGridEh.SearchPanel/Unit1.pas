unit Unit1;

{$I EhLib.Inc}

interface

uses
{$IFDEF EH_LIB_7}
  {$IFNDEF EH_LIB_16}
    XPMan,
  {$ENDIF}
{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, ADODB, DBGridEhGrouping,
  DBGridEhToolCtrls, DBVertGridsEh, ExtCtrls, GridsEh, DBAxisGridsEh,
  DBGridEh, MemTableEh, DataDriverEh, ADODataDriverEh, DBCtrls, DynVarsEh,
  SearchPanelsEh, ToolCtrlsEh,
  ObjectInspectorEh, EhLibVCL;

type
  TForm1 = class(TForm)
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    ADODataDriverEh1: TADODataDriverEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    Splitter1: TSplitter;
    DBVertGridEh1: TDBVertGridEh;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    ADOConnectionProviderEh2: TADOConnectionProviderEh;
    ADODataDriverEh2: TADODataDriverEh;
    procedure ADOConnectionProviderEh1InlineConnectionBeforeConnect(
      Sender: TObject);
    procedure ADODataDriverEh1BuildDataStruct(DataDriver: TDataDriverEh;
      DataStruct: TMTDataStructEh);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure MemTableEh1AfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ADOConnectionProviderEh1InlineConnectionBeforeConnect(
  Sender: TObject);
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\BioLife.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\BioLife.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\BioLife.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\BioLife.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\BioLife.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\BioLife.mdb';

  ADOConnectionProviderEh1.InlineConnection.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;User ID=Admin;'+
    'Data Source=' + FilePath + ';'+
    'Mode=Share Deny None;Jet OLEDB:System database="";';
end;

procedure TForm1.ADODataDriverEh1BuildDataStruct(DataDriver: TDataDriverEh;
  DataStruct: TMTDataStructEh);
var
  fld: TMTDataFieldEh;
begin
  DataDriver.DefaultBuildDataStruct(DataStruct);
  fld := DataStruct.FindField('Graphic');
  if (fld is TMTBlobDataFieldEh) then
    TMTBlobDataFieldEh(fld).BlobType := ftGraphic;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DBVertGridEh1.SearchPanel.Enabled := True;
  DBVertGridEh1.SearchPanel.OptionsPopupMenuItems := [vgsmuSearchScopes];
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

procedure TForm1.MemTableEh1AfterOpen(DataSet: TDataSet);
begin
  DBGridEh1.OptimizeAllColsWidth();
end;

initialization
  DefFontData.Name := 'Tahoma';
end.
