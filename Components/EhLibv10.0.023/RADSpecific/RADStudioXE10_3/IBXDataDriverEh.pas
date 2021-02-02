{*******************************************************}
{                                                       }
{                     EhLib 10.0                        }
{                                                       }
{              TIBXDataDriverEh component               }
{                                                       }
{     Copyright (c) 2003-2020 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit IBXDataDriverEh;

{$I EHLIB.INC}

interface

uses Windows, SysUtils, Classes, Controls, DB,
  Variants, Contnrs,
{$IFDEF EH_LIB_20}
  IBX.IBCustomDataSet, IBX.IBDatabase, IBX.IBQuery, IBX.IBTable, IBX.IBStoredProc,
{$ELSE}
  IBCustomDataSet, IBDatabase, IBQuery, IBTable, IBStoredProc,
{$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh;

type

  TIBXDataDriverEh = class;
  TIBXConnectionProviderEh = class;

{ TIBXCommandEh }

  TIBXCommandEh = class(TBaseSQLCommandEh)
  private
    function GetDataDriver: TIBXDataDriverEh;
  public
    function Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    property DataDriver: TIBXDataDriverEh read GetDataDriver;
  published
    property Params;
    property ParamCheck;
    property CommandText;
    property CommandType;
  end;

{ TIBXDataDriverEh }

  TIBXDataDriverEh = class(TBaseSQLDataDriverEh)
  private
    FConnectionProvider: TIBXConnectionProviderEh;
    FDatabase: TIBDatabase;
    FIbsSpecOperations: TInterbaseSpecOperationsEh;
    procedure SetConnectionProvider(const Value: TIBXConnectionProviderEh);
    procedure SetDatabase(const Value: TIBDatabase);

  protected
    function CreateCommand: TCustomSQLCommandEh; override;
    procedure SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function CreateDesignCopy: TCustomSQLDataDriverEh; override;
    function GetConnectionProvider: IConnectionProviderEh; override;
    function HaveDataConnection(): Boolean; override;
    function InternalGetServerSpecOperations: TServerSpecOperationsEh; override;

    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure DoServerSpecOperations(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;

  published
    property ConnectionProvider: TIBXConnectionProviderEh read FConnectionProvider write SetConnectionProvider;
    property Database: TIBDatabase read FDatabase write SetDatabase;
    property MacroVars;
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

{ TIBXInlineConnectionEh }

  TIBXInlineConnectionEh = class(TCustomInlineConnectionEh)
  private
    FConnectionProvider: TIBXConnectionProviderEh;
    FDatabase: TIBDatabase;
    FDefTransaction: TIBTransaction;
    FUseAtRunTime: Boolean;

    function GetDatabaseName: TIBFileName;
    function GetDBParams: TStrings;
    function GetSQLDialect: Integer;
    function GetUseAtRunTime: Boolean;

    procedure SetDatabaseName(const Value: TIBFileName);
    procedure SetDBParams(const Value: TStrings);
    procedure SetSQLDialect(const Value: Integer);
    procedure SetUseAtRunTime(const Value: Boolean);

  protected
    function GetConnected: Boolean; override;
    procedure SetDesignConnected(const Value: Boolean); override;
    procedure BeforeInlineConnection(Sender: TObject);
    procedure AfterInlineConnection(Sender: TObject);

  public
    constructor Create(AConnectionProvider: TIBXConnectionProviderEh);
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    property ConnectionProvider: TIBXConnectionProviderEh read FConnectionProvider;
    property DataBase: TIBDatabase read FDataBase;

  published
    property Connected;

    property DatabaseName: TIBFileName read GetDatabaseName write SetDatabaseName;
    property Params: TStrings read GetDBParams write SetDBParams;
    property SQLDialect: Integer read GetSQLDialect write SetSQLDialect default 3;

    property UseAtDesignTime;
    property UseAtRunTime: Boolean read GetUseAtRunTime write SetUseAtRunTime default False;

  end;

{ TIBXConnectionProviderEh }

  TIBXConnectionProviderEh = class(TConnectionProviderEh)
  private
    FDatabase: TIBDatabase;
    FInlineConnection: TIBXInlineConnectionEh;
    FInlineConnectionBeforeConnect: TNotifyEvent;
    FInlineConnectionAfterConnect: TNotifyEvent;
    procedure SetDatabase(const Value: TIBDatabase);
    procedure SetInlineConnection(const Value: TIBXInlineConnectionEh);

  protected
    FDesignDataBase: TComponent;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetServerType: String; override;
    procedure SetServerType(const Value: String); override;

  public
    {DesignTime stuff}
    function GetDesignDataBase: TComponent; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function DefaultExecuteCommand(SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer; override;
    function UseDesignDatabase: Boolean;
    function CurrentTimeDatabase: TIBDatabase;

  published
    property Database: TIBDatabase read FDatabase write SetDatabase;
    property InlineConnection: TIBXInlineConnectionEh read FInlineConnection write SetInlineConnection;
    property ServerType read GetServerType write SetServerType stored False;

    property OnExecuteCommand;
    property OnGetBackUpdatedValues;
    property OnGetServerSpecOperations;
    property OnUpdateRecord;

    property InlineConnectionBeforeConnect: TNotifyEvent read FInlineConnectionBeforeConnect write FInlineConnectionBeforeConnect;
    property InlineConnectionAfterConnect: TNotifyEvent read FInlineConnectionAfterConnect write FInlineConnectionAfterConnect;
  end;

function DefaultExecuteIBXCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ADatabase: TIBDatabase): Integer;

procedure DefaultUpdateIBXRecordEh(SQLDataDriver: TCustomSQLDataDriverEh;
  MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
  var Processed: Boolean; ADatabase: TIBDatabase);

var
  IBXConnectionProviderDesignService: IConnectionProviderDesignServiceEh;

implementation

function DefaultExecuteIBXCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ADatabase: TIBDatabase): Integer;
var
  ACursor: TDataSet;
  q: TIBQuery;
  t: TIBTable;
  sp: TIBStoredProc;
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
          q := TIBQuery.Create(nil);
          q.Database := ADatabase;
          q.SQL := Command.FinalCommandText;
          q.Params := TBaseSQLCommandEh(Command).Params;
          if Command.CommandType = cthSelectQuery then
            q.Open
          else
          begin
            q.ExecSQL;
            Result := q.RowsAffected;
          end;
          TBaseSQLCommandEh(Command).Params := q.Params;
          ACursor := q;
        end;
      cthTable:
        begin
          t := TIBTable.Create(nil);
          t.Database := ADatabase;
          t.TableName := Command.FinalCommandText.Text;
          t.Open;
          ACursor := t;
        end;
      cthStoredProc:
        begin
          sp := TIBStoredProc.Create(nil);
          sp.Database := ADatabase;
          sp.StoredProcName := Command.FinalCommandText.Text;
          sp.Params := TBaseSQLCommandEh(Command).Params;
          sp.ExecProc;
          TBaseSQLCommandEh(Command).Params := sp.Params;
          ACursor := sp;
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

procedure DefaultUpdateIBXRecordEh(SQLDataDriver: TCustomSQLDataDriverEh;
  MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
  var Processed: Boolean; ADatabase: TIBDatabase);
begin
end;

{ TIBXCommandEh }

function TIBXCommandEh.Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  ACursor: TDataSet;
  Processed: Boolean;
  q: TIBQuery;
  t: TIBTable;
  sp: TIBStoredProc;
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
          q := TIBQuery.Create(nil);
          q.Database := DataDriver.Database;
          q.SQL := Self.FinalCommandText;
          q.Params := Self.Params;
          if CommandType = cthSelectQuery then
            q.Open
          else
          begin
            q.ExecSQL;
            Result := q.RowsAffected;
          end;
          Self.Params := q.Params;
          ACursor := q;
        end;
      cthTable:
        begin
          t := TIBTable.Create(nil);
          t.Database := DataDriver.Database;
          t.TableName := Self.FinalCommandText.Text;
          t.Open;
          ACursor := t;
        end;
      cthStoredProc:
        begin
          sp := TIBStoredProc.Create(nil);
          sp.Database := DataDriver.Database;
          sp.StoredProcName := Self.FinalCommandText.Text;
          sp.Params := Self.Params;
          sp.ExecProc;
          Self.Params := sp.Params;
          ACursor := sp;
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

function TIBXCommandEh.GetDataDriver: TIBXDataDriverEh;
begin
  Result := TIBXDataDriverEh(inherited DataDriver);
end;

{ TIBXDataDriverEh }

constructor TIBXDataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FIbsSpecOperations := TInterbaseSpecOperationsEh.Create;
end;

destructor TIBXDataDriverEh.Destroy;
begin
  FreeAndNil(FIbsSpecOperations);
  inherited Destroy;
end;

function TIBXDataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
begin
  Result := TIBXDataDriverEh.Create(nil);
  TIBXDataDriverEh(Result).ConnectionProvider := ConnectionProvider;
  Result.SelectCommand := SelectCommand;
  Result.UpdateCommand := UpdateCommand;
  Result.InsertCommand := InsertCommand;
  Result.DeleteCommand := DeleteCommand;
  Result.GetrecCommand := GetrecCommand;
  TIBXDataDriverEh(Result).SpecParams := SpecParams;
  Result.DynaSQLParams := DynaSQLParams;
  Result.MacroVars := MacroVars;
end;

function TIBXDataDriverEh.CreateCommand: TCustomSQLCommandEh;
begin
  Result := TIBXCommandEh.Create(Self);
end;

procedure TIBXDataDriverEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  inherited GetBackUpdatedValues(MemRec, Command, ResDataSet);
  DoServerSpecOperations(MemRec, Command, ResDataSet);
end;

procedure TIBXDataDriverEh.DoServerSpecOperations(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  if (Database = nil) then
    Exit;
end;

procedure TIBXDataDriverEh.SetDatabase(const Value: TIBDatabase);
begin
  if FDatabase <> Value then
  begin
    FDatabase := Value;
    if FDatabase <> nil then
    begin
      FDatabase.FreeNotification(Self);
      ConnectionProvider := nil;
    end;
  end;
end;

procedure TIBXDataDriverEh.SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh);
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

function TIBXDataDriverEh.GetConnectionProvider: IConnectionProviderEh;
begin
  Supports(FConnectionProvider, IConnectionProviderEh, Result);
end;

procedure TIBXDataDriverEh.SetConnectionProvider(const Value: TIBXConnectionProviderEh);
begin
  if FConnectionProvider <> Value then
  begin
    FConnectionProvider := Value;
    if FConnectionProvider <> nil then
    begin
      FConnectionProvider.FreeNotification(Self);
      Database := nil;
    end;
  end;
end;

function TIBXDataDriverEh.HaveDataConnection: Boolean;
begin
  if Assigned(Database) and Database.Connected then
    Result := True
  else if  ConnectionProvider <> nil then
    Result := True
  else
    Result := inherited HaveDataConnection();
end;

procedure TIBXDataDriverEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent <> nil) then
  begin
    if FDatabase = AComponent then
      FDatabase := nil;
    if AComponent = ConnectionProvider then
      ConnectionProvider := nil;
  end;
end;

function TIBXDataDriverEh.InternalGetServerSpecOperations: TServerSpecOperationsEh;
begin
  Result := FIbsSpecOperations;
end;

{ TIBXConnectionProviderEh }

constructor TIBXConnectionProviderEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInlineConnection := TIBXInlineConnectionEh.Create(Self);
  if IBXConnectionProviderDesignService <> nil then
    FDesignDataBase := IBXConnectionProviderDesignService.CreateDesignDataBase(Self);
  inherited ServerType := 'Interbase';
end;

destructor TIBXConnectionProviderEh.Destroy;
begin
  FreeAndNil(FInlineConnection);
  FreeAndNil(FDesignDataBase);
  inherited Destroy;
end;

function TIBXConnectionProviderEh.DefaultExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof, Processed: Boolean): Integer;
begin
  Result := inherited DefaultExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed);

  if not Processed then
  begin
    if CurrentTimeDatabase <> nil then
    begin
      Result := DefaultExecuteIBXCommandEh(SQLDataDriver, Command,
        Cursor, FreeOnEof, Processed, CurrentTimeDatabase);
    end;
  end;
