unit uReport;

interface

uses
  Contnrs,
  ADODB,
  uReportCommon,
  uReportResultsDataSet,
  uReportsDataSet,
  uReportColumnsDataSet,
  uReportColumn;

type

  //
  // TReport
  //

  TReport = class(TObject)
  private
    // fields
    FnUID: Integer;
    FstrName: String;
    FstrCode: String;
    FstrDescription: String;
    FnParentId: Integer;
    FbIsFolder: Boolean;
    FnOrderIndex: Integer;
    FnVersion: Integer;
    FstrAuthor: String;
    FstrGUID: String;
    FbInvariable: Boolean;

    FReportParameters: TReportParameters;
    FdstResult: TReportResultsDataSet;
    FbActive: Boolean;
    FcnnMain: TADOConnection;
    FlstReportColumns: TReportColumnList;

    // private helper methods
    procedure _BuildReportColumns();
    procedure _CreateReportColumnFromDataSet(
        const AdstReportColumns: TReportColumnsDataSet);

    procedure _CreateResultDataSet();
    procedure _DestroyResultDataSet();
    procedure _DefaultReportParameters();

    function _SaveReport(): Boolean;
    procedure _SaveReportColumns();

  protected
    // properties methods
    procedure SetActive(const AbActive: Boolean); virtual;

  public
    // constructor / destructor
    constructor Create(const Acnn: TADOConnection; const AnUID: Integer);
    destructor Destroy(); override;

    // public methods
    procedure Save(const AbSaveColumns: Boolean);

    procedure AddColumn(const AReportColumn: TReportColumn);
    procedure DeleteColumn(const AnId: Integer);

    // properties
    property UID: Integer read FnUID;
    property ReportName: String read FstrName write FstrName;
    property Code: String read FstrCode write FstrCode;
    property Description: String read FstrDescription write FstrDescription;
    property ParentId: Integer read FnParentId write FnParentId;
    property IsFolder: Boolean read FbIsFolder write FbIsFolder;
    property OrderIndex: Integer read FnOrderIndex write FnOrderIndex;
    property Version: Integer read FnVersion write FnVersion;
    property Author: String read FstrAuthor write FstrAuthor;
    property GUID: String read FstrGUID write FstrGUID;
    property Invariable: Boolean read FbInvariable write FbInvariable;

    property ReportParameters: TReportParameters
        read FReportParameters write FReportParameters;
    property ResultDataSet: TReportResultsDataSet read FdstResult;
    property ReportColumns: TReportColumnList read FlstReportColumns;
    property Active: Boolean read FbActive write SetActive;

  end; // TReport


  //
  // TReportList
  //

  TReportList = class(TObjectList)
  protected
    // properties methods
    function GetItem(const AnIndex: Integer): TReport;
    procedure SetItem(const AnIndex: Integer; const AValue: TReport);

  public
    // constructor / destructor
    constructor Create(const AbOwner: Boolean);

    // public methods
    procedure Add(const AValue: TReport);
    function GetActiveReport(): TReport;
    procedure SetActiveReport(const AnActiveUID: Integer;
        const AReportParameters: TReportParameters);
    function FindByUID(const AnUID: Integer): TReport;
    function FindByGUID(const AstrGUID: String): TReport;

    // properties
    property Items[const Index: Integer]: TReport
        read GetItem write SetItem; default;

  end; // TReportList


implementation

uses
{$IFDEF GC3SERVER}
  gccomputers,
  uVirtualTime,
  uTimeShift,
{$ENDIF}
  DB,
  SysUtils;

const
  DEF_QUERY_OTHERS1 = 'EXEC CustomReport';
  DEF_QUERY_OTHERS2 = 'Execute ';

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TReport.Create(const Acnn: TADOConnection;
    const AnUID: Integer);
const
  IS_OWNER = TRUE;
begin
  inherited Create();
  FcnnMain := Acnn;
  FlstReportColumns := TReportColumnList.Create(IS_OWNER);
  FnUID := AnUID;
  _BuildReportColumns();
  _DefaultReportParameters();
end; // TReport.Create


destructor TReport.Destroy();
begin
  _DestroyResultDataSet();
  FreeAndNil(FlstReportColumns);
  inherited Destroy();
end; // TReport.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TReport.Save(const AbSaveColumns: Boolean);
begin
{$IFDEF GC3SERVER}
  if IsManager and not Invariable then begin
{$ENDIF}
    if _SaveReport() then begin
      if AbSaveColumns then begin
        _SaveReportColumns();
      end;
    end;
{$IFDEF GC3SERVER}
  end;
{$ENDIF}
end; // TReport.Save


procedure TReport.AddColumn(
    const AReportColumn: TReportColumn);
begin
  ASSERT(Assigned(AReportColumn));

  FlstReportColumns.Add(AReportColumn);

