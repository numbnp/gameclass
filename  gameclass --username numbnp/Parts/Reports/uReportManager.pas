unit uReportManager;

interface

uses
  Contnrs,
  ADODB,
  uReportCommon,
  uReport,
  uReportColumn,
  uReportsDataSet,
  uReportColumnsDataSet;


type

  // forward declaration
  TReportManager = class;

  //
  TReportImportParentIdMode = (
    rimUserParentId,
    rimXMLParentId,
    rimSQLParentId,
    rimSQLotherwiseXMLParentId);



  // events types
  TSetActiveReport = procedure(const ASender: TObject;
      const AActiveReport: TReport) of object;
  TDeleteReport = procedure(const ASender: TObject;
      const AnDeleteReportId: Integer) of object;


  //
  // TReportManagerLink
  //

  TReportManagerLink = class(TObject)
  private
    // fields
    FSender: TReportManager;
    FOnSetActiveReport: TSetActiveReport;
    FOnDeleteReport: TDeleteReport;

  public
    // constructor / destructor
    constructor Create(const AReportManager: TReportManager);
    destructor Destroy(); override;

    // public methods
    procedure SetActiveReport(const AActiveReport: TReport); dynamic;
    procedure DeleteReport(const AnDeleteReportId: Integer); dynamic;

    // properties
    property OnSetActiveReport: TSetActiveReport
        read FOnSetActiveReport write FOnSetActiveReport;
    property OnDeleteReport: TDeleteReport
        read FOnDeleteReport write FOnDeleteReport;

  end; // TReportManagerLink


  //
  // TReportManager
  //

  TReportManager = class(TObject)
  private
    // fields
    FcnnReport: TADOConnection;

    FlstReports: TReportList;
    FlstFavorites: TReportList;

    FlstObservers: TObjectList;

    // private helper methods
    procedure _BuildReports();
    procedure _CreateReportFromDataSet(
        const AdstReports: TReportsDataSet);
    procedure _NewReportInDB(const AnParentId: Integer;
        const AbIsFolder: Boolean;var AReport: TReport);
    procedure _DeleteReportFromDB(const AnId: Integer);
    procedure _NewReportColumnInDB(const AReport: TReport;
        var ANewReportColumn: TReportColumn);
    procedure _DeleteReportColumnFromDB(const AReport: TReport;
        const AnColumnId: Integer);
    function _CreateGUID(): String;
    function _GetReportFromGUID(const AstrGUID: String): TReport;

    // fire methods
    procedure _FireSetActiveReport();
    procedure _FireDeleteReport(const AnDeleteReportId: Integer);

  public
    // constructor / destructor
    constructor Create(const AcnnReport: TADOConnection);
    destructor Destroy(); override;

    // public methods
    procedure InitData();
    procedure SetActiveReport(const AnActiveUID: Integer;
        const AReportParameters: TReportParameters);
    function GetActiveReport(): TReport;

    function NewReport(const AnParentId: Integer;
        const AbIsFolder: Boolean): TReport;
    procedure DeleteReport(const AnId: Integer);
    function NewReportColumn(const AReport: TReport): TReportColumn;
    procedure DeleteReportColumn(const AReport: TReport;
        const AnId: Integer);

    procedure ExportReports(const AReportIds: array of Integer;
        const AstrExportFile: String);
    function ImportReports(const AstrImportFile: String;
        const AParentIdMode: TReportImportParentIdMode;
        const AnParentId: Integer): Boolean; overload;
    function ImportReports(const AstrImportFile: String;
        const AnParentId: Integer): Boolean; overload;

    // observer subject realization
    procedure RegisterChanges(const ALink: TReportManagerLink);
    procedure UnregisterChanges(const ALink: TReportManagerLink);

    // properties
    property Reports: TReportList read FlstReports;
    property Favorites: TReportList read FlstFavorites;

  end; // TReportManager


implementation

uses
  SysUtils,
  ActiveX,
  ComObj,
  DB,
  xmldom,
  XMLIntf,
  msxmldom,
  XMLDoc, Dialogs, Variants;

resourcestring
  INVARIABLE_REPORT_CODE = '/*  Код этого отчета нельзя изменять!  */ '#13#10;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TReportManagerLink

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TReportManagerLink.Create(const AReportManager: TReportManager);
begin
  inherited Create();
  FSender := AReportManager;
  AReportManager.RegisterChanges(Self);
