unit DataSetTextExporter;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_7}
  {$IFNDEF EH_LIB_16}
    XPMan,
  {$ENDIF}
{$ENDIF}
  Themes,
  DataSetImpExpEh,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh,
  ExtDlgs, DBCtrlsEh, EhLibJPegImage, CompoMansEh, Mask, ComCtrls;

type
  TfrDataSetExporter = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGridEh1: TDBGridEh;
    TabSheet2: TTabSheet;
    DBMemoEh1: TDBMemoEh;
    Button2: TButton;
    rbDelim: TRadioButton;
    rbFixSize: TRadioButton;
    cbxCodePage: TDBComboBoxEh;
    GroupBox1: TGroupBox;
    cbbDateFormat: TDBComboBoxEh;
    cbbDateSep: TDBComboBoxEh;
    cbbTimeSep: TDBComboBoxEh;
    cbbDecSep: TDBComboBoxEh;
    DBEditEh1: TDBEditEh;
    cbIncludeFieldNames: TDBCheckBoxEh;
    cbxTextQuoteChar: TDBComboBoxEh;
    cbxFieldsDelimiter: TDBComboBoxEh;
    GroupBox2: TGroupBox;
    bResetFielsMapTable: TButton;
    bCleaFielsMapTable: TButton;
    gridFieldsMap: TDBGridEh;
    dsFixSetParams: TDataSource;
    mtFieldsMap: TMemTableEh;
    dbTableName: TDBComboBoxEh;
    eTimeLong: TDBEditEh;
    TabSheet3: TTabSheet;
    cbUseFormatExportValueEvent: TDBCheckBoxEh;
    cbbTimeFormat: TDBComboBoxEh;
    CompoManEh1: TCompoManEh;
    DataSetTextExporterEh1: TDataSetTextExporterEh;
    SaveTextFileDialog1: TSaveDialog;
    cbbDateTimeFormat: TDBComboBoxEh;
    procedure PaintBox1Paint(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure bResetFielsMapTableClick(Sender: TObject);
    procedure bCleaFielsMapTableClick(Sender: TObject);
    procedure DBEditEh1EditButtons0Click(Sender: TObject; var Handled: Boolean);
    procedure rbDelimClick(Sender: TObject);
    procedure rbFixSizeClick(Sender: TObject);
    procedure dbTableNameChange(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure ReadState(Reader: TReader); override;
  public
//    ImpExpList: TImpExpListEh;

    constructor Create(AOwner: TComponent); override;
    procedure UpdateState;
    procedure FormatTextExportValue(Exporter: TDataSetTextExporterEh;
      FieldsMapItem: TFieldsMapItemEh; var Value: String;
      var Processed: Boolean);
    function GetEncodingByText(EncText: String): TExportImportEncodingEh;
  end;

implementation

uses MainUnit, DataMod;

{$R *.dfm}

{ TfrFrameOne }

constructor TfrDataSetExporter.Create(AOwner: TComponent);
var
  Path: String;
begin
  inherited Create(AOwner);
  Panel1.Height := 36;
  DBGridEh1.FooterParams.VertLineColor := DBGridEh1.GridLineParams.DarkColor;
  DBGridEh1.FooterParams.HorzLineColor := DBGridEh1.GridLineParams.DarkColor;
  DBGridEh1.FooterParams.Color := ApproximateColor(DBGridEh1.FixedColor, clWindow, 128);

  DBGridEh1.TitleParams.SecondColor := ApproximateColor(clBtnFace, clWindow, 170);

  DBGridEh1.FooterParams.Font.Style := [fsBold];

  GetDir(0, Path);
  Path := Path + '\ExpFile.Txt';
  DBEditEh1.Text := Path;

  cbxCodePage.Items.Clear;

{$IFDEF EH_LIB_12}
  {$IFDEF EH_LIB_16}
    cbxCodePage.Items.Add('UTF8');
    cbxCodePage.Items.Add('UTF7');
    cbxCodePage.Items.Add('Unicode');
    cbxCodePage.Items.Add('BigEndianUnicode');
    cbxCodePage.Items.Add('ANSI');
    cbxCodePage.Items.Add('ASCII');
  {$ELSE}
    cbxCodePage.Items.Add('UTF8');
    cbxCodePage.Items.Add('UTF7');
    cbxCodePage.Items.Add('Unicode');
  {$ENDIF}
{$ELSE}
    cbxCodePage.Items.Add('ANSI');
{$ENDIF}
  cbxCodePage.ItemIndex := 0;
end;

procedure TfrDataSetExporter.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrDataSetExporter.ReadState(Reader: TReader);
begin
  inherited ReadState(Reader);
end;

///////////

procedure TfrDataSetExporter.rbDelimClick(Sender: TObject);
begin
  UpdateState;
end;

procedure TfrDataSetExporter.rbFixSizeClick(Sender: TObject);
begin
  UpdateState;
end;

procedure TfrDataSetExporter.UpdateState;
begin
  cbxFieldsDelimiter.Enabled := rbDelim.Checked;
end;

procedure TfrDataSetExporter.Button1Click(Sender: TObject);
var
  te: TDataSetTextExporterEh;
  Path: string;
  fmi: TFieldsMapItemEh;
  tc: LongWord;
begin
  GetDir(0,Path);

  te := TDataSetTextExporterEh.Create(nil);
  te.DataSet := DBGridEh1.DataSource.DataSet;

  if rbDelim.Checked then
  begin
    te.ValueSeparationStyle := vssDelimiterSeparatedEh;
    if Length(cbxTextQuoteChar.Text) > 0 then
      te.QuoteChar := cbxTextQuoteChar.Text[1]
    else
      te.QuoteChar := #0;

    if cbxFieldsDelimiter.Text = '<Tab>' then
      te.ValueDelimiter := #9
    else if Length(cbxFieldsDelimiter.Text) > 0 then
      te.ValueDelimiter :=  cbxFieldsDelimiter.Text[1]
    else
      te.ValueDelimiter := #0;
  end
  else
    te.ValueSeparationStyle := vssFixedPositionAndSizeEh;

  if Length(cbbDecSep.Text) > 0 then
    te.ExportFormats.DecimalSeparator := cbbDecSep.Text[1];
  te.ExportFormats.DateFormat := cbbDateFormat.Text;
  if Length(cbbDateSep.Text) > 0 then
    te.ExportFormats.DateSeparator := cbbDateSep.Text[1];
  te.ExportFormats.TimeFormat := cbbTimeFormat.Text;
  if Length(cbbTimeSep.Text) > 0 then
    te.ExportFormats.TimeSeparator := cbbTimeSep.Text[1];
  te.ExportFormats.DateTimeFormat := cbbDateTimeFormat.Text;

  te.IsExportFieldNames := cbIncludeFieldNames.Checked;
  te.Encoding := GetEncodingByText(cbxCodePage.Text);

  if not mtFieldsMap.IsEmpty then
  begin
    te.FieldsMap.Clear;
    mtFieldsMap.DisableControls;
    gridFieldsMap.SaveBookmark;
    mtFieldsMap.First;
    try
      while not mtFieldsMap.Eof do
      begin
        fmi := te.FieldsMap.Add;
        fmi.DataSetFieldName := VarToStr(mtFieldsMap['DataSetFieldName']);
        fmi.FileFieldName := VarToStr(mtFieldsMap['FileFieldName']);
        if not VarIsNull(mtFieldsMap['FileFieldPos']) then
          fmi.FileFieldPos := mtFieldsMap['FileFieldPos'];
        if not VarIsNull(mtFieldsMap['FileFieldLen']) then
          fmi.FileFieldLen := mtFieldsMap['FileFieldLen'];
        mtFieldsMap.Next;
      end;

    finally
      gridFieldsMap.RestoreBookmark;
      mtFieldsMap.EnableControls;
    end;
  end;

//  if cbUseFormatExportValueEvent.Checked
//    then te.OnFormatExportValue := FormatTextExportValue
//    else te.OnFormatExportValue := nil;

  tc := GetTickCount;
  te.ExportToFile(DBEditEh1.Text, false);
  eTimeLong.Text := FloatToStr((GetTickCount - tc) / 1000) + ' sec';

  te.Free;

  DBMemoEh1.Lines.Clear;
  DBMemoEh1.Lines.LoadFromFile(DBEditEh1.Text);

  PageControl1.ActivePageIndex := 1;
end;

procedure TfrDataSetExporter.bResetFielsMapTableClick(Sender: TObject);
var
  i: Integer;
begin
  mtFieldsMap.DisableControls;
  try
    mtFieldsMap.EmptyTable;
    for i := 0 to DBGridEh1.DataSource.DataSet.Fields.Count-1 do
      mtFieldsMap.AppendRecord([
        DBGridEh1.DataSource.DataSet.Fields[i].FieldName,
        DBGridEh1.DataSource.DataSet.Fields[i].FieldName
        ]);

  finally
    mtFieldsMap.First;
    mtFieldsMap.EnableControls;
  end;
end;

procedure TfrDataSetExporter.bCleaFielsMapTableClick(Sender: TObject);
begin
  mtFieldsMap.EmptyTable;
end;

procedure TfrDataSetExporter.dbTableNameChange(Sender: TObject);
begin
  if dbTableName.Text = 'Orders' then
    DBGridEh1.DataSource := MainDataModule.DataSource1
  else if dbTableName.Text = 'FishFact' then
    DBGridEh1.DataSource := MainDataModule.dsFisgFact;
  DBGridEh1.OptimizeAllColsWidth;
end;

procedure TfrDataSetExporter.FormatTextExportValue(
  Exporter: TDataSetTextExporterEh; FieldsMapItem: TFieldsMapItemEh;
  var Value: String; var Processed: Boolean);
begin
  if FieldsMapItem.Field.FieldName = 'SaleDate' then
  begin
    if FieldsMapItem.Field.IsNull then
      Value := ''
    else
      Value := FormatDateTime('YYYYMMDD', FieldsMapItem.Field.AsDateTime);
    Processed := True;
  end;
end;

procedure TfrDataSetExporter.DBEditEh1EditButtons0Click(Sender: TObject;
  var Handled: Boolean);
begin
  SaveTextFileDialog1.FileName := DBEditEh1.Text;
  if SaveTextFileDialog1.Execute then
    DBEditEh1.Text := SaveTextFileDialog1.FileName;
end;

function TfrDataSetExporter.GetEncodingByText(
  EncText: String): TExportImportEncodingEh;
begin
{$IFDEF EH_LIB_12}
  {$IFDEF EH_LIB_16}
  if EncText = 'UTF8' then
    Result := eieUTF8Eh
  else if EncText = 'UTF7' then
    Result := eieUTF7Eh
  else if EncText = 'Unicode' then
    Result := eieUnicodeEh
  else if EncText = 'BigEndianUnicode' then
    Result := eieBigEndianUnicodeEh
  else if EncText = 'ANSI' then
    Result := eieANSIEh
  else if EncText = 'ASCII' then
    Result := eieASCIIEh
  else
    Result := eieAutoEh;
  {$ELSE}
  if EncText = 'UTF8' then
    Result := eieUTF8Eh
  else if EncText = 'UTF7' then
    Result := eieUTF7Eh
  else if EncText = 'Unicode' then
    Result := eieUnicodeEh
  else
    Result := eieAutoEh;
  {$ENDIF}
{$ELSE}
  if EncText = 'ANSI' then
    Result := eieANSIEh
  else
    Result := eieAutoEh;
{$ENDIF}
end;

end.
