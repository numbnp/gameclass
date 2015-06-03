{*******************************************************}
{                                                       }
{                     EhLib v7.0                        }
{                                                       }
{         TADODataDriverEh component (Build 7.0.07)     }
{                                                       }
{     Copyright (c) 2004-2012 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit ADODataDriverEh;

{$I EHLIB.INC}

interface

uses Windows, SysUtils, Classes, Controls, DB, Forms, Dialogs, Messages,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
{$IFDEF EH_LIB_14} DBCommonTypes, {$ENDIF}
//  ADODataDriverDesignEh,
  ToolCtrlsEh, MemTableDataEh, DataDriverEh, ADODB;

type

  IADOConnectionProviderEh = interface(IConnectionProviderEh)
  ['{11014AAC-0132-4C66-8B53-0204F54DB001}']
    function GetConnection: TADOConnection;
  end;

  TADODataDriverEh = class;
  TADOCommandEh = class;
  TADOConnectionProviderEh = class;

  TAssignParameterEhEvent = procedure (DataDriver: TADODataDriverEh;
    Command: TADOCommandEh; MemRecord: TMemoryRecordEh;
    DataValueVersion: TDataValueVersionEh; Parameter: TParameter) of object;
  TADODataDriverExecuteCommandEhEvent = function (DataDriver: TADODataDriverEh;
    Command: TADOCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer of object;
  TADODataDriverGetBackUpdatedValuesEhEvent = procedure (DataDriver: TADODataDriverEh;
    MemRec: TMemoryRecordEh; Command: TADOCommandEh; ResDataSet: TDataSet) of object;

  TADODBCommandEh = class(TADOCommand)
  protected
    property ComponentRef;
  end;

{ TADOCommandEh }

  TADOCommandEh = class(TCustomSQLCommandEh)
  private
    FOnAssignParameter: TAssignParameterEhEvent;
    FCommand: TADODBCommandEh;
    FParams: TParams;
    FCommandTimeOut: Integer;
    function GetParamCheck: Boolean;
    function GetParameters: TParameters;
    function GetDataDriver: TADODataDriverEh;
    procedure SetCommandTimeOut(const Value: Integer);
  protected
    procedure CommandTextChanged(Sender: TObject); override;
    procedure SetParamCheck(const Value: Boolean); virtual;
    procedure SetParameters(const Value: TParameters); virtual;
  public
    constructor Create(ADataDriver: TADODataDriverEh);
    destructor Destroy; override;
    function Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    function GetParams: TParams; override;
    procedure Assign(Source: TPersistent); override;
    procedure DefaultRefreshParameter(MemRecord: TMemoryRecordEh;
      DataValueVersion: TDataValueVersionEh; Parameter: TParameter); virtual;
    procedure RefreshParams(MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh); override;
    procedure RebuildParams; override;
    procedure SetParams(AParams: TParams); override;

    property DataDriver: TADODataDriverEh read GetDataDriver;
    property OnAssignParameter: TAssignParameterEhEvent read FOnAssignParameter write FOnAssignParameter;
  published
    property CommandText;
    property CommandTimeout: Integer read FCommandTimeOut write SetCommandTimeOut default 30;
    property CommandType;
    property Parameters: TParameters read GetParameters write SetParameters;
    property ParamCheck: Boolean read GetParamCheck write SetParamCheck default True;
  end;

{ TADODataDriverEh }

  TADODataDriverEh = class(TCustomSQLDataDriverEh)
  private
    FADOConnection: TADOConnection;
    FConnectionString: WideString;
    FOnAssignCommandParameter: TAssignParameterEhEvent;
//    FOnExecuteCommand: TADODataDriverExecuteCommandEhEvent;
    FOnGetBackUpdatedValues: TADODataDriverGetBackUpdatedValuesEhEvent;
    FConnectionProvider: TADOConnectionProviderEh;
    function GetDeleteCommand: TADOCommandEh;
    function GetGetrecCommand: TADOCommandEh;
    function GetInsertCommand: TADOCommandEh;
    function GetSelectCommand: TADOCommandEh;
    function GetUpdateCommand: TADOCommandEh;
    procedure SetConnection(const Value: TADOConnection);
    procedure SetConnectionString(const Value: WideString);
    procedure SetDeleteCommand(const Value: TADOCommandEh);
    procedure SetGetrecCommand(const Value: TADOCommandEh);
    procedure SetInsertCommand(const Value: TADOCommandEh);
    procedure SetSelectCommand(const Value: TADOCommandEh);
    procedure SetUpdateCommand(const Value: TADOCommandEh);
    function GetOnExecuteCommand: TADODataDriverExecuteCommandEhEvent;
    procedure SetOnExecuteCommand(const Value: TADODataDriverExecuteCommandEhEvent);
    procedure SetConnectionProvider(const Value: TADOConnectionProviderEh);
  protected
    function CreateCommand: TCustomSQLCommandEh; override;
    procedure AssignCommandParameter(Command: TADOCommandEh;
      MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Parameter: TParameter); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh); override;
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function CreateDesignCopy: TCustomSQLDataDriverEh; override;
    function ExecuteCommand(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    function HaveDataConnection(): Boolean; override;
    procedure AssignFromDesignDriver(DesignDataDriver: TCustomSQLDataDriverEh); override;
    procedure DefaultAssignCommandParameter(Command: TADOCommandEh; MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Parameter: TParameter); virtual;
    procedure DefaultGetUpdatedServerValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    function ReadData(MemTableData: TMemTableDataEh; Count: Integer): Integer; override;
    function GetConnectionProvider: IConnectionProviderEh; override;
  published
    property ADOConnection: TADOConnection read FADOConnection write SetConnection;
    property ConnectionProvider: TADOConnectionProviderEh read FConnectionProvider write SetConnectionProvider;
    property ConnectionString: WideString read FConnectionString write SetConnectionString;
    property DynaSQLParams;
    property KeyFields;
    property MacroVars;
    property ProviderDataSet;
    property SpecParams;

    property SelectCommand: TADOCommandEh read GetSelectCommand write SetSelectCommand;
    property SelectSQL;
    property UpdateCommand: TADOCommandEh read GetUpdateCommand write SetUpdateCommand;
    property UpdateSQL;
    property InsertCommand: TADOCommandEh read GetInsertCommand write SetInsertCommand;
    property InsertSQL;
    property DeleteCommand: TADOCommandEh read GetDeleteCommand write SetDeleteCommand;
    property DeleteSQL;
    property GetrecCommand: TADOCommandEh read GetGetrecCommand write SetGetrecCommand;
    property GetrecSQL;

    property OnAssignCommandParameter: TAssignParameterEhEvent read FOnAssignCommandParameter write FOnAssignCommandParameter;
    property OnAssignFieldValue;
    property OnBuildDataStruct;
    property OnExecuteCommand: TADODataDriverExecuteCommandEhEvent read GetOnExecuteCommand write SetOnExecuteCommand;
    property OnGetBackUpdatedValues: TADODataDriverGetBackUpdatedValuesEhEvent read FOnGetBackUpdatedValues write FOnGetBackUpdatedValues;
    property OnProduceDataReader;
    property OnReadRecord;
    property OnRefreshRecord;
    property OnUpdateError;
    property OnUpdateRecord;
  end;

{ TADOInlineConnectionEh }

  TADOInlineConnectionEh = class(TCustomInlineConnectionEh)
  private
    FConnectionProvider: TADOConnectionProviderEh;
    FInlineConnection: TADOConnection;
    FInlineConnectionString: WideString;
    FConnectOptions: TConnectOption;
    FUseAtRunTime: Boolean;
    FPostponedDataSets: TList;
    FUseAtRunTimeStored: Boolean;
    FUseAtDesignTimeStored: Boolean;
    FUseAtDesignTime: Boolean;
    function GetInlineConnectionString: WideString;
    procedure SetInlineConnectionString(const Value: WideString);
    function GetAttributes: TXactAttributes;
    function GetCommandTimeout: Integer;
    function GetConnectionTimeout: Integer;
    function GetCursorLocation: TCursorLocation;
    function GetDefaultDatabase: WideString;
    function GetIsolationLevel: TIsolationLevel;
    function GetKeepConnection: Boolean;
    function GetLoginPrompt: Boolean;
    function GetMode: TConnectMode;
    function GetProvider: WideString;
    function IsDefaultDatabaseStored: Boolean;
    function IsProviderStored: Boolean;
    procedure SetAttributes(const Value: TXactAttributes);
    procedure SetCommandTimeout(const Value: Integer);
    procedure SetConnectionTimeout(const Value: Integer);
    procedure SetConnectOptions(const Value: TConnectOption);
    procedure SetCursorLocation(const Value: TCursorLocation);
    procedure SetDefaultDatabase(const Value: WideString);
    procedure SetIsolationLevel(const Value: TIsolationLevel);
    procedure SetKeepConnection(const Value: Boolean);
    procedure SetLoginPrompt(const Value: Boolean);
    procedure SetMode(const Value: TConnectMode);
    procedure SetProvider(const Value: WideString);
    function GetUseAtRunTime: Boolean;
    function GetUseAtDesignTime: Boolean;
    function IsUseAtRunTimeStored: Boolean;
    procedure SetUseAtDesignTime(const Value: Boolean);
    procedure SetUseAtRunTime(const Value: Boolean);
    function IsUseAtDesignTimeStored: Boolean;
    procedure SetUseAtDesignTimeStored(const Value: Boolean);
    procedure SetUseAtRunTimeStored(const Value: Boolean);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation);
    procedure AddPostponedActivationDataSet(ADataSet: TDataSet);
    procedure ActivatePostponedDataSets;
  protected
    function GetConnected: Boolean; override;
    procedure BeforeInlineConnection(Sender: TObject);
    procedure AfterInlineConnection(Sender: TObject);
    procedure SetDesignConnected(const Value: Boolean); override;
  public
    constructor Create(AConnectionProvider: TADOConnectionProviderEh);
    destructor Destroy; override;
    function DefaultUseAtRunTime: Boolean;
    function DefaultUseAtDesignTime: Boolean;
    procedure Assign(Source: TPersistent); override;
    property Connection: TADOConnection read FInlineConnection;
    property ConnectionProvider: TADOConnectionProviderEh read FConnectionProvider;
  published
    property Connected;
    property ConnectionString: WideString read GetInlineConnectionString write SetInlineConnectionString;

    property UseAtDesignTime: Boolean read GetUseAtDesignTime write SetUseAtDesignTime stored IsUseAtDesignTimeStored;
    property UseAtDesignTimeStored: Boolean read IsUseAtDesignTimeStored write SetUseAtDesignTimeStored stored False;

    property UseAtRunTime: Boolean read GetUseAtRunTime write SetUseAtRunTime stored IsUseAtRunTimeStored;
    property UseAtRunTimeStored: Boolean read IsUseAtRunTimeStored write SetUseAtRunTimeStored stored False;

    property Attributes: TXactAttributes read GetAttributes write SetAttributes default [];
    property CommandTimeout: Integer read GetCommandTimeout write SetCommandTimeout default 30;
    property ConnectionTimeout: Integer read GetConnectionTimeout write SetConnectionTimeout default 15;
    property ConnectOptions: TConnectOption read FConnectOptions write SetConnectOptions default coConnectUnspecified;
    property CursorLocation: TCursorLocation read GetCursorLocation write SetCursorLocation default clUseClient;
    property DefaultDatabase: WideString read GetDefaultDatabase write SetDefaultDatabase stored IsDefaultDatabaseStored;
    property IsolationLevel: TIsolationLevel read GetIsolationLevel write SetIsolationLevel default ilCursorStability;
    property KeepConnection: Boolean read GetKeepConnection write SetKeepConnection default True;
    property LoginPrompt: Boolean read GetLoginPrompt write SetLoginPrompt default False;
    property Mode: TConnectMode read GetMode write SetMode default cmUnknown;
    property Provider: WideString read GetProvider write SetProvider stored IsProviderStored;
  end;

{ TADOConnectionProviderEh }

  TADOConnectionProviderEh = class(TConnectionProviderEh)
  private
    FConnection: TADOConnection;
    FInlineConnection: TADOInlineConnectionEh;
    FDesignDataBase: TComponent;
    FInlineConnectionBeforeConnect: TNotifyEvent;
    FInlineConnectionAfterConnect: TNotifyEvent;
    function GetOnInlineConnectionBeginTransComplete: TBeginTransCompleteEvent;
    function GetOnInlineConnectionCommitTransComplete: TConnectErrorEvent;
    function GetOnInlineConnectionConnectComplete: TConnectErrorEvent;
    function GetOnInlineConnectionDisconnect: TDisconnectEvent;
    function GetOnInlineConnectionExecuteComplete: TExecuteCompleteEvent;
    function GetOnInlineConnectionInfoMessage: TInfoMessageEvent;
    function GetOnInlineConnectionRollbackTransComplete: TConnectErrorEvent;
    function GetOnInlineConnectionWillConnect: TWillConnectEvent;
    function GetOnInlineConnectionWillExecute: TWillExecuteEvent;
    function GetPath: String;

    procedure SetConnection(const Value: TADOConnection);
    procedure SetInlineConnection(const Value: TADOInlineConnectionEh);
    procedure SetOnInlineConnectionBeginTransComplete(const Value: TBeginTransCompleteEvent);
    procedure SetOnInlineConnectionCommitTransComplete(const Value: TConnectErrorEvent);
    procedure SetOnInlineConnectionConnectComplete(const Value: TConnectErrorEvent);
    procedure SetOnInlineConnectionDisconnect(const Value: TDisconnectEvent);
    procedure SetOnInlineConnectionExecuteComplete(const Value: TExecuteCompleteEvent);
    procedure SetOnInlineConnectionInfoMessage(const Value: TInfoMessageEvent);
    procedure SetOnInlineConnectionRollbackTransComplete(const Value: TConnectErrorEvent);
    procedure SetOnInlineConnectionWillConnect(const Value: TWillConnectEvent);
    procedure SetOnInlineConnectionWillExecute(const Value: TWillExecuteEvent);

  protected
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  protected
    procedure AddPostponedActivationDataSet(ADataSet: TDataSet); override;

  public
    {DesignTime stuff}
    function GetDesignDataBase: TComponent; override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ConnectionIsPostponed: Boolean; override;
    function UseInlineConnection: Boolean;
    function CurrentTimeConnection: TADOConnection;
    function DefaultExecuteCommand(SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer; override;
    function UnmacrosConnectionString(MacrosedString: WideString): WideString;

    procedure GetDataReaderForSQL(SQLText: String; AParams: TParams; var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean); override;

  published
    property Connection: TADOConnection read FConnection write SetConnection;
    property InlineConnection: TADOInlineConnectionEh read FInlineConnection write SetInlineConnection;
    property Path: String read GetPath;
    property ServerType;

    property OnExecuteCommand;
    property OnGetBackUpdatedValues;
    property OnGetServerSpecOperations;
    property OnUpdateRecord;
    property InlineConnectionBeforeConnect: TNotifyEvent read FInlineConnectionBeforeConnect write FInlineConnectionBeforeConnect;
    property InlineConnectionAfterConnect: TNotifyEvent read FInlineConnectionAfterConnect write FInlineConnectionAfterConnect;

    property OnInlineConnectionDisconnect: TDisconnectEvent read GetOnInlineConnectionDisconnect write SetOnInlineConnectionDisconnect;
    property OnInlineConnectionInfoMessage: TInfoMessageEvent read GetOnInlineConnectionInfoMessage write SetOnInlineConnectionInfoMessage;
    property OnInlineConnectionBeginTransComplete: TBeginTransCompleteEvent read GetOnInlineConnectionBeginTransComplete write SetOnInlineConnectionBeginTransComplete;
    property OnInlineConnectionCommitTransComplete: TConnectErrorEvent read GetOnInlineConnectionCommitTransComplete write SetOnInlineConnectionCommitTransComplete;
    property OnInlineConnectionRollbackTransComplete: TConnectErrorEvent read GetOnInlineConnectionRollbackTransComplete write SetOnInlineConnectionRollbackTransComplete;
    property OnInlineConnectionConnectComplete: TConnectErrorEvent read GetOnInlineConnectionConnectComplete write SetOnInlineConnectionConnectComplete;
    property OnInlineConnectionWillConnect: TWillConnectEvent read GetOnInlineConnectionWillConnect write SetOnInlineConnectionWillConnect;
    property OnInlineConnectionExecuteComplete: TExecuteCompleteEvent read GetOnInlineConnectionExecuteComplete write SetOnInlineConnectionExecuteComplete;
    property OnInlineConnectionWillExecute: TWillExecuteEvent read GetOnInlineConnectionWillExecute write SetOnInlineConnectionWillExecute;

  end;

{ TNiADODataDriverEh }

  TNiADODataDriverEh = class(TADODataDriverEh)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property SideParent;
  end;

function DefaultExecuteADOCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    ADOConnection: TADOConnection; ADOConnectionString: WideString): Integer;

type TGetADODataDriverServerSpecOperations = function (DataDriver: TADODataDriverEh): TServerSpecOperationsEh;

function RegisterGetADODataDriverServerSpecOperationsPrg(Prg: TGetADODataDriverServerSpecOperations): TGetADODataDriverServerSpecOperations;

var
  ADOConnectionProviderDesignService: IConnectionProviderDesignServiceEh;

implementation

uses StrUtils;

var
  FGetADODataDriverServerSpecOperationsPrg: TGetADODataDriverServerSpecOperations;

function RegisterGetADODataDriverServerSpecOperationsPrg(Prg: TGetADODataDriverServerSpecOperations): TGetADODataDriverServerSpecOperations;
begin
  Result := FGetADODataDriverServerSpecOperationsPrg;
  FGetADODataDriverServerSpecOperationsPrg := Prg;
end;

function DefaultExecuteADOCommandEh(SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    ADOConnection: TADOConnection; ADOConnectionString: WideString): Integer;
var
  ACursor: TDataSet;
begin
  Result := -1;
  Cursor := nil;
  FreeOnEof := False;
  ACursor := nil;
  try
    case Command.CommandType of
      cthSelectQuery, cthUpdateQuery:
        begin
          ACursor := TADOQuery.Create(nil);
          with ACursor as TADOQuery do
          begin
            Connection := ADOConnection;
            ConnectionString := ADOConnectionString;
            SQL.Text := Command.FinalCommandText.Text;
            if Command is TADOCommandEh
              then Parameters := TADOCommandEh(Command).Parameters
              else Parameters.Assign(TBaseSQLCommandEh(Command).Params);
{$IFDEF EH_LIB_6}
            CommandTimeout := TADOCommandEh(Command).CommandTimeout;
{$ENDIF}
            if Command.CommandType = cthSelectQuery then
              Open
            else
            begin
              ExecSQL;
              Result := RowsAffected;
            end;
            if Command is TADOCommandEh
              then TADOCommandEh(Command).Parameters := Parameters
              else TBaseSQLCommandEh(Command).Params.Assign(Parameters);
          end;
        end;
      cthTable:
        begin
          ACursor := TADOTable.Create(nil);
          with ACursor as TADOTable do
          begin
            Connection := ADOConnection;
            ConnectionString := ADOConnectionString;
            TableName := Command.FinalCommandText.Text;
{$IFDEF EH_LIB_6}  
            CommandTimeout := TADOCommandEh(Command).CommandTimeout;
{$ENDIF}
//            Parameters.Assign(TBaseSQLCommandEh(Command).Params);
            Open;
//            TBaseSQLCommandEh(Command).Params.Assign(Parameters);
          end;
        end;
      cthStoredProc:
        begin
          ACursor := TADOStoredProc.Create(nil);
          with ACursor as TADOStoredProc do
          begin
            Connection := ADOConnection;
            ConnectionString := ADOConnectionString;
            ProcedureName := Command.FinalCommandText.Text;
            if Command is TADOCommandEh
              then Parameters := TADOCommandEh(Command).Parameters
              else Parameters.Assign(TBaseSQLCommandEh(Command).Params);
{$IFDEF EH_LIB_6}  
            CommandTimeout := TADOCommandEh(Command).CommandTimeout;
{$ENDIF}
            ExecProc;
//??            Result := RowsAffected;
            if Command is TADOCommandEh
              then TADOCommandEh(Command).Parameters := Parameters
              else TBaseSQLCommandEh(Command).Params.Assign(Parameters);
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

{ TADOCommandEh }

constructor TADOCommandEh.Create(ADataDriver: TADODataDriverEh);
begin
  inherited Create(ADataDriver);
  FCommand := TADODBCommandEh.Create(ADataDriver);
  FCommand.ComponentRef := ADataDriver;
  FCommandTimeOut := 30;
end;

destructor TADOCommandEh.Destroy;
begin
  FCommand.Free;
  FParams.Free;
  inherited Destroy;
end;

procedure TADOCommandEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TADOCommandEh then
    with (Source as TADOCommandEh) do
    begin
      Self.ParamCheck := ParamCheck;
      Self.Parameters := Parameters;
    end
  else if Source is TBaseSQLCommandEh then
    with (Source as TBaseSQLCommandEh) do
    begin
      Self.ParamCheck := ParamCheck;
      Self.Parameters.Assign(GetParams);
    end;
end;

procedure TADOCommandEh.CommandTextChanged(Sender: TObject);
begin
  inherited CommandTextChanged(Sender);
  if (DataDriver <> nil) then
  begin
    if DataDriver.ConnectionProvider <> nil then
    begin
      FCommand.Connection := DataDriver.ConnectionProvider.CurrentTimeConnection;
    end else
    begin
      FCommand.Connection := DataDriver.ADOConnection;
      FCommand.ConnectionString := DataDriver.ConnectionString;
    end;
  end;
  FCommand.CommandText := CommandText.Text;
//  if not (csReading in DataDriver.ComponentState) then
//    if ParamCheck then
//      Parameters.ParseSQL(CommandText.Text, True);
end;

procedure TADOCommandEh.RebuildParams;
var
  FParamsCommand: TADODBCommandEh;
begin
  FParamsCommand := TADODBCommandEh.Create(nil);
  try
    if DataDriver <> nil then
    begin
      FParamsCommand.Connection := DataDriver.ADOConnection;
      FParamsCommand.ConnectionString := DataDriver.ConnectionString;
    end;
    FParamsCommand.Parameters.Assign(Parameters);
    FParamsCommand.CommandText := CommandText.Text;
    Parameters.Assign(FParamsCommand.Parameters);
  finally
    FParamsCommand.Free;
  end;
end;

procedure TADOCommandEh.RefreshParams(MemRecord: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh);
var
  I: Integer;
begin
  for I := 0 to Parameters.Count - 1 do
  begin
    if Assigned(OnAssignParameter)
      then OnAssignParameter(DataDriver, Self, MemRecord, DataValueVersion, Parameters[I])
      else DefaultRefreshParameter(MemRecord, DataValueVersion, Parameters[I]);
  end;
end;

procedure TADOCommandEh.DefaultRefreshParameter(MemRecord: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh; Parameter: TParameter);
begin
  DataDriver.AssignCommandParameter(Self, MemRecord, DataValueVersion, Parameter);
end;

function TADOCommandEh.Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
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

{  if (DataDriver.ADOConnection is TADOConnectionEh) then
  begin
    Processed := False;
    Result := TADOConnectionEh(DataDriver.ADOConnection).ExecuteCommand(DataDriver, Self, Cursor, FreeOnEof, Processed);
    if Processed then
      Exit;
  end;
}

  Result := -1;
  Cursor := nil;
  FreeOnEof := False;
  ACursor := nil;
  try
    case CommandType of
      cthSelectQuery, cthUpdateQuery:
        begin
          ACursor := TADOQuery.Create(nil);
          with ACursor as TADOQuery do
          begin
            Connection := DataDriver.ADOConnection;
            ConnectionString := DataDriver.ConnectionString;
            SQL.Text := Self.FinalCommandText.Text;
            Parameters.Assign(Self.Parameters);
            if CommandType = cthSelectQuery then
              Open
            else
            begin
              ExecSQL;
              Result := RowsAffected;
            end;
            Self.Parameters.Assign(Parameters);
          end;
        end;
      cthTable:
        begin
          ACursor := TADOTable.Create(nil);
          with ACursor as TADOTable do
          begin
            Connection := DataDriver.ADOConnection;
            ConnectionString := DataDriver.ConnectionString;
            TableName := Self.FinalCommandText.Text;
            Parameters.Assign(Self.Parameters);
            Open;
            Self.Parameters.Assign(Parameters);
          end;
        end;
      cthStoredProc:
        begin
          ACursor := TADOStoredProc.Create(nil);
          with ACursor as TADOStoredProc do
          begin
            Connection := DataDriver.ADOConnection;
            ConnectionString := DataDriver.ConnectionString;
            ProcedureName := Self.FinalCommandText.Text;
            Parameters.Assign(Self.Parameters);
            ExecProc;
//??            Result := RowsAffected;
            Self.Parameters.Assign(Parameters);
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

function TADOCommandEh.GetDataDriver: TADODataDriverEh;
begin
  Result := TADODataDriverEh(inherited DataDriver);
end;

function TADOCommandEh.GetParamCheck: Boolean;
begin
  Result := FCommand.ParamCheck;
end;

procedure TADOCommandEh.SetParamCheck(const Value: Boolean);
begin
  FCommand.ParamCheck := Value;
end;

function TADOCommandEh.GetParameters: TParameters;
begin
  Result := FCommand.Parameters;
end;

procedure TADOCommandEh.SetParameters(const Value: TParameters);
begin
  FCommand.Parameters := Value;
end;

function TADOCommandEh.GetParams: TParams;
begin
  if not Assigned(FParams) then
    FParams := TParams.Create(Self);
  FParams.Assign(Parameters);
  Result := FParams;
end;

procedure TADOCommandEh.SetParams(AParams: TParams);
begin
  Parameters.Assign(AParams);
end;

{ TADODataDriverEh }

(*
var
  DataBaseInc: Integer = 0;

function GetUnicalDataBaseName: String;
begin
  Inc(DataBaseInc);
  Result := 'ADODataDriverEhDataBaseName' + IntToStr(DataBaseInc);
end;
*)

constructor TADODataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TADODataDriverEh.Destroy;
begin
  inherited Destroy;
end;

function TADODataDriverEh.ExecuteCommand(Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  ExecComEvent: TADODataDriverExecuteCommandEhEvent;
begin
  ExecComEvent := OnExecuteCommand;
  if Assigned(ExecComEvent)
    then Result := ExecComEvent(Self, TADOCommandEh(Command), Cursor, FreeOnEof)
    else Result := DefaultExecuteCommand(Command, Cursor, FreeOnEof);
end;

function TADODataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
var
  Res: TADODataDriverEh;
begin
  Res := TADODataDriverEh.Create(nil);
  Res.ADOConnection := ADOConnection; 
  Res.ConnectionProvider := ConnectionProvider;
  Res.SelectCommand := SelectCommand;
  Res.UpdateCommand := UpdateCommand;
  Res.InsertCommand := InsertCommand;
  Res.DeleteCommand := DeleteCommand;
  Res.GetrecCommand := GetrecCommand;
  Res.SpecParams := SpecParams;
  Res.DynaSQLParams := DynaSQLParams;
  Res.MacroVars := MacroVars;
  Result := Res;
//  TADODataDriverEh(Result).DatabaseName :=
//   (DesignDataBase as IDBXDesignDataBaseEh).GetDataBase.DatabaseName;
end;

procedure TADODataDriverEh.AssignFromDesignDriver(
  DesignDataDriver: TCustomSQLDataDriverEh);
begin
  SelectCommand := TADODataDriverEh(DesignDataDriver).SelectCommand;
  UpdateCommand := TADODataDriverEh(DesignDataDriver).UpdateCommand;
  InsertCommand := TADODataDriverEh(DesignDataDriver).InsertCommand;
  DeleteCommand := TADODataDriverEh(DesignDataDriver).DeleteCommand;
  GetrecCommand := TADODataDriverEh(DesignDataDriver).GetrecCommand;
  SpecParams := TADODataDriverEh(DesignDataDriver).SpecParams;
  DynaSQLParams := TADODataDriverEh(DesignDataDriver).DynaSQLParams;
  MacroVars := TADODataDriverEh(DesignDataDriver).MacroVars;
end;

type
  TDBDescription = record
    szName          : String;          { Logical name (Or alias) }
    szText          : String;          { Descriptive text }
    szPhyName       : String;          { Physical name/path }
    szDbType        : String;          { Database type }
  end;

function TADODataDriverEh.CreateCommand: TCustomSQLCommandEh;
begin
  Result := TADOCommandEh.Create(Self);
end;

procedure TADODataDriverEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  if Assigned(FOnGetBackUpdatedValues)
    then OnGetBackUpdatedValues(Self, MemRec, TADOCommandEh(Command), ResDataSet)
    else DefaultGetUpdatedServerValues(MemRec, Command, ResDataSet);
//  DoServerSpecOperations(MemRec, Command, ResDataSet);
end;

procedure TADODataDriverEh.DefaultGetUpdatedServerValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
var
  ADOCommand: TADOCommandEh;
  i, fi: Integer;
begin
  ADOCommand := TADOCommandEh(Command);
  for i := 0 to ADOCommand.Parameters.Count-1 do
  begin
    if ADOCommand.Parameters[i].Direction in [pdOutput, pdInputOutput, pdReturnValue] then
    begin
      fi := MemRec.DataStruct.FieldIndex(ADOCommand.Parameters[i].Name);
      if fi >= 0 then
        MemRec.Value[fi, dvvValueEh] := ADOCommand.Parameters[i].Value;
    end;
  end;

  inherited DefaultGetUpdatedServerValues(MemRec, Command, ResDataSet);
end;

procedure TADODataDriverEh.SetConnection(const Value: TADOConnection);
begin
  if FADOConnection <> Value then
  begin
    FADOConnection := Value;
    if FADOConnection <> nil then
    begin
      FADOConnection.FreeNotification(Self);
      ConnectionProvider := nil;
    end;
  end;
end;

procedure TADODataDriverEh.SetConnectionString(const Value: WideString);
begin
  if FConnectionString <> Value then
  begin
    if FConnectionString <> '' then
      ConnectionProvider := nil;
    FConnectionString := Value;
  end;
end;

procedure TADODataDriverEh.SetConnectionProvider(const Value: TADOConnectionProviderEh);
begin
//  ShowMessage('TADODataDriverEh.SetConnectionProvider');
//  raise Exception.Create('TADODataDriverEh.SetConnectionProvider');
  if FConnectionProvider <> Value then
  begin
    FConnectionProvider := Value;
    if FConnectionProvider <> nil then
    begin
      FConnectionProvider.FreeNotification(Self);
      ADOConnection := nil;
      ConnectionString := '';
    end;
  end;
end;

procedure TADODataDriverEh.SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh);
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

procedure TADODataDriverEh.AssignCommandParameter(
  Command: TADOCommandEh; MemRecord: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh; Parameter: TParameter);
begin
  if Assigned(OnAssignCommandParameter)
    then OnAssignCommandParameter(Self, Command, MemRecord, DataValueVersion, Parameter)
    else DefaultAssignCommandParameter(Command, MemRecord, DataValueVersion, Parameter);
end;

procedure TADODataDriverEh.DefaultAssignCommandParameter(
  Command: TADOCommandEh; MemRecord: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh; Parameter: TParameter);
var
  FIndex: Integer;
begin
  FIndex := MemRecord.DataStruct.FieldIndex(Parameter.Name);
  if FIndex >= 0 then
  begin
    { TODO : Check DataType as in TParam.AssignFieldValue }
    if Command.ParamCheck then
      Parameter.DataType := MemRecord.DataStruct[FIndex].DataType;
    Parameter.Value := MemRecord.DataValues[Parameter.Name, DataValueVersion];
  end
  else if (UpperCase(Copy(Parameter.Name,1, Length('OLD_'))) = 'OLD_') then
  begin
    FIndex := MemRecord.DataStruct.FieldIndex(Copy(Parameter.Name, 5, 255));
    if FIndex >= 0 then
    begin
      if Command.ParamCheck then
        Parameter.DataType := MemRecord.DataStruct[FIndex].DataType;
      Parameter.Value := MemRecord.DataValues[Copy(Parameter.Name, 5, 255), dvvOldestValue];
    end
  end;
end;

function TADODataDriverEh.ReadData(MemTableData: TMemTableDataEh;
  Count: Integer): Integer;
var
  Recordset: _Recordset;
  i,j: Integer;
  ar: Variant;
  {Cols, }Rows: Integer;
  Rec: TMemoryRecordEh;
  DataToRecFields: array of Integer;

  function RecordsetFieldIndex(AFieldName: String): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to Recordset.Fields.Count-1 do
      if AFieldName = Recordset.Fields.Item[i].Name then
      begin
        Result := i;
        Exit;
      end;
  end;
//  v: Variant;
begin
  Recordset := nil;
  if (ReaderDataSet is TCustomADODataSet) and
     (Count = -1) and
     not Assigned(OnReadRecord) and
     not Assigned(OnAssignFieldValue)
  then
    Recordset := TCustomADODataSet(ReaderDataSet).Recordset;
  if (Recordset <> nil) and not ProviderEOF then
  begin
    if ReaderDataSet.IsEmpty then
    begin
      Result := 0;
      ProviderEOF := True;
      Exit;
    end;

    ar := Recordset.GetRows(-1, EmptyParam, EmptyParam);

//    Cols := VarArrayHighBound(ar, 1);
    Rows := VarArrayHighBound(ar, 2);

    SetLength(DataToRecFields, MemTableData.DataStruct.Count);
    for i := 0 to MemTableData.DataStruct.Count-1 do
      DataToRecFields[i] := RecordsetFieldIndex(MemTableData.DataStruct[i].FieldName);

//    if Count = -1 then
//      MemTableData.RecordsList.BeginUpdate;
    try
    for i := 0 to Rows do
    begin
      Rec := MemTableData.RecordsList.NewRecord;
      for j := 0 to MemTableData.DataStruct.Count-1 do
      begin
        if DataToRecFields[j] >= 0 then
          Rec.Value[j, dvvValueEh] := ar[DataToRecFields[j], i];
//          Rec.Value[j, dvvValueEh] := VarArrayGet(ar,[DataToRecFields[j], i]);
//        v := ar[j, i];
      end;
      MemTableData.RecordsList.FetchRecord(Rec);
    end;
    finally
//      if Count = -1 then
//        MemTableData.RecordsList.EndUpdate; //No good as will force to rebuild data in DataView
    end;
    Result := Rows;
    ProviderEOF := True;
    ar := Null;
  end else
    Result := inherited ReadData(MemTableData, Count);
end;

function TADODataDriverEh.HaveDataConnection: Boolean;
begin
  if (Assigned(ADOConnection) and ADOConnection.Connected) or
     (ConnectionString <> '') or
     (ConnectionProvider <> nil)
    then Result := True
    else Result := inherited HaveDataConnection();
end;

procedure TADODataDriverEh.Loaded;
begin
  inherited Loaded;
{  ShowMessage('TADODataDriverEh.Loaded');
  if GetConnectionProvider = nil  then
    ShowMessage('TADODataDriverEh.Loaded, GetConnectionProvider = nil: ' + Name);
  if csFixups in ComponentState then
    ShowMessage('csFixups in ComponentState: ' + Name);

  if csLoading in ComponentState then Showmessage('csLoading');
  if csReading in ComponentState then showmessage('csReading');
  if csWriting in ComponentState then Showmessage('csWriting');
  if csDestroying in ComponentState then Showmessage('csDestroying');
  if csDesigning in ComponentState then Showmessage('csDesigning');
  if csAncestor in ComponentState then Showmessage('csAncestor');
  if csUpdating in ComponentState then Showmessage('csUpdating');
  if csFixups in ComponentState then Showmessage('csFixups');
  if csFreeNotification in ComponentState then Showmessage('csFreeNotification');
  if csInline in ComponentState then Showmessage('csInline');
  if csDesignInstance in ComponentState then Showmessage('csDesignInstance');
}
end;

procedure TADODataDriverEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent <> nil) then
  begin
    if FADOConnection = AComponent then
      FADOConnection := nil;
    if AComponent = ConnectionProvider then
      ConnectionProvider := nil;
  end;