end; // TReportManagerLink.Create


destructor TReportManagerLink.Destroy();
begin
  ASSERT(Assigned(FSender));

  FSender.UnregisterChanges(Self);

  inherited Destroy();

end; // TReportManagerLink.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TReportManagerLink.SetActiveReport(const AActiveReport: TReport);
begin
  if Assigned(OnSetActiveReport) then begin
    OnSetActiveReport(FSender, AActiveReport);
  end;
end; // TReportManagerLink.Change


procedure TReportManagerLink.DeleteReport(const AnDeleteReportId: Integer);
begin
  if Assigned(OnDeleteReport) then begin
    OnDeleteReport(FSender, AnDeleteReportId);
  end;
end; // TReportManagerLink.DeleteReport


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TReportManager

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TReportManager.Create(const AcnnReport: TADOConnection);
const
  IS_OWNER = TRUE;
begin
  inherited Create();
  FcnnReport := AcnnReport;

  FlstObservers := TObjectList.Create(FALSE);

  FlstReports := TReportList.Create(IS_OWNER);
  FlstFavorites := TReportList.Create(not IS_OWNER);

end; // TReportManager.Create


destructor TReportManager.Destroy();
begin
  while FlstObservers.Count > 0 do begin
    UnregisterChanges(TReportManagerLink(FlstObservers.Last()));
  end;
  FreeAndNil(FlstObservers);

  FreeAndNil(FlstFavorites);
  FreeAndNil(FlstReports);

  inherited Destroy();

end; // TReportManager.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TReportManager.InitData();
begin
  if Assigned(FcnnReport) then begin
    ASSERT(FcnnReport.State = [stOpen]);  
    if FcnnReport.State = [stOpen] then begin
      _BuildReports();
    end;
  end;
end; // TReportManager.InitData


procedure TReportManager.SetActiveReport(const AnActiveUID: Integer;
    const AReportParameters: TReportParameters);
begin
  FlstReports.SetActiveReport(AnActiveUID, AReportParameters);
  _FireSetActiveReport();
end; // TReportManager.SetActiveReport


function TReportManager.GetActiveReport(): TReport;
begin
  Result := FlstReports.GetActiveReport();
end; // TReportManager.GetActiveReport


function TReportManager.NewReport(const AnParentId: Integer;
    const AbIsFolder: Boolean): TReport;
var
  NewReport: TReport;
begin
  _NewReportInDB(AnParentId, AbIsFolder, NewReport);
  if Assigned(NewReport) then begin
    FlstReports.Add(NewReport);
  end;
  Result := NewReport;
end; // TReportManager.NewReport


procedure TReportManager.DeleteReport(const AnId: Integer);
var
  Report: TReport;
begin
  Report := FlstReports.FindByUID(AnId);
  if Assigned(Report) then begin
    _FireDeleteReport(AnId);  
    _DeleteReportFromDB(AnId);
    FlstReports.Remove(Report);
  end;
end; // TReportManager.DeleteReport


function TReportManager.NewReportColumn(
    const AReport: TReport): TReportColumn;
var
  NewReportColumn: TReportColumn;
begin
  _NewReportColumnInDB(AReport, NewReportColumn);
  if Assigned(NewReportColumn) then begin
    AReport.AddColumn(NewReportColumn);
  end;
  Result := NewReportColumn;
end; // TReportManager.NewReportColumn


procedure TReportManager.DeleteReportColumn(const AReport: TReport;
    const AnId: Integer);
begin
  _DeleteReportColumnFromDB(AReport, AnId);
  AReport.DeleteColumn(AnId);
end; // TReportManager.DeleteReportColumn


procedure TReportManager.ExportReports(const AReportIds: array of Integer;
    const AstrExportFile: String);
var
  XMLDocReports: TXMLDocument;
  nodeReport: IXMLNode;
  nodeReportColumns: IXMLNode;
  nodeReportColumn: IXMLNode;
  Report: TReport;
  ReportColumn: TReportColumn;
  i: Integer;
  col: Integer;
