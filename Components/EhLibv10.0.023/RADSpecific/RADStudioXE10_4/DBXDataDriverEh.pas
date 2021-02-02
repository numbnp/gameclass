{*******************************************************}
{                                                       }
{                     EhLib 10.0                        }
{                                                       }
{             TDBXDataDriverEh component                }
{                                                       }
{     Copyright (c) 2003-2020 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit DBXDataDriverEh;

{$I EhLib.Inc}

interface

uses Windows, SysUtils, Classes, Controls, DB,
  Variants, SqlExpr, Contnrs,
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh;
type

  TDBXDataDriverEh = class;
  TDBXConnectionProviderEh = class;

{ TDBXCommandEh }

  TDBXCommandEh = class(TBaseSQLCommandEh)
  private
    function GetDataDriver: TDBXDataDriverEh;
  public
    function Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    property DataDriver: TDBXDataDriverEh read GetDataDriver;
  published
    property Params;
    property ParamCheck;
    property CommandText;
    property CommandType;
  end;

{ TDBXDataDriverEh }

  TDBXDataDriverEh = class(TBaseSQLDataDriverEh)
  private
    FConnectionProvider: TDBXConnectionProviderEh;
    FServerSpecOperations: TServerSpecOperationsEh;
    FSQLConnection: TSQLConnection;

    procedure SetConnection(const Value: TSQLConnection);
    procedure SetConnectionProvider(const Value: TDBXConnectionProviderEh);

  protected
    function CreateCommand: TCustomSQLCommandEh; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function InternalGetServerSpecOperations: TServerSpecOperationsEh; override;
    function CreateDesignCopy: TCustomSQLDataDriverEh; override;
    function GetConnectionProvider: IConnectionProviderEh; override;
    function HaveDataConnection(): Boolean; override;

    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure DoServerSpecOperations(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;

  published
    property ConnectionProvider: TDBXConnectionProviderEh read FConnectionProvider write SetConnectionProvider;
    property MacroVars;
    property SQLConnection: TSQLConnection read FSQLConnection write SetConnection;
    property SelectCommand;
    property SelectSQL;
    property UpdateCommand;
    property UpdateSQL;
    property InsertCommand;
    property InsertSQL;
    property DeleteCommand;
    property DeleteSQL;
    property GetrecCommand;
    property GetrecSQL;
    property DynaSQLParams;
    property ProviderDataSet;
    property KeyFields;
    property SpecParams;

    property OnExecuteCommand;
    property OnBuildDataStruct;
    property OnGetBackUpdatedValues;
    property OnProduceDataReader;
    property OnAssignFieldValue;
    property OnReadRecord;
    property OnRefreshRecord;
    property OnUpdateRecord;
    property OnAssignCommandParam;
    property OnUpdateError;
  end;

{ TDBXDesignConnectionEh }

  TDBXInlineConnectionEh = class(TSQLConnection)
  private
    FUseAtDesignTime: Boolean;
    FUseAtRunTime: Boolean;
    function GetConnectionProvider: TDBXConnectionProviderEh;
    function GetUseAtRunTime: Boolean;
    procedure SetUseAtRunTime(const Value: Boolean);

  protected
    procedure SetConnected(Value: Boolean); override;
    procedure BeforeInlineConnection(Sender: TObject);
    procedure AfterInlineConnection(Sender: TObject);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ConnectionProvider: TDBXConnectionProviderEh read GetConnectionProvider;

  published
    property UseAtDesignTime: Boolean read FUseAtDesignTime write FUseAtDesignTime default False;
    property UseAtRunTime: Boolean read GetUseAtRunTime write SetUseAtRunTime default False;
  end;


{ TDBXConnectionProviderEh }

  TDBXConnectionProviderEh = class(TConnectionProviderEh)
  private
    FSQLConnection: TSQLConnection;
    FDesignConnection: TDBXInlineConnectionEh;
    FInlineConnectionBeforeConnect: TNotifyEvent;
    FInlineConnectionAfterConnect: TNotifyEvent;
    procedure SetConnection(const Value: TSQLConnection);
    procedure SetDesignConnection(const Value: TDBXInlineConnectionEh);

  protected
    FDesignDataBase: TComponent;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    {DesignTime stuff}
    function GetDesignDataBase: TComponent; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function DefaultExecuteCommand(SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer; override;
    function UseAtDesignTime: Boolean;
    function CurrentTimeConnection: TSQLConnection;

  published
    property SQLConnection: TSQLConnection read FSQLConnection write SetConnection;
    property InlineConnection: TDBXInlineConnectionEh read FDesignConnection write SetDesignConnection;
    property ServerType;

    property OnExecuteCommand;
    property OnGetBackUpdatedValues;
    property OnGetServerSpecOperations;
    property OnUpdateRecord;

    property InlineConnectionBeforeConnect: TNotifyEvent read FInlineConnectionBeforeConnect write FInlineConnectionBeforeConnect;
    property InlineConnectionAfterConnect: TNotifyEvent read FInlineConnectionAfterConnect write FInlineConnectionAfterConnect;
  end;

function DefaultExecuteDBXCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ASQLConnection: TSQLConnection): Integer;

var
  DBXConnectionProviderDesignService: IConnectionProviderDesignServiceEh;

implementation

function DefaultExecuteDBXCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ASQLConnection: TSQLConnection): Integer;
var
  ACursor: TDataSet;
  q: TSQLQuery;
  t: TSQLTable;
  sp: TSQLStoredProc;
begin
  Result := -1;
  Cursor := nil;
  FreeOnEof := False;
  ACursor := nil;
  Processed := True;
  try
    case Command.CommandType of
      cthSelectQuery, cthUpdateQuery:
        begin
          q := TSQLQuery.Create(nil);
          ACursor := q;
          q.SQLConnection := ASQLConnection;
          q.SQL.Text := Command.FinalCommandText.Text;
          q.Params := TBaseSQLCommandEh(Command).Params;
          if Command.CommandType = cthSelectQuery then
            q.Open
          else
          begin
            q.ExecSQL;
            Result := q.RowsAffected;
          end;
          TBaseSQLCommandEh(Command).Params := q.Params;
        end;
      cthTable:
        begin
          t := TSQLTable.Create(nil);
          ACursor := t;
          t.SQLConnection := ASQLConnection;
          t.TableName := Command.FinalCommandText.Text;
          t.Open;
        end;
      cthStoredProc:
        begin
          sp := TSQLStoredProc.Create(nil);
          ACursor := sp;
          sp.SQLConnection := ASQLConnection;
          sp.StoredProcName := Command.FinalCommandText.Text;
          sp.Params := TBaseSQLCommandEh(Command).Params;
          sp.ExecProc;
          TBaseSQLCommandEh(Command).Params := sp.Params;
        end;
    end;
    if ACursor.Active then
    begin
      Cursor := ACursor;
      FreeOnEof := True;
      ACursor := nil;
    end
  finally
    if ACursor <> nil then
      ACursor.Free;
  end;
end;

{ TDBXCommandEh }

function TDBXCommandEh.Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  ACursor: TDataSet;
  Processed: Boolean;
  q: TSQLQuery;
  t: TSQLTable;
  sp: TSQLStoredProc;
begin
  if DataDriver.ConnectionProvider <> nil then
  begin
    Processed := False;
    Result := DataDriver.ConnectionProvider.ExecuteCommand(DataDriver, Self, Cursor, FreeOnEof, Processed);
    if Processed then
      Exit;
  end;
  Result := -1;
  Cursor := nil;
  FreeOnEof := False;
  ACursor := nil;
  try
    case CommandType of
      cthSelectQuery, cthUpdateQuery:
        begin
          q := TSQLQuery.Create(nil);
          ACursor := q;
          q.SQLConnection := DataDriver.SQLConnection;
          q.SQL.Text := Self.FinalCommandText.Text;
          q.Params := Self.Params;
          if CommandType = cthSelectQuery then
            q.Open
          else
          begin
            q.ExecSQL;
            Result := q.RowsAffected;
          end;
          Self.Params := q.Params;
        end;
      cthTable:
        begin
          t := TSQLTable.Create(nil);
          ACursor := t;
          t.SQLConnection := DataDriver.SQLConnection;
          t.TableName := Self.FinalCommandText.Text;
          t.Open;
        end;
      cthStoredProc:
        begin
          sp := TSQLStoredProc.Create(nil);
          ACursor := sp;
          sp.SQLConnection := DataDriver.SQLConnection;
          sp.StoredProcName := Self.FinalCommandText.Text;
          sp.Params := Self.Params;
          sp.ExecProc;
          Self.Params := sp.Params;
        end;
    end;
    if ACursor.Active then
    begin
      Cursor := ACursor;
      FreeOnEof := True;
      ACursor := nil;
    end
  finally
    if ACursor <> nil then
      ACursor.Free;
  end;
end;

function TDBXCommandEh.GetDataDriver: TDBXDataDriverEh;
begin
  Result := TDBXDataDriverEh(inherited DataDriver);
end;

{ TDBXDataDriverEh }

var
  DataBaseInc: Integer = 0;

function GetUnicalDataBaseName: String;
begin
  Inc(DataBaseInc);
  Result := 'DBXDataDriverEhDataBaseName' + IntToStr(DataBaseInc);
end;

constructor TDBXDataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TDBXDataDriverEh.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FServerSpecOperations);
end;

function TDBXDataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
begin
  Result := TDBXDataDriverEh.Create(nil);
  TDBXDataDriverEh(Result).ConnectionProvider := ConnectionProvider;
  Result.SelectCommand := SelectCommand;
  Result.UpdateCommand := UpdateCommand;
  Result.InsertCommand := InsertCommand;
  Result.DeleteCommand := DeleteCommand;
  Result.GetrecCommand := GetrecCommand;
  TDBXDataDriverEh(Result).SpecParams := SpecParams;
  Result.DynaSQLParams := DynaSQLParams;
  Result.MacroVars := MacroVars;
end;

type
  TDBDescription = record
    szName          : String;          { Logical name (Or alias) }
    szText          : String;          { Descriptive text }
    szPhyName       : String;          { Physical name/path }
    szDbType        : String;          { Database type }
  end;

function TDBXDataDriverEh.CreateCommand: TCustomSQLCommandEh;
begin
  Result := TDBXCommandEh.Create(Self);
end;

procedure TDBXDataDriverEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  inherited GetBackUpdatedValues(MemRec, Command, ResDataSet);
  DoServerSpecOperations(MemRec, Command, ResDataSet);
end;

procedure TDBXDataDriverEh.DoServerSpecOperations(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
end;

procedure TDBXDataDriverEh.SetConnection(const Value: TSQLConnection);
begin
  if FSQLConnection <> Value then
  begin
    FSQLConnection := Value;
    if FSQLConnection <> nil then
    begin
      FSQLConnection.FreeNotification(Self);
      ConnectionProvider := nil;
    end;
  end;
end;

procedure TDBXDataDriverEh.SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh);
var
  AutoIncFieldName: String;
  AutoIncField: TMTDataFieldEh;