end;

function TADODataDriverEh.GetDeleteCommand: TADOCommandEh;
begin
  Result := TADOCommandEh(inherited DeleteCommand);
end;

function TADODataDriverEh.GetGetrecCommand: TADOCommandEh;
begin
  Result := TADOCommandEh(inherited GetrecCommand);
end;

function TADODataDriverEh.GetInsertCommand: TADOCommandEh;
begin
  Result := TADOCommandEh(inherited InsertCommand);
end;

function TADODataDriverEh.GetOnExecuteCommand: TADODataDriverExecuteCommandEhEvent;
begin
  Result := TADODataDriverExecuteCommandEhEvent(inherited OnExecuteCommand)
end;

procedure TADODataDriverEh.SetOnExecuteCommand(const Value: TADODataDriverExecuteCommandEhEvent);
begin
  inherited OnExecuteCommand := TDataDriverExecuteCommandEhEvent(Value)
end;

function TADODataDriverEh.GetSelectCommand: TADOCommandEh;
begin
  Result := TADOCommandEh(inherited SelectCommand);
end;

function TADODataDriverEh.GetUpdateCommand: TADOCommandEh;
begin
  Result := TADOCommandEh(inherited UpdateCommand);
end;

procedure TADODataDriverEh.SetDeleteCommand(const Value: TADOCommandEh);
begin
  inherited DeleteCommand := Value;