end; // TReport.AddColumn


procedure TReport.DeleteColumn(const AnId: Integer);
var
  ReportColumn: TReportColumn;
begin
  ReportColumn := FlstReportColumns.FindById(AnId);
  if Assigned(ReportColumn) then begin
    FlstReportColumns.Remove(ReportColumn);
  end;
end; // TReport.DeleteColumn


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TReport.SetActive(const AbActive: Boolean);
begin
  FbActive := AbActive;
  if AbActive then begin
    _CreateResultDataSet();
  end else begin
    _DestroyResultDataSet();
  end;
end; // TReport.SetActive


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TReport._BuildReportColumns();

var
  dstReportColumns: TReportColumnsDataSet;
begin
  dstReportColumns := TReportColumnsDataSet.Create(FcnnMain, FcnnMain);
  try
    dstReportColumns.OpenDef(UID);
    if not dstReportColumns.IsEmpty() then begin
      while not dstReportColumns.Eof do begin
        _CreateReportColumnFromDataSet(dstReportColumns);
        dstReportColumns.Next();
      end;
    end;
  finally
    FreeAndNil(dstReportColumns);
  end;

end; // TReport._BuildReportColumns


procedure TReport._CreateReportColumnFromDataSet(
    const AdstReportColumns: TReportColumnsDataSet);
var
  ReportColumn: TReportColumn;
begin
  ReportColumn := TReportColumn.Create();
  try
    ReportColumn.UID := AdstReportColumns.UID;
    ReportColumn.ColumnName := AdstReportColumns.ColumnName;
    ReportColumn.Field := AdstReportColumns.Field;
    ReportColumn.ChartRole := AdstReportColumns.ChartRole;
    ReportColumn.ChartDefault := AdstReportColumns.ChartDefault;
    ReportColumn.IsGeneral := AdstReportColumns.IsGeneral;
    ReportColumn.AggregateFunction := AdstReportColumns.AggregateFunction;
    ReportColumn.Visible := AdstReportColumns.Visible;
    ReportColumn.Width := AdstReportColumns.Width;
    ReportColumn.OrderIndex := AdstReportColumns.OrderIndex;
  except
    FreeAndNil(ReportColumn);
  end;

  if Assigned(ReportColumn) then begin
    FlstReportColumns.Add(ReportColumn);
  end;

end; // TReport._CreateReportColumnFromDataSet


procedure TReport._CreateResultDataSet();
begin
  if IsFolder then begin
    exit;
  end;

  if Assigned(FdstResult) then begin
    _DestroyResultDataSet();
  end;

{$IFDEF GC3SERVER}
  if IsManager and (Length(FstrCode) = 0) then begin
    exit;
  end;
{$ENDIF}

  FdstResult := TReportResultsDataSet.Create(FcnnMain);
  try
    FdstResult.Connection := FcnnMain;
    FdstResult.CommandType := cmdText;
{$IFDEF GC3SERVER}
    if IsManager and not Invariable then begin
      FdstResult.CommandText := FstrCode;
      FdstResult.OpenReport(ReportParameters, False);
    end else begin
      FdstResult.CommandText := DEF_QUERY_OTHERS1 + IntToStr(UID)
          + DEF_QUERY_OTHERS2;
      FdstResult.OpenReport(ReportParameters, True);
    end
{$ELSE}
    FdstResult.CommandText := FstrCode;
    FdstResult.OpenReport(ReportParameters, False);
{$ENDIF}
  except
    FreeAndNil(FdstResult);
  end;

end; // TReport._CreateResultDataSet


procedure TReport._DestroyResultDataSet();
begin
  FreeAndNil(FdstResult);
end; // TReport._DestroyResultDataSet


procedure TReport._DefaultReportParameters();
begin
{$IFDEF GC3SERVER}
  FReportParameters.dtCurrent := GetVirtualTime;
  FReportParameters.dtCurrentShiftBegin := GetCurrentShiftBegin(ReportParameters.dtCurrent);
  FReportParameters.dtPrevShiftBegin := GetCurrentShiftBegin(ReportParameters.dtCurrentShiftBegin);
  FReportParameters.dtPrevShiftEnd := FReportParameters.dtCurrentShiftBegin;
{$ELSE}
  FReportParameters.dtCurrent := Now();
  FReportParameters.dtCurrentShiftBegin := Now();
  FReportParameters.dtPrevShiftBegin := Now();
  FReportParameters.dtPrevShiftEnd := Now();
{$ENDIF}
  FReportParameters.dtBegin := MinDateTime;
  FReportParameters.dtEnd := MaxDateTime;

end; // TReport._DefaultReportParameters


procedure TReport._SaveReportColumns();
var
  dstReportColumns: TReportColumnsDataSet;
  Column: TReportColumn;
  i: Integer;
