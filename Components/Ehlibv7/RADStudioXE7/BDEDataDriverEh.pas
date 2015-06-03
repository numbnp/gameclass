{*******************************************************}
{                                                       }
{                     EhLib v7.0                        }
{                                                       }
{          TBDEDataDriverEh component (Build 7.0.01)    }
{                                                       }
{      Copyright (c) 2003-12 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

unit BDEDataDriverEh {$IFDEF CIL} platform{$ENDIF};

{$I EHLIB.INC}

interface

{ TODO :
  if (ResDataSet is TDBDataSet) and (TDBDataSet(ResDataSet).Database <> nil) then
    Check(DbiGetProp(hDBIObj(TDBDataSet(ResDataSet).Database.Handle), drvNATIVESQLCA, @sqlca, SizeOf(tsqlca), res));
does't work }

uses Windows, SysUtils, Classes, Controls, DB,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh, DBTables;
type

  TBDEDataDriverEh = class;
  TBDEConnectionProviderEh = class;

{ TBDECommandEh }

  TBDECommandEh = class(TBaseSQLCommandEh)
  private
    function GetDataDriver: TBDEDataDriverEh;
  public
    function Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    property DataDriver: TBDEDataDriverEh read GetDataDriver;
  published
    property Params;
    property ParamCheck;
    property CommandText;
    property CommandType;
  end;

{ TBDEDataDriverEh }

  TBDEDataDriverEh = class(TBaseSQLDataDriverEh)
  private
    FConnectionProvider: TBDEConnectionProviderEh;
    FDatabaseName: string;
    FServerSpecOperations: TServerSpecOperationsEh;
    FSessionName: string;
    function GetDBSession: TSession;
    procedure SetConnectionProvider(const Value: TBDEConnectionProviderEh);
    procedure SetDatabaseName(const Value: string);
    procedure SetSessionName(const Value: string);
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
//    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure DefaultGetUpdatedServerValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure DoServerSpecOperations(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;
    property DBSession: TSession read GetDBSession;
    property SessionName: string read FSessionName write SetSessionName;
  published
    property ConnectionProvider: TBDEConnectionProviderEh read FConnectionProvider write SetConnectionProvider;
    property DatabaseName: string read FDatabaseName write SetDatabaseName;
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

{ TBDEInlineConnectionEh }

  TBDEInlineConnectionEh = class(TCustomInlineConnectionEh)
  private
    FConnectionProvider: TBDEConnectionProviderEh;
    FDatabase: TDatabase;
    FUseAtRunTime: Boolean;
    function GetAliasName: string;
    function GetDriverName: string;
    function GetParams: TStrings;
    function GetReadOnly: Boolean;
    procedure SetAliasName(const Value: string);
    procedure SetDatabaseName(const Value: string);
    procedure SetDriverName(const Value: string);
    procedure SetParams(const Value: TStrings);
    procedure SetReadOnly(const Value: Boolean);
    function GetDatabaseName: string;
    function GetUseAtRunTime: Boolean;
    procedure SetUseAtRunTime(const Value: Boolean);
  protected
    function GetConnected: Boolean; override;
    procedure BeforeInlineConnection(Sender: TObject);
    procedure AfterInlineConnection(Sender: TObject);
    procedure SetDesignConnected(const Value: Boolean); override;
  public
    constructor Create(AConnectionProvider: TBDEConnectionProviderEh);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property ConnectionProvider: TBDEConnectionProviderEh read FConnectionProvider;
    property DataBase: TDataBase read FDataBase;
  published
    property Connected;

    property AliasName: string read GetAliasName write SetAliasName;
    property DatabaseName: string read GetDatabaseName write SetDatabaseName;
    property DriverName: string read GetDriverName write SetDriverName;
    property Params: TStrings read GetParams write SetParams;
    property ReadOnly: Boolean read GetReadOnly write SetReadOnly default False;

    property UseAtDesignTime;
    property UseAtRunTime: Boolean read GetUseAtRunTime write SetUseAtRunTime default False;

  end;

{ TBDEConnectionProviderEh }

  TBDEConnectionProviderEh = class(TConnectionProviderEh)
  private
    FDatabase: TDatabase;
    FInlineConnection: TBDEInlineConnectionEh;
    FServerType: String;
    FInlineConnectionBeforeConnect: TNotifyEvent;
    FInlineConnectionAfterConnect: TNotifyEvent;
    procedure SetDatabase(const Value: TDatabase);
    procedure SetInlineConnection(const Value: TBDEInlineConnectionEh);
  protected
    FDesignDataBase: TComponent;
    FDynaServerSpecOperations: TServerSpecOperationsEh;
    function GetServerType: String; override;
    function IsServerTypeStored: Boolean;
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetServerType(const Value: String); override;
  public
    {DesignTime stuff}
    function GetDesignDataBase: TComponent; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetServerTypeNameByDatabaseType: String;
    function DefaultExecuteCommand(SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer; override;
    function GetServerSpecOperations: TServerSpecOperationsEh; override;
    function GetDynaServerSpecOperations: TServerSpecOperationsEh;
    function UseDesignDatabase: Boolean;
    function CurrentTimeDatabase: TDatabase;
//    property DBSession: TSession read GetDBSession;
//    property SessionName: string read FSessionName write SetSessionName;
  published
//    property DatabaseName: string read FDatabaseName write SetDatabaseName;
    property Database: TDatabase read FDatabase write SetDatabase;
    property InlineConnection: TBDEInlineConnectionEh read FInlineConnection write SetInlineConnection;
    property ServerType stored IsServerTypeStored;

    property OnExecuteCommand;
    property OnGetBackUpdatedValues;
    property OnGetServerSpecOperations;
    property OnUpdateRecord;

    property InlineConnectionBeforeConnect: TNotifyEvent read FInlineConnectionBeforeConnect write FInlineConnectionBeforeConnect;
    property InlineConnectionAfterConnect: TNotifyEvent read FInlineConnectionAfterConnect write FInlineConnectionAfterConnect;
  end;

function DefaultExecuteBDECommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ADatabaseName: String): Integer;

var
  BDEConnectionProviderDesignService: IConnectionProviderDesignServiceEh;

implementation

uses
{$IFDEF CIL}
  System.Text,
{$ENDIF}
  BDE, Forms;

function DefaultExecuteBDECommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean; ADatabaseName: String): Integer;
var
  ACursor: TDataSet;
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
          ACursor := TQuery.Create(nil);
          with ACursor as TQuery do
          begin
            DatabaseName := ADatabaseName;
            SQL := Command.FinalCommandText;
            Params := TBaseSQLCommandEh(Command).Params;
            if Command.CommandType = cthSelectQuery then
              Open
            else
            begin
              ExecSQL;
              Result := RowsAffected;
            end;
            TBaseSQLCommandEh(Command).Params := Params;
          end;
        end;
      cthTable:
        begin
          ACursor := TTable.Create(nil);
          with ACursor as TTable do
          begin
            DatabaseName := ADatabaseName;
            TableName := Command.FinalCommandText.Text;
//            Parameters.Assign(TBaseSQLCommandEh(Command).Params);
            Open;
//            TBaseSQLCommandEh(Command).Params.Assign(Parameters);
          end;
        end;
      cthStoredProc:
        begin
          ACursor := TStoredProc.Create(nil);
          with ACursor as TStoredProc do
          begin
            DatabaseName := ADatabaseName;
            StoredProcName := Command.FinalCommandText.Text;
            Params := TBaseSQLCommandEh(Command).Params;
            ExecProc;
//??            Result := RowsAffected;
            TBaseSQLCommandEh(Command).Params := Params;
          end;
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

{ TBDECommandEh }

function TBDECommandEh.Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  ACursor: TDataSet;
  Processed: Boolean;
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
          ACursor := TQuery.Create(nil);
          with ACursor as TQuery do
          begin
            DataBaseName := DataDriver.DatabaseName;
            SQL := Self.FinalCommandText;
            Params := Self.Params;
            if CommandType = cthSelectQuery then
              Open
            else
            begin
              ExecSQL;
              Result := RowsAffected;
            end;
            Self.Params := Params;
          end;
        end;
      cthTable:
        begin
          ACursor := TTable.Create(nil);
          with ACursor as TTable do
          begin
            DataBaseName := DataDriver.DatabaseName;
            TableName := Self.FinalCommandText.Text;
            Params := Self.Params;
            Open;
            Self.Params := Params;
          end;
        end;
      cthStoredProc:
        begin
          ACursor := TStoredProc.Create(nil);
          with ACursor as TStoredProc do
          begin
            DataBaseName := DataDriver.DatabaseName;
            StoredProcName := Self.FinalCommandText.Text;
            Params := Self.Params;
            ExecProc;
//??            Result := RowsAffected;
            Self.Params := Params;
          end;
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

function TBDECommandEh.GetDataDriver: TBDEDataDriverEh;
begin
  Result := TBDEDataDriverEh(inherited DataDriver);
end;

{ TBDEDataDriverEh }

(*
var
  DataBaseInc: Integer = 0;

function GetUnicalDataBaseName: String;
begin
  Inc(DataBaseInc);
  Result := 'BDEDataDriverEhDataBaseName' + IntToStr(DataBaseInc);
end;
*)

constructor TBDEDataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TBDEDataDriverEh.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FServerSpecOperations);
end;

function TBDEDataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
begin
  Result := TBDEDataDriverEh.Create(nil);
  TBDEDataDriverEh(Result).ConnectionProvider := ConnectionProvider;
  Result.SelectCommand := SelectCommand;
  Result.UpdateCommand := UpdateCommand;
  Result.InsertCommand := InsertCommand;
  Result.DeleteCommand := DeleteCommand;
  Result.GetrecCommand := GetrecCommand;
  TBDEDataDriverEh(Result).SpecParams := SpecParams;
  Result.DynaSQLParams := DynaSQLParams;
  Result.MacroVars := MacroVars;

//  TBDEDataDriverEh(Result).DatabaseName :=
//   (DesignDataBase as IBDEDesignDataBaseEh).GetDataBase.DatabaseName;
end;

type
  TDBDescription = record
    szName          : String;          { Logical name (Or alias) }
    szText          : String;          { Descriptive text }
    szPhyName       : String;          { Physical name/path }
    szDbType        : String;          { Database type }
  end;

{$IFDEF CIL}
function StrToOem(const AnsiStr: string): string;
var
  Len: Cardinal;
  Buffer: StringBuilder;
begin
  Len := Length(AnsiStr);
  if Len > 0 then
  begin
    Buffer := StringBuilder.Create(Len);
    CharToOemA(AnsiStr, Buffer);
    Result := Buffer.ToString;
  end;