end;

procedure TADODataDriverEh.SetGetrecCommand(const Value: TADOCommandEh);
begin
  inherited GetrecCommand := Value;
end;

procedure TADODataDriverEh.SetInsertCommand(const Value: TADOCommandEh);
begin
  inherited InsertCommand := Value;
end;

procedure TADODataDriverEh.SetSelectCommand(const Value: TADOCommandEh);
begin
  inherited SelectCommand := Value;
end;

procedure TADODataDriverEh.SetUpdateCommand(const Value: TADOCommandEh);
begin
  inherited UpdateCommand := Value;
end;

procedure TADOCommandEh.SetCommandTimeOut(const Value: Integer);
begin
  FCommandTimeOut := Value;
end;

{ TADOConnectionProviderEh }

constructor TADOConnectionProviderEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FInlineConnection := TADOInlineConnectionEh.Create(Self);
  if ADOConnectionProviderDesignService <> nil then
    FDesignDataBase := ADOConnectionProviderDesignService.CreateDesignDataBase(Self);
end;

function TADOConnectionProviderEh.CurrentTimeConnection: TADOConnection;
begin
  if UseInlineConnection
    then Result := InlineConnection.Connection
    else Result := Connection;
end;

destructor TADOConnectionProviderEh.Destroy;
begin
  FreeAndNil(FInlineConnection);
  FreeAndNil(FDesignDataBase);
  inherited Destroy;