begin
  XMLDocReports := TXMLDocument.Create(FcnnReport);
  try
    try
      XMLDocReports.XML.Add('<?xml version="1.0" encoding="Windows-1251" '
        + 'standalone="no"?><REPORTS version="2.0" />');
      XMLDocReports.Active := TRUE;

      for i := Low(AReportIds) to High(AReportIds) do begin
        Report := FlstReports.FindByUID(AReportIds[i]);
        if not Assigned(Report) then begin
          continue;
        end;

        nodeReport := XMLDocReports.DocumentElement.AddChild('REPORT');
        nodeReport.Attributes['name'] := Report.ReportName;
        nodeReport.Attributes['description'] := Report.Description;
        nodeReport.Attributes['code'] := Report.Code;
        nodeReport.Attributes['author'] := Report.Author;
        nodeReport.Attributes['guid'] := Report.GUID;
        nodeReport.Attributes['isfolder'] := Report.IsFolder;
        nodeReport.Attributes['version'] := Report.Version;

        nodeReportColumns := nodeReport.AddChild('REPORTCOLUMNS');
        for col := 0 to Report.ReportColumns.Count - 1 do begin
          nodeReportColumn := nodeReportColumns.AddChild('REPORTCOLUMN');
          ReportColumn := Report.ReportColumns[col];
          nodeReportColumn.Attributes['name'] := ReportColumn.ColumnName;
          nodeReportColumn.Attributes['field'] := ReportColumn.Field;
          nodeReportColumn.Attributes['isgeneral'] := ReportColumn.IsGeneral;
          nodeReportColumn.Attributes['chartdefault'] := ReportColumn.ChartDefault;
          nodeReportColumn.Attributes['visible'] := ReportColumn.Visible;

          if ReportColumn.ChartRole = ChartRole_None then begin
            nodeReportColumn.Attributes['chartrole'] := 0;
          end else if ReportColumn.ChartRole = ChartRole_X then begin
            nodeReportColumn.Attributes['chartrole'] := 1;
          end else if ReportColumn.ChartRole = ChartRole_Y then begin
            nodeReportColumn.Attributes['chartrole'] := 2;
          end else begin
            nodeReportColumn.Attributes['chartrole'] := 0;
          end;

          if ReportColumn.AggregateFunction = Aggregate_None then begin
            nodeReportColumn.Attributes['aggregatefunction'] := 0;
          end else if ReportColumn.AggregateFunction = Aggregate_Sum then begin
            nodeReportColumn.Attributes['aggregatefunction'] := 1;
          end else if ReportColumn.AggregateFunction = Aggregate_Avg then begin
            nodeReportColumn.Attributes['aggregatefunction'] := 2;
          end else if ReportColumn.AggregateFunction = Aggregate_Count then begin
            nodeReportColumn.Attributes['aggregatefunction'] := 3;
          end else begin
            nodeReportColumn.Attributes['aggregatefunction'] := 0;
          end;
        end;

      end;

      XMLDocReports.SaveToFile(AstrExportFile);
      XMLDocReports.Active := FALSE;

    except
      XMLDocReports.Active := FALSE;
    end;

  finally
    FreeAndNil(XMLDocReports);
  end;
end; // TReportManager.ExportReports


function TReportManager.ImportReports(const AstrImportFile: String;
    const AParentIdMode: TReportImportParentIdMode;
    const AnParentId: Integer): Boolean;
var
  XMLDocReports: TXMLDocument;
  i: Integer;
  j: Integer;
  strGUID: String;
  Report: TReport;
  ReportColumn: TReportColumn;
  nodeReport: IXMLNode;
  nodeReportColumns: IXMLNode;
  nodeReportColumn: IXMLNode;
  bIsNewReport: Boolean;