end;
{$ELSE}
{$IFDEF EH_LIB_12}
function StrToOem(const AnsiStr: AnsiString): AnsiString;
begin
  Result := AnsiStr;
  if Length(Result) > 0 then
    CharToOemA(PAnsiChar(Result), PAnsiChar(Result));
end;
{$ELSE}
function StrToOem(const AnsiStr: string): string;
begin
  SetLength(Result, Length(AnsiStr));
  if Length(Result) > 0 then
    CharToOem(PChar(AnsiStr), PChar(Result));
end;
{$ENDIF}
{$ENDIF}

function GetDatabaseDesc(DBName: String; var Description: TDBDescription): Boolean;
var
  Desc: DBDesc;
begin
  Result := False;
{$IFDEF CIL}
  if DbiGetDatabaseDesc(StrToOem(DBName), Desc) <> 0 then Exit;
{$ELSE}
{$IFDEF EH_LIB_12}
  if DbiGetDatabaseDesc(PAnsiChar(StrToOem(AnsiString(DBName))), @Desc) <> 0 then Exit;
{$ELSE}
  if DbiGetDatabaseDesc(PChar(StrToOem(DBName)), @Desc) <> 0 then Exit;
{$ENDIF}
{$ENDIF}
  Description.szName := String(Desc.szName);
  Description.szText := String(Desc.szText);
  Description.szPhyName := String(Desc.szPhyName);
  Description.szDbType := String(Desc.szDbType);
  Result := True;