end;

function TADOConnectionProviderEh.DefaultExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof, Processed: Boolean): Integer;
begin
  Result := inherited DefaultExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed);

  if not Processed then
  begin
    if {$IFDEF DESIGNTIME} (csDesigning in ComponentState) and {$ENDIF} InlineConnection.UseAtDesignTime then
    begin
      while True do
      begin
        if FInlineConnection.Connected then
          Break
        else
        begin
          if FInlineConnection.ConnectionString <> '' then
            try
              FInlineConnection.Connected := True;
              Break;
            except
              Application.HandleException(Self);
            end;
        end;

        if not FInlineConnection.Connected then
        begin
          if ADOConnectionProviderDesignService.EditDesignData(Self)
            then Continue
            else Break;
        end;
      end;
      if FInlineConnection.Connected then
      begin
        Result := DefaultExecuteADOCommandEh(SQLDataDriver, Command,
          Cursor, FreeOnEof, FInlineConnection.Connection, '');
        Processed := True;
      end;
    end else if not (csDesigning in ComponentState) and InlineConnection.UseAtRunTime then
    begin
      Result := DefaultExecuteADOCommandEh(SQLDataDriver, Command,
        Cursor, FreeOnEof, FInlineConnection.Connection, '');
      Processed := True;
    end else if Connection <> nil then
    begin
      Result := DefaultExecuteADOCommandEh(SQLDataDriver, Command,
        Cursor, FreeOnEof, Connection, '');
      Processed := True;
    end;
  end;