begin
  AutoIncFieldName := SpecParams.Values['AUTO_INCREMENT_FIELD'];
  AutoIncField := nil;
  if AutoIncFieldName <> '' then
    AutoIncField := DataStruct.FindField(AutoIncFieldName);
  if (AutoIncField <> nil) and (AutoIncField is TMTNumericDataFieldEh) then
    TMTNumericDataFieldEh(AutoIncField).AutoIncrement := True;
end;

procedure TDBXDataDriverEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent <> nil) then
  begin
    if FSQLConnection = AComponent then
      FSQLConnection := nil;
    if AComponent = ConnectionProvider then
      ConnectionProvider := nil;
  end;
end;

function TDBXDataDriverEh.HaveDataConnection: Boolean;
begin
  if Assigned(SQLConnection) and SQLConnection.Connected then
    Result := True
  else if  ConnectionProvider <> nil then
    Result := True
  else
    Result := inherited HaveDataConnection();
end;

type
  TServerSpecOperationsEhClass = class of TServerSpecOperationsEh;

function TDBXDataDriverEh.InternalGetServerSpecOperations: TServerSpecOperationsEh;
var
  ServerOpClass: TServerSpecOperationsEhClass;
  DbType: String;
begin
  ServerOpClass := nil;
  Result := FServerSpecOperations;
  if SQLConnection <> nil then
    DbType := UpperCase(SQLConnection.DriverName);
  if DbType = 'INFORMIX' then
    ServerOpClass := TInfromixSpecOperationsEh
  else if DbType = 'DB2' then
    ServerOpClass := TDB2SpecOperationsEh
  else if DbType = 'INTRBASE' then
    ServerOpClass := TInterbaseSpecOperationsEh
  else if DbType = 'ORACLE' then
    ServerOpClass := TOracleSpecOperationsEh
  else if DbType = 'SYBASE' then
    ServerOpClass := TSybaseSpecOperationsEh;

  if (Result = nil) or (ServerOpClass <> Result.ClassType) then
  begin
    FreeAndNil(Result);
    if ServerOpClass <> nil then
      Result := ServerOpClass.Create;
    FServerSpecOperations := Result;
  end;
end;

function TDBXDataDriverEh.GetConnectionProvider: IConnectionProviderEh;
begin
  Supports(FConnectionProvider, IConnectionProviderEh, Result);
