unit uReportColumnsDataSet;

interface

uses
  // system units
  Classes,
  ADODB,
  // project units
  uReportCommon;


type

  //
  // TReportColumnsDataSet
  //

  TReportColumnsDataSet = class(TADODataSet)
  protected
    // properties methods
    function GetUID(): Integer; virtual;

    function GetColumnName(): String; virtual;
    procedure SetColumnName(const AstrColumnName: String); virtual;

    function GetField(): String; virtual;
    procedure SetField(const Astrfield: String); virtual;

    function GetChartRole(): TChartRole; virtual;
    procedure SetChartRole(const AChartRole: TChartRole); virtual;

    function GetChartDefault(): Boolean; virtual;
    procedure SetChartDefault(const AbChartDefault: Boolean); virtual;

    function GetIsGeneral(): Boolean; virtual;
    procedure SetIsGeneral(const AbIsGeneral: Boolean); virtual;

    function GetAggregateFunction(): TAggregateFunction; virtual;
    procedure SetAggregateFunction(
        const AAgregateFunction: TAggregateFunction); virtual;

    function GetVisible(): Boolean; virtual;
    procedure SetVisible(const AbVisible: Boolean); virtual;

    function GetWidth(): Integer; virtual;
    procedure SetWidth(const AnWidth: Integer); virtual;

    function GetOrderIndex(): Integer; virtual;
    procedure SetOrderIndex(const AnOrderIndex: Integer); virtual;

    function GetReportId(): Integer; virtual;
    procedure SetReportId(const AnReportId: Integer); virtual;

  public
    // constructor / destructor
    constructor Create(const AOwner: TComponent;
        const Acnn: TADOConnection); reintroduce;

    // public methods
    procedure OpenDef(const AnReportId: Integer);

    function LocateById(const AnId: Integer): Boolean;

    // properties
    property UID: Integer read GetUID;
    property ColumnName: String read GetColumnName write SetColumnName;
    property Field: String read GetField write SetField;
    property ChartRole: TChartRole read GetChartRole write SetChartRole;
    property ChartDefault: Boolean read GetChartDefault write SetChartDefault;
    property IsGeneral: Boolean read GetIsGeneral write SetIsGeneral;
    property AggregateFunction: TAggregateFunction
        read GetAggregateFunction write SetAggregateFunction;
    property Visible: Boolean read GetVisible write SetVisible;
    property Width: Integer read GetWidth write SetWidth;
    property OrderIndex: Integer read GetOrderIndex write SetOrderIndex;
    property ReportId: Integer read GetReportId write SetReportId;

  end; // TReportColumnsDataSet


implementation

uses
{$IFDEF GC3SERVER}
  gccomputers,
{$ENDIF}
  SysUtils;


const
  DEF_QUERY_MANGER =
      'SELECT * FROM ReportColumns WHERE ReportId = %d ORDER BY OrderIndex ASC';
  DEF_QUERY_OTHERS = 'EXEC CustomReportColumnsSelect %d';

  FLD_UID = 'id';
  FLD_COLUMNNAME = 'Name';
  FLD_FIELD = 'Field';
  FLD_CHARTROLE = 'ChartRole';
  FLD_CHARTDEFAULT = 'ChartDefault';
  FLD_ISGENERAL = 'IsGeneral';
  FLD_AGGREGATEFUNCTION = 'AggregateFunction';
  FLD_VISIBLE = 'Visible';
  FLD_WIDTH = 'Width';
  FLD_ORDER = 'OrderIndex';
  FLD_REPORT_ID = 'ReportId';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TReportColumnsDataSet.Create(const AOwner: TComponent;
    const Acnn: TADOConnection);
begin
  inherited Create(AOwner);
  Connection := Acnn;