end;

function TADOConnectionProviderEh.GetPath: String;
begin
  if ADOConnectionProviderDesignService <> nil then
    Result := ADOConnectionProviderDesignService.GetConnectionSettingsFilePath(Self);
end;

function TADOConnectionProviderEh.UnmacrosConnectionString(
  MacrosedString: WideString): WideString;
begin
  Result := StringReplace(MacrosedString, '%PROJECT_PATH%', Path, [rfReplaceAll]);
end;

procedure TADOConnectionProviderEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FConnection = AComponent)
  then
    Connection := nil;
  if InlineConnection <> nil then
    InlineConnection.Notification(AComponent, Operation);
end;

procedure TADOConnectionProviderEh.SetConnection(const Value: TADOConnection);
begin
  if FConnection <> Value then
  begin
    FConnection := Value;
    if FConnection <> nil then
      FConnection.FreeNotification(Self);
  end;
end;

procedure TADOConnectionProviderEh.SetInlineConnection(
  const Value: TADOInlineConnectionEh);
begin
  FInlineConnection.Assign(Value);
end;

procedure TADOConnectionProviderEh.Loaded;
begin
  inherited Loaded;
  InlineConnection.Loaded;
end;

procedure TADOConnectionProviderEh.GetDataReaderForSQL(SQLText: String;
  AParams: TParams; var Cursor: TDataSet; var FreeOnEof, Processed: Boolean);