begin
  Result := False;
  XMLDocReports := TXMLDocument.Create(FcnnReport);
  try
    try
      XMLDocReports.LoadFromFile(AstrImportFile);
      XMLDocReports.Active := TRUE;

      for i := 0 to XMLDocReports.DocumentElement.ChildNodes.Count - 1 do begin
        nodeReport := XMLDocReports.DocumentElement.ChildNodes[i];
        strGUID := nodeReport.Attributes['guid'];

        bIsNewReport := (FlstReports.FindByGUID(strGUID) = Nil);
        Report := _GetReportFromGUID(strGUID);

        if not bIsNewReport
            and (Report.Version >= nodeReport.Attributes['version']) then begin
          Result := True;
          continue;
        end;

        Report.ReportName := nodeReport.Attributes['name'];
        Report.Description := nodeReport.Attributes['description'];
        Report.Code := nodeReport.Attributes['code'];
        Report.Author := nodeReport.Attributes['author'];
        Report.GUID := nodeReport.Attributes['guid'];
        Report.IsFolder := nodeReport.Attributes['isfolder'];
        Report.Version := nodeReport.Attributes['version'];
        case AParentIdMode of
          rimUserParentId:
            Report.ParentId := AnParentId;
          rimXMLParentId:
            if VarIsNull(nodeReport.Attributes['parentid']) then
              Report.ParentId := AnParentId
            else
              Report.ParentId := nodeReport.Attributes['parentid'];
          rimSQLParentId:
            if bIsNewReport then
              Report.ParentId := AnParentId;
          rimSQLotherwiseXMLParentId:
            if bIsNewReport then begin
              if VarIsNull(nodeReport.Attributes['parentid']) then
                Report.ParentId := AnParentId
              else
                Report.ParentId := nodeReport.Attributes['parentid'];
            end;
        end;

        Report.ReportColumns.Clear();

        nodeReportColumns := nodeReport.ChildNodes[0];
        if Assigned(nodeReportColumns) then begin
          for j := 0 to nodeReportColumns.ChildNodes.Count - 1 do begin
            nodeReportColumn := nodeReportColumns.ChildNodes[j];
            ReportColumn := TReportColumn.Create();
            ReportColumn.ColumnName := nodeReportColumn.Attributes['name'];
            ReportColumn.Field := nodeReportColumn.Attributes['field'];
            ReportColumn.IsGeneral := nodeReportColumn.Attributes['isgeneral'];
            ReportColumn.ChartDefault := nodeReportColumn.Attributes['chartdefault'];
            ReportColumn.Visible := nodeReportColumn.Attributes['visible'];

            if nodeReportColumn.Attributes['chartrole'] = 0 then begin
              ReportColumn.ChartRole := ChartRole_None;
            end else if nodeReportColumn.Attributes['chartrole'] = 1 then begin
              ReportColumn.ChartRole := ChartRole_X;
            end else if nodeReportColumn.Attributes['chartrole'] = 2 then begin
              ReportColumn.ChartRole := ChartRole_Y;
            end else begin
              ReportColumn.ChartRole := ChartRole_None;
            end;

            if nodeReportColumn.Attributes['aggregatefunction'] = 0 then begin
              ReportColumn.AggregateFunction := Aggregate_None;
            end else if nodeReportColumn.Attributes['aggregatefunction'] = 1 then begin
              ReportColumn.AggregateFunction := Aggregate_Sum;
            end else if nodeReportColumn.Attributes['aggregatefunction'] = 2 then begin
              ReportColumn.AggregateFunction := Aggregate_Avg;
            end else if nodeReportColumn.Attributes['aggregatefunction'] = 3 then begin
              ReportColumn.AggregateFunction := Aggregate_Count;
            end else begin
              ReportColumn.AggregateFunction := Aggregate_None;
            end;

            Report.AddColumn(ReportColumn);
          end;
        end;

        Report.Save(TRUE);
        Result := True;
      end;

      XMLDocReports.Active := FALSE;

    except
      XMLDocReports.Active := FALSE;
    end;

  finally
    FreeAndNil(XMLDocReports);
  end;
end; // TReportManager.ImportReports

function TReportManager.ImportReports(const AstrImportFile: String;
    const AnParentId: Integer): Boolean;
begin
  Result := ImportReports(AstrImportFile, rimUserParentId, AnParentId);
end;

//////////////////////////////////////////////////////////////////////////////
// observer subject realization

procedure TReportManager.RegisterChanges(
    const ALink: TReportManagerLink);
begin
  ASSERT(Assigned(ALink));
  ASSERT(Assigned(FlstObservers));

  if Assigned(FlstObservers) then begin
    FlstObservers.Add(ALink);
  end;

end; // TReportManager.RegisterChanges


procedure TReportManager.UnregisterChanges(
    const ALink: TReportManagerLink);