end; // TReportColumnsDataSet.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TReportColumnsDataSet.OpenDef(const AnReportId: Integer);
begin
  CommandType := cmdText;
{$IFDEF GC3SERVER}
  if IsManager then
    CommandText := Format(DEF_QUERY_MANGER, [AnReportId])
  else
    CommandText := Format(DEF_QUERY_OTHERS, [AnReportId]);
{$ELSE}
  CommandText := Format(DEF_QUERY_MANGER, [AnReportId]);
{$ENDIF}
  Open();

  ASSERT(Assigned(FieldByName(FLD_UID))
      and Assigned(FieldByName(FLD_COLUMNNAME))
      and Assigned(FieldByName(FLD_FIELD))
      and Assigned(FieldByName(FLD_CHARTROLE))
      and Assigned(FieldByName(FLD_CHARTDEFAULT))
      and Assigned(FieldByName(FLD_ISGENERAL))
      and Assigned(FieldByName(FLD_AGGREGATEFUNCTION))
      and Assigned(FieldByName(FLD_VISIBLE))
      and Assigned(FieldByName(FLD_WIDTH))
      and Assigned(FieldByName(FLD_ORDER))
      and Assigned(FieldByName(FLD_REPORT_ID)));

end; // TReportColumnsDataSet.OpenDef


function TReportColumnsDataSet.LocateById(const AnId: Integer): Boolean;
begin
  Result := Locate(FLD_UID, AnId, []);
end; // TReportColumnsDataSet.LocateById


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TReportColumnsDataSet.GetUID(): Integer;
begin
  Result := FieldByName(FLD_UID).AsInteger;
end; // TReportColumnsDataSet.GetUID


function TReportColumnsDataSet.GetColumnName(): String;
begin
  Result := FieldByName(FLD_COLUMNNAME).AsString;
end; // TReportColumnsDataSet.GetColumnName


procedure TReportColumnsDataSet.SetColumnName(const AstrColumnName: String);
begin
  FieldByName(FLD_COLUMNNAME).AsString := AstrColumnName;
end; // TReportColumnsDataSet.SetColumnName


function TReportColumnsDataSet.GetField(): String;
begin
  Result := FieldByName(FLD_FIELD).AsString;
end; // TReportColumnsDataSet.GetField


procedure TReportColumnsDataSet.SetField(const AstrField: String);
begin
  FieldByName(FLD_FIELD).AsString := AstrField;
end; // TReportColumnsDataSet.SetField


function TReportColumnsDataSet.GetChartRole(): TChartRole;
var
  nChartRole: Integer;
begin
  nChartRole := FieldByName(FLD_CHARTROLE).AsInteger;
  case nChartRole of
    0: begin
      Result := ChartRole_None;
    end;
    1: begin
      Result := ChartRole_X;
    end;
    2: begin
      Result := ChartRole_Y;
    end;
    else begin
      ASSERT(FALSE, 'Unknown ChartRole!');
      Result := ChartRole_None;
    end;
  end;
end; // TReportColumnsDataSet.GetChartRole


procedure TReportColumnsDataSet.SetChartRole(const AChartRole: TChartRole);
begin
  case AChartRole of
    ChartRole_None: begin
      FieldByName(FLD_CHARTROLE).AsInteger := 0;
    end;
    ChartRole_X: begin
      FieldByName(FLD_CHARTROLE).AsInteger := 1;
    end;
    ChartRole_Y: begin
      FieldByName(FLD_CHARTROLE).AsInteger := 2;
    end;
    else begin
      ASSERT(FALSE, 'Unknown ChartRole!');
      FieldByName(FLD_CHARTROLE).AsInteger := 0;
    end;
  end;
end; // TReportColumnsDataSet.SetChartRole


function TReportColumnsDataSet.GetChartDefault(): Boolean;
begin
  Result := (FieldByName(FLD_CHARTDEFAULT).AsInteger <> 0);
end; // TReportColumnsDataSet.GetChartDefault


procedure TReportColumnsDataSet.SetChartDefault(const AbChartDefault: Boolean);
begin
  if AbChartDefault then begin
    FieldByName(FLD_CHARTDEFAULT).AsInteger := 1;
  end else begin
    FieldByName(FLD_CHARTDEFAULT).AsInteger := 0;
  end;
end; // TReportColumnsDataSet.SetChartDefault