var
  ACur: TADOQuery;
begin
  Cursor := nil;
  FreeOnEof := False;
  ACur := nil;
  try
    ACur := TADOQuery.Create(nil);
    begin
      if UseInlineConnection
        then ACur.Connection := InlineConnection.Connection
        else ACur.Connection := Connection;
      ACur.SQL.Text := SQLText;   
      if AParams <> nil then
        ACur.Parameters.Assign(AParams);
      ACur.Open;
    end;
    if ACur.Active then
    begin
      Cursor := ACur;
      FreeOnEof := True;
      ACur := nil;
    end
  finally
    if ACur <> nil then
      ACur.Free;
  end;
  Processed := True;
end;

function TADOConnectionProviderEh.GetDesignDataBase: TComponent;
begin
  Result := FDesignDataBase;
end;

function TADOConnectionProviderEh.ConnectionIsPostponed: Boolean;
begin
//  ShowMessage('TADOConnectionProviderEh.ConnectionIsPostponed Starts');
  Result := UseInlineConnection and not InlineConnection.Connection.Connected;
{  if Result then
    ShowMessage('TADOConnectionProviderEh.ConnectionIsPostponed=True')
  else
    ShowMessage('TADOConnectionProviderEh.ConnectionIsPostponed=False');}
end;

function TADOConnectionProviderEh.UseInlineConnection: Boolean;
var
  CheckDesignTime: Boolean;
