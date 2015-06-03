unit FrameWorkingWithHugeData;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF EH_LIB_16} System.UITypes, {$ENDIF}
  Dialogs, StdCtrls, ExtCtrls, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  GridsEh, DBGridEh, ComCtrls, Mask, DBCtrlsEh,
  EhLibMTE, ExtActns, MemTableDataEh, Db, ADODB, MemTableEh, DataDriverEh,
  ADODataDriverEh, DBAxisGridsEh, DynVarsEh;

type
  TfrWorkingWithHugeData = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label2: TLabel;
    Panel2: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    btnSmallTable: TButton;
    btnBigTable: TButton;
    DBEditEh1: TDBEditEh;
    btnSortBy: TButton;
    ProgressBar1: TProgressBar;
    DBGridEh1: TDBGridEh;
    ADOConnectionProviderEh1: TADOConnectionProviderEh;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADODataDriverEh1: TADODataDriverEh;
    DataSetDriverEh1: TDataSetDriverEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    procedure PaintBox1Paint(Sender: TObject);
    procedure btnSmallTableClick(Sender: TObject);
    procedure btnBigTableClick(Sender: TObject);
    procedure btnSortByClick(Sender: TObject);
    procedure DBGridEh1SortMarkingChanged(Sender: TObject);
    procedure ADOConnection1BeforeConnect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DoDownload;
    function CheckDatafile: Boolean;
    procedure DownloadProgress(Sender: TDownLoadURL; Progress,
      ProgressMax: Cardinal; StatusCode: TURLDownloadStatus; StatusText: String;
      var Cancel: Boolean);

    constructor Create(AOwner: TComponent); override;
  end;

implementation

uses Unit1;

{$R *.dfm}

constructor TfrWorkingWithHugeData.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alClient;

  if Form1.PixelsPerInch <> 96 then
    ScaleBy(Form1.PixelsPerInch, 96);
  Panel1.DoubleBuffered := True;
  Panel2.DoubleBuffered := True;
end;


function TfrWorkingWithHugeData.CheckDatafile: Boolean;
var
  DataFilePath: String;
  mr: Integer;
begin
  Result := True;
//  DataFilePath := ExtractFileDir(ParamStr(0)) + '\cities10000.mdb';

  if FileExists(ExtractFilePath(ParamStr(0))+'\cities10000.mdb') then
    DataFilePath := ExtractFilePath(ParamStr(0))+'\cities10000.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\cities10000.mdb') then
    DataFilePath := ExtractFilePath(ParamStr(0))+'..\Data\cities10000.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\cities10000.mdb') then
    DataFilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\cities10000.mdb'
  else
    DataFilePath := '';

  if not FileExists(DataFilePath) then
  begin
    mr := MessageDlg('Data file: ' + DataFilePath + #13' does not exist. Do you to want download it?',
      mtConfirmation, [mbYes, mbNo, mbCancel], -1);
    case mr of
      mrYes: DoDownload;
      mrNo: ;
      mrCancel: Result := False;
    end;
  end;
end;

procedure TfrWorkingWithHugeData.DBGridEh1SortMarkingChanged(Sender: TObject);
var
  ticks:LongWord;
begin
  ticks := GetTickCount;
  DBGridEh1.DefaultApplySorting;
  DBEditEh1.Text := IntToStr((GetTickCount-ticks));
end;

procedure TfrWorkingWithHugeData.DoDownload;
begin
  with TDownloadURL.Create(self) do
  try
    URL:='http://www.ehlib.com/demos/data/cities10000.mdb';

    if DirectoryExists(ExtractFilePath(ParamStr(0))+'..\Data') then
      FileName := ExtractFilePath(ParamStr(0))+'..\Data\cities10000.mdb'
    else if DirectoryExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data') then
      FileName := ExtractFilePath(ParamStr(0))+'..\..\..\Data\cities10000.mdb'
    else
      FileName := ExtractFileDir(ParamStr(0)) + '\cities10000.mdb';

     OnDownloadProgress := DownloadProgress;
     ExecuteTarget(nil) ;
  finally
    Free;
  end;
end;

procedure TfrWorkingWithHugeData.DownloadProgress(Sender: TDownLoadURL; Progress,
  ProgressMax: Cardinal; StatusCode: TURLDownloadStatus; StatusText: String;
  var Cancel: Boolean);
begin
  ProgressBar1.Min := 0;
  ProgressBar1.Max := ProgressMax;
  ProgressBar1.Position := Progress;
  ProgressBar1.Update;
end;

procedure TfrWorkingWithHugeData.btnSmallTableClick(Sender: TObject);
var
  ticks:LongWord;
begin
  if not CheckDatafile then Exit;
  ticks := GetTickCount;
//AQtimeHelpers.EnableProfiling(True);

  ADODataDriverEh1.MacroVars.Macros['%Table_name%'] := 'Cities1000Small';
  DataSource1.DataSet := MemTableEh1;
  MemTableEh1.Close;
  MemTableEh1.Open;
//AQtimeHelpers.EnableProfiling(False);
  DBEditEh1.Text := IntToStr((GetTickCount-ticks));
end;

procedure TfrWorkingWithHugeData.btnSortByClick(Sender: TObject);
var
  ticks:LongWord;
begin
  CheckDatafile;
  ticks := GetTickCount;
//AQtimeHelpers.EnableProfiling(True);
  MemTableEh1.SortByFields('asciiname');
//AQtimeHelpers.EnableProfiling(False);
  DBEditEh1.Text := IntToStr((GetTickCount-ticks));
end;

procedure TfrWorkingWithHugeData.btnBigTableClick(Sender: TObject);
var
  ticks:LongWord;
begin
  if not CheckDatafile then Exit;
  ticks := GetTickCount;

  ADODataDriverEh1.MacroVars.Macros['%Table_name%'] := 'Cities1000';
  DataSource1.DataSet := MemTableEh1;
  MemTableEh1.Close;
  MemTableEh1.Open;
//  DataSource1.DataSet := ADOQuery1;
//  ADOQuery1.Active := not ADOQuery1.Active;
//  ADOQuery1.Last;
  DBEditEh1.Text := IntToStr((GetTickCount-ticks));
end;

procedure TfrWorkingWithHugeData.PaintBox1Paint(Sender: TObject);
begin
  Form1.FillFrameTopPanel(PaintBox1.Canvas, Rect(0, 0, PaintBox1.Width, PaintBox1.Height));
end;

procedure TfrWorkingWithHugeData.ADOConnection1BeforeConnect(Sender: TObject);
var
  FilePath: String;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'\cities10000.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'\cities10000.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\Data\cities10000.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\Data\cities10000.mdb'
  else if FileExists(ExtractFilePath(ParamStr(0))+'..\..\..\Data\cities10000.mdb') then
    FilePath := ExtractFilePath(ParamStr(0))+'..\..\..\Data\cities10000.mdb';

  ADOConnection1.ConnectionString :=
     StringReplace(ADOConnection1.ConnectionString,
      '%DataBasePath%',
      FilePath,[]);

end;

end.