end;

function TIBXConnectionProviderEh.GetDesignDataBase: TComponent;
begin
  Result := FDesignDataBase;
end;

procedure TIBXConnectionProviderEh.Loaded;
begin
  inherited Loaded;
end;

procedure TIBXConnectionProviderEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (Database = AComponent)
  then
    Database := nil;
end;

procedure TIBXConnectionProviderEh.SetDatabase(const Value: TIBDatabase);
begin
  FDatabase := Value;
end;

procedure TIBXConnectionProviderEh.SetInlineConnection(const Value: TIBXInlineConnectionEh);
begin
  FInlineConnection.Assign(Value);
end;

function TIBXConnectionProviderEh.UseDesignDatabase: Boolean;
begin
  if {$IFDEF DESIGNTIME} (csDesigning in ComponentState) and {$ENDIF}
    InlineConnection.UseAtDesignTime
    then Result := True
    else Result := False;
end;

function TIBXConnectionProviderEh.CurrentTimeDatabase: TIBDatabase;
begin
  if {$IFDEF DESIGNTIME} (csDesigning in ComponentState) and {$ENDIF} InlineConnection.UseAtDesignTime then
    Result := InlineConnection.Database
  else if not (csDesigning in ComponentState) and InlineConnection.UseAtRunTime then
    Result := InlineConnection.Database
  else
    Result := Database;
