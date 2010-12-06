unit GCCustomReports;

interface

uses Classes;

type
  TCustomReport = class(TCollectionItem)
  private
    FstrId : String;
    FstrName : String;
    FstrDescription : String;
    FstrSQLCode : String;
    FnTabIndex : Integer;
    FnVersion: Integer;
  public
    property Id : String read FstrId write FstrId;
    property Name : String read FstrName write FstrName;
    property Description: String read FstrDescription write FstrDescription;
    property SQLCode: String read FstrSQLCode write FstrSQLCode;
    property TabIndex : Integer read FnTabIndex write FnTabIndex;
    property Version : Integer read FnVersion write FnVersion;
    procedure Save;
    procedure SaveByImport;
    procedure Delete;
    procedure Execute;
  end;

  TCustomReports = class(TCollection)
  public
    constructor Create;
    destructor Destroy; override;

    function Index(AstrName:string):integer;
    function IndexById(AstrId:string):integer;
    procedure Add(AstrId: String; AstrName:String; AstrDescription:String; AstrSQLCode:String; AnTabIndex: Integer; AnVersion: Integer);
                         //добавить новую запись или не добавить если есть (без сохранения)
    function GetItem(Index: Integer): TCustomReport ;
    procedure SetItem(Index: Integer; Value: TCustomReport);
    property Items[Index: Integer]:TCustomReport read GetItem write SetItem; default;
    function CheckSyntax(AstrSQLCode:String):Boolean;
    procedure Load;
    procedure RebuildTabIndex;
    function CompileMacros(AstrSQLCode:String):String;
  end;

var
  GCustomReports : TCustomReports;

implementation

uses
  SysUtils,
  StrUtils,
  gccommon,
  gcconst,
  gccomputers,
  ADODB,
  gclangutils,
  DateUtils,
  frmMain,
  udmMain,
  frameReport,
  Forms,
  frmTrial,
  uVirtualTime;

procedure TCustomReport.Save;
var
  str :String;
  strSQLCode : String;