end;

function TBDEDataDriverEh.CreateCommand: TCustomSQLCommandEh;
begin
  Result := TBDECommandEh.Create(Self);
end;

procedure TBDEDataDriverEh.SetDatabaseName(const Value: string);
begin
  FDatabaseName := Value;
end;

procedure TBDEDataDriverEh.DoServerSpecOperations(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
//var
//  Description: TDBDescription;
begin
(*  if not GetDatabaseDesc(DatabaseName, Description) then
    Exit;
  if Description.szDbType = 'INFORMIX' then
    DoInformixServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if Description.szDbType = 'DB2' then
    DoDB2ServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if Description.szDbType = 'INTRBASE' then
//    DoInterBaseServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if Description.szDbType = 'ORACLE' then
    DoOracleServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if Description.szDbType = 'SYBASE' then
    DoSybaseServerSpecOperations(Self, MemRec, Command, ResDataSet)
  else if Description.szDbType = 'SQL Server' then
    DoMSSQLServerSpecOperations(Self, MemRec, Command, ResDataSet)
*)    
end;

function TBDEDataDriverEh.GetConnectionProvider: IConnectionProviderEh;
begin
  Supports(FConnectionProvider, IConnectionProviderEh, Result);
//  Result := FConnectionProvider;
end;

function TBDEDataDriverEh.GetDBSession: TSession;
begin
  Result := Sessions.FindSession(SessionName);
  if Result = nil then Result := DBTables.Session;
end;

procedure TBDEDataDriverEh.SetSessionName(const Value: string);
begin
  FSessionName := Value;
end;

procedure TBDEDataDriverEh.SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh);
var
  AutoIncFieldName: String;
  AutoIncField: TMTDataFieldEh;
begin
  AutoIncFieldName := SpecParams.Values['AUTO_INCREMENT_FIELD'];
  AutoIncField := nil;
  if AutoIncFieldName <> '' then
    AutoIncField := DataStruct.FindField(AutoIncFieldName);
  if (AutoIncField <> nil) and (AutoIncField is TMTNumericDataFieldEh) then
//    TMTNumericDataFieldEh(AutoIncField).NumericDataType := fdtAutoIncEh;
    TMTNumericDataFieldEh(AutoIncField).AutoIncrement := True;
end;

procedure TBDEDataDriverEh.SetConnectionProvider(const Value: TBDEConnectionProviderEh);
begin
  if FConnectionProvider <> Value then
  begin
    FConnectionProvider := Value;
    if FConnectionProvider <> nil then
    begin
      FConnectionProvider.FreeNotification(Self);
      DatabaseName := '';
    end;
  end;
end;

function TBDEDataDriverEh.HaveDataConnection: Boolean;
var
  DataBase: TDatabase;
begin
  if DatabaseName <> '' then
  begin
    Result := False;
    DataBase := Session.FindDatabase(DatabaseName);
    if (DataBase <> nil) and DataBase.Connected then
      Result := True;
  end else if ConnectionProvider <> nil then
    Result := True
  else
    Result := inherited HaveDataConnection();
end;