end;

function TIBXConnectionProviderEh.GetServerType: String;
begin
  Result := 'Interbase';
end;

procedure TIBXConnectionProviderEh.SetServerType(const Value: String);
begin
end;

{ TIBXInlineConnectionEh }

constructor TIBXInlineConnectionEh.Create(AConnectionProvider: TIBXConnectionProviderEh);
begin
  inherited Create(AConnectionProvider);
  FConnectionProvider := AConnectionProvider;

  FDatabase := TIBDatabase.Create(FConnectionProvider);
  FDatabase.LoginPrompt := False;
  FDatabase.BeforeConnect := BeforeInlineConnection;

  FDefTransaction := TIBTransaction.Create(FConnectionProvider);
  FDatabase.DefaultTransaction := FDefTransaction;
  FDatabase.BeforeConnect := BeforeInlineConnection;
  FDatabase.AfterConnect := AfterInlineConnection;
end;

destructor TIBXInlineConnectionEh.Destroy;
begin
  FreeAndNil(FDatabase);
  FreeAndNil(FDefTransaction);
  inherited Destroy;
end;

procedure TIBXInlineConnectionEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

procedure TIBXInlineConnectionEh.BeforeInlineConnection(Sender: TObject);
begin
  if Assigned(ConnectionProvider.FInlineConnectionBeforeConnect) then
    ConnectionProvider.FInlineConnectionBeforeConnect(Self);