begin
  if FlstReportColumns.Count = 0 then begin
    exit;
  end;

  dstReportColumns := TReportColumnsDataSet.Create(FcnnMain, FcnnMain);
  try
    dstReportColumns.OpenDef(UID);

    for i := 0 to ReportColumns.Count - 1 do begin
      if ReportColumns[i].UID = 0 then begin
        // добавляем поле
        dstReportColumns.Insert();

      end else begin
        if dstReportColumns.Locate('id', ReportColumns[i].UID, []) then begin
          // редактируем поле
          dstReportColumns.Edit();

        end else begin
          ASSERT(FALSE);
        end;
      end;

      if ((dstReportColumns.State = dsInsert)
          or (dstReportColumns.State = dsEdit)) then begin
        try
          dstReportColumns.ColumnName := ReportColumns[i].ColumnName;
          dstReportColumns.Field := ReportColumns[i].Field;
          dstReportColumns.IsGeneral := ReportColumns[i].IsGeneral;
          dstReportColumns.ChartRole := ReportColumns[i].ChartRole;
          dstReportColumns.ChartDefault := ReportColumns[i].ChartDefault;
          dstReportColumns.AggregateFunction := ReportColumns[i].AggregateFunction;
          dstReportColumns.Width := ReportColumns[i].Width;
          dstReportColumns.Visible := ReportColumns[i].Visible;
          dstReportColumns.OrderIndex := ReportColumns[i].OrderIndex;
          dstReportColumns.ReportId := UID;

          dstReportColumns.Post();
          ReportColumns[i].UID := dstReportColumns.UID;
        except
          if ((dstReportColumns.State = dsInsert)
              or (dstReportColumns.State = dsEdit)) then begin
            dstReportColumns.Cancel();
          end;
        end; // try
      end; // if
    end; // for

    // удаляем ненужные поля
    if dstReportColumns.IsEmpty() then begin
      exit;
    end;

    dstReportColumns.First();
    while not dstReportColumns.Eof do begin
      Column := ReportColumns.FindById(dstReportColumns.UID);
      if Assigned(Column) then begin
        dstReportColumns.Next();
      end else begin
        dstReportColumns.Delete();
      end;
    end;

  finally
    FreeAndNil(dstReportColumns);
  end;

end; // TReport._SaveReportColumns


function TReport._SaveReport(): Boolean;
var
  dstReports: TReportsDataSet;
begin
  Result := FALSE;
  dstReports := TReportsDataSet.Create(FcnnMain, FcnnMain);
  try
    dstReports.OpenDef();
    if dstReports.LocateById(UID) then begin
      try
        dstReports.Edit();
        dstReports.ReportName := ReportName;
        dstReports.IsFolder := IsFolder;
        dstReports.ParentId := ParentId;
        dstReports.Description := Description;
        dstReports.Code := Code;
        dstReports.OrderIndex := OrderIndex;
        dstReports.Author := Author;
        dstReports.Version := Version;
        dstReports.Post();
        Result := TRUE;
      except
        if ((dstReports.State = dsInsert)
            or (dstReports.State = dsEdit)) then begin
          dstReports.Cancel();
        end;
      end;
    end;
  finally
    FreeAndNil(dstReports);
  end;
end; // TReport._SaveReport


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TReportList.Create(const AbOwner: Boolean);
begin
  inherited Create(AbOwner);
end; // TReportList.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TReportList.Add(const AValue: TReport);
begin
  inherited Add(AValue);
end; // TReportList.Add


function TReportList.GetActiveReport(): TReport;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do begin
    if Items[i].Active then begin
      Result := Items[i];
      break;
    end;
  end;
end; // TReportList.GetActiveReport


procedure TReportList.SetActiveReport(const AnActiveUID: Integer;
    const AReportParameters: TReportParameters);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do begin
    Items[i].Active := FALSE;
    if Items[i].UID = AnActiveUID then begin
      Items[i].ReportParameters := AReportParameters;
      Items[i].Active := TRUE;
    end;
  end;
end; // TReportList.SetActiveReport


function TReportList.FindByUID(const AnUID: Integer): TReport;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do begin
    if Items[i].UID = AnUID then begin
      Result := Items[i];
      break;
    end;
  end;
end; // TReportList.FindByUID


function TReportList.FindByGUID(const AstrGUID: String): TReport;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do begin
    if CompareText(Items[i].GUID, AstrGUID) = 0 then begin
      Result := Items[i];
      break;
    end;
  end;
end; // TReportList.FindByGUID


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TReportList.GetItem(const AnIndex: Integer): TReport;
begin
  Result := TReport(inherited GetItem(AnIndex));
end; // TReportList.GetItem


procedure TReportList.SetItem(const AnIndex: Integer; const AValue: TReport);
begin
  inherited SetItem(AnIndex, AValue)
end; // TReportList.SetItem


end.
