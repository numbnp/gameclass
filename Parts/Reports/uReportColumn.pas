unit uReportColumn;

interface

uses
  Contnrs,
  uReportCommon;


type

  //
  // TReportColumn
  //

  TReportColumn = class(TObject)
  private
    // fields
    FnUID: Integer;
    FstrName: String;
    FstrField: String;
    FChartRole: TChartRole;
    FbChartDefault: Boolean;
    FbIsGeneral: Boolean;
    FAggregateFunction: TAggregateFunction;
    FbVisible: Boolean;
    FnWidth: Integer;
    FnOrderIndex: Integer;

  public
    // properties
    property UID: Integer read FnUID write FnUID;
    property ColumnName: String read FstrName write FstrName;
    property Field: String read FstrField write FstrField;
    property ChartRole: TChartRole read FChartRole write FChartRole;
    property ChartDefault: Boolean read FbChartDefault write FbChartDefault;
    property IsGeneral: Boolean read FbIsGeneral write FbIsGeneral;
    property AggregateFunction: TAggregateFunction
        read FAggregateFunction write FAggregateFunction;
    property Visible: Boolean read FbVisible write FbVisible;
    property Width: Integer read FnWidth write FnWidth;
    property OrderIndex: Integer read FnOrderIndex write FnOrderIndex;

  end; // TReportColumn


  //
  // TReportColumnList
  //

  TReportColumnList = class(TObjectList)
  protected
    // properties methods
    function GetItem(const AnIndex: Integer): TReportColumn;
    procedure SetItem(const AnIndex: Integer; const AValue: TReportColumn);

  public
    // constructor / destructor
    constructor Create(const AbOwner: Boolean);

    // public methods
    procedure Add(const AValue: TReportColumn);
    function FindById(const AnId: Integer): TReportColumn;
    function FindByField(const AstrField: String): TReportColumn;
    procedure SortByOrder();

    // properties
    property Items[const Index: Integer]: TReportColumn
        read GetItem write SetItem; default;

  end; // TReportColumnList


implementation

uses
  SysUtils,
  System.Classes;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TReportColumnList.Create(const AbOwner: Boolean);
begin
  inherited Create(AbOwner);
end; // TReportColumnList.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TReportColumnList.Add(const AValue: TReportColumn);
begin
  inherited Add(AValue);
end; // TReportColumnList.Add


function TReportColumnList.FindById(const AnId: Integer): TReportColumn;
var
  i: Integer;
begin
  Result := nil;
  
  if Count = 0 then begin
    exit;
  end;

  for i := 0 to Count - 1 do begin
    if Items[i].UID = AnId then begin
      Result := Items[i];
      break;
    end;
  end;
end; // TReportColumnList.FindById


function TReportColumnList.FindByField(
    const AstrField: String): TReportColumn;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do begin
    if CompareText(Items[i].Field, AstrField) = 0 then begin
      Result := Items[i];
      break;
    end;
  end;
end; // TReportColumnList.FindByField


procedure TReportColumnList.SortByOrder();
var
  i: Integer;
  j: Integer;
begin
  if Count < 2 then begin
    exit;
  end;

  for i := Count - 1 downto 1 do begin
    for j := 0 to i - 1 do begin
      if Items[j].OrderIndex > Items[j + 1].OrderIndex then begin
        Move(j, j + 1);
      end;
    end;
  end;

end; // TReportColumnList.SortByOrder


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TReportColumnList.GetItem(const AnIndex: Integer): TReportColumn;
begin
  Result := TReportColumn(inherited GetItem(AnIndex))
end; // TReportColumnList.GetItem


procedure TReportColumnList.SetItem(
    const AnIndex: Integer; const AValue: TReportColumn);
begin
  inherited SetItem(AnIndex, AValue);
end; // TReportColumnList.SetItem


end.
