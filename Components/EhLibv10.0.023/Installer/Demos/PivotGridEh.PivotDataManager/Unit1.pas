unit Unit1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  {$IFNDEF EH_LIB_16}
    XPMan,
  {$ENDIF}
  Controls, Forms, Dialogs, UnitFrame2, UnitFrame1;

type
  TForm1 = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    Frame11: TFrame1;
    Frame21: TFrame2;

    function ConnectionLinesToConnectionString(cl: String): String;
    function ConnectionStringToConnectionLines(cl: String): String;
    function CreateRealConnectionString(ConnLines, PathLines: String): String;
    function GetDelimitedTextFromStrings(sl: TStringList; Delimiter: String): String;

    procedure SelectReport;
    procedure SwitchToPivotGrid;
    procedure SwitchToSelectReport;
  end;

var
  Form1: TForm1;

implementation

uses SQLMonForm;

{$R *.dfm}

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if Frame21.CloseQuery then
    CanClose := True
  else
    CanClose := False;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  fSQLMon := TfSQLMon.Create(Application);

  Frame11 := TFrame1.Create(Self);
  Frame11.Parent := Self;

  Frame21 := TFrame2.Create(Self);
  Frame21.Parent := Self;

  Frame21.Visible := False;

  Frame11.Align := alClient;
  Frame11.mtReportList.Open;
end;

function TForm1.ConnectionLinesToConnectionString(cl: String): String;
var
  connParams: TStringList;
begin
  connParams := TStringList.Create;
  connParams.Text := cl;
  Result := GetDelimitedTextFromStrings(connParams, ';');
  connParams.Free;
end;

function TForm1.ConnectionStringToConnectionLines(cl: String): String;
begin

end;

function TForm1.CreateRealConnectionString(ConnLines, PathLines: String): String;
var
//  connString: String;
  connParams: TStringList;
  FileName, s: String;
  FilesList: TStringList;
  i: Integer;
  AppDir: String;
begin
  AppDir := ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

  FilesList := TStringList.Create;
  FilesList.Text := PathLines;
  if FilesList.Count > 0 then
  begin
    FileName := '';
    for i := 0 to FilesList.Count-1 do
    begin
      s := FilesList[i];
      s := StringReplace(s, '%APPDIR%', AppDir, [rfIgnoreCase]);
      if FileExists(s) then
      begin
        FileName := s;
        Break;
      end;
    end;
    if FileName = '' then
      raise Exception.Create('Can''t find file name specified by "FilePaths" field value');
  end;
  FilesList.Free;

  connParams := TStringList.Create;
  connParams.Text := ConnLines;
  for i := 0 to connParams.Count-1 do
  begin
    if Copy(connParams[i], 1, Length('Data Source')) = 'Data Source' then
    begin
      s := StringReplace(connParams[i], '%FilePath%', FileName, [rfIgnoreCase]);
      connParams[i] := s;
    end;
  end;
  Result := GetDelimitedTextFromStrings(connParams, ';');
  connParams.Free;
end;

procedure TForm1.SelectReport;
begin
  SwitchToPivotGrid;
  Frame21.SelectReport(Frame11.mtReportList);
end;

procedure TForm1.SwitchToPivotGrid;
begin
  Frame11.Visible := False;
  Frame21.Visible := True;
  Frame21.Align := alClient;
  Frame21.UpdateButtonsState;
end;

procedure TForm1.SwitchToSelectReport;
begin
  Frame21.Visible := False;
  Frame11.Visible := True;
  Frame11.Align := alClient;
end;

function TForm1.GetDelimitedTextFromStrings(sl: TStringList;
  Delimiter: String): String;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to sl.Count-1 do
  begin
    if Result <> '' then
      Result := Result + Delimiter;
    Result := Result + sl[i];
  end;
end;

end.