end;

procedure TIBXInlineConnectionEh.AfterInlineConnection(Sender: TObject);
begin
  if Assigned(ConnectionProvider.FInlineConnectionAfterConnect) then
    ConnectionProvider.FInlineConnectionAfterConnect(Self);
end;

function TIBXInlineConnectionEh.GetConnected: Boolean;
begin
  Result := FDatabase.Connected;
end;

function TIBXInlineConnectionEh.GetDatabaseName: TIBFileName;
begin
  Result := FDatabase.DatabaseName;
end;

function TIBXInlineConnectionEh.GetDBParams: TStrings;
begin
  Result := FDatabase.Params;
end;

function TIBXInlineConnectionEh.GetSQLDialect: Integer;
begin
  Result := FDatabase.SQLDialect;
end;

procedure TIBXInlineConnectionEh.SetDatabaseName(const Value: TIBFileName);
begin
  FDatabase.DatabaseName := Value;
end;

procedure TIBXInlineConnectionEh.SetDBParams(const Value: TStrings);
begin
  FDatabase.Params := Value;
end;

procedure TIBXInlineConnectionEh.SetDesignConnected(const Value: Boolean);
begin
  FDatabase.Connected := Value;
end;

procedure TIBXInlineConnectionEh.SetSQLDialect(const Value: Integer);
begin
  FDatabase.SQLDialect := Value;
end;

function TIBXInlineConnectionEh.GetUseAtRunTime: Boolean;
begin
  Result := FUseAtRunTime;
end;

procedure TIBXInlineConnectionEh.SetUseAtRunTime(const Value: Boolean);
begin
  FUseAtRunTime := Value;
end;

end.