begin
  CheckDesignTime :=
    {$IFDEF DESIGNTIME} (csDesigning in ComponentState) {$ELSE} True {$ENDIF};
  if CheckDesignTime then
  begin
    if InlineConnection.UseAtDesignTime
      then Result := True
      else Result := False;
  end else
  begin
    if InlineConnection.UseAtRunTime
      then Result := True
      else Result := False;
  end;
end;

procedure TADOConnectionProviderEh.AddPostponedActivationDataSet(ADataSet: TDataSet);
begin
  InlineConnection.AddPostponedActivationDataSet(ADataSet);
end;

function TADOConnectionProviderEh.GetOnInlineConnectionBeginTransComplete: TBeginTransCompleteEvent;
begin
  Result := InlineConnection.Connection.OnBeginTransComplete;
end;

procedure TADOConnectionProviderEh.SetOnInlineConnectionBeginTransComplete(const Value: TBeginTransCompleteEvent);
begin
  InlineConnection.Connection.OnBeginTransComplete := Value;
end;

function TADOConnectionProviderEh.GetOnInlineConnectionCommitTransComplete: TConnectErrorEvent;
begin
  Result := InlineConnection.Connection.OnCommitTransComplete;
end;

procedure TADOConnectionProviderEh.SetOnInlineConnectionCommitTransComplete(const Value: TConnectErrorEvent);
begin
  InlineConnection.Connection.OnCommitTransComplete := Value;
end;

function TADOConnectionProviderEh.GetOnInlineConnectionConnectComplete: TConnectErrorEvent;
begin
  Result := InlineConnection.Connection.OnConnectComplete;
end;

procedure TADOConnectionProviderEh.SetOnInlineConnectionConnectComplete(const Value: TConnectErrorEvent);
begin
  InlineConnection.Connection.OnConnectComplete := Value;
end;

function TADOConnectionProviderEh.GetOnInlineConnectionDisconnect: TDisconnectEvent;
begin
  Result := InlineConnection.Connection.OnDisconnect;
end;

procedure TADOConnectionProviderEh.SetOnInlineConnectionDisconnect(const Value: TDisconnectEvent);
begin
  InlineConnection.Connection.OnDisconnect := Value;
end;

function TADOConnectionProviderEh.GetOnInlineConnectionExecuteComplete: TExecuteCompleteEvent;
begin
  Result := InlineConnection.Connection.OnExecuteComplete;
end;

procedure TADOConnectionProviderEh.SetOnInlineConnectionExecuteComplete(const Value: TExecuteCompleteEvent);
begin
  InlineConnection.Connection.OnExecuteComplete := Value;
end;

function TADOConnectionProviderEh.GetOnInlineConnectionInfoMessage: TInfoMessageEvent;
begin
  Result := InlineConnection.Connection.OnInfoMessage;
end;

procedure TADOConnectionProviderEh.SetOnInlineConnectionInfoMessage(
  const Value: TInfoMessageEvent);
begin
  InlineConnection.Connection.OnInfoMessage := Value;
end;

function TADOConnectionProviderEh.GetOnInlineConnectionRollbackTransComplete: TConnectErrorEvent;
begin
  Result := InlineConnection.Connection.OnRollbackTransComplete;
end;

procedure TADOConnectionProviderEh.SetOnInlineConnectionRollbackTransComplete(
  const Value: TConnectErrorEvent);
begin
  InlineConnection.Connection.OnRollbackTransComplete := Value;
end;

function TADOConnectionProviderEh.GetOnInlineConnectionWillConnect: TWillConnectEvent;
begin
  Result := InlineConnection.Connection.OnWillConnect;
end;

procedure TADOConnectionProviderEh.SetOnInlineConnectionWillConnect(
  const Value: TWillConnectEvent);
begin
  InlineConnection.Connection.OnWillConnect := Value;
end;

function TADOConnectionProviderEh.GetOnInlineConnectionWillExecute: TWillExecuteEvent;
begin
  Result := InlineConnection.Connection.OnWillExecute;
end;

procedure TADOConnectionProviderEh.SetOnInlineConnectionWillExecute(
  const Value: TWillExecuteEvent);
begin
  InlineConnection.Connection.OnWillExecute := Value;
end;

{ TADOInlineConnectionEh }

constructor TADOInlineConnectionEh.Create(AConnectionProvider: TADOConnectionProviderEh);
begin
  inherited Create(AConnectionProvider);
  FConnectionProvider := AConnectionProvider;
  FInlineConnection := TADOConnection.Create(nil);
  FInlineConnection.LoginPrompt := False;
  FInlineConnection.BeforeConnect := BeforeInlineConnection;
  FInlineConnection.AfterConnect := AfterInlineConnection;
  FPostponedDataSets := TList.Create;
end;

destructor TADOInlineConnectionEh.Destroy;
begin
  FreeAndNil(FInlineConnection);
  FreeAndNil(FPostponedDataSets);
  inherited Destroy;
end;

function TADOInlineConnectionEh.GetConnected: Boolean;
begin
  Result := FInlineConnection.Connected;
end;

procedure TADOInlineConnectionEh.SetDesignConnected(const Value: Boolean);
begin
  FInlineConnection.Connected := Value;
end;

function TADOInlineConnectionEh.GetInlineConnectionString: WideString;
begin
  Result := FInlineConnectionString;
end;

procedure TADOInlineConnectionEh.SetInlineConnectionString(const Value: WideString);
begin
  if Value <> FInlineConnectionString then
  begin
    FInlineConnection.Close;
    FInlineConnectionString := Value;
    FInlineConnection.ConnectionString := Value;
  end;
end;

procedure TADOInlineConnectionEh.BeforeInlineConnection(Sender: TObject);
begin
  FInlineConnection.ConnectionString := FConnectionProvider.UnmacrosConnectionString(FInlineConnectionString);
  if Assigned(ConnectionProvider.FInlineConnectionBeforeConnect) then
    ConnectionProvider.FInlineConnectionBeforeConnect(Self);
end;

procedure TADOInlineConnectionEh.AfterInlineConnection(Sender: TObject);
begin
  ActivatePostponedDataSets;  
  if Assigned(ConnectionProvider.FInlineConnectionAfterConnect) then
    ConnectionProvider.FInlineConnectionAfterConnect(Self);
end;

function TADODataDriverEh.GetConnectionProvider: IConnectionProviderEh;
begin
  Supports(FConnectionProvider, IConnectionProviderEh, Result);
  if Result = nil then
    Supports(ADOConnection, IConnectionProviderEh, Result);
//  Result := FConnectionProvider;
end;

