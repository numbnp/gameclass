unit Frame3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StrUtils, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, Types,
  MemTableDataEh, Db, StdCtrls, MemTableEh, GridsEh, DBGridEh, ExtCtrls,
  Mask, DBCtrlsEh, DynVarsEh, EhLibVCL, DBAxisGridsEh, ComCtrls;

type
  TfrFrame3 = class(TFrame)
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBMemoEh1: TDBMemoEh;
    DBGridEh1: TDBGridEh;
    Panel2: TPanel;
    Label2: TLabel;
    procedure DBGridEh1SearchPanelCheckCellHitSearch(Grid: TCustomDBGridEh;
      Column: TColumnEh; var Accept: Boolean);
    procedure DBGridEh1SearchPanelGetHighlightStrings(
      Grid: TCustomDBGridEh; Column: TColumnEh;
      var Strings: TStringDynArray);
    procedure DBGridEh1SearchPanelSearchEditChange(Grid: TCustomDBGridEh;
      SearchEdit: TDBGridSearchPanelTextEditEh);
  private
    { Private declarations }
  public
    { Public declarations }
    FSearchStrArr: TStringDynArray;
//    Text: String;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

function FindDelimiter(const Delimiters, S: string; StartIdx: Integer = 1): Integer;
var
  Stop: Boolean;
  Len: Integer;
begin
  Result := 0;

  Len := Length(S);
  Stop := False;
  while (not Stop) and (StartIdx <= Len) do
    if IsDelimiter(Delimiters, S, StartIdx) then
    begin
      Result := StartIdx;
      Stop := True;
    end
    else
      Inc(StartIdx);
end;

function SplitString(const S, Delimiters: string): TStringDynArray;
var
  StartIdx: Integer;
  FoundIdx: Integer;
  SplitPoints: Integer;
  CurrentSplit: Integer;
  i: Integer;
begin
  Result := nil;

  if S <> '' then
  begin
    SplitPoints := 0;
    for i := 1 to Length(S) do
      if IsDelimiter(Delimiters, S, i) then
        Inc(SplitPoints);

    SetLength(Result, SplitPoints + 1);

    StartIdx := 1;
    CurrentSplit := 0;
    repeat
      FoundIdx := FindDelimiter(Delimiters, S, StartIdx);
      if FoundIdx <> 0 then
      begin
        Result[CurrentSplit] := Copy(S, StartIdx, FoundIdx - StartIdx);
        Inc(CurrentSplit);
        StartIdx := FoundIdx + 1;
      end;
    until CurrentSplit = SplitPoints;

    Result[SplitPoints] := Copy(S, StartIdx, Length(S) - StartIdx + 1);
  end;
end;

constructor TfrFrame3.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  Text := 'Use Full Filter Panel facilities when the Grid is connected to TMemTableEh. Filtering in a selected area is supported';
end;

procedure TfrFrame3.DBGridEh1SearchPanelCheckCellHitSearch(
  Grid: TCustomDBGridEh; Column: TColumnEh; var Accept: Boolean);
var
  S, SubStr: String;
  Pos: Integer;
  i: Integer;
begin
  S := Column.DisplayText;
  if not DBGridEh1.SearchPanel.CaseSensitive then
    S := NlsUpperCase(S);
  for i := 0 to Length(FSearchStrArr)-1 do
  begin
    SubStr := FSearchStrArr[i];
    if not DBGridEh1.SearchPanel.CaseSensitive then
      SubStr := NlsUpperCase(SubStr);
    Pos := PosEx(SubStr, S);
    if Pos > 0 then
    begin
      Accept := True;
      Break;
    end else
      Accept := False;
  end;
end;

procedure TfrFrame3.DBGridEh1SearchPanelGetHighlightStrings(
  Grid: TCustomDBGridEh; Column: TColumnEh; var Strings: TStringDynArray);
begin
  Strings := FSearchStrArr;
end;

procedure TfrFrame3.DBGridEh1SearchPanelSearchEditChange(
  Grid: TCustomDBGridEh; SearchEdit: TDBGridSearchPanelTextEditEh);
begin
  FSearchStrArr := SplitString(SearchEdit.Text, ' ');
end;

end.