end;

procedure TDBXDataDriverEh.SetConnectionProvider(const Value: TDBXConnectionProviderEh);
begin
  if FConnectionProvider <> Value then
  begin
    FConnectionProvider := Value;
    if FConnectionProvider <> nil then
    begin
      FConnectionProvider.FreeNotification(Self);
      SQLConnection := nil;
    end;
  end;
end;

{ TDBXConnectionProviderEh }

constructor TDBXConnectionProviderEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDesignConnection := TDBXInlineConnectionEh.Create(Self);
  if DBXConnectionProviderDesignService <> nil then
    FDesignDataBase := DBXConnectionProviderDesignService.CreateDesignDataBase(Self);
end;

destructor TDBXConnectionProviderEh.Destroy;
begin
  FreeAndNil(FDesignConnection);
  FreeAndNil(FDesignDataBase);
  inherited Destroy;
end;

function TDBXConnectionProviderEh.DefaultExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof, Processed: Boolean): Integer;
begin
  Result := inherited DefaultExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed);

  if not Processed then
  begin
    if CurrentTimeConnection <> nil then
    begin
      Result := DefaultExecuteDBXCommandEh(SQLDataDriver, Command,
        Cursor, FreeOnEof, Processed, CurrentTimeConnection);
    end;
  end;
end;

function TDBXConnectionProviderEh.GetDesignDataBase: TComponent;
begin
  Result := FDesignDataBase;
end;

procedure TDBXConnectionProviderEh.Loaded;
begin
  inherited Loaded;
  InlineConnection.Loaded;  
end;

procedure TDBXConnectionProviderEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (SQLConnection = AComponent)
  then
    SQLConnection := nil;
end;

procedure TDBXConnectionProviderEh.SetConnection(const Value: TSQLConnection);
begin
  FSQLConnection := Value;
end;

procedure TDBXConnectionProviderEh.SetDesignConnection(const Value: TDBXInlineConnectionEh);
begin
  FDesignConnection.Assign(Value);
end;

function TDBXConnectionProviderEh.UseAtDesignTime: Boolean;
begin
  if {$IFDEF DESIGNTIME} (csDesigning in ComponentState) and {$ENDIF}
    InlineConnection.UseAtDesignTime
    then Result := True
    else Result := False;
end;

function TDBXConnectionProviderEh.CurrentTimeConnection: TSQLConnection;
begin
  if {$IFDEF DESIGNTIME} (csDesigning in ComponentState) and {$ENDIF} InlineConnection.UseAtDesignTime then
    Result := InlineConnection
  else if not (csDesigning in ComponentState) and InlineConnection.UseAtRunTime then
    Result := InlineConnection
  else
    Result := SQLConnection;
end;

{ TDBXInlineConnectionEh }

constructor TDBXInlineConnectionEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FComponentStyle := FComponentStyle + [csSubComponent];
  Name := 'DesignConection';

  BeforeConnect := BeforeInlineConnection;
  AfterConnect := AfterInlineConnection;
end;

destructor TDBXInlineConnectionEh.Destroy;
begin
  inherited Destroy;
end;

function TDBXInlineConnectionEh.GetConnectionProvider: TDBXConnectionProviderEh;
begin
  Result := TDBXConnectionProviderEh(Owner);
end;

procedure TDBXInlineConnectionEh.SetConnected(Value: Boolean);
begin
{$IFDEF DESIGNTIME} if (csDesigning in ComponentState) then
{$ELSE} if True then
{$ENDIF}
  begin
    inherited SetConnected(Value)
  end else if UseAtRunTime and not (csDesigning in ComponentState) then
    inherited SetConnected(Value);
end;

procedure TDBXInlineConnectionEh.SetUseAtRunTime(const Value: Boolean);
begin
  FUseAtRunTime := Value;
end;

function TDBXInlineConnectionEh.GetUseAtRunTime: Boolean;
begin
  Result := FUseAtRunTime;
end;

procedure TDBXInlineConnectionEh.BeforeInlineConnection(Sender: TObject);
begin
  if Assigned(ConnectionProvider.FInlineConnectionBeforeConnect) then
    ConnectionProvider.FInlineConnectionBeforeConnect(Self);
end;

procedure TDBXInlineConnectionEh.AfterInlineConnection(Sender: TObject);
begin
  if Assigned(ConnectionProvider.FInlineConnectionAfterConnect) then
    ConnectionProvider.FInlineConnectionAfterConnect(Self);
end;

end.