procedure TADOInlineConnectionEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
// TO DO
end;

function TADOInlineConnectionEh.GetAttributes: TXactAttributes;
begin
  Result := FInlineConnection.Attributes;
end;

function TADOInlineConnectionEh.GetCommandTimeout: Integer;
begin
  Result := FInlineConnection.CommandTimeout;
end;

function TADOInlineConnectionEh.GetConnectionTimeout: Integer;
begin
  Result := FInlineConnection.ConnectionTimeout;
end;

function TADOInlineConnectionEh.GetCursorLocation: TCursorLocation;
begin
  Result := FInlineConnection.CursorLocation;
end;

function TADOInlineConnectionEh.GetDefaultDatabase: WideString;
begin
  Result := FInlineConnection.DefaultDatabase;
end;

function TADOInlineConnectionEh.GetIsolationLevel: TIsolationLevel;
begin
  Result := FInlineConnection.IsolationLevel;
end;

function TADOInlineConnectionEh.GetKeepConnection: Boolean;
begin
  Result := FInlineConnection.KeepConnection;
end;

function TADOInlineConnectionEh.GetLoginPrompt: Boolean;
begin
  Result := FInlineConnection.LoginPrompt;
end;

function TADOInlineConnectionEh.GetMode: TConnectMode;
begin
  Result := FInlineConnection.Mode;
end;

function TADOInlineConnectionEh.GetProvider: WideString;
begin
  Result := FInlineConnection.Provider;
end;

function TADOInlineConnectionEh.IsDefaultDatabaseStored: Boolean;
begin
  Result := FInlineConnection.DefaultDatabase <> '';
end;

function TADOInlineConnectionEh.IsProviderStored: Boolean;
begin
  if FInlineConnection.Connected
    then Result := FInlineConnection.Provider <> 'MSDASQL.1'
    else Result := FInlineConnection.Provider <> 'MSDASQL';
end;

procedure TADOInlineConnectionEh.SetAttributes(const Value: TXactAttributes);
begin
  FInlineConnection.Attributes := Value;
end;

procedure TADOInlineConnectionEh.SetCommandTimeout(const Value: Integer);
begin
  FInlineConnection.CommandTimeout := Value;
end;

procedure TADOInlineConnectionEh.SetConnectionTimeout(const Value: Integer);
begin
  FInlineConnection.ConnectionTimeout := Value;
end;

procedure TADOInlineConnectionEh.SetConnectOptions(const Value: TConnectOption);
begin
  FConnectOptions := Value;
end;

procedure TADOInlineConnectionEh.SetCursorLocation(const Value: TCursorLocation);
begin
  FInlineConnection.CursorLocation := Value;
end;

procedure TADOInlineConnectionEh.SetDefaultDatabase(const Value: WideString);
begin
  FInlineConnection.DefaultDatabase := Value;
end;

procedure TADOInlineConnectionEh.SetIsolationLevel(const Value: TIsolationLevel);
begin
  FInlineConnection.IsolationLevel := Value;
end;

procedure TADOInlineConnectionEh.SetKeepConnection(const Value: Boolean);
begin
  FInlineConnection.KeepConnection := Value;
end;

procedure TADOInlineConnectionEh.SetLoginPrompt(const Value: Boolean);
begin
  FInlineConnection.LoginPrompt := Value;
end;

procedure TADOInlineConnectionEh.SetMode(const Value: TConnectMode);
begin
  FInlineConnection.Mode := Value;
end;

procedure TADOInlineConnectionEh.SetProvider(const Value: WideString);
begin
  FInlineConnection.Provider := Value;
end;

//UseAtRunTime
function TADOInlineConnectionEh.GetUseAtRunTime: Boolean;
begin
  if IsUseAtRunTimeStored
    then Result := FUseAtRunTime
    else Result := DefaultUseAtRunTime;
end;

procedure TADOInlineConnectionEh.SetUseAtRunTime(const Value: Boolean);
begin
  if IsUseAtRunTimeStored and (Value = FUseAtRunTime) then Exit;
  UseAtRunTimeStored := True;
  FUseAtRunTime := Value;
end;

function TADOInlineConnectionEh.IsUseAtRunTimeStored: Boolean;
begin
  Result := FUseAtRunTimeStored;
end;

procedure TADOInlineConnectionEh.SetUseAtRunTimeStored(const Value: Boolean);
begin
  if (Value = True) and (IsUseAtRunTimeStored = False) then
  begin
    FUseAtRunTimeStored := True;
    FUseAtRunTime := DefaultUseAtRunTime;
  end else if (Value = False) and (IsUseAtRunTimeStored = True) then
  begin
    FUseAtRunTimeStored := False;
    FUseAtRunTime := DefaultUseAtRunTime;
  end;
end;

function TADOInlineConnectionEh.DefaultUseAtRunTime: Boolean;
begin
  Result := (FConnectionProvider.Connection = nil) and (ConnectionString <> '');
end;


//UseAtDesignTime
function TADOInlineConnectionEh.GetUseAtDesignTime: Boolean;
begin
  if IsUseAtDesignTimeStored
    then Result := FUseAtDesignTime
    else Result := DefaultUseAtDesignTime;
end;

procedure TADOInlineConnectionEh.SetUseAtDesignTime(const Value: Boolean);
begin
  if IsUseAtDesignTimeStored and (Value = FUseAtDesignTime) then Exit;
  UseAtDesignTimeStored := True;
  FUseAtDesignTime := Value;
end;

function TADOInlineConnectionEh.IsUseAtDesignTimeStored: Boolean;
begin
  Result := FUseAtDesignTimeStored;
end;

procedure TADOInlineConnectionEh.SetUseAtDesignTimeStored(const Value: Boolean);
begin
  if (Value = True) and (IsUseAtDesignTimeStored = False) then
  begin
    FUseAtDesignTimeStored := True;
    FUseAtDesignTime := DefaultUseAtRunTime;
  end else if (Value = False) and (IsUseAtDesignTimeStored = True) then
  begin
    FUseAtDesignTimeStored := False;
    FUseAtDesignTime := DefaultUseAtRunTime;
  end;
end;

function TADOInlineConnectionEh.DefaultUseAtDesignTime: Boolean;
begin
  Result := ConnectionString <> '';
end;


procedure TADOInlineConnectionEh.ActivatePostponedDataSets;
var
  i: Integer;
begin
  for i := 0 to FPostponedDataSets.Count-1 do
    TDataSet(FPostponedDataSets[i]).Open;
  FPostponedDataSets.Clear;
end;

procedure TADOInlineConnectionEh.AddPostponedActivationDataSet(ADataSet: TDataSet);
begin
  if FPostponedDataSets.IndexOf(ADataSet) = -1 then
  begin
    FPostponedDataSets.Add(ADataSet);
    ADataSet.FreeNotification(ConnectionProvider);
  end;
end;

procedure TADOInlineConnectionEh.Notification(AComponent: TComponent; Operation: TOperation);
var
  idx: Integer;
begin
  if Operation <> opRemove then Exit;
  idx := FPostponedDataSets.IndexOf(AComponent);
  if idx >= 0 then
    FPostponedDataSets.Delete(idx);
end;

{ TNiADODataDriverEh }

constructor TNiADODataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSideParentable := True;
end;

end.