begin
  ASSERT(Assigned(ALink));
  ASSERT(Assigned(FlstObservers));

  FlstObservers.Remove(ALink);

end; // TReportManager.UnregisterChanges


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TReportManager._BuildReports();
var
  dstReports: TReportsDataSet;
begin
  FlstFavorites.Clear();
  FlstReports.Clear();

  dstReports := TReportsDataSet.Create(FcnnReport, FcnnReport);
  try
    dstReports.OpenDef();
    if not dstReports.IsEmpty() then begin
      dstReports.First();
      while not dstReports.Eof do begin
        _CreateReportFromDataSet(dstReports);
        dstReports.Next();
      end;
    end;
  finally
    FreeAndNil(dstReports);
  end;

end; // TReportManager._BuildReports


procedure TReportManager._CreateReportFromDataSet(
    const AdstReports: TReportsDataSet);
var
  Report: TReport;
begin
  Report := TReport.Create(FcnnReport, AdstReports.UID);
  try
    Report.ReportName := AdstReports.ReportName;
    if AdstReports.Invariable then
      Report.Code := INVARIABLE_REPORT_CODE + AdstReports.Code
    else
      Report.Code := AdstReports.Code;
    Report.Description := AdstReports.Description;
    Report.ParentId := AdstReports.ParentId;
    Report.IsFolder := AdstReports.IsFolder;
    Report.OrderIndex := AdstReports.OrderIndex;
    Report.Version := AdstReports.Version;
    Report.Author := AdstReports.Author;
    Report.GUID := AdstReports.GUID;
    Report.Invariable := AdstReports.Invariable;
  except
    on e: Exception do begin
      FreeAndNil(Report);
    end;
  end;

  if Assigned(Report) then begin
    FlstReports.Add(Report);
  end;

end; // TReportManager._CreateReportFromDataSet


procedure TReportManager._NewReportInDB(const AnParentId: Integer;
    const AbIsFolder: Boolean; var AReport: TReport);
var
  dstReports: TReportsDataSet;
  nNewId: Integer;
  nOrderIndex: Integer;
begin
  AReport := nil;

  nNewId := 0;

  dstReports := TReportsDataSet.Create(FcnnReport, FcnnReport);
  try
    dstReports.OpenDef();
    //Ищем максимальный OrderIndex
    dstReports.Filter := 'ParentId = ' + IntToStr(AnParentId);
    dstReports.Filtered := True;
    dstReports.Sort := 'OrderIndex DESC';
    nOrderIndex := dstReports.OrderIndex + 1;
    dstReports.Sort := '';
    dstReports.Filtered := False;
    try
      dstReports.Insert();
      dstReports.ReportName := 'name';
      dstReports.ParentId := AnParentId;
      dstReports.IsFolder := AbIsFolder;
      dstReports.Author := '';
      dstReports.GUID := _CreateGUID();
      dstReports.Version := 1;

      dstReports.Post();
      nNewId := dstReports.UID;

    except
      if dstReports.State = dsInsert then begin
        dstReports.Cancel();
      end;
    end;

    if nNewId <> 0 then begin
      AReport := TReport.Create(FcnnReport, nNewId);
      AReport.ReportName := dstReports.ReportName;
      AReport.ParentId := dstReports.ParentId;
      AReport.Code := dstReports.Code;
      AReport.Description := dstReports.Description;
      AReport.IsFolder := dstReports.IsFolder;
//      AReport.OrderIndex := dstReports.OrderIndex;
      AReport.OrderIndex := nOrderIndex;
      AReport.GUID := dstReports.GUID;
      AReport.Version := dstReports.Version;
    end;

  finally
    FreeAndNil(dstReports);
  end;

end; // TReportManager._NewReportInDB


procedure TReportManager._DeleteReportFromDB(const AnId: Integer);
var
  dstReports: TReportsDataSet;
begin
  dstReports := TReportsDataSet.Create(FcnnReport, FcnnReport);
  try
    dstReports.OpenDef();

    if dstReports.LocateById(AnId) then begin
      dstReports.Delete();
    end;

  finally
    FreeAndNil(dstReports);
  end;
end; // TReportManager._DeleteReportFromDB