procedure TBDEDataDriverEh.DefaultGetUpdatedServerValues(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
var
  Processed: Boolean;
begin
  Processed := False;
  if DefaultSQLDataDriverResolver <> nil then
    DefaultSQLDataDriverResolver.GetBackUpdatedValues(Self, MemRec, Command, ResDataSet, Processed);
  if not Processed then
    DoServerSpecOperations(MemRec, Command, ResDataSet);
end;

type
  TServerSpecOperationsEhClass = class of TServerSpecOperationsEh;

function TBDEDataDriverEh.InternalGetServerSpecOperations: TServerSpecOperationsEh;
var
  Description: TDBDescription;
  ServerOpClass: TServerSpecOperationsEhClass;
begin
  ServerOpClass := nil;
  Result := FServerSpecOperations;
  if not GetDatabaseDesc(DatabaseName, Description) then
    Exit;
  if Description.szDbType = 'INFORMIX' then
    ServerOpClass := TInfromixSpecOperationsEh
  else if Description.szDbType = 'DB2' then
    ServerOpClass := TDB2SpecOperationsEh
  else if Description.szDbType = 'INTRBASE' then
    ServerOpClass := TInterbaseSpecOperationsEh
  else if Description.szDbType = 'ORACLE' then
    ServerOpClass := TOracleSpecOperationsEh
  else if Description.szDbType = 'SYBASE' then
    ServerOpClass := TSybaseSpecOperationsEh
  else if Description.szDbType = 'SQL Server' then
    ServerOpClass := TMSSQLSpecOperationsEh;

  if (Result = nil) or (ServerOpClass <> Result.ClassType) then
  begin
    FreeAndNil(Result);
    if ServerOpClass <> nil then
      Result := ServerOpClass.Create;
    FServerSpecOperations := Result;
  end;
end;

procedure TBDEDataDriverEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent <> nil) then
  begin
    if AComponent = ConnectionProvider then
      ConnectionProvider := nil;
  end;
end;

{ TBDEConnectionProviderEh }

constructor TBDEConnectionProviderEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInlineConnection := TBDEInlineConnectionEh.Create(Self);
  if BDEConnectionProviderDesignService <> nil then
    FDesignDataBase := BDEConnectionProviderDesignService.CreateDesignDataBase(Self);
end;

destructor TBDEConnectionProviderEh.Destroy;
begin
  FreeAndNil(FInlineConnection);
  FreeAndNil(FDesignDataBase);
  FreeAndNil(FDynaServerSpecOperations);
  inherited Destroy;
end;

function TBDEConnectionProviderEh.DefaultExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof, Processed: Boolean): Integer;
begin
  Result := inherited DefaultExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed);

  if not Processed then
  begin
    if (csDesigning in ComponentState) and InlineConnection.UseAtDesignTime then
    begin
      while True do
      begin
        if FInlineConnection.Connected then
          Break
        else
        begin
          if FInlineConnection.DatabaseName <> '' then
            try
              FInlineConnection.Connected := True;
              Break;
            except
              Application.HandleException(Self);
            end;
        end;

        Break
        {if not FInlineConnection.Connected then
        begin
          if ADOConnectionProviderDesignService.EditDesignData(Self)
            then Continue
            else Break;
        end;}
      end;
      if FInlineConnection.Connected then
      begin
        Result := DefaultExecuteBDECommandEh(SQLDataDriver, Command,
          Cursor, FreeOnEof, Processed, InlineConnection.Database.DatabaseName);
        Processed := True;
      end;
    end else if not (csDesigning in ComponentState) and InlineConnection.UseAtRunTime then
    begin
      Result := DefaultExecuteBDECommandEh(SQLDataDriver, Command,
          Cursor, FreeOnEof, Processed, InlineConnection.Database.DatabaseName);
      Processed := True;
    end else if Database <> nil then
    begin
      Result := DefaultExecuteBDECommandEh(SQLDataDriver, Command,
        Cursor, FreeOnEof, Processed, Database.DatabaseName);
      Processed := True;
    end;
  end;
end;

function TBDEConnectionProviderEh.GetDesignDataBase: TComponent;
begin
  Result := FDesignDataBase;
end;

function TBDEConnectionProviderEh.GetServerSpecOperations: TServerSpecOperationsEh;
begin
  Result := inherited GetServerSpecOperations;
  if Result = nil then
    Result := GetDynaServerSpecOperations;