begin
  strSQLCode := SQLCode;
  strSQLCode := AnsiReplaceText(strSQLCode,'''','''''');
  if Id = 'GUID' then
    str := DS_CUSTOMREPORTS_ADD + ' @name='''+ Name + ''', @description=''' +
      Description + ''', @sqlcode=''' +
      strSQLCode + ''', @tabindex=' + IntToStr(TabIndex) + ', @version=' + IntToStr(Version)
  else
    str := DS_CUSTOMREPORTS_UPDATE + ' @idReport='''+Id +
      ''', @name='''+ Name + ''', @description=''' + Description + ''', @sqlcode=''' +
      strSQLCode + ''', @tabindex=' + IntToStr(TabIndex) + ', @version=' + IntToStr(Version);
  dsDoCommand(str);
end;

procedure TCustomReport.SaveByImport;
var
  str :String;
  strSQLCode : String;
begin
  strSQLCode := SQLCode;
  strSQLCode := AnsiReplaceText(strSQLCode,'''','''''');
  str := DS_CUSTOMREPORTS_IMPORT + ' @id='''+Id +
    ''', @name='''+ Name + ''', @description=''' + Description + ''', @sqlcode=''' +
    strSQLCode + ''', @tabindex=' + IntToStr(TabIndex) + ', @version=' + IntToStr(Version);
  dsDoCommand(str);
end;

procedure TCustomReport.Delete;
begin
  if Id <> '' then
    dsDoCommand(DS_CUSTOMREPORTS_DELETE + ' @idReport=''' + Id + '''');
  Free;
end;

constructor TCustomReports.Create;
begin
   inherited Create(TCustomReport);
end;

destructor TCustomReports.Destroy;
begin
  if Self <> nil then begin
    Clear;
    inherited Destroy;
  end;
end;

function TCustomReports.Index(AstrName:string):integer;
var
   i : Integer;
begin
   Result := -1;
   for i := 0 to Count-1 do
      if Items[i].Name = AstrName then
         Result := i;
end;

function TCustomReports.IndexById(AstrId:string):integer;
var
   i : Integer;
begin
   Result := -1;
   for i := 0 to Count-1 do
      if Items[i].Id = AstrId then
         Result := i;
end;

procedure TCustomReports.Add(AstrId: String; AstrName:String; AstrDescription:String; AstrSQLCode:String; AnTabIndex: Integer; AnVersion: Integer);
var
   i : Integer;
   report : TCustomReport;
begin
   i := Index(AstrName);
   if i=-1 then begin
      report := TCustomReport(inherited Add);
      report.Id := AstrId;
      report.Name := AstrName;
      report.Description := AstrDescription;
      report.SQLCode := AstrSQLCode;
      report.TabIndex := AnTabIndex;
      report.Version := AnVersion;
   end;
end;

function TCustomReports.GetItem(Index: Integer): TCustomReport;
begin
  Result := TCustomReport(inherited Items[Index]);
end;

procedure TCustomReports.SetItem(Index: Integer; Value: TCustomReport);
begin
  Items[Index].Assign(Value);
end;

procedure TCustomReports.Load;
var
  dts: TADODataSet;
begin
  Clear;
  if Not IsMAnager then
    exit;
  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_CUSTOMREPORTS_SELECT, @dts);
    while (not dts.Recordset.EOF) do
    begin
      Add(dts.Recordset.Fields.Item['id'].Value,
        dts.Recordset.Fields.Item['name'].Value,
        dts.Recordset.Fields.Item['description'].Value,
        dts.Recordset.Fields.Item['sqlcode'].Value,
        dts.Recordset.Fields.Item['tabindex'].Value,
        dts.Recordset.Fields.Item['version'].Value);
        dts.Recordset.MoveNext;
    end;
    dts.Close;
    dts.Destroy;
    Console.AddEvent(EVENT_ICON_EMPTY, LEVEL_2, translate('dsLoadCustomReportsOk')+' ['+IntToStr(Count)+']');
  end;
end;

function TCustomReports.CheckSyntax(AstrSQLCode:String):Boolean;
var
  str: String;
begin
    str := AstrSQLCode;
    str := AnsiReplaceStr(str,',','.');
    str := AnsiReplaceStr(str,#9,'.');
    str := AnsiReplaceStr(str,' ','.');
    str := AnsiReplaceStr(str,']','.');
    str := AnsiReplaceStr(str,'[','.');
    str := AnsiReplaceStr(str,')','.');
    str := AnsiReplaceStr(str,'(','.');
    str := AnsiReplaceStr(str,#10,'.');
    str := AnsiReplaceStr(str,#13,'.');
    str := '.' + str + '.';
    str := AnsiReplaceStr(str,'..','.');
    str := AnsiReplaceStr(str,'..','.');
    str := AnsiReplaceStr(str,'..','.');
    str := AnsiReplaceText(str,'.INSERT.INTO.#','LEGALINSERT');
    if AnsiContainsText(str,'.INSERT.') or
      AnsiContainsText(str,'.DELETE.') or
      AnsiContainsText(str,'.UPDATE.') or
      AnsiContainsText(str,'.EXEC.') then
      Result := False
    else
      Result := True;
end;

function TCustomReports.CompileMacros(AstrSQLCode:String):String;
var
  str: String;
  dt,dt1,dt2,dt3: TDateTime;
begin
  str := AstrSQLCode;
{%CURRENTTIME% - текущий момент времени
%CURMONTH-BEGIN% - начало текущего месяца
%TODAY-BEGIN% - начало текущего дня
%SHIFT-BEGIN% - начало текущей смены
%SHIFT2-BEGIN% - начале предыдущей смены
%SHIFT2-END% - конец предыдущей смены
%YESTERDAY-BEGIN% - начало вчерашнего дня
%YESTERDAY-END% - конец вчерашнего дня
%TIME-START% - время установоленное вручную в блоке фильтра
%TIME-STOP% - время установоленное вручную в блоке фильтра
}
  dt := GetVirtualTime;
  str := AnsiReplaceText(str,'%CURRENTTIME%',QuotedStr(DateTimeToSql(dt)));
  dt := RecodeTime(dt,0,0,0,0);
  str := AnsiReplaceText(str,'%TODAY-BEGIN%',QuotedStr(DateTimeToSql(dt)));
  str := AnsiReplaceText(str,'%YESTERDAY-BEGIN%',QuotedStr(DateTimeToSql(IncDay(dt,-1))));
  str := AnsiReplaceText(str,'%CURMONTH-BEGIN%',QuotedStr(DateTimeToSql(RecodeDay(dt,1))));
  dt := RecodeTime(dt,23,59,59,99);
  str := AnsiReplaceText(str,'%YESTERDAY-END%',QuotedStr(DateTimeToSql(IncDay(dt,-1))));

  dt := formMain.frameReport.dtpBeginDate.DateTime;
  ReplaceTime(dt,formMain.frameReport.dtpBeginTime.DateTime);
  str := AnsiReplaceText(str,'%TIME-START%',QuotedStr(DateTimeToSql(dt)));
  dt := formMain.frameReport.dtpEndDate.DateTime;
  ReplaceTime(dt,formMain.frameReport.dtpEndTime.DateTime);
  str := AnsiReplaceText(str,'%TIME-STOP%',QuotedStr(DateTimeToSql(dt)));

  dsGet3LastOpReportPoints(@dt,@dt1,@dt2,@dt3);
  str := AnsiReplaceText(str,'%SHIFT-BEGIN%',QuotedStr(DateTimeToSql(dt)));
  str := AnsiReplaceText(str,'%SHIFT2-END%',QuotedStr(DateTimeToSql(dt)));
  str := AnsiReplaceText(str,'%SHIFT2-BEGIN%',QuotedStr(DateTimeToSql(dt1)));

  Result := str;
end;

procedure TCustomReports.RebuildTabIndex;
var
  i: Integer;
begin
  for i:=0 to Count-1 do
    with Items[i] do begin
      TabIndex := i;
      Save;
    end;
end;

procedure TCustomReport.Execute;
var
  i: Integer;
begin
  i:=0;
  if Not (StrLen(Registration.UserName) > i*3) and
    ((Registration.TrialDaysLeft=0) or (Registration.TrialExLeft=0)) then begin
    Application.CreateForm(TformTrial, formTrial);
    formTrial.memoInfo.Text := 'GameClass '+APP_VERSION+''#13#10#13#10+
      translate('TrialEnd')+''#13#10+translate('Unreg6');
    formTrial.pbLeft.Position := Round(((21-Registration.TrialDaysLeft)/21)*100);
    formTrial.ShowModal;
    formTrial.Destroy;
    exit;
  end;
  formMain.frameReport.pnlFilter.Visible := True;
  formMain.frameReport.pcReport.ActivePage := formMain.frameReport.tabGrid;
  formMain.frameReport.lblBeginTime.Enabled := True;
  formMain.frameReport.dtpBeginDate.Enabled := True;
  formMain.frameReport.dtpBeginTime.Enabled := True;
  formMain.frameReport.lblEndTime.Enabled := True;
  formMain.frameReport.dtpEndDate.Enabled := True;
  formMain.frameReport.dtpEndTime.Enabled := True;
  formMain.frameReport.cbAllRecords.Enabled := False;
  for i:=0 to formMain.frameReport.tbarReports.ButtonCount-1 do
    if formMain.frameReport.tbarReports.Buttons[i].Caption <> Name then
      formMain.frameReport.tbarReports.Buttons[i].Down := False
    else
      formMain.frameReport.tbarReports.Buttons[i].Down := True;
  formMain.frameReport.datasetReport.Active := False;
  formMain.frameReport.datasetReport.Fields.Clear;
  formMain.frameReport.datasetReport.Connection := dmMain.cnnMain;
  formMain.frameReport.datasetReport.CommandText := GCustomReports.CompileMacros(SQLCode);
  formMain.frameReport.datasetReport.Active := True;
  formMain.frameReport.gridReport.Columns.Clear;
  formMain.frameReport.gridReport.DataSource.DataSet.Last;
  for i:=0 to formMain.frameReport.gridReport.Columns.Count-1 do
    if formMain.frameReport.gridReport.Columns.Items[i].Width > 500 then
      formMain.frameReport.gridReport.Columns.Items[i].Width := 500;
  formMain.frameReport.gridReport.SetFocus;
end;

end.