procedure TReportManager._NewReportColumnInDB(
    const AReport: TReport; var ANewReportColumn: TReportColumn);
var
  dstReportColumns: TReportColumnsDataSet;
  nNewId: Integer;
begin
  ANewReportColumn := nil;
  nNewId := 0;

  dstReportColumns := TReportColumnsDataSet.Create(FcnnReport, FcnnReport);
  try
    dstReportColumns.OpenDef(AReport.UID);
    try
      dstReportColumns.Insert();
      dstReportColumns.ColumnName := 'name';
      dstReportColumns.Field := '';
      dstReportColumns.IsGeneral := TRUE;
      dstReportColumns.Visible := TRUE;
      dstReportColumns.ChartDefault := FALSE;
      dstReportColumns.ChartRole := ChartRole_None;
      dstReportColumns.AggregateFunction := Aggregate_None;
      dstReportColumns.Width := 64;
      dstReportColumns.ReportId := AReport.UID;
      dstReportColumns.OrderIndex := AReport.ReportColumns.Count;
      dstReportColumns.Post();
      nNewId := dstReportColumns.UID;
    except
      if dstReportColumns.State = dsInsert then begin
        dstReportColumns.Cancel();
      end;
    end;

    if nNewId <> 0 then begin
      ANewReportColumn := TReportColumn.Create();
      ANewReportColumn.UID := nNewId;
      ANewReportColumn.ColumnName := dstReportColumns.ColumnName;
      ANewReportColumn.Field := dstReportColumns.Field;
      ANewReportColumn.IsGeneral := dstReportColumns.IsGeneral;
      ANewReportColumn.Visible := dstReportColumns.Visible;
      ANewReportColumn.ChartDefault := dstReportColumns.ChartDefault;
      ANewReportColumn.ChartRole := dstReportColumns.ChartRole;
      ANewReportColumn.AggregateFunction := dstReportColumns.AggregateFunction;
      ANewReportColumn.Width := dstReportColumns.Width;
      ANewReportColumn.OrderIndex := dstReportColumns.OrderIndex;
    end;

  finally
    FreeAndNil(dstReportColumns);
  end;
end; // TReportManager._NewReportColumnInDB


procedure TReportManager._DeleteReportColumnFromDB(
    const AReport: TReport; const AnColumnId: Integer);
var
  dstReportColumns: TReportColumnsDataSet;
begin
  dstReportColumns := TReportColumnsDataSet.Create(FcnnReport, FcnnReport);
  try
    dstReportColumns.OpenDef(AReport.UID);

    if dstReportColumns.LocateById(AnColumnId) then begin
      dstReportColumns.Delete();
    end;

  finally
    FreeAndNil(dstReportColumns);
  end;
end; // TReportManager._DeleteReportColumnFromDB


function TReportManager._CreateGUID(): String;
var
  GUID: TGUID;
begin
  Result := '';
  if CoCreateGUID(GUID) = S_OK then begin
    result := GUIDToString(GUID);
  end;
end; // TReportManager._CreateGUID


function TReportManager._GetReportFromGUID(const AstrGUID: String): TReport;
var
  Report: TReport;
begin
  Report := FlstReports.FindByGUID(AstrGUID);
  if not Assigned(Report) then begin
    Report := NewReport(0, FALSE);
  end;
  Result := Report;
end; // TReportManager.GetReportFromGUID


//////////////////////////////////////////////////////////////////////////////
// fire methods

procedure TReportManager._FireSetActiveReport();
var
  i: Integer;
  Report: TReport;
begin
  ASSERT(Assigned(FlstObservers));

  Report := FlstReports.GetActiveReport();
  if Assigned(Report) then begin
    for i := 0 to FlstObservers.Count - 1 do begin
      TReportManagerLink(FlstObservers[i]).SetActiveReport(Report);
    end;
  end;

end; // TReportManager._FireSetActiveReport


procedure TReportManager._FireDeleteReport(const AnDeleteReportId: Integer);
var
  i: Integer;
begin
  ASSERT(Assigned(FlstObservers));

  for i := 0 to FlstObservers.Count - 1 do begin
    TReportManagerLink(FlstObservers[i]).DeleteReport(AnDeleteReportId);
  end;

end; // TReportManager._FireDeleteReport


end.