end;

function TBDEConnectionProviderEh.GetDynaServerSpecOperations: TServerSpecOperationsEh;
var
  AServerTypeName: String;
  AServerSpecOperationsClass: TServerSpecOperationsEhClass;
  NewSTIndex: Integer;
  DesignDataBaseIntf: IDesignDataBaseEh;
begin
  AServerSpecOperationsClass := nil;
  Result := nil;
  if (FDynaServerSpecOperations <> nil) and
    (FDynaServerSpecOperations.GetServerTypeName <> GetServerTypeNameByDatabaseType)
  then
    FreeAndNil(FDynaServerSpecOperations);

  if FDynaServerSpecOperations = nil then
  begin
    if Database <> nil then
    begin
      AServerTypeName := GetServerTypeNameByDatabaseType;
      if AServerTypeName <> '' then
      begin
        NewSTIndex := ServerTypeClasses.IndexOf(AServerTypeName);
        if NewSTIndex < 0 then Exit;
        AServerSpecOperationsClass := TServerSpecOperationsEhClass(ServerTypeClasses.Objects[NewSTIndex]);
        FDynaServerSpecOperations := AServerSpecOperationsClass.Create;
      end;
    end;
    if (Supports(GetDesignDataBase, IDesignDataBaseEh, DesignDataBaseIntf)) then
    begin
      DesignDataBaseIntf.SetServerTypeAsServerSpecOperationsClass(AServerSpecOperationsClass);
    end;
  end;

  Result := FDynaServerSpecOperations;
end;

function TBDEConnectionProviderEh.GetServerType: String;
begin
  if FServerType <> '' then
    Result := inherited GetServerType
  else
    Result := GetServerTypeNameByDatabaseType;
end;

function TBDEConnectionProviderEh.GetServerTypeNameByDatabaseType: String;
var
  Description: TDBDescription;
begin
  Result := '';
  if Database = nil then
    Exit;
  if not GetDatabaseDesc(Database.DatabaseName, Description) then
    Exit;
  if Description.szDbType = 'INFORMIX' then
    Result := 'Infromix'
  else if Description.szDbType = 'DB2' then
    Result := 'DB2'
  else if Description.szDbType = 'INTRBASE' then
    Result := 'Interbase'
  else if Description.szDbType = 'ORACLE' then
    Result := 'Oracle'
  else if Description.szDbType = 'SYBASE' then
    Result := 'Sybase'
  else if Description.szDbType = 'SQL Server' then
    Result := 'MSSQL'
  else if Description.szDbType = 'MSACCESS' then
    Result := 'MSAccess';
end;

function TBDEConnectionProviderEh.IsServerTypeStored: Boolean;
begin
  Result := (FServerType <> '');
end;

procedure TBDEConnectionProviderEh.SetServerType(const Value: String);
begin
  FServerType := Value;
  inherited SetServerType(Value);
  if ServerSpecOperations <> nil then
    FreeAndNil(FDynaServerSpecOperations);
end;

function TBDEConnectionProviderEh.UseDesignDatabase: Boolean;
begin
  if {$IFDEF DESIGNTIME} (csDesigning in ComponentState) and {$ENDIF}
    InlineConnection.UseAtDesignTime
    then Result := True
    else Result := False;
end;

function TBDEConnectionProviderEh.CurrentTimeDatabase: TDatabase;
begin
  if {$IFDEF DESIGNTIME} (csDesigning in ComponentState) and {$ENDIF} InlineConnection.UseAtDesignTime then
    Result := InlineConnection.Database
  else if not (csDesigning in ComponentState) and InlineConnection.UseAtRunTime then
    Result := InlineConnection.Database
  else
    Result := Database;
{  if UseDesignDatabase
    then Result := InlineConnection.Database
    else Result := Database;}
end;

procedure TBDEConnectionProviderEh.Loaded;
begin
  inherited Loaded;
end;

procedure TBDEConnectionProviderEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
end;