function TReportColumnsDataSet.GetIsGeneral(): Boolean;
begin
  Result := (FieldByName(FLD_ISGENERAL).AsInteger <> 0);
end; // TReportColumnsDataSet.GetIsGeneral


procedure TReportColumnsDataSet.SetIsGeneral(const AbIsGeneral: Boolean);
begin
  if AbIsGeneral then begin
    FieldByName(FLD_ISGENERAL).AsInteger := 1;
  end else begin
    FieldByName(FLD_ISGENERAL).AsInteger := 0;
  end;
end; // TReportColumnsDataSet.SetIsGeneral


function TReportColumnsDataSet.GetAggregateFunction(): TAggregateFunction;
var
  nAggregateFunction: Integer;
begin
  nAggregateFunction := FieldByName(FLD_AGGREGATEFUNCTION).AsInteger;
  case nAggregateFunction of
    0: begin
      Result := Aggregate_None;
    end;
    1: begin
      Result := Aggregate_Sum;
    end;
    2: begin
      Result := Aggregate_Avg;
    end;
    3: begin
      Result := Aggregate_Count;
    end;
    else begin
      ASSERT(FALSE, 'Unknown aggregate!');
      Result := Aggregate_None;
    end;
  end;
end; // TReportColumnsDataSet.GetAggregateFunction


procedure TReportColumnsDataSet.SetAggregateFunction(
    const AAgregateFunction: TAggregateFunction);
begin
  case AAgregateFunction of
    Aggregate_None: begin
      FieldByName(FLD_AGGREGATEFUNCTION).AsInteger := 0;
    end;
    Aggregate_Sum: begin
      FieldByName(FLD_AGGREGATEFUNCTION).AsInteger := 1;
    end;
    Aggregate_Avg: begin
      FieldByName(FLD_AGGREGATEFUNCTION).AsInteger := 2;
    end;
    Aggregate_Count: begin
      FieldByName(FLD_AGGREGATEFUNCTION).AsInteger := 3;
    end;
    else begin
      ASSERT(FALSE, 'Unknown aggregate!');
      FieldByName(FLD_AGGREGATEFUNCTION).AsInteger := 0;
    end;
  end;
end; // TReportColumnsDataSet.SetAggregateFunction


function TReportColumnsDataSet.GetVisible(): Boolean;
begin
  Result := (FieldByName(FLD_VISIBLE).AsInteger <> 0);
end; // TReportColumnsDataSet.GetVisible


procedure TReportColumnsDataSet.SetVisible(const AbVisible: Boolean);
begin
  if AbVisible then begin
    FieldByName(FLD_VISIBLE).AsInteger := 1;
  end else begin
    FieldByName(FLD_VISIBLE).AsInteger := 0;
  end;
end; // TReportColumnsDataSet.SetVisible


function TReportColumnsDataSet.GetWidth(): Integer;
begin
  Result := FieldByName(FLD_WIDTH).AsInteger;
end; // TReportColumnsDataSet.GetWidth


procedure TReportColumnsDataSet.SetWidth(const AnWidth: Integer);
begin
  FieldByName(FLD_WIDTH).AsInteger := AnWidth;
end; // TReportColumnsDataSet.SetWidth


function TReportColumnsDataSet.GetOrderIndex(): Integer;
begin
  Result := FieldByName(FLD_ORDER).AsInteger;
end; // TReportColumnsDataSet.GetOrderIndex


procedure TReportColumnsDataSet.SetOrderIndex(const AnOrderIndex: Integer);
begin
  FieldByName(FLD_ORDER).AsInteger := AnOrderIndex;
end; // TReportColumnsDataSet.SetOrderIndex


function TReportColumnsDataSet.GetReportId(): Integer;
begin
  Result := FieldByName(FLD_REPORT_ID).AsInteger;
end; // TReportColumnsDataSet.GetReportId


procedure TReportColumnsDataSet.SetReportId(const AnReportId: Integer);
begin
  FieldByName(FLD_REPORT_ID).AsInteger := AnReportId;
end; // TReportColumnsDataSet.SetReportId


end.