procedure TBDEConnectionProviderEh.SetDatabase(const Value: TDatabase);
begin
  FDatabase := Value;
end;

procedure TBDEConnectionProviderEh.SetInlineConnection(
  const Value: TBDEInlineConnectionEh);
begin
  FInlineConnection.Assign(Value);
end;

(*
function TBDEConnectionProviderEh.GetDBSession: TSession;
begin
  Result := Sessions.FindSession(SessionName);
  if Result = nil then Result := DBTables.Session;
end;

procedure TBDEConnectionProviderEh.SetDatabaseName(const Value: string);
begin
  FDatabaseName := Value;
end;

procedure TBDEConnectionProviderEh.SetSessionName(const Value: string);
begin
  FSessionName := Value;
end;
*)

{ TBDEInlineConnectionEh }

constructor TBDEInlineConnectionEh.Create(AConnectionProvider: TBDEConnectionProviderEh);
begin
  inherited Create(AConnectionProvider);
  FConnectionProvider := AConnectionProvider;

  FDatabase := TDatabase.Create(FConnectionProvider);
  FDatabase.LoginPrompt := False;
  FDatabase.BeforeConnect := BeforeInlineConnection;
  FDatabase.AfterConnect := AfterInlineConnection;
end;

destructor TBDEInlineConnectionEh.Destroy;
begin
  FreeAndNil(FDatabase);
  inherited Destroy;
end;

procedure TBDEInlineConnectionEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

procedure TBDEInlineConnectionEh.BeforeInlineConnection(Sender: TObject);
begin
//  FInlineConnection.ConnectionString := FConnectionProvider.UnmacrosConnectionString(FInlineConnectionString);
  if Assigned(ConnectionProvider.FInlineConnectionBeforeConnect) then
    ConnectionProvider.FInlineConnectionBeforeConnect(Self);
end;

procedure TBDEInlineConnectionEh.AfterInlineConnection(Sender: TObject);
begin
//  ActivatePostponedDataSets;  
  if Assigned(ConnectionProvider.FInlineConnectionAfterConnect) then
    ConnectionProvider.FInlineConnectionAfterConnect(Self);
end;

function TBDEInlineConnectionEh.GetAliasName: string;
begin
  Result := FDatabase.AliasName;
end;

function TBDEInlineConnectionEh.GetConnected: Boolean;
begin
  Result := FDatabase.Connected;
end;

function TBDEInlineConnectionEh.GetDriverName: string;
begin
  Result := FDatabase.DriverName;
end;

function TBDEInlineConnectionEh.GetParams: TStrings;
begin
  Result := FDatabase.Params;
end;

function TBDEInlineConnectionEh.GetReadOnly: Boolean;
begin
  Result := FDatabase.ReadOnly;
end;

procedure TBDEInlineConnectionEh.SetAliasName(const Value: string);
begin
  FDatabase.AliasName := Value;
end;

procedure TBDEInlineConnectionEh.SetDatabaseName(const Value: string);
begin
  FDatabase.DatabaseName := Value;
end;

function TBDEInlineConnectionEh.GetDatabaseName: string;
begin
  Result := FDatabase.DatabaseName;
end;


procedure TBDEInlineConnectionEh.SetDesignConnected(const Value: Boolean);
begin
  FDatabase.Connected := Value;
end;

procedure TBDEInlineConnectionEh.SetDriverName(const Value: string);
begin
  FDatabase.DriverName := Value;
end;

procedure TBDEInlineConnectionEh.SetParams(const Value: TStrings);
begin
  FDatabase.Params := Value;
end;

procedure TBDEInlineConnectionEh.SetReadOnly(const Value: Boolean);
begin
  FDatabase.ReadOnly := Value;
end;

function TBDEInlineConnectionEh.GetUseAtRunTime: Boolean;
begin
  Result := FUseAtRunTime;
end;

procedure TBDEInlineConnectionEh.SetUseAtRunTime(const Value: Boolean);
begin
  FUseAtRunTime := Value;
end;

end.
