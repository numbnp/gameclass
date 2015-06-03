{*******************************************************}
{                                                       }
{                     EhLib v7.0                        }
{                                                       }
{           TDataDriverEh, TSQLDataDriverEh             }
{                components (Build 7.0.10)              }
{                                                       }
{     Copyright (c) 2003-14 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit DataDriverEh;

{$I EHLIB.INC}

interface

uses SysUtils, Classes, Controls, DB, Windows, Forms,
//  DBCommon,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
{$IFDEF FPC}
  EhLibLCL, LCLType, Win32Extra,
{$ELSE}
  EhLibVCL, Messages, Contnrs,
{$ENDIF}
{$ENDIF}
  ToolCtrlsEh, DynVarsEh, MemTableDataEh;
type


  TDataDriverEh = class;
  TConnectionProviderEh = class;
  TMacroVarsEh = class;
  TCustomSQLDataDriverEh = class;
  TCustomSQLCommandEh = class;

  TUpdateErrorActionEh = (ueaBreakAbortEh, ueaBreakRaiseEh, ueaCountinueEh, ueaRetryEh, ueaCountinueSkip);

  TFieldTypesEh = set of TFieldType;

  TDataDriverProduceDataReaderEhEvent = procedure (DataDriver: TDataDriverEh; var DataReader: TDataSet; var FreeOnEof: Boolean) of object;
  TDataDriverBuildDataStructEhEvent = procedure (DataDriver: TDataDriverEh; DataStruct: TMTDataStructEh) of object;
  TDataDriverReadRecordEhEvent = procedure (DataDriver: TDataDriverEh; MemTableData: TMemTableDataEh;
    MemRec: TMemoryRecordEh; var ProviderEOF: Boolean) of object;
  TDataDriverUpdateErrorEhEvent = procedure (DataDriver: TDataDriverEh; MemTableData: TMemTableDataEh;
    MemRec: TMemoryRecordEh; var Action: TUpdateErrorActionEh) of object;
  TDataDriverRecordEhEvent = procedure (DataDriver: TDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh) of object;
  TDataDriverAssignFieldValueEhEvent = procedure (DataDriver: TDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
    DataFieldIndex: Integer; DataValueVersion: TDataValueVersionEh; ReaderDataSet: TDataSet) of object;

// TProviderOption = (poFetchBlobsOnDemand, poFetchDetailsOnDemand, poIncFieldProps,
//                    poCascadeDeletes, poCascadeUpdates, poReadOnly, poAllowMultiRecordUpdates,
//                    poDisableInserts, poDisableEdits, poDisableDeletes, poNoReset,
//                    poAutoRefresh, poPropogateChanges, poAllowCommandText, poRetainServerOrder);

// TDataDriverOptionEh = (ddoAutoRefresh, ddoUpdatesInTransactionEh);

  IDataDriverConsumerEh = interface
    ['{E390BBF2-666F-43D7-8CC8-1FA2BA8263D1}']
    procedure SetDataDriverConsumer(AObject: TObject);
    function GetDataDriverConsumer: TObject;
    property DataDriverConsumer: TObject read GetDataDriverConsumer write SetDataDriverConsumer;
  end;

{ IConnectionProviderEh }

  IConnectionProviderEh = interface
  ['{C5744985-A67B-4786-9165-DB99A7CA4831}']
    function ExecuteCommand(SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer;
    procedure GetDataReaderForSQL(SQLText: String; AParams: TParams; var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean);
    procedure FillMemTableForSQL(SQLText: String; AParams: TParams; MemTableData: TMemTableDataEh; var Processed: Boolean);
    function ExecuteSQL(SQLText: String; AParams: TParams; var Processed: Boolean): Integer;
    procedure UpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh; var Processed: Boolean);
    procedure GetBackUpdatedValues(SQLDataDriver: TCustomSQLDataDriverEh; MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean);
    procedure AddPostponedActivationDataSet(ADataSet: TDataSet);
    function ConnectionIsPostponed: Boolean;
    function GetDesignDataBase: TComponent;
  end;

{ TDataDriverEh }

  TDataDriverEh = class(TComponent, ISideOwnedComponentEh, IDataDriverConsumerEh{$IFNDEF CIL}, IUnknown{$ENDIF})
  private
    FKeyFields: String;
    FOnAssignFieldValue: TDataDriverAssignFieldValueEhEvent;
    FOnBuildDataStruct: TDataDriverBuildDataStructEhEvent;
    FOnProduceDataReader: TDataDriverProduceDataReaderEhEvent;
    FOnReadRecord: TDataDriverReadRecordEhEvent;
    FOnRefreshRecord: TDataDriverRecordEhEvent;
    FOnUpdateError: TDataDriverUpdateErrorEhEvent;
    FOnUpdateRecord: TDataDriverRecordEhEvent;
    FProviderDataSet: TDataSet;
    FProviderEOF: Boolean;
    FReaderDataSet: TDataSet;
    FReaderDataSetFreeOnEof: Boolean;
    FResolveToDataSet: Boolean;
    FDataDriverConsumer: TObject;
    FSideParent: TComponent;
    FSideParentName: String;
    procedure SetKeyFields(const Value: String);
    procedure SetProviderDataSet(const Value: TDataSet);
    procedure SetProviderEOF(const Value: Boolean);

    procedure ReadSideParent(Reader: TReader);
    procedure WriteSideParent(Writer: TWriter);
    function IsSideParentStored: Boolean;
  protected
    FDataToRecFields: array of Integer;
    FSideParentable: Boolean;
    function GetDataDriverConsumer: TObject;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh); virtual;
    procedure SetDataDriverConsumer(ADataDriverConsumer: TObject);
    procedure ResetDataToRecFields(DataStruct: TMTDataStructEh; DataSet: TDataSet);
    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;
    function IsSideParentedBy(AComponent: TComponent): Boolean; virtual;
    procedure SetSideParent(AComponent: TComponent); virtual;

    property KeyFields: String read FKeyFields write SetKeyFields;
    property ProviderDataSet: TDataSet read FProviderDataSet write SetProviderDataSet;
    property ReaderDataSet: TDataSet read FReaderDataSet;
    property SideParent: TComponent read FSideParent stored False;
  public
    function ConnectionIsPostponed: Boolean; virtual;
    procedure AddPostponedActivationDataSet(ADataSet: TDataSet); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function ApplyUpdates(MemTableData: TMemTableDataEh): Integer; virtual;
    function DefaultUpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; virtual;
    function GetDataReader: TDataSet; virtual;
    function ReadData(MemTableData: TMemTableDataEh; Count: Integer): Integer; virtual;
    function RefreshReaderParamsFromCursor(DataSet: TDataSet): Boolean; virtual;
    procedure AssignFieldValue(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
      DataFieldIndex: Integer; DataValueVersion: TDataValueVersionEh; ReaderDataSet: TDataSet); virtual;
    procedure UpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh); virtual;
    procedure ConsumerClosed(ConsumerDataSet: TDataSet); virtual;
    procedure DefaultAssignFieldValue(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh;
      DataFieldIndex: Integer; DataValueVersion: TDataValueVersionEh; ReaderDataSet: TDataSet); virtual;
    procedure DefaultBuildDataStruct(DataStruct: TMTDataStructEh); virtual;
    procedure DefaultProduceDataReader(var DataSet: TDataSet; var FreeOnEof: Boolean); virtual;
    procedure DefaultReadRecord(MemTableData: TMemTableDataEh; Rec: TMemoryRecordEh; var ProviderEOF: Boolean); virtual;
    procedure DefaultUpdateError(MemTableData: TMemTableDataEh;
      MemRec: TMemoryRecordEh; var Action: TUpdateErrorActionEh); virtual;
    procedure DefaultRefreshRecord(MemRecord: TMemoryRecordEh); virtual;
    procedure BuildDataStruct(DataStruct: TMTDataStructEh); virtual;
    procedure RefreshRecord(MemRecord: TMemoryRecordEh); virtual;
    procedure RefreshReader; virtual;
    procedure SetReaderParamsFromCursor(DataSet: TDataSet); virtual;
    property ProviderEOF: Boolean read FProviderEOF write SetProviderEOF;
    property ResolveToDataSet: Boolean read FResolveToDataSet write FResolveToDataSet default True;
    property OnBuildDataStruct: TDataDriverBuildDataStructEhEvent read FOnBuildDataStruct write FOnBuildDataStruct;
    property OnProduceDataReader: TDataDriverProduceDataReaderEhEvent read FOnProduceDataReader write FOnProduceDataReader;
    property OnAssignFieldValue: TDataDriverAssignFieldValueEhEvent read FOnAssignFieldValue write FOnAssignFieldValue;
    property OnReadRecord: TDataDriverReadRecordEhEvent read FOnReadRecord write FOnReadRecord;
    property OnRefreshRecord: TDataDriverRecordEhEvent read  FOnRefreshRecord write FOnRefreshRecord;
    property OnUpdateRecord: TDataDriverRecordEhEvent read  FOnUpdateRecord write FOnUpdateRecord;
    property OnUpdateError: TDataDriverUpdateErrorEhEvent read  FOnUpdateError write FOnUpdateError;
  end;

  TDataSetDriverEh = class(TDataDriverEh)
  published
    property KeyFields;
    property ProviderDataSet;
    property OnBuildDataStruct;
    property OnProduceDataReader;
    property OnAssignFieldValue;
    property OnReadRecord;
    property OnRefreshRecord;
    property OnUpdateRecord;
    property OnUpdateError;
    property ResolveToDataSet;
  end;

  TServerSpecOperationsEh = class;

{ TDynaSQLParamsEh }

  TDynaSQLOptionEh = ( dsoDynamicSQLInsertEh, dsoDynamicSQLUpdateEh, dsoDynamicSQLDeleteEh);
  TDynaSQLOptionsEh = set of TDynaSQLOptionEh;

  TDynaSQLParamsEh = class(TPersistent)
  private
    FDataDriver: TCustomSQLDataDriverEh;
    FUpdateTable: String;
    FUpdateFields: String;
    FKeyFields: String;
    FSkipUnchangedFields: Boolean;
    FOptions: TDynaSQLOptionsEh;
    procedure SetKeyFields(const Value: String);
    procedure SetUpdateFields(const Value: String);
    procedure SetUpdateTable(const Value: String);
  public
    constructor Create(ADataDriver: TCustomSQLDataDriverEh);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property DataDriver: TCustomSQLDataDriverEh read FDataDriver;
  published
    property KeyFields: String read FKeyFields write SetKeyFields;
    property UpdateFields: String read FUpdateFields write SetUpdateFields;
    property UpdateTable: String read FUpdateTable write SetUpdateTable;
    property SkipUnchangedFields: Boolean read FSkipUnchangedFields write FSkipUnchangedFields default False;
    property Options: TDynaSQLOptionsEh read FOptions write FOptions;
  end;

{ TSpecMacrosEh }

  TSpecMacrosEh = class(TPersistent)
  private
    FFilterMacroName: String;
    FSortOrderMacroName: String;
    FSortOrderMacroValue: String;
    FFilterMacroValue: String;
    FMacroVars: TMacroVarsEh;
    function IsFilterMacroNameStored: Boolean;
    function IsSortOrderMacroNameStored: Boolean;
    procedure SetFilterMacroValue(const Value: String);
    procedure SetSortOrderMacroValue(const Value: String);
  public
    constructor Create(AMacroVars: TMacroVarsEh);
    procedure Assign(Source: TPersistent); override;
	  property FilterMacroValue: String read FFilterMacroValue write SetFilterMacroValue;
	  property SortOrderMacroValue: String read FSortOrderMacroValue write SetSortOrderMacroValue;
  published
	  property FilterMacroName: String read FFilterMacroName write FFilterMacroName stored IsFilterMacroNameStored;
	  property SortOrderMacroName: String read FSortOrderMacroName write FSortOrderMacroName stored IsSortOrderMacroNameStored;
  end;

{ TMacroVarsEh }
  TSpecMacrosUsageEh = (smuUseFilterMacroEh, smuFilterAsWhereClauseEh, smuFilterWithANDPrecedingEh,
    smuUseSortOrderMacroEh, smuSortOrderAsOrderByClauseEh, smuSortOrderWithCommaPrecedingEh);
  TSpecMacrosUsagesEh = set of TSpecMacrosUsageEh;

  TMacroVarsEh = class(TPersistent)
  private
    FDataDriver: TCustomSQLDataDriverEh;
    FMacros: TStringVarsEh;
    FSpecMacrosUsages: TSpecMacrosUsagesEh;
    FSpecMacros: TSpecMacrosEh;
    procedure SetMacros(const Value: TStringVarsEh);
    procedure SetSpecMacrosUsages(const Value: TSpecMacrosUsagesEh);
    procedure SetSpecMacros(const Value: TSpecMacrosEh);
  protected
    procedure MacrosChanged(Sender: TObject); virtual;
  public
    constructor Create(ADataDriver: TCustomSQLDataDriverEh);
    destructor Destroy; override;
    function SubstituteMacro(Text, MacroName, MacroValue: String): String;
    procedure Assign(Source: TPersistent); override;
    procedure ScanStrForMacros(SrcStr: String; var sl: TStringList);
    procedure ScanAllForMacros(var sl: TStringList);
    property DataDriver: TCustomSQLDataDriverEh read FDataDriver;
  published
    property SpecMacros: TSpecMacrosEh read FSpecMacros write SetSpecMacros;
    property SpecMacrosUsages: TSpecMacrosUsagesEh read FSpecMacrosUsages write SetSpecMacrosUsages default [smuFilterAsWhereClauseEh, smuSortOrderAsOrderByClauseEh];
    property Macros: TStringVarsEh read FMacros write SetMacros;
  end;

{ TCustomSQLCommandEh }

  TSQLCommandTypeEh = (cthSelectQuery, cthUpdateQuery, cthTable, cthStoredProc);
  TSQLExecuteEhEvent = function (var Cursor: TDataSet; var FreeOnEof: Boolean) : Integer of object;
  TAssignParamEhEvent = procedure (Command: TCustomSQLCommandEh;
    MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Param: TParam) of object;

  TCustomSQLCommandEh = class(TPersistent)
  private
    FCommandText: TStrings;
    FCommandType: TSQLCommandTypeEh;
    FDataDriver: TCustomSQLDataDriverEh;
    FFinalCommandText: TStrings;
    function IsCommandTypeStored: Boolean;
    function GetFinalCommandText: TStrings;
  protected
    FFinalCommandTextObsolete: Boolean;
    function DefaultCommandType: TSQLCommandTypeEh; virtual;
    function GetCommandText: TStrings; virtual;
    function GetCommandType: TSQLCommandTypeEh; virtual;
    function GetOwner: TPersistent; override;
    procedure CommandTextChanged(Sender: TObject); virtual;
    procedure CommandTypeChanged; virtual;
    procedure SetCommandText(const Value: TStrings); virtual;
    procedure SetCommandType(const Value: TSQLCommandTypeEh); virtual;
  public
    constructor Create(ADataDriver: TCustomSQLDataDriverEh);
    destructor Destroy; override;
    function Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; virtual;
    function GetNamePath: String; override;
    function GetParams: TParams; virtual;

    procedure Assign(Source: TPersistent); override;
    procedure FinalCommandTextObsolete;
    procedure FormFinalCommandText; virtual;
    procedure RefreshParams(MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh); virtual;
    procedure RebuildParams; virtual;
    procedure SetParams(AParams: TParams); virtual;
    property CommandText: TStrings read GetCommandText write SetCommandText;
    property CommandType: TSQLCommandTypeEh read GetCommandType write SetCommandType stored IsCommandTypeStored;
    property DataDriver: TCustomSQLDataDriverEh read FDataDriver;
    property FinalCommandText: TStrings read GetFinalCommandText;
  end;

{ TCustomSQLDataDriverEh }

{$IFNDEF EH_LIB_6}
  IInterface = IUnknown;
{$ENDIF}

  TDataDriverExecuteCommandEhEvent = function (DataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer of object;
  TDataDriverGetBackUpdatedValuesEhEvent = procedure (DataDriver: TCustomSQLDataDriverEh;
    MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet) of object;

  TCustomSQLDataDriverEh = class(TDataDriverEh)
  private
    FDeleteCommand: TCustomSQLCommandEh;
    FDesignDataBase: TComponent;
    FGetrecCommand: TCustomSQLCommandEh;
    FInsertCommand: TCustomSQLCommandEh;
    FOnExecuteCommand: TDataDriverExecuteCommandEhEvent;
    FOnGetBackUpdatedValues: TDataDriverGetBackUpdatedValuesEhEvent;
    FSelectCommand: TCustomSQLCommandEh;
    FSpecParams: TStrings;
    FUpdateCommand: TCustomSQLCommandEh;
    FServiceCommand: TCustomSQLCommandEh;
    FServerSpecOperations: TServerSpecOperationsEh;
    FDynaSQLParams: TDynaSQLParamsEh;
    FMacroVars: TMacroVarsEh;
    function GetDeleteSQL: TStrings;
    function GetFinalDeleteSQL: TStrings;
    function GetFinalGetrecSQL: TStrings;
    function GetFinalInsertSQL: TStrings;
    function GetFinalSelectSQL: TStrings;
    function GetFinalUpdateSQL: TStrings;
    function GetGetrecSQL: TStrings;
    function GetInsertSQL: TStrings;
    function GetSelectSQL: TStrings;
    function GetUpdateSQL: TStrings;
    procedure SetDeleteCommand(const Value: TCustomSQLCommandEh);
    procedure SetDeleteSQL(const Value: TStrings);
    procedure SetDynaSQLParams(const Value: TDynaSQLParamsEh);
    procedure SetGetrecCommand(const Value: TCustomSQLCommandEh);
    procedure SetGetrecSQL(const Value: TStrings);
    procedure SetInsertCommand(const Value: TCustomSQLCommandEh);
    procedure SetInsertSQL(const Value: TStrings);
    procedure SetMacroVars(const Value: TMacroVarsEh);
    procedure SetSelectCommand(const Value: TCustomSQLCommandEh);
    procedure SetSelectSQL(const Value: TStrings);
    procedure SetServerSpecOperations(const Value: TServerSpecOperationsEh);
    procedure SetServiceCommand(const Value: TCustomSQLCommandEh);
    procedure SetSpecParams(const Value: TStrings);
    procedure SetUpdateCommand(const Value: TCustomSQLCommandEh);
    procedure SetUpdateSQL(const Value: TStrings);
  protected
    procedure SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh); override;
    procedure SetDesignDataBase(const Value: TComponent); virtual;
    procedure Loaded; override;
    procedure MacrosChanged; virtual;
  public
    {DesignTime stuff}
    function CreateDesignCopy: TCustomSQLDataDriverEh; virtual;
    function CreateDesignDataBase: TComponent; virtual;
    function ForceGetNewDesignDataBase: TComponent; virtual;
    function GetDesignDataBase: TComponent; virtual;
    procedure AssignFromDesignDriver(DesignDataDriver: TCustomSQLDataDriverEh); virtual;
    property DesignDataBase: TComponent read GetDesignDataBase write SetDesignDataBase;
  protected
    function CreateCommand: TCustomSQLCommandEh; virtual;
    function CreateDeleteCommand: TCustomSQLCommandEh; virtual;
    function CreateInsertCommand: TCustomSQLCommandEh; virtual;
    function CreateSelectCommand: TCustomSQLCommandEh; virtual;
    function CreateGetrecCommand: TCustomSQLCommandEh; virtual;
    function CreateUpdateCommand: TCustomSQLCommandEh; virtual;
    function GetDefaultCommandTypeFor(Command: TCustomSQLCommandEh): TSQLCommandTypeEh; virtual;
    function CheckAddFieldInDynaSQL(UpdateStatus: TUpdateStatus; FieldName: String): Boolean; virtual;
    procedure CommandTextChanged(Sender: TCustomSQLCommandEh); virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure UpdateServerService; virtual;
    property ServiceCommand: TCustomSQLCommandEh read FServiceCommand write SetServiceCommand;
  public
    function InternalGetServerSpecOperations: TServerSpecOperationsEh; virtual;
    function ConnectionIsPostponed: Boolean; override;
    procedure AddPostponedActivationDataSet(ADataSet: TDataSet); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function DefaultUpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; override;
    function DoUpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; virtual;
    function ExecuteCommand(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; virtual;
    function DefaultExecuteCommand(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; virtual;
    function RefreshReaderParamsFromCursor(DataSet: TDataSet): Boolean; override;
    function HaveDataConnection(): Boolean; virtual;
    function GetConnectionProvider: IConnectionProviderEh; virtual;
    function OrderByTextSupported: Boolean; virtual;
    function FilterTextSupported: Boolean; virtual;
    procedure ApplyOrderByText(OrderByText: String); virtual;
    procedure ApplyFilterText(FilterText: String); virtual;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;
    procedure DefaultBuildDataStruct(DataStruct: TMTDataStructEh); override;
    procedure DefaultGetUpdatedServerValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;
    procedure DefaultProduceDataReader(var DataSet: TDataSet; var FreeOnEof: Boolean); override;
    procedure DefaultRefreshRecord(MemRecord: TMemoryRecordEh); override;
    procedure GenerateDynamicSQLCommand(MemRecord: TMemoryRecordEh; Command: TCustomSQLCommandEh); virtual;
    procedure SetReaderParamsFromCursor(DataSet: TDataSet); override;
    property DynaSQLParams: TDynaSQLParamsEh read FDynaSQLParams write SetDynaSQLParams;
    property MacroVars: TMacroVarsEh read FMacroVars write SetMacroVars;
    property ResolveToDataSet default False;

    property DeleteCommand: TCustomSQLCommandEh read FDeleteCommand write SetDeleteCommand;
    property DeleteSQL: TStrings read GetDeleteSQL write SetDeleteSQL stored False;
    property FinalDeleteSQL: TStrings read GetFinalDeleteSQL stored False;

    property GetrecCommand: TCustomSQLCommandEh read FGetrecCommand write SetGetrecCommand;
    property GetrecSQL: TStrings read GetGetrecSQL write SetGetrecSQL stored False;
    property FinalGetrecSQL: TStrings read GetFinalGetrecSQL stored False;

    property InsertCommand: TCustomSQLCommandEh read FInsertCommand write SetInsertCommand;
    property InsertSQL: TStrings read GetInsertSQL write SetInsertSQL stored False;
    property FinalInsertSQL: TStrings read GetFinalInsertSQL stored False;

    property SelectCommand: TCustomSQLCommandEh read FSelectCommand write SetSelectCommand;
    property SelectSQL: TStrings read GetSelectSQL write SetSelectSQL stored False;
    property FinalSelectSQL: TStrings read GetFinalSelectSQL stored False;

    property ServerSpecOperations: TServerSpecOperationsEh read FServerSpecOperations write SetServerSpecOperations;
    property SpecParams: TStrings read FSpecParams write SetSpecParams;

    property UpdateCommand: TCustomSQLCommandEh read FUpdateCommand write SetUpdateCommand;
    property UpdateSQL: TStrings read GetUpdateSQL write SetUpdateSQL stored False;
    property FinalUpdateSQL: TStrings read GetFinalUpdateSQL stored False;

    property OnExecuteCommand: TDataDriverExecuteCommandEhEvent read FOnExecuteCommand write FOnExecuteCommand;
    property OnGetBackUpdatedValues: TDataDriverGetBackUpdatedValuesEhEvent read FOnGetBackUpdatedValues write FOnGetBackUpdatedValues;
  end;

{ TServerSpecOperationsEh }

  TServerSpecOperationsEh = class(TObject)
  private
  protected
    procedure GenWhereClause(KeyFields: String; SQL: TStrings); virtual;
    procedure BuildChangedFieldList(MemRec: TMemoryRecordEh; UpdateFieldList, ChangedFieldList: TStringList); virtual;
  public
    constructor Create; virtual;
    class function GetServerTypeName: String; virtual;
    function UpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; virtual;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); virtual;
    procedure GenerateDynaSQLCommand(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh); virtual;
    procedure GenerateDeleteCommand(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh); virtual;
    procedure GenerateUpdateCommand(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh); virtual;
    procedure GenerateInsertCommand(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh); virtual;
  end;

  TServerSpecOperationsEhClass = class of TServerSpecOperationsEh;

{ TSQLDataDriverResolver }

  TResolverExecuteCommandEhEvent = function (SQLDataDriver: TCustomSQLDataDriverEh;
    Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean;
    var Processed: Boolean): Integer of object;

  TResolverGetBackUpdatedValuesEhEvent = procedure (SQLDataDriver: TCustomSQLDataDriverEh;
   MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet;
   var Processed: Boolean) of object;
  TResolverGetServerSpecOperationsEh = procedure (var Processed: Boolean;
    var ServerSpecOperations: TServerSpecOperationsEh) of object;
  TResolverUpdateRecordEhEvent = procedure (SQLDataDriver: TCustomSQLDataDriverEh;
      MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh; var Processed: Boolean) of object;

  TSQLDataDriverResolver = class(TPersistent)
  private
    FServerSpecOperations: TServerSpecOperationsEh;
    FOnExecuteCommand: TResolverExecuteCommandEhEvent;
    FOnGetBackUpdatedValues: TResolverGetBackUpdatedValuesEhEvent;
    FOnGetServerSpecOperations: TResolverGetServerSpecOperationsEh;
    FOnUpdateRecord: TResolverUpdateRecordEhEvent;
  public
    function ExecuteCommand(SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
      var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer; virtual;
    function GetServerSpecOperations(var Processed: Boolean): TServerSpecOperationsEh; virtual;
    procedure UpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh;
      MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh; var Processed: Boolean); virtual;
    procedure DefaultUpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh;
      MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh; var Processed: Boolean); virtual;
    procedure GetBackUpdatedValues(SQLDataDriver: TCustomSQLDataDriverEh; MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean); virtual;
    procedure DefaultGetUpdatedServerValues(SQLDataDriver: TCustomSQLDataDriverEh; MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean); virtual;
    property ServerSpecOperations: TServerSpecOperationsEh read FServerSpecOperations write FServerSpecOperations;
    property OnExecuteCommand: TResolverExecuteCommandEhEvent read FOnExecuteCommand write FOnExecuteCommand;
    property OnGetBackUpdatedValues: TResolverGetBackUpdatedValuesEhEvent read FOnGetBackUpdatedValues write FOnGetBackUpdatedValues;
    property OnGetServerSpecOperations: TResolverGetServerSpecOperationsEh read FOnGetServerSpecOperations write FOnGetServerSpecOperations;
    property OnUpdateRecord: TResolverUpdateRecordEhEvent read FOnUpdateRecord write FOnUpdateRecord;
  end;

  TBaseSQLCommandEh = class;
  TBaseSQLDataDriverEh = class;

  TSQLDataDriverExecuteCommandEhEvent = function (DataDriver: TBaseSQLDataDriverEh;
    Command: TBaseSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer of object;
  TSQLDataDriverAssignParamEhEvent = procedure (DataDriver: TBaseSQLDataDriverEh;
    Command: TBaseSQLCommandEh; MemRecord: TMemoryRecordEh;
    DataValueVersion: TDataValueVersionEh; Param: TParam) of object;
  TSQLDataDriverGetBackUpdatedValuesEhEvent = procedure (DataDriver: TBaseSQLDataDriverEh;
    MemRec: TMemoryRecordEh; Command: TBaseSQLCommandEh; ResDataSet: TDataSet) of object;

{ TBaseSQLDataDriverEh }

  TBaseSQLDataDriverEh = class(TCustomSQLDataDriverEh)
  private
    FOnAssignCommandParam: TSQLDataDriverAssignParamEhEvent;
    FOnGetBackUpdatedValues: TSQLDataDriverGetBackUpdatedValuesEhEvent;
    function GetDeleteCommand: TBaseSQLCommandEh;
    function GetInsertCommand: TBaseSQLCommandEh;
    function GetSelectCommand: TBaseSQLCommandEh;
    function GetGetrecCommand: TBaseSQLCommandEh;
    function GetUpdateCommand: TBaseSQLCommandEh;
    procedure SetDeleteCommand(const Value: TBaseSQLCommandEh);
    procedure SetInsertCommand(const Value: TBaseSQLCommandEh);
    procedure SetSelectCommand(const Value: TBaseSQLCommandEh);
    procedure SetGetrecCommand(const Value: TBaseSQLCommandEh);
    procedure SetUpdateCommand(const Value: TBaseSQLCommandEh);
    function GetOnExecuteCommand: TSQLDataDriverExecuteCommandEhEvent;
    procedure SetOnExecuteCommand(const Value: TSQLDataDriverExecuteCommandEhEvent);
  protected
    function CreateCommand: TCustomSQLCommandEh; override;
    procedure AssignCommandParam(Command: TBaseSQLCommandEh;
      MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Param: TParam); virtual;
  public
    function CreateDesignCopy: TCustomSQLDataDriverEh; override;
    function ExecuteCommand(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    procedure DefaultGetUpdatedServerValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    procedure DefaultAssignCommandParam(Command: TBaseSQLCommandEh;
      MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh; Param: TParam); virtual;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    property DynaSQLParams;
    property DeleteCommand: TBaseSQLCommandEh read GetDeleteCommand write SetDeleteCommand;
    property GetrecCommand: TBaseSQLCommandEh read GetGetrecCommand write SetGetrecCommand;
    property InsertCommand: TBaseSQLCommandEh read GetInsertCommand write SetInsertCommand;
    property SelectCommand: TBaseSQLCommandEh read GetSelectCommand write SetSelectCommand;
    property UpdateCommand: TBaseSQLCommandEh read GetUpdateCommand write SetUpdateCommand;
    property SpecParams;
    property OnAssignCommandParam: TSQLDataDriverAssignParamEhEvent read FOnAssignCommandParam write FOnAssignCommandParam;
    property OnExecuteCommand: TSQLDataDriverExecuteCommandEhEvent read GetOnExecuteCommand write SetOnExecuteCommand;
    property OnGetBackUpdatedValues: TSQLDataDriverGetBackUpdatedValuesEhEvent read FOnGetBackUpdatedValues write FOnGetBackUpdatedValues;
  end;

{ TBaseSQLCommandEh }

  TBaseSQLCommandEh = class(TCustomSQLCommandEh)
  private
    FParamCheck: Boolean;
    FParams: TParams;
    FOnAssignParam: TAssignParamEhEvent;
    function GetParamCheck: Boolean;
    function GetDataDriver: TBaseSQLDataDriverEh;
  protected
    procedure CommandTextChanged(Sender: TObject); override;
    procedure SetParamCheck(const Value: Boolean); virtual;
  public
    constructor Create(ADataDriver: TBaseSQLDataDriverEh);
    destructor Destroy; override;
    function GetParams: TParams; override;
    procedure Assign(Source: TPersistent); override;
    procedure SetParams(AParams: TParams); override;
    procedure DefaultRefreshParam(MemRecord: TMemoryRecordEh;
      DataValueVersion: TDataValueVersionEh; Param: TParam); virtual;
    procedure RefreshParams(MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh); override;
    procedure RebuildParams; override;
    property DataDriver: TBaseSQLDataDriverEh read GetDataDriver;

    property OnAssignParam: TAssignParamEhEvent read FOnAssignParam write FOnAssignParam;
    property Params: TParams read GetParams write SetParams;
    property ParamCheck: Boolean read GetParamCheck write SetParamCheck default True;
  end;

{ TSQLCommandEh }

  TSQLCommandEh = class(TBaseSQLCommandEh)
  published
    property Params;
    property ParamCheck;
    property CommandText;
    property CommandType;
  end;

{ TSQLDataDriverEh }

  TSQLDataDriverEh = class(TBaseSQLDataDriverEh)
  private
    FConnectionProvider: TConnectionProviderEh;
    function GetDeleteCommand: TSQLCommandEh;
    function GetGetrecCommand: TSQLCommandEh;
    function GetInsertCommand: TSQLCommandEh;
    function GetSelectCommand: TSQLCommandEh;
    function GetUpdateCommand: TSQLCommandEh;

    procedure SetConnectionProvider(const Value: TConnectionProviderEh);
    procedure SetDeleteCommand(AValue: TSQLCommandEh);
    procedure SetGetrecCommand(AValue: TSQLCommandEh);
    procedure SetInsertCommand(AValue: TSQLCommandEh);
    procedure SetSelectCommand(AValue: TSQLCommandEh);
    procedure SetUpdateCommand(AValue: TSQLCommandEh);

  protected
    function CreateSelectCommand: TCustomSQLCommandEh; override;
    function CreateUpdateCommand: TCustomSQLCommandEh; override;
    function CreateInsertCommand: TCustomSQLCommandEh; override;
    function CreateDeleteCommand: TCustomSQLCommandEh; override;
    function CreateGetrecCommand: TCustomSQLCommandEh; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    function GetConnectionProvider: IConnectionProviderEh; override;

  published
    property DeleteCommand: TSQLCommandEh read GetDeleteCommand write SetDeleteCommand;
    property DeleteSQL;
    property DynaSQLParams;
    property GetrecCommand: TSQLCommandEh read GetGetrecCommand write SetGetrecCommand;
    property GetrecSQL;
    property InsertCommand: TSQLCommandEh read GetInsertCommand write SetInsertCommand;
    property InsertSQL;
    property SelectCommand: TSQLCommandEh read GetSelectCommand write SetSelectCommand;
    property SelectSQL;
    property UpdateCommand: TSQLCommandEh read GetUpdateCommand write SetUpdateCommand;
    property UpdateSQL;

    property ConnectionProvider: TConnectionProviderEh read FConnectionProvider write SetConnectionProvider;
    property KeyFields;
    property MacroVars;
    property ProviderDataSet;
    property SpecParams;

    property OnAssignCommandParam;
    property OnAssignFieldValue;
    property OnBuildDataStruct;
    property OnExecuteCommand;
    property OnGetBackUpdatedValues;
    property OnProduceDataReader;
    property OnReadRecord;
    property OnRefreshRecord;
    property OnUpdateError;
    property OnUpdateRecord;
  end;

  TSQLDataDriverEhClass = class of TCustomSQLDataDriverEh;

{ TCustomInlineConnectionEh }

  TCustomInlineConnectionEh = class(TPersistent)
  private
    FUseAtDesignTime: Boolean;
    {$IFDEF FPC}
    {$ELSE}
    FWinControl: TWinControl;
    FWndMethod: TWndMethod;
    FReadingTimeConnected: Boolean;
    {$ENDIF}
    FConnectionProvider: TConnectionProviderEh;
    FConnectionFileName: String;
    FKeepConnectionInfoInFile: Boolean;
    procedure SetConnectionFileName(const Value: String);
    procedure SetKeepConnectionInfoInFile(const Value: Boolean);
  protected
    function GetConnected: Boolean; virtual;
    procedure SetConnected(const Value: Boolean); virtual;
    procedure SetDesignConnected(const Value: Boolean); virtual;
    {$IFDEF FPC}
    {$ELSE}
    procedure WinProg(var Message: TMessage);
    {$ENDIF}
    procedure Loaded; virtual;
    property ConnectionFileName: String read FConnectionFileName write SetConnectionFileName;
    property KeepConnectionInfoInFile: Boolean read FKeepConnectionInfoInFile write SetKeepConnectionInfoInFile;
    property UseAtDesignTime: Boolean read FUseAtDesignTime write FUseAtDesignTime default False;
  public
    constructor Create(AConnectionProvider: TConnectionProviderEh);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Open;
    procedure Close;
    property ConnectionProvider: TConnectionProviderEh read FConnectionProvider;
    property Connected: Boolean read GetConnected write SetConnected default False;
  end;

{ TConnectionProviderEh }

  TConnectionProviderEh = class(TComponent, IConnectionProviderEh)
  private
    FOnExecuteCommand: TResolverExecuteCommandEhEvent;
    FOnGetBackUpdatedValues: TResolverGetBackUpdatedValuesEhEvent;
    FOnGetServerSpecOperations: TResolverGetServerSpecOperationsEh;
    FOnUpdateRecord: TResolverUpdateRecordEhEvent;
    FServerSpecOperations: TServerSpecOperationsEh;
    function GetServerTypes(AIndex: Integer): String;
    function GetServerTypesCount: Integer;
  protected
    function GetServerType: String; virtual;
    function ConnectionIsPostponed: Boolean; virtual;
    procedure SetServerType(const Value: String); virtual;
    procedure AddPostponedActivationDataSet(ADataSet: TDataSet); virtual;
  public
    {DesignTime stuff}
    function GetDesignDataBase: TComponent; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ExecuteCommand(SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer; virtual;
    function DefaultExecuteCommand(SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer; virtual;
    function GetServerSpecOperations: TServerSpecOperationsEh; virtual;
    procedure GetDataReaderForSQL(SQLText: String; AParams: TParams; var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean); virtual;
    procedure FillMemTableForSQL(SQLText: String; AParams: TParams; MemTableData: TMemTableDataEh; var Processed: Boolean); virtual;
    function ExecuteSQL(SQLText: String; AParams: TParams; var Processed: Boolean): Integer; virtual;
    procedure UpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh; var Processed: Boolean); virtual;
    procedure DefaultUpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh; var Processed: Boolean); virtual;
    procedure GetBackUpdatedValues(SQLDataDriver: TCustomSQLDataDriverEh; MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean); virtual;
    procedure DefaultGetUpdatedServerValues(SQLDataDriver: TCustomSQLDataDriverEh; MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean); virtual;
    property ServerSpecOperations: TServerSpecOperationsEh read FServerSpecOperations write FServerSpecOperations;
    property OnExecuteCommand: TResolverExecuteCommandEhEvent read FOnExecuteCommand write FOnExecuteCommand;
    property OnGetBackUpdatedValues: TResolverGetBackUpdatedValuesEhEvent read FOnGetBackUpdatedValues write FOnGetBackUpdatedValues;
    property OnGetServerSpecOperations: TResolverGetServerSpecOperationsEh read FOnGetServerSpecOperations write FOnGetServerSpecOperations;
    property OnUpdateRecord: TResolverUpdateRecordEhEvent read FOnUpdateRecord write FOnUpdateRecord;

    property ServerType: String read GetServerType write SetServerType;
    property ServerTypes[AIndex: Integer]: String read GetServerTypes;
    property ServerTypesCount: Integer read GetServerTypesCount;
  end;

{ TSQLConnectionProviderEh }

  TSQLConnectionProviderEh = class(TConnectionProviderEh)
  published
    property ServerType;
    
    property OnExecuteCommand;
    property OnGetBackUpdatedValues;
    property OnGetServerSpecOperations;
    property OnUpdateRecord;
  end;

{ IConnectionProviderDesignSerivceEh }

  IConnectionProviderDesignServiceEh = interface
  ['{8524FC1E-990F-4665-99B0-7FA145B3A1A9}']
    function EditDesignData(ConnectionProvider: TConnectionProviderEh): Boolean;
    function ResetSysVariablesValues(sl: TStringList): Boolean;
    function GetConnectionSettingsFilePath(ConnectionProvider: TComponent): String;
    function CreateDesignDataBase(ConnectionProvider: TComponent): TComponent;
  end;

{ IDesignDataBaseEh }

  IDesignDataBaseEh = interface
  ['{01F477A4-8417-4DC9-B93A-1F95D2FF2EB8}']
    function CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh;
    function Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
    function BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean;
    function BuildObjectTree(List: TList): Boolean;
    function GetFieldList(const TableName: string; DataSet: TDataSet): Boolean;
    procedure EditDatabaseParams;
    function GetConnected: Boolean;
    procedure SetConnected(const Value: Boolean);
    procedure SetServerTypeAsServerSpecOperationsClass(const Value: TServerSpecOperationsEhClass);
  end;

{ TOracleSpecOperationsEh }

  TOracleSpecOperationsEh = class(TServerSpecOperationsEh)
  public
    class function GetServerTypeName: String; override;
  public
    function UpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; override;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
  end;

{ TMSSQLSpecOperationsEh }

  TMSSQLSpecOperationsEh = class(TServerSpecOperationsEh)
  public
    class function GetServerTypeName: String; override;
  public
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    constructor Create; override;
  end;

{ TInterbaseSpecOperationsEh }

  TInterbaseSpecOperationsEh = class(TServerSpecOperationsEh)
  public
    class function GetServerTypeName: String; override;
  public
    function UpdateRecord(SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer; override;
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
  end;

{ TInfromixSpecOperationsEh }

  TInfromixSpecOperationsEh = class(TServerSpecOperationsEh)
  public
    class function GetServerTypeName: String; override;
  public
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    constructor Create; override;
  end;

{ TDB2SpecOperationsEh }

  TDB2SpecOperationsEh = class(TServerSpecOperationsEh)
  public
    class function GetServerTypeName: String; override;
  public
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
  end;

{ TSybaseSpecOperationsEh }

  TSybaseSpecOperationsEh = class(TServerSpecOperationsEh)
  public
    class function GetServerTypeName: String; override;
  public
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
  end;

{ TMSAccessSpecOperationsEh }

  TMSAccessSpecOperationsEh = class(TServerSpecOperationsEh)
  public
    class function GetServerTypeName: String; override;
  public
    procedure GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet); override;
    constructor Create; override;
  end;

  TSetDesignDataBaseProcEh = procedure(DataDriver: TCustomSQLDataDriverEh);

function DefaultSQLDataDriverResolver: TSQLDataDriverResolver;
function RegisterDefaultSQLDataDriverResolver(ASQLDataDriverResolver: TSQLDataDriverResolver): TSQLDataDriverResolver;


procedure RegisterDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass;
  DesignDataBaseProc: TSetDesignDataBaseProcEh);
procedure UnregisterDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass);
function GetDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass):
  TSetDesignDataBaseProcEh;

procedure VarParamsToParams(VarParams: Variant; Params: TParams);

procedure RegisterServerType(ServerTypeClass: TServerSpecOperationsEhClass);

var
  ServerTypeClasses: TStringList;
  KeyAllowedFieldTypes: TFieldTypesEh;

implementation

uses
  Dialogs,
{$IFDEF CIL}
  System.Runtime.InteropServices,
{$ENDIF}
  MemTableEh, 
// SideOwnedComponentsEh, 
  StrUtils;

var
  AnsiServerSpecOperations: TServerSpecOperationsEh;
  DesignDataBuilderClasses: TList;
  DesignDataBuilderProcs: TList;

{$IFDEF CIL}

function DataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TBookmarkStr): Integer;
var
  I1, I2: IntPtr;
begin
  try
    I1 := Marshal.StringToHGlobalAnsi(Bookmark1);
    I2 := Marshal.StringToHGlobalAnsi(Bookmark1);
    Result := DataSet.CompareBookmarks(TBookmark(I1), TBookmark(I2));
  finally
    Marshal.FreeHGlobal(I1);
    if Assigned(I2) then
      Marshal.FreeHGlobal(I2);
  end;
end;

function DataSetBookmarkValid(DataSet: TDataSet; Bookmark: TBookmarkStr): Boolean;
var
  I1: IntPtr;
begin
  try
    I1 := Marshal.StringToHGlobalAnsi(Bookmark);
    Result := DataSet.BookmarkValid(TBookmark(I1));
  finally
    Marshal.FreeHGlobal(I1);
  end;
end;

{$ELSE}

function DataSetCompareBookmarks(DataSet: TDataSet; Bookmark1, Bookmark2: TUniBookmarkEh): Integer;
begin
  Result := DataSet.CompareBookmarks(TBookmark(Bookmark1), TBookmark(Bookmark2));
end;

function DataSetBookmarkValid(DataSet: TDataSet; Bookmark: TUniBookmarkEh): Boolean;
begin
  Result := DataSet.BookmarkValid(TBookmark(Bookmark));
end;

{$ENDIF}

var
  FDefaultSQLDataDriverResolver: TSQLDataDriverResolver;

function DefaultSQLDataDriverResolver: TSQLDataDriverResolver;
begin
  Result := FDefaultSQLDataDriverResolver;
end;

function RegisterDefaultSQLDataDriverResolver(ASQLDataDriverResolver: TSQLDataDriverResolver): TSQLDataDriverResolver;
begin
  Result := FDefaultSQLDataDriverResolver;
  FDefaultSQLDataDriverResolver := ASQLDataDriverResolver;
end;

procedure InitializeUnit;
var
  Resolver: TSQLDataDriverResolver;
begin
  AnsiServerSpecOperations := TServerSpecOperationsEh.Create;
  Resolver := TSQLDataDriverResolver.Create;
//  Does add this to avoide automatic resolution for all SQLDataDriver.
//  Resolver.ServerSpecOperations := AnsiServerSpecOperations;
  RegisterDefaultSQLDataDriverResolver(Resolver);

  RegisterServerType(TServerSpecOperationsEh);
  RegisterServerType(TOracleSpecOperationsEh);
  RegisterServerType(TMSSQLSpecOperationsEh);
  RegisterServerType(TInterbaseSpecOperationsEh);
  RegisterServerType(TInfromixSpecOperationsEh);
  RegisterServerType(TDB2SpecOperationsEh);
  RegisterServerType(TSybaseSpecOperationsEh);
  RegisterServerType(TMSAccessSpecOperationsEh);

  KeyAllowedFieldTypes := [
    ftUnknown, ftString, ftSmallint, ftInteger, ftWord,
    ftBoolean, ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,
    ftBytes, ftVarBytes, ftAutoInc, {ftBlob,} {ftMemo,} {ftGraphic,} {ftFmtMemo,}
    {ftParadoxOle,} {ftDBaseOle,} {ftTypedBinary,} {ftCursor,} ftFixedChar, ftWideString,
    ftLargeint, ftADT, ftArray, ftReference, {ftDataSet,} {ftOraBlob,} {ftOraClob,}
    ftVariant, ftInterface, ftIDispatch, ftGuid, ftTimeStamp, ftFMTBcd
{$IFDEF EH_LIB_10}
    ,ftFixedWideChar, ftWideMemo, ftOraTimeStamp, ftOraInterval
{$ENDIF}
{$IFDEF EH_LIB_12}
    ,ftLongWord, ftShortint, ftByte, TFieldType.ftExtended
{$ENDIF}
   ];
end;

procedure FinalizaUnit;
begin
  FreeAndNil(FDefaultSQLDataDriverResolver);
  FreeAndNil(DesignDataBuilderClasses);
  FreeAndNil(DesignDataBuilderProcs);
  FreeAndNil(AnsiServerSpecOperations);
  FreeAndNil(ServerTypeClasses);
end;

procedure VarParamsToParams(VarParams: Variant; Params: TParams);
var
  i: Integer;
  dt: TFieldType;
  p: TParam;
begin
  if VarIsNull(VarParams) then
    Exit;
  if VarArrayHighBound(VarParams, 1) > VarArrayLowBound(VarParams, 1) then
    for i := VarArrayLowBound(VarParams, 1) to VarArrayHighBound(VarParams, 1) div 2 do
    begin
      dt := VarTypeToDataType(VarType(VarParams[i*2+1]));
      if dt = ftUnknown then
        dt := ftString;
      p := Params.FindParam(VarParams[i*2]);
      if not Assigned(p) then
        p := Params.CreateParam(dt, VarParams[i*2], ptInputOutput);
      p.Value := VarParams[i*2+1];
    end;
end;

procedure RegisterServerType(ServerTypeClass: TServerSpecOperationsEhClass);
var
  STName: String;
begin
  if ServerTypeClasses = nil then
    ServerTypeClasses := TStringList.Create;
  STName := ServerTypeClass.GetServerTypeName;
  if ServerTypeClasses.IndexOf(STName) >= 0 then
    raise Exception.Create('Server type with name: "'+STName+'" is already registered');

  ServerTypeClasses.AddObject(STName, TObject(ServerTypeClass));
end;

{ TDataDriverEh }

constructor TDataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FResolveToDataSet := True;
  FSideParentable := False;
end;

destructor TDataDriverEh.Destroy;
begin
  ProviderEof := True;
  inherited Destroy;
end;

{$IFNDEF CIL}
{$IFDEF EH_LIB_16}
{$ELSE}
function AcquireExceptionObject: Pointer;
type
  PRaiseFrame = ^TRaiseFrame;
  TRaiseFrame = record
    NextRaise: PRaiseFrame;
    ExceptAddr: Pointer;
    ExceptObject: TObject;
    ExceptionRecord: PExceptionRecord;
  end;
begin
{$WARNINGS OFF}
  if RaiseList <> nil then
  begin
    Result := Exception(PRaiseFrame(RaiseList)^.ExceptObject);
    PRaiseFrame(RaiseList)^.ExceptObject := nil;
  end
  else
    Result := nil;
{$WARNINGS ON}
end;
{$ENDIF}
{$ENDIF}

procedure TDataDriverEh.AddPostponedActivationDataSet(ADataSet: TDataSet);
begin
//
end;

function TDataDriverEh.ConnectionIsPostponed: Boolean;
begin
  Result := False;
end;

function TDataDriverEh.ApplyUpdates(MemTableData: TMemTableDataEh): Integer;
var
  I: Integer;
  MemRec: TMemoryRecordEh;
  Action: TUpdateErrorActionEh;

  procedure ApplyUpdate;
  begin
    while True do
    begin
      try
        UpdateRecord(MemTableData, MemRec);
        Result := Result + 1;
      except
        on E: EDatabaseError do
        begin
          if Assigned(OnUpdateError)
            then OnUpdateError(Self, MemRec.RecordsList.MemTableData, MemRec, Action)
            else DefaultUpdateError(MemRec.RecordsList.MemTableData, MemRec, Action);

          if Action = ueaBreakRaiseEh then
            raise
          else begin
            if MemRec.UpdateError <> nil then
              MemRec.UpdateError.Free;
            MemRec.UpdateError := TUpdateErrorEh.Create(E);
{$IFNDEF CIL}
            AcquireExceptionObject;
{$ENDIF}
            if Action = ueaRetryEh
              then Continue
              else Break;
          end;
        end;
      end;
      Break;
    end;
  end;

begin
  Result := 0;
  for I := 0 to MemTableData.RecordsList.DeltaList.Count-1 do
  begin
    MemRec := TMemoryRecordEh(MemTableData.RecordsList.DeltaList[I]);
    if MemRec = nil then Continue;
    Action := ueaBreakRaiseEh;
    ApplyUpdate;
    if Action = ueaBreakAbortEh then
      Break;
    if Action <> ueaCountinueSkip then
      MemRec.MergeChanges;
//ueaBreakAbortEh, ueaBreakRaiseEh, ueaCountinueEh, ueaRetryEh
  end;

  MemTableData.RecordsList.CleanupChangedRecs;
end;

procedure TDataDriverEh.DefaultUpdateError(MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; var Action: TUpdateErrorActionEh);
begin
  Action := ueaBreakRaiseEh;
end;

procedure TDataDriverEh.UpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh);
begin
  if Assigned(OnUpdateRecord)
    then OnUpdateRecord(Self, MemTableData, MemRec)
    else DefaultUpdateRecord(MemTableData, MemRec);
end;

function TDataDriverEh.DefaultUpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer;
var
  vOldValues: Variant;
  i, idx: Integer;
  KeyFound: Boolean;
  Bookmark: TUniBookmarkEh;
  ProviderField: TField;
  UsedKeyFields: String;
begin
  Result := 0;
  if ResolveToDataSet and (ProviderDataSet <> nil) then
  begin
    Bookmark := ProviderDataSet.Bookmark;
    try
    if KeyFields <> '' then
      UsedKeyFields := KeyFields
    else
    begin
      UsedKeyFields := '';
      idx := 0;
      for i := 0 to ProviderDataSet.FieldCount - 1 do
      begin
        if ProviderDataSet.Fields[i].DataType in KeyAllowedFieldTypes then
        begin
          if idx > 0
            then UsedKeyFields := UsedKeyFields + ';' + ProviderDataSet.Fields[i].FieldName
            else UsedKeyFields := ProviderDataSet.Fields[i].FieldName;
          Inc(idx);
        end;
      end;
    end;

    if MemRec.UpdateStatus in [usModified, usDeleted] then
    begin
      vOldValues := MemRec.DataValues[UsedKeyFields, dvvOldestValue];
      KeyFound := ProviderDataSet.Locate(UsedKeyFields, vOldValues, []);
      if KeyFound then
      begin
        if (DataSetCompareBookmarks(ProviderDataSet,
          ProviderDataSet.Bookmark, Bookmark) = 0) and
          (MemRec.UpdateStatus = usDeleted)
        then // Will not go to the deleted bookmark
          Bookmark := NilBookmarkEh;
      end;
    end else
      KeyFound := True;

    if KeyFound then
    begin

      if MemRec.UpdateStatus = usModified then
        ProviderDataSet.Edit
      else if MemRec.UpdateStatus = usInserted then
        ProviderDataSet.Insert
      else
        ProviderDataSet.Delete;

      if MemRec.UpdateStatus in [usModified, usInserted] then
      begin
        try
          with MemRec do
            for i := 0 to DataStruct.Count-1 do
            begin
              ProviderField := ProviderDataSet.FindField(DataStruct[i].FieldName);
              if Assigned(ProviderField) and not ProviderField.ReadOnly then
                ProviderField.Value := Value[i, dvvValueEh];
            end;
          ProviderDataSet.Post;
        except
          on E: EDatabaseError do
          begin
            if ProviderDataSet.State in dsEditModes then
              ProviderDataSet.Cancel;
            raise;
          end;
        end;
//        if RefreshRecord then
//        begin
          MemRec.Edit;
          for i := 0 to MemRec.DataStruct.Count-1 do
            begin
              ProviderField := ProviderDataSet.FindField(MemRec.DataStruct[i].FieldName);
              if Assigned(ProviderField) {and not ProviderField.ReadOnly} then
                MemRec.Value[i, dvvValueEh] := ProviderField.Value;
            end;
          MemRec.Post;
//        end;
      end;

      Result := 1;
    end;
    finally
      if (Bookmark <> NilBookmarkEh) and DataSetBookmarkValid(ProviderDataSet, Bookmark) then
        ProviderDataSet.Bookmark := Bookmark;
    end;

//    MemRec.MergeChanges;
  end;
end;

procedure TDataDriverEh.ConsumerClosed(ConsumerDataSet: TDataSet);
begin
  if (ProviderDataSet <> nil) then
    ProviderDataSet.Close;
  ProviderEOF := True;
end;

procedure TDataDriverEh.RefreshReader;
begin
  if (ProviderDataSet <> nil) then
  begin
    ProviderDataSet.Refresh;
    ProviderDataSet.First;
  end;
end;

function TDataDriverEh.RefreshReaderParamsFromCursor(DataSet: TDataSet): Boolean;
var
  FParams: TParams;
  Field: TField;
  I: Integer;
begin
  Result := False;
  FParams := nil;
{$IFDEF EH_LIB_5}

{$IFDEF FPC}
{$ELSE}
   if (ProviderDataSet <> nil) then
      FParams := IProviderSupport(ProviderDataSet).PSGetParams();
{$ENDIF}

  if FParams <> nil then
    for I := 0 to FParams.Count - 1 do
    begin
      Field := DataSet.FindField(FParams[I].Name);
      if (Field <> nil) and not VarEquals(Field.Value, FParams[I].Value) then
      begin
        Result := True;
        Break;
      end;
    end;
{$ENDIF}
end;

procedure TDataDriverEh.SetReaderParamsFromCursor(DataSet: TDataSet);
var
  I: Integer;
  FParams: TParams;
begin
  FParams := nil;
{$IFDEF EH_LIB_5}

{$IFDEF FPC}
{$ELSE}
  if (ProviderDataSet <> nil) then
    FParams := IProviderSupport(ProviderDataSet).PSGetParams();
{$ENDIF}
  if FParams <> nil then
  begin
    DataSet.FieldDefs.Update;
    for I := 0 to FParams.Count - 1 do
      with FParams[I] do
        if not Bound then
        begin
          AssignField(DataSet.FieldByName(Name));
          Bound := False;
        end;
  end;
{$ENDIF}
end;

procedure TDataDriverEh.BuildDataStruct(DataStruct: TMTDataStructEh);
var
  DS: TDataSet;
begin
  if Assigned(FOnBuildDataStruct) then
    OnBuildDataStruct(Self, DataStruct)
  else if Assigned(FOnProduceDataReader) then
  begin
    DS := GetDataReader;
    DataStruct.BuildStructFromFields(DS.Fields);
  end else
    DefaultBuildDataStruct(DataStruct);
end;

procedure TDataDriverEh.DefaultBuildDataStruct(DataStruct: TMTDataStructEh);
begin
  if (ReaderDataSet <> nil) then
  begin
    DataStruct.BuildStructFromFields(ReaderDataSet.Fields);
    SetAutoIncFields(ReaderDataSet.Fields, DataStruct);
  end else if (ProviderDataSet <> nil) then
  begin
    if ProviderDataSet.FieldCount > 0 then
      DataStruct.BuildStructFromFields(ProviderDataSet.Fields)
    else
    begin
      ProviderDataSet.Active := True;
      DataStruct.BuildStructFromFields(ProviderDataSet.Fields);
      ProviderDataSet.Active := False;
    end;
    SetAutoIncFields(ProviderDataSet.Fields, DataStruct);
  end;
end;

procedure TDataDriverEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = FProviderDataSet then
      ProviderDataSet := nil;
  end;
end;

function TDataDriverEh.GetDataReader: TDataSet;
begin
  SetLength(FDataToRecFields, 0);
  if (FReaderDataSet <> nil) and not ProviderEOF then
    Result := FReaderDataSet
  else
  begin
    FReaderDataSetFreeOnEof := False;
    ProviderEOF := False;
    if Assigned(FOnProduceDataReader) then
      OnProduceDataReader(Self, FReaderDataSet, FReaderDataSetFreeOnEof)
    else
      DefaultProduceDataReader(FReaderDataSet, FReaderDataSetFreeOnEof);
    Result := FReaderDataSet;
  end;
end;

procedure TDataDriverEh.DefaultProduceDataReader(var DataSet: TDataSet; var FreeOnEof: Boolean);
begin
  if (ProviderDataSet <> nil) then
  begin
    ProviderDataSet.Active := True;
    ProviderDataSet.First;
    FreeOnEof := False;
    DataSet := ProviderDataSet;
  end;
end;

function TDataDriverEh.ReadData(MemTableData: TMemTableDataEh; Count: Integer): Integer;
var
  Rec: TMemoryRecordEh;
  AProviderEOF: Boolean;
begin
  Result := 0;
  if ProviderEOF = True then Exit;
  while Count <> 0 do
  begin
    Rec := MemTableData.RecordsList.NewRecord;
    try
      if Assigned(OnReadRecord)
        then OnReadRecord(Self, MemTableData, Rec, AProviderEOF)
        else DefaultReadRecord(MemTableData, Rec, AProviderEOF);
    except
      Rec.Free;
      raise;
    end;
    ProviderEOF := AProviderEOF;
    if ProviderEOF then
      Rec.Free
    else
    begin
      MemTableData.RecordsList.FetchRecord(Rec);
      Inc(Result);
    end;

    if ProviderEOF then Exit;
    Dec(Count);
  end;
end;

procedure TDataDriverEh.DefaultReadRecord(MemTableData: TMemTableDataEh;
  Rec: TMemoryRecordEh; var ProviderEOF: Boolean);
var
  i: Integer;
begin
  ProviderEOF := False;
  if (ReaderDataSet = nil) or
   ((ReaderDataSet <> nil) and not ReaderDataSet.Active) or
   ((ReaderDataSet <> nil) and ReaderDataSet.Active and ReaderDataSet.Eof)
  then
    ProviderEOF := True;
  if (ReaderDataSet = nil) or (ProviderEOF = True) then
    Exit;

  for i := 0 to Rec.DataStruct.Count-1 do
    AssignFieldValue(MemTableData, Rec, i, dvvValueEh, ReaderDataSet);

  ReaderDataSet.Next;
end;

procedure TDataDriverEh.AssignFieldValue(MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; DataFieldIndex: Integer;
  DataValueVersion: TDataValueVersionEh; ReaderDataSet: TDataSet);
begin
  if Assigned(OnAssignFieldValue)
    then OnAssignFieldValue(Self, MemTableData, MemRec, DataFieldIndex, DataValueVersion, ReaderDataSet)
    else DefaultAssignFieldValue(MemTableData, MemRec, DataFieldIndex, DataValueVersion, ReaderDataSet);
end;

procedure TDataDriverEh.ResetDataToRecFields(DataStruct: TMTDataStructEh;
  DataSet: TDataSet);

  function RecordsetFieldIndex(AFieldName: String): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := 0 to DataSet.Fields.Count-1 do
      if AnsiCompareText(AFieldName, DataSet.Fields[i].FieldName) = 0 then
      begin
        Result := i;
        Exit;
      end;
  end;

var
  i: Integer;
begin
  SetLength(FDataToRecFields, DataStruct.Count);
  for i := 0 to DataStruct.Count-1 do
    FDataToRecFields[i] := RecordsetFieldIndex(DataStruct[i].FieldName);
end;

procedure TDataDriverEh.DefaultAssignFieldValue(MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; DataFieldIndex: Integer;
  DataValueVersion: TDataValueVersionEh; ReaderDataSet: TDataSet);
var
  Field: TField;
begin
  if Length(FDataToRecFields) = 0 then
    ResetDataToRecFields(MemRec.DataStruct, ReaderDataSet);
  if FDataToRecFields[DataFieldIndex] >= 0 then
  begin
    Field := ReaderDataSet.Fields[FDataToRecFields[DataFieldIndex]];
    MemRec.Value[DataFieldIndex, DataValueVersion] := Field.Value;
  end;  
end;

procedure TDataDriverEh.DefaultRefreshRecord(MemRecord: TMemoryRecordEh);
var
  vValues: Variant;
  i: Integer;
  KeyFound: Boolean;
  Bookmark: TUniBookmarkEh;
begin
  if (ProviderDataSet <> nil) then
  begin
    try

      if KeyFields = '' then
        raise Exception.Create('It is required to set DataDriver.KeyFields to refresh record values');

      Bookmark := ProviderDataSet.Bookmark;
      try

        if MemRecord.UpdateStatus = usModified
          then vValues := MemRecord.DataValues[KeyFields, dvvOldValueEh]
          else vValues := MemRecord.DataValues[KeyFields, dvvValueEh];
        KeyFound := ProviderDataSet.Locate(KeyFields, vValues, []);

        if KeyFound then
            for i := 0 to MemRecord.DataStruct.Count-1 do
              AssignFieldValue(MemRecord.DataStruct.MemTableData, MemRecord, i,
                dvvRefreshValue, ProviderDataSet)
        else
          raise Exception.Create('Key is not found in ProviderDataSet');

      finally
        if (Bookmark <> NilBookmarkEh) and DataSetBookmarkValid(ProviderDataSet, Bookmark) then
          ProviderDataSet.Bookmark := Bookmark;
      end;

    finally
//      DeltaDataSet.Free;
    end;
//    Resync([]);
  end;
end;

procedure TDataDriverEh.RefreshRecord(MemRecord: TMemoryRecordEh);
begin
  if Assigned(OnRefreshRecord)
    then OnRefreshRecord(Self, MemRecord.DataStruct.MemTableData, MemRecord)
    else DefaultRefreshRecord(MemRecord);
end;

procedure TDataDriverEh.SetKeyFields(const Value: String);
begin
  FKeyFields := Value;
end;

procedure TDataDriverEh.SetProviderDataSet(const Value: TDataSet);
{$IFDEF FPC}
{$ELSE}
var
  Msg: TCMChanged;
{$ENDIF}
begin
  if Value <> FProviderDataSet then
  begin
    if (Value <> nil) and (Value is TCustomMemTableEh) and  (TCustomMemTableEh(Value).DataDriver = Self) then
      if not (csLoading in ComponentState) and (csDesigning in ComponentState) then
        DatabaseError('Circular of ProviderDataSet and TMemTableEh.DataDriver assigning is not allowed');
    FProviderDataSet := Value;
    if Value <> nil then Value.FreeNotification(Self);

    {$IFDEF FPC}
    {$ELSE}
    if not (csLoading in ComponentState) and (csDesigning in ComponentState) then
    begin
      Msg.Msg := CM_CHANGED;
{$IFDEF CIL}
{$ELSE}
      Msg.Unused := 0;
      Msg.Child := nil;
{$ENDIF}
      Msg.Result := 0;
      if (Owner is TWinControl) then
        TWinControl(Owner).Broadcast(Msg);
    end;
    {$ENDIF}
  end;
end;

{
function TDataDriverEh.GetReaderDataSet: TDataSet;
begin
  Result := ProviderDataSet;
end;
}

procedure TDataDriverEh.SetProviderEOF(const Value: Boolean);
begin
  if FProviderEOF <> Value then
  begin
    FProviderEOF := Value;
    if FProviderEOF and (FReaderDataSet <> nil) and FReaderDataSetFreeOnEof then
    begin
      FReaderDataSet.Free;
      FReaderDataSetFreeOnEof := False;
      FReaderDataSet := nil;
    end;
  end;
end;

procedure TDataDriverEh.SetAutoIncFields(Fields: TFields; DataStruct: TMTDataStructEh);
begin
end;

function TDataDriverEh.GetDataDriverConsumer: TObject;
begin
  Result := FDataDriverConsumer;
end;

procedure TDataDriverEh.SetDataDriverConsumer(ADataDriverConsumer: TObject);
begin
  FDataDriverConsumer := ADataDriverConsumer;
end;

procedure TDataDriverEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  if FSideParentable then
    Filer.DefineProperty('SideParentName', ReadSideParent, WriteSideParent, IsSideParentStored);
end;

procedure TDataDriverEh.Loaded;
begin
  inherited Loaded;
  if FSideParentable then
  begin
    if FSideParentName <> '' then
      FSideParent := Owner.FindComponent(FSideParentName);
    FSideParentName := '';

(*    if (csDesigning in ComponentState) and
       (FSideParent = nil) and
       Assigned(SelectSideParentComponentProc)
    then
      SelectSideParentComponentProc(Self, FSideParent,
      'SideOwnerable component + "' + Name + ' : ' + ClassName + '" doesn''t have SideOwner. ' + sLineBreak +
      'Plasse select SideOwner for SideOwnerable component.'
      );
*)
  end;
end;

function TDataDriverEh.IsSideParentStored: Boolean;
begin
  Result := (FSideParent <> nil);
end;

procedure TDataDriverEh.ReadSideParent(Reader: TReader);
begin
  FSideParentName := Reader.ReadString;
end;

procedure TDataDriverEh.WriteSideParent(Writer: TWriter);
begin
  Writer.WriteString(FSideParent.Name);
end;

function TDataDriverEh.IsSideParentedBy(AComponent: TComponent): Boolean;
begin
  if FSideParentable
    then Result := (SideParent = AComponent)
    else Result := False;
end;

procedure TDataDriverEh.SetSideParent(AComponent: TComponent);
begin
  if FSideParentable then
    FSideParent := AComponent;
end;

{ TCustomSQLCommandEh }

constructor TCustomSQLCommandEh.Create(ADataDriver: TCustomSQLDataDriverEh);
begin
  inherited Create;
  FDataDriver := ADataDriver;
  FCommandText := TStringList.Create;
  TStringList(FCommandText).OnChange := CommandTextChanged;
  FFinalCommandText := TStringList.Create;
  FFinalCommandTextObsolete := True;
end;

destructor TCustomSQLCommandEh.Destroy;
begin
  FreeAndNil(FCommandText);
  FreeAndNil(FFinalCommandText);
  inherited Destroy;
end;

function TCustomSQLCommandEh.GetCommandText: TStrings;
begin
  Result := FCommandText;
end;

procedure TCustomSQLCommandEh.SetCommandText(const Value: TStrings);
begin
  FCommandText.Assign(Value);
end;

function TCustomSQLCommandEh.Execute(var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  Processed: Boolean;
begin
  Processed := False;
  Result := -1;
  Cursor := nil;
  if DataDriver.GetConnectionProvider <> nil then
  begin
    Processed := False;
    Result := DataDriver.GetConnectionProvider.ExecuteCommand(DataDriver, Self, Cursor, FreeOnEof, Processed);
    if Processed then
      Exit;
  end;
  if DefaultSQLDataDriverResolver <> nil then
    Result := DefaultSQLDataDriverResolver.ExecuteCommand(DataDriver, Self, Cursor, FreeOnEof, Processed);
end;

procedure TCustomSQLCommandEh.FinalCommandTextObsolete;
begin
  FFinalCommandTextObsolete := True;
end;

procedure TCustomSQLCommandEh.FormFinalCommandText;
var
  MacroVars: TMacroVarsEh;
  i: Integer;
begin
  FFinalCommandText.Assign(CommandText);
  if (DataDriver <> nil) then
  begin
    MacroVars := DataDriver.MacroVars;
    if smuUseFilterMacroEh in MacroVars.SpecMacrosUsages then
    begin
      FFinalCommandText.Text := MacroVars.SubstituteMacro(FFinalCommandText.Text,
        MacroVars.SpecMacros.FilterMacroName, MacroVars.SpecMacros.FilterMacroValue);
    end;
    if smuUseSortOrderMacroEh in MacroVars.SpecMacrosUsages then
    begin
      FFinalCommandText.Text := MacroVars.SubstituteMacro(FFinalCommandText.Text,
        MacroVars.SpecMacros.SortOrderMacroName, MacroVars.SpecMacros.SortOrderMacroValue);
    end;
    for i := 0 to MacroVars.Macros.Count-1 do
    begin
      FFinalCommandText.Text := MacroVars.SubstituteMacro(FFinalCommandText.Text,
        MacroVars.Macros.Items[i].Name, MacroVars.Macros.Items[i].Value);
    end;
  end;
  FFinalCommandTextObsolete := False;
end;

procedure TCustomSQLCommandEh.CommandTextChanged(Sender: TObject);
begin
  if (DataDriver <> nil) then
    DataDriver.CommandTextChanged(Self);
  FinalCommandTextObsolete;
end;

procedure TCustomSQLCommandEh.CommandTypeChanged;
begin
end;

function TCustomSQLCommandEh.GetCommandType: TSQLCommandTypeEh;
begin
  Result := FCommandType;
end;

function TCustomSQLCommandEh.GetFinalCommandText: TStrings;
begin
  if FFinalCommandTextObsolete then
    FormFinalCommandText;
  Result := FFinalCommandText;
end;

procedure TCustomSQLCommandEh.SetCommandType(const Value: TSQLCommandTypeEh);
begin
  FCommandType := Value;
end;

procedure TCustomSQLCommandEh.RefreshParams(MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh);
begin
end;

function TCustomSQLCommandEh.GetOwner: TPersistent;
begin
  Result := FDataDriver;
end;

function TCustomSQLCommandEh.GetNamePath: String;
begin
  Result := 'SQLCommand';
end;

function TCustomSQLCommandEh.IsCommandTypeStored: Boolean;
begin
  Result := (FCommandType <> DefaultCommandType);
end;

function TCustomSQLCommandEh.DefaultCommandType: TSQLCommandTypeEh;
begin
  Result := DataDriver.GetDefaultCommandTypeFor(Self);
end;

procedure TCustomSQLCommandEh.Assign(Source: TPersistent);
begin
  if Source is TCustomSQLCommandEh then
    with (Source as TCustomSQLCommandEh) do
    begin
      Self.CommandText := CommandText;
      Self.CommandType := CommandType;
    end;
end;

{procedure TCustomSQLCommandEh.AssignParams(AParams: TParams);
begin
end;

procedure TCustomSQLCommandEh.AssignToParams(AParams: TParams);
begin
end;}

function TCustomSQLCommandEh.GetParams: TParams;
begin
  Result := nil;
end;

procedure TCustomSQLCommandEh.SetParams(AParams: TParams);
begin
end;

procedure TCustomSQLCommandEh.RebuildParams;
begin

end;

{ TBaseSQLCommandEh }

constructor TBaseSQLCommandEh.Create(ADataDriver: TBaseSQLDataDriverEh);
begin
  inherited Create(ADataDriver);
  FParams := TParams.Create(Self);
  FParamCheck := True;
end;

destructor TBaseSQLCommandEh.Destroy;
begin
  FreeAndNil(FParams);
  inherited Destroy;
end;

procedure TBaseSQLCommandEh.RefreshParams(MemRecord: TMemoryRecordEh; DataValueVersion: TDataValueVersionEh);
var
  I: Integer;
begin
  for I := 0 to Params.Count - 1 do
  begin
    if Assigned(OnAssignParam)
      then OnAssignParam(Self, MemRecord, DataValueVersion, Params[I])
      else DefaultRefreshParam(MemRecord, DataValueVersion, Params[I]);
  end;
end;

procedure TBaseSQLCommandEh.DefaultRefreshParam(MemRecord: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh; Param: TParam);
begin
  DataDriver.AssignCommandParam(Self, MemRecord, DataValueVersion, Param);
end;

function TBaseSQLCommandEh.GetParamCheck: Boolean;
begin
  Result := FParamCheck;
end;

procedure TBaseSQLCommandEh.SetParamCheck(const Value: Boolean);
begin
  FParamCheck := Value;
end;

procedure TBaseSQLCommandEh.SetParams(AParams: TParams);
begin
  if FParams <> AParams then
    FParams.Assign(AParams);
end;

function TBaseSQLCommandEh.GetParams: TParams;
begin
  Result := FParams;
end;

procedure TBaseSQLCommandEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
  if Source is TBaseSQLCommandEh then
    with (Source as TBaseSQLCommandEh) do
    begin
      Self.ParamCheck := ParamCheck;
      Self.Params := Params;
    end
  else if Source is TCustomSQLCommandEh then
    with (Source as TCustomSQLCommandEh) do
    begin
      Self.ParamCheck := ParamCheck;
      Self.Params.Assign(GetParams);
    end
end;

procedure TBaseSQLCommandEh.CommandTextChanged(Sender: TObject);
begin
  inherited CommandTextChanged(Sender);
  if not (csReading in DataDriver.ComponentState) then
//    if ParamCheck then
//      Params.ParseSQL(CommandText.Text, True);
    if ParamCheck or (csDesigning in DataDriver.ComponentState) then
    begin
      RebuildParams;
    end;
end;

procedure TBaseSQLCommandEh.RebuildParams;
var
  List: TParams;
begin
  List := TParams.Create(Self);
  try
    List.ParseSQL(CommandText.Text, True);
    List.AssignValues(Params);
    Params.Clear;
    Params.Assign(List);
  finally
    List.Free;
  end;
end;

function TBaseSQLCommandEh.GetDataDriver: TBaseSQLDataDriverEh;
begin
  Result := TBaseSQLDataDriverEh(inherited DataDriver);
end;

{procedure TBaseSQLCommandEh.AssignParams(AParams: TParams);
begin
  Params := AParams;
end;

procedure TBaseSQLCommandEh.AssignToParams(AParams: TParams);
begin
  AParams.Assign(Params);
end;}

{ TCustomSQLDataDriverEh }

constructor TCustomSQLDataDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSelectCommand := CreateSelectCommand;
  FSelectCommand.FCommandType := GetDefaultCommandTypeFor(FSelectCommand);
  FUpdateCommand := CreateUpdateCommand;
  FUpdateCommand.FCommandType := GetDefaultCommandTypeFor(FUpdateCommand);
  FInsertCommand := CreateInsertCommand;
  FInsertCommand.FCommandType := GetDefaultCommandTypeFor(FInsertCommand);
  FDeleteCommand := CreateDeleteCommand;
  FDeleteCommand.FCommandType := GetDefaultCommandTypeFor(FDeleteCommand);
  FGetrecCommand := CreateGetrecCommand;
  FGetrecCommand.FCommandType := GetDefaultCommandTypeFor(FGetrecCommand);
  FSpecParams := TStringList.Create;
  ResolveToDataSet := False;
  FServiceCommand := CreateCommand;
  FDynaSQLParams := TDynaSQLParamsEh.Create(Self);
  FMacroVars := TMacroVarsEh.Create(Self);
end;

destructor TCustomSQLDataDriverEh.Destroy;
begin
  FreeAndNil(FDynaSQLParams);
  FreeAndNil(FSelectCommand);
  FreeAndNil(FUpdateCommand);
  FreeAndNil(FInsertCommand);
  FreeAndNil(FDeleteCommand);
  FreeAndNil(FGetrecCommand);
  FreeAndNil(FServiceCommand);
  FDesignDataBase := nil;
  FreeAndNil(FSpecParams);
  FreeAndNil(FMacroVars);
  inherited Destroy;
end;

procedure TCustomSQLDataDriverEh.SetSelectCommand(const Value: TCustomSQLCommandEh);
begin
  FSelectCommand.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.SetDeleteCommand(const Value: TCustomSQLCommandEh);
begin
  FDeleteCommand.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.SetInsertCommand(const Value: TCustomSQLCommandEh);
begin
  FInsertCommand.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.SetGetrecCommand(const Value: TCustomSQLCommandEh);
begin
  FGetrecCommand.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.SetUpdateCommand(const Value: TCustomSQLCommandEh);
begin
  FUpdateCommand.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.DefaultProduceDataReader(var DataSet: TDataSet; var FreeOnEof: Boolean);
begin
  if ProviderDataSet <> nil
    then inherited DefaultProduceDataReader(DataSet, FreeOnEof)
    else ExecuteCommand(SelectCommand, DataSet, FreeOnEof);
end;

procedure TCustomSQLDataDriverEh.DefaultBuildDataStruct(DataStruct: TMTDataStructEh);
var
  AReaderDS: TDataSet;
  AFreeOnEof: Boolean;
begin
  if (ReaderDataSet <> nil) or (ProviderDataSet <> nil) then
    inherited DefaultBuildDataStruct(DataStruct)
  else
  begin
//    if AReaderDS = nil then
      ExecuteCommand(SelectCommand, AReaderDS, AFreeOnEof);
    if AReaderDS = nil then
      raise Exception.Create('SelectCommand.Execute does not get DataSet');
    AReaderDS.Active := True;
    DataStruct.BuildStructFromFields(AReaderDS.Fields);
    AReaderDS.Active := False;
    if AFreeOnEof then
      AReaderDS.Free;
  end;
end;

function TCustomSQLDataDriverEh.DefaultExecuteCommand(Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  Processed: Boolean;
  DesignDataBaseIntf: IDesignDataBaseEh;
begin

  { TODO : Is it valid technology? }
  if HaveDataConnection then
    Result := Command.Execute(Cursor, FreeOnEof)
  else
  begin
    Result := -1;
    Processed := False;
    if (csDesigning in ComponentState) and
       (ForceGetNewDesignDataBase <> nil) and
       (Supports(DesignDataBase, IDesignDataBaseEh, DesignDataBaseIntf)) then
    begin
      DesignDataBaseIntf.Execute(Command, Cursor, FreeOnEof);
      Processed := True;
    end else
    begin
      if Assigned(FDefaultSQLDataDriverResolver) then
        Result := FDefaultSQLDataDriverResolver.ExecuteCommand(Self, Command, Cursor, FreeOnEof, Processed);
      if not Processed then
        Result := Command.Execute(Cursor, FreeOnEof);
    end;
  end;
end;

function TCustomSQLDataDriverEh.ExecuteCommand(Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
begin
  if Assigned(OnExecuteCommand)
    then Result := OnExecuteCommand(Self, Command, Cursor, FreeOnEof)
    else Result := DefaultExecuteCommand(Command, Cursor, FreeOnEof);
end;

procedure TCustomSQLDataDriverEh.DefaultRefreshRecord(MemRecord: TMemoryRecordEh);
var
  i: Integer;
  RecDataSet: TDataSet;
  AFreeOnEof: Boolean;
begin
  if ResolveToDataSet then
    inherited RefreshRecord(MemRecord)
  else
  begin
    GetrecCommand.RefreshParams(MemRecord, dvvOldestValue);
    ExecuteCommand(GetrecCommand, RecDataSet, AFreeOnEof);
    try
      if RecDataSet.IsEmpty then
        raise Exception.Create('There are no fresh record on server');

      MemRecord.EditForRefresh;
      try
        for i := 0 to MemRecord.DataStruct.Count-1 do
          AssignFieldValue(MemRecord.DataStruct.MemTableData, MemRecord, i,
            dvvOldestValue, RecDataSet);
      finally
        MemRecord.Post;
      end;  
{      begin
        Field := RecDataSet.FindField(MemRecord.DataStruct[i].FieldName);
        if Field <> nil then
          MemRecord.Value[i, dvtOldestValue] := Field.Value;
      end;}

    finally
      if AFreeOnEof then
        RecDataSet.Free;
    end;
  end;
end;

function TCustomSQLDataDriverEh.DoUpdateRecord(MemTableData: TMemTableDataEh; MemRec: TMemoryRecordEh): Integer;
var
  Command: TCustomSQLCommandEh;
  ResDataSet: TDataSet;
  AFreeOnEof: Boolean;
begin
  Result := 0;
  if ResolveToDataSet then
    Result := inherited DefaultUpdateRecord(MemTableData, MemRec)
  else
  begin
    Command := nil;
    if  ((MemRec.UpdateStatus = usModified) and (dsoDynamicSQLUpdateEh in DynaSQLParams.Options))
     or ((MemRec.UpdateStatus = usInserted) and (dsoDynamicSQLInsertEh in DynaSQLParams.Options))
     or ((MemRec.UpdateStatus = usDeleted) and (dsoDynamicSQLDeleteEh in DynaSQLParams.Options)) then
    begin
      GenerateDynamicSQLCommand(MemRec, ServiceCommand);
      if ServiceCommand.CommandText.Text <> '' then
        Command := ServiceCommand;
    end else
      case MemRec.UpdateStatus of
        usModified: Command := UpdateCommand;
        usInserted: Command := InsertCommand;
        usDeleted: Command := DeleteCommand;
      end;
    if Command = nil then Exit;
    Command.RefreshParams(MemRec, dvvValueEh);
    Result := ExecuteCommand(Command, ResDataSet, AFreeOnEof);
    GetBackUpdatedValues(MemRec, Command, ResDataSet);
    if AFreeOnEof then
      ResDataSet.Free;
//    MemRec.MergeChanges;
  end
end;

function TCustomSQLDataDriverEh.DefaultUpdateRecord(MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh): Integer;
var
  Processed: Boolean;
begin
  Result := 0;
  Processed := False;
  if GetConnectionProvider <> nil then
    GetConnectionProvider.UpdateRecord(Self, MemTableData, MemRec, Processed);
  if not Processed and Assigned(FDefaultSQLDataDriverResolver) then
    FDefaultSQLDataDriverResolver.UpdateRecord(Self, MemTableData, MemRec, Processed);
  if not Processed then
  begin
    if InternalGetServerSpecOperations <> nil
      then Result := InternalGetServerSpecOperations.UpdateRecord(Self, MemTableData, MemRec)
      else Result := DoUpdateRecord(MemTableData, MemRec);
  end;
end;

procedure TCustomSQLDataDriverEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  if Assigned(FOnGetBackUpdatedValues)
    then OnGetBackUpdatedValues(Self, MemRec, Command, ResDataSet)
    else DefaultGetUpdatedServerValues(MemRec, Command, ResDataSet);
end;

procedure TCustomSQLDataDriverEh.DefaultGetUpdatedServerValues(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
var
  Processed: Boolean;
begin
  Processed := False;
  if GetConnectionProvider <> nil then
    GetConnectionProvider.GetBackUpdatedValues(Self, MemRec, Command, ResDataSet, Processed);
  if not Processed and Assigned(FDefaultSQLDataDriverResolver) then
    FDefaultSQLDataDriverResolver.GetBackUpdatedValues(Self, MemRec, Command, ResDataSet, Processed);
  if not Processed and (InternalGetServerSpecOperations <> nil) then
    InternalGetServerSpecOperations.GetBackUpdatedValues(MemRec, Command, ResDataSet);
end;

function TCustomSQLDataDriverEh.CreateDeleteCommand: TCustomSQLCommandEh;
begin
  Result := CreateCommand;
end;

function TCustomSQLDataDriverEh.CreateInsertCommand: TCustomSQLCommandEh;
begin
  Result := CreateCommand;
end;

function TCustomSQLDataDriverEh.CreateSelectCommand: TCustomSQLCommandEh;
begin
  Result := CreateCommand;
end;

function TCustomSQLDataDriverEh.CreateGetrecCommand: TCustomSQLCommandEh;
begin
  Result := CreateCommand;
end;

function TCustomSQLDataDriverEh.CreateUpdateCommand: TCustomSQLCommandEh;
begin
  Result := CreateCommand;
end;

{
function TCustomSQLDataDriverEh.GetReaderDataSet: TDataSet;
begin
  if ProviderDataSet <> nil
    then Result := inherited GetReaderDataSet
    else Result := FReaderDataSet;
end;
}

function TCustomSQLDataDriverEh.GetDefaultCommandTypeFor(Command: TCustomSQLCommandEh): TSQLCommandTypeEh;
begin
  if (Command = SelectCommand) or (Command = GetrecCommand)
    then Result := cthSelectQuery
    else Result := cthUpdateQuery;
end;

procedure RegisterDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass;
  DesignDataBaseProc: TSetDesignDataBaseProcEh);
var
  ExistsIdx: Integer;
begin
  if DesignDataBuilderClasses = nil then
  begin
    DesignDataBuilderClasses := TList.Create;
    DesignDataBuilderProcs := TList.Create;
  end;
  ExistsIdx := DesignDataBuilderClasses.IndexOf(TObject(DataDriverClass));
  if ExistsIdx >= 0 then
    DesignDataBuilderProcs[ExistsIdx] := @DesignDataBaseProc
  else
  begin
    DesignDataBuilderClasses.Add(TObject(DataDriverClass));
    DesignDataBuilderProcs.Add(@DesignDataBaseProc);
  end;
end;

procedure UnregisterDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass);
var
  ExistsIdx: Integer;
begin
  if DesignDataBuilderClasses = nil then Exit;
  ExistsIdx := DesignDataBuilderClasses.IndexOf(TObject(DataDriverClass));
  if ExistsIdx >= 0 then
  begin
    DesignDataBuilderClasses.Delete(ExistsIdx);
    DesignDataBuilderProcs.Delete(ExistsIdx);
  end;
end;

function GetDesignDataBuilderProcEh(DataDriverClass: TSQLDataDriverEhClass):
  TSetDesignDataBaseProcEh;

  function GetDatasetFeaturesDeep(ARootClass, AClass: TClass): Integer;
  begin
    Result := 0;
    while True do
    begin
      if ARootClass = AClass then
        Exit;
      Inc(Result);
      AClass := AClass.ClassParent;
      if AClass = nil then
      begin
        Result := MAXINT;
        Exit;
      end;
    end;
  end;

var
  Deep, MeenDeep, i: Integer;
  TargetClass: TSQLDataDriverEhClass;
begin
  Result := nil;
  if DesignDataBuilderClasses = nil then Exit;
  MeenDeep := MAXINT;
  for i := 0 to DesignDataBuilderClasses.Count - 1 do
  begin
    if DataDriverClass.InheritsFrom(TSQLDataDriverEhClass(DesignDataBuilderClasses[i])) then
    begin
      TargetClass := TSQLDataDriverEhClass(DesignDataBuilderClasses[i]);
      Deep := GetDatasetFeaturesDeep(TargetClass, DataDriverClass);
      if Deep < MeenDeep then
      begin
        MeenDeep := Deep;
        Result := TSetDesignDataBaseProcEh(DesignDataBuilderProcs[i]);
      end;
    end;
  end;
end;

function TCustomSQLDataDriverEh.CreateDesignDataBase: TComponent;
begin
  Result := nil;
end;

procedure TCustomSQLDataDriverEh.AddPostponedActivationDataSet(ADataSet: TDataSet);
begin
  if GetConnectionProvider <> nil then
    GetConnectionProvider.AddPostponedActivationDataSet(ADataSet);
end;

function TCustomSQLDataDriverEh.ConnectionIsPostponed: Boolean;
begin
  Result := False;
  if GetConnectionProvider <> nil then
    Result := GetConnectionProvider.ConnectionIsPostponed
end;

procedure TCustomSQLDataDriverEh.AssignFromDesignDriver(DesignDataDriver: TCustomSQLDataDriverEh);
begin
  SelectCommand := DesignDataDriver.SelectCommand;
  UpdateCommand := DesignDataDriver.UpdateCommand;
  InsertCommand := DesignDataDriver.InsertCommand;
  DeleteCommand := DesignDataDriver.DeleteCommand;
  GetrecCommand := DesignDataDriver.GetrecCommand;
  SpecParams := DesignDataDriver.SpecParams;
  DynaSQLParams := DesignDataDriver.DynaSQLParams;
  MacroVars := DesignDataDriver.MacroVars;
end;

function TCustomSQLDataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
begin
  Result := TCustomSQLDataDriverEh.Create(nil);
  Result.SelectCommand := SelectCommand;
  Result.UpdateCommand := UpdateCommand;
  Result.InsertCommand := InsertCommand;
  Result.DeleteCommand := DeleteCommand;
  Result.GetrecCommand := GetrecCommand;
  Result.SpecParams := SpecParams;
  Result.DynaSQLParams := DynaSQLParams;
  Result.MacroVars := MacroVars;
end;

function TCustomSQLDataDriverEh.GetSelectSQL: TStrings;
begin
  Result := SelectCommand.CommandText;
end;

procedure TCustomSQLDataDriverEh.SetSelectSQL(const Value: TStrings);
begin
  SelectCommand.CommandText := Value;
end;

function TCustomSQLDataDriverEh.GetDeleteSQL: TStrings;
begin
  Result := DeleteCommand.CommandText;
end;

procedure TCustomSQLDataDriverEh.SetDeleteSQL(const Value: TStrings);
begin
  DeleteCommand.CommandText := Value;
end;

function TCustomSQLDataDriverEh.GetGetrecSQL: TStrings;
begin
  Result := GetrecCommand.CommandText;
end;

procedure TCustomSQLDataDriverEh.SetGetrecSQL(const Value: TStrings);
begin
  GetrecCommand.CommandText := Value;
end;

function TCustomSQLDataDriverEh.GetInsertSQL: TStrings;
begin
  Result := InsertCommand.CommandText;
end;

procedure TCustomSQLDataDriverEh.SetInsertSQL(const Value: TStrings);
begin
  InsertCommand.CommandText := Value;
end;

procedure TCustomSQLDataDriverEh.SetMacroVars(const Value: TMacroVarsEh);
begin
  FMacroVars.Assign(Value);
end;

function TCustomSQLDataDriverEh.GetUpdateSQL: TStrings;
begin
  Result := UpdateCommand.CommandText;
end;

procedure TCustomSQLDataDriverEh.SetUpdateSQL(const Value: TStrings);
begin
  UpdateCommand.CommandText := Value;
end;

function TCustomSQLDataDriverEh.ForceGetNewDesignDataBase: TComponent;
var
  SetBaseProc: TSetDesignDataBaseProcEh;
begin
  Result := nil;
  SetBaseProc := GetDesignDataBuilderProcEh(TSQLDataDriverEhClass(ClassType));
  if @SetBaseProc = nil then Exit;
  SetBaseProc(Self);
  Result := FDesignDataBase;
end;

function TCustomSQLDataDriverEh.GetDesignDataBase: TComponent;
begin
  if GetConnectionProvider <> nil then
    Result := GetConnectionProvider.GetDesignDataBase
  else
    Result := FDesignDataBase;
end;

function TCustomSQLDataDriverEh.GetFinalDeleteSQL: TStrings;
begin
  Result := DeleteCommand.FinalCommandText;
end;

function TCustomSQLDataDriverEh.GetFinalGetrecSQL: TStrings;
begin
  Result := GetrecCommand.FinalCommandText;
end;

function TCustomSQLDataDriverEh.GetFinalInsertSQL: TStrings;
begin
  Result := InsertCommand.FinalCommandText;
end;

function TCustomSQLDataDriverEh.GetFinalSelectSQL: TStrings;
begin
  Result := SelectCommand.FinalCommandText;
end;

function TCustomSQLDataDriverEh.GetFinalUpdateSQL: TStrings;
begin
  Result := UpdateCommand.FinalCommandText;
end;

procedure TCustomSQLDataDriverEh.SetDesignDataBase(const Value: TComponent);
begin
  if FDesignDataBase <> Value then
  begin
    FDesignDataBase := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TCustomSQLDataDriverEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FDesignDataBase = AComponent)
  then
    FDesignDataBase := nil;
end;

function TCustomSQLDataDriverEh.OrderByTextSupported: Boolean;
begin
  Result := (smuUseSortOrderMacroEh in MacroVars.SpecMacrosUsages);
end;

procedure TCustomSQLDataDriverEh.ApplyOrderByText(OrderByText: String);
begin
  if OrderByText = '' then
    MacroVars.SpecMacros.SortOrderMacroValue := ''
  else if smuSortOrderAsOrderByClauseEh in MacroVars.SpecMacrosUsages then
    MacroVars.SpecMacros.SortOrderMacroValue := 'ORDER BY ' + OrderByText
  else if smuSortOrderWithCommaPrecedingEh in MacroVars.SpecMacrosUsages then
    MacroVars.SpecMacros.SortOrderMacroValue := ', ' + OrderByText;
end;

function TCustomSQLDataDriverEh.FilterTextSupported: Boolean;
begin
  Result := (smuUseFilterMacroEh in MacroVars.SpecMacrosUsages);
end;

procedure TCustomSQLDataDriverEh.ApplyFilterText(FilterText: String);
begin
  if FilterText = '' then
    MacroVars.SpecMacros.FilterMacroValue := ''
  else if smuFilterAsWhereClauseEh in MacroVars.SpecMacrosUsages then
    MacroVars.SpecMacros.FilterMacroValue := 'WHERE ' + FilterText
  else if smuFilterWithANDPrecedingEh in MacroVars.SpecMacrosUsages then
    MacroVars.SpecMacros.FilterMacroValue := 'AND (' + FilterText + ')';
end;

function TCustomSQLDataDriverEh.RefreshReaderParamsFromCursor(DataSet: TDataSet): Boolean;
var
  FParams: TParams;
  Field: TField;
  I: Integer;
begin
  if (ProviderDataSet <> nil) then
    Result := inherited RefreshReaderParamsFromCursor(DataSet)
  else
  begin
    Result := False;
    FParams := SelectCommand.GetParams;
    if FParams <> nil then
      for I := 0 to FParams.Count - 1 do
      begin
        Field := DataSet.FindField(FParams[I].Name);
        if (Field <> nil) and not VarEquals(Field.Value, FParams[I].Value) then
        begin
          Result := True;
          Break;
        end;
      end;
  end;
end;

procedure TCustomSQLDataDriverEh.SetReaderParamsFromCursor(DataSet: TDataSet);
var
  I: Integer;
  FParams: TParams;
begin
  if (ProviderDataSet <> nil) then
    inherited SetReaderParamsFromCursor(DataSet)
  else
  begin
    FParams := SelectCommand.GetParams;
    if FParams <> nil then
    begin
      DataSet.FieldDefs.Update;
      for I := 0 to FParams.Count - 1 do
        with FParams[I] do
        begin
//          if not Bound then
//          begin
            AssignField(DataSet.FieldByName(Name));
            Bound := False;
//          end;
        end;
    end;
    SelectCommand.SetParams(FParams);
  end;
end;

procedure TCustomSQLDataDriverEh.SetSpecParams(const Value: TStrings);
begin
  FSpecParams.Assign(Value);
end;

function TCustomSQLDataDriverEh.HaveDataConnection: Boolean;
begin
  if GetConnectionProvider <> nil
    then Result := True
    else Result := False;
end;

function TCustomSQLDataDriverEh.CreateCommand: TCustomSQLCommandEh;
begin
  Result := TCustomSQLCommandEh.Create(Self);
end;

procedure TCustomSQLDataDriverEh.SetServiceCommand(
  const Value: TCustomSQLCommandEh);
begin
  FServiceCommand := Value;
end;

procedure TCustomSQLDataDriverEh.UpdateServerService;
begin

end;

procedure TCustomSQLDataDriverEh.SetDynaSQLParams(const Value: TDynaSQLParamsEh);
begin
  FDynaSQLParams.Assign(Value);
end;

procedure TCustomSQLDataDriverEh.SetServerSpecOperations(const Value: TServerSpecOperationsEh);
begin
  FServerSpecOperations := Value;
end;

procedure TCustomSQLDataDriverEh.GenerateDynamicSQLCommand(
  MemRecord: TMemoryRecordEh; Command: TCustomSQLCommandEh);
begin
  if (InternalGetServerSpecOperations <> nil) then
    InternalGetServerSpecOperations.GenerateDynaSQLCommand(MemRecord, Command)
  else if Assigned(DefaultSQLDataDriverResolver.ServerSpecOperations) then
    DefaultSQLDataDriverResolver.ServerSpecOperations.GenerateDynaSQLCommand(MemRecord, Command)
  else
    AnsiServerSpecOperations.GenerateDynaSQLCommand(MemRecord, Command);
end;

function TCustomSQLDataDriverEh.InternalGetServerSpecOperations: TServerSpecOperationsEh;
begin
  Result := ServerSpecOperations;
end;

procedure TCustomSQLDataDriverEh.Loaded;
begin
  inherited Loaded;
end;

procedure TCustomSQLDataDriverEh.MacrosChanged;
begin
  DeleteCommand.FinalCommandTextObsolete;
  GetrecCommand.FinalCommandTextObsolete;
  InsertCommand.FinalCommandTextObsolete;
  SelectCommand.FinalCommandTextObsolete;
  UpdateCommand.FinalCommandTextObsolete;
end;

procedure TCustomSQLDataDriverEh.SetAutoIncFields(Fields: TFields;
  DataStruct: TMTDataStructEh);
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

procedure TCustomSQLDataDriverEh.CommandTextChanged(Sender: TCustomSQLCommandEh);
begin
  if (Sender = SelectCommand) and
     (FDataDriverConsumer <> nil) and
     (FDataDriverConsumer is TCustomMemTableEh)
  then
    (FDataDriverConsumer as TCustomMemTableEh).DriverStructChanged;
end;

function TCustomSQLDataDriverEh.GetConnectionProvider: IConnectionProviderEh;
begin
  Result := nil;
end;

function TCustomSQLDataDriverEh.CheckAddFieldInDynaSQL(
  UpdateStatus: TUpdateStatus; FieldName: String): Boolean;
begin
  Result := True;
  if UpdateStatus = usInserted then
    if SpecParams.Values['AUTO_INCREMENT_FIELD'] = FieldName then
      Result := False;
end;

{ TBaseSQLDataDriverEh }

procedure TBaseSQLDataDriverEh.AssignCommandParam(
  Command: TBaseSQLCommandEh; MemRecord: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh; Param: TParam);
begin
  if Assigned(OnAssignCommandParam)
    then OnAssignCommandParam(Self, Command, MemRecord, DataValueVersion, Param)
    else DefaultAssignCommandParam(Command, MemRecord, DataValueVersion, Param);
end;

function TBaseSQLDataDriverEh.CreateCommand: TCustomSQLCommandEh;
begin
  Result := TBaseSQLCommandEh.Create(Self);
end;

procedure TBaseSQLDataDriverEh.DefaultAssignCommandParam(
  Command: TBaseSQLCommandEh; MemRecord: TMemoryRecordEh;
  DataValueVersion: TDataValueVersionEh; Param: TParam);
var
  FIndex: Integer;
begin
  FIndex := MemRecord.DataStruct.FieldIndex(Param.Name);
  if FIndex >= 0 then
  begin
    { TODO : Check DataType as in TParam.AssignFieldValue }
    if Command.ParamCheck then
      Param.DataType := MemRecord.DataStruct[FIndex].DataType;
    Param.Value := MemRecord.DataValues[Param.Name, DataValueVersion];
  end
  else if (UpperCase(Copy(Param.Name,1, Length('OLD_'))) = 'OLD_') then
  begin
    FIndex := MemRecord.DataStruct.FieldIndex(Copy(Param.Name, 5, 255));
    if FIndex >= 0 then
    begin
      if Command.ParamCheck then
        Param.DataType := MemRecord.DataStruct[FIndex].DataType;
      Param.Value := MemRecord.DataValues[Copy(Param.Name, 5, 255), dvvOldestValue];
    end
  end;
end;


procedure TBaseSQLDataDriverEh.DefaultGetUpdatedServerValues(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh;
  ResDataSet: TDataSet);
var
  i: Integer;
  DataField: TMTDataFieldEh;
  ACommand: TBaseSQLCommandEh;
begin
  inherited DefaultGetUpdatedServerValues(MemRec, Command, ResDataSet);
  ACommand := TBaseSQLCommandEh(Command);
  // Use params
  for i := 0 to ACommand.Params.Count-1 do
  begin
    DataField := nil;
    if ACommand.Params[i].ParamType in [ptOutput, ptInputOutput, ptResult] then
      DataField := MemRec.DataStruct.FindField(ACommand.Params[i].Name);
    if DataField <> nil then
    { TODO : Assign server values in future }
      MemRec.DataValues[ACommand.Params[i].Name, dvvValueEh] := ACommand.Params[i].Value;
  end;

  // Use result dataset
  if (ResDataSet <> nil) and not ResDataSet.IsEmpty then
    for i := 0 to ResDataSet.FieldCount-1 do
    begin
      DataField := MemRec.DataStruct.FindField(ResDataSet.Fields[i].FieldName);
      if DataField <> nil then
      { TODO : Assign server values in future }
        MemRec.DataValues[ResDataSet.Fields[i].FieldName, dvvValueEh] := ResDataSet.Fields[i].Value;
    end;
end;

procedure TBaseSQLDataDriverEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  if Assigned(FOnGetBackUpdatedValues)
    then OnGetBackUpdatedValues(Self, MemRec, TBaseSQLCommandEh(Command), ResDataSet)
    else DefaultGetUpdatedServerValues(MemRec, Command, ResDataSet);
end;

function TBaseSQLDataDriverEh.GetDeleteCommand: TBaseSQLCommandEh;
begin
  Result := TBaseSQLCommandEh(inherited DeleteCommand);
end;

procedure TBaseSQLDataDriverEh.SetDeleteCommand(const Value: TBaseSQLCommandEh);
begin
  inherited DeleteCommand := Value;
end;

function TBaseSQLDataDriverEh.GetInsertCommand: TBaseSQLCommandEh;
begin
  Result := TBaseSQLCommandEh(inherited InsertCommand);
end;

function TBaseSQLDataDriverEh.GetOnExecuteCommand: TSQLDataDriverExecuteCommandEhEvent;
begin
  Result := TSQLDataDriverExecuteCommandEhEvent(inherited OnExecuteCommand)
end;

procedure TBaseSQLDataDriverEh.SetInsertCommand(const Value: TBaseSQLCommandEh);
begin
  inherited InsertCommand := Value;
end;

procedure TBaseSQLDataDriverEh.SetOnExecuteCommand(
  const Value: TSQLDataDriverExecuteCommandEhEvent);
begin
  inherited OnExecuteCommand := TDataDriverExecuteCommandEhEvent(Value)
end;

function TBaseSQLDataDriverEh.GetSelectCommand: TBaseSQLCommandEh;
begin
  Result := TBaseSQLCommandEh(inherited SelectCommand);
end;

procedure TBaseSQLDataDriverEh.SetSelectCommand(const Value: TBaseSQLCommandEh);
begin
  inherited SelectCommand := Value;
end;

function TBaseSQLDataDriverEh.GetGetrecCommand: TBaseSQLCommandEh;
begin
  Result := TBaseSQLCommandEh(inherited GetrecCommand);
end;

procedure TBaseSQLDataDriverEh.SetGetrecCommand(const Value: TBaseSQLCommandEh);
begin
  inherited GetrecCommand := Value;
end;

function TBaseSQLDataDriverEh.GetUpdateCommand: TBaseSQLCommandEh;
begin
  Result := TBaseSQLCommandEh(inherited UpdateCommand);
end;

procedure TBaseSQLDataDriverEh.SetUpdateCommand(const Value: TBaseSQLCommandEh);
begin
  inherited UpdateCommand := Value;
end;

function TBaseSQLDataDriverEh.ExecuteCommand(Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  ExecComEvent: TSQLDataDriverExecuteCommandEhEvent;
begin
  ExecComEvent := OnExecuteCommand;
  if Assigned(ExecComEvent)
    then Result := ExecComEvent(Self, TBaseSQLCommandEh(Command), Cursor, FreeOnEof)
    else Result := DefaultExecuteCommand(Command, Cursor, FreeOnEof);
end;

function TBaseSQLDataDriverEh.CreateDesignCopy: TCustomSQLDataDriverEh;
begin
  Result := TBaseSQLDataDriverEh.Create(nil);
  Result.SelectCommand := SelectCommand;
  Result.UpdateCommand := UpdateCommand;
  Result.InsertCommand := InsertCommand;
  Result.DeleteCommand := DeleteCommand;
  Result.GetrecCommand := GetrecCommand;
  Result.SpecParams := SpecParams;
  Result.DynaSQLParams := DynaSQLParams;
  Result.MacroVars := MacroVars;
end;

{ TSQLDataDriverEh }

function TSQLDataDriverEh.CreateDeleteCommand: TCustomSQLCommandEh;
begin
  Result := TSQLCommandEh.Create(Self);
end;

function TSQLDataDriverEh.CreateGetrecCommand: TCustomSQLCommandEh;
begin
  Result := TSQLCommandEh.Create(Self);
end;

function TSQLDataDriverEh.CreateInsertCommand: TCustomSQLCommandEh;
begin
  Result := TSQLCommandEh.Create(Self);
end;

function TSQLDataDriverEh.CreateSelectCommand: TCustomSQLCommandEh;
begin
  Result := TSQLCommandEh.Create(Self);
end;

function TSQLDataDriverEh.CreateUpdateCommand: TCustomSQLCommandEh;
begin
  Result := TSQLCommandEh.Create(Self);
end;

function TSQLDataDriverEh.GetConnectionProvider: IConnectionProviderEh;
begin
  Supports(FConnectionProvider, IConnectionProviderEh, Result);
end;

procedure TSQLDataDriverEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if (Operation = opRemove) then
  begin
    if AComponent = FConnectionProvider then
      ConnectionProvider := nil;
  end;
end;

procedure TSQLDataDriverEh.SetConnectionProvider(const Value: TConnectionProviderEh);
begin
  if Value <> FConnectionProvider then
  begin
    FConnectionProvider := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

function TSQLDataDriverEh.GetDeleteCommand: TSQLCommandEh;
begin
  Result := TSQLCommandEh(inherited GetDeleteCommand);
end;

function TSQLDataDriverEh.GetGetrecCommand: TSQLCommandEh;
begin
  Result := TSQLCommandEh(inherited GetGetrecCommand);
end;

function TSQLDataDriverEh.GetInsertCommand: TSQLCommandEh;
begin
  Result := TSQLCommandEh(inherited GetInsertCommand);
end;

function TSQLDataDriverEh.GetSelectCommand: TSQLCommandEh;
begin
  Result := TSQLCommandEh(inherited GetSelectCommand);
end;

function TSQLDataDriverEh.GetUpdateCommand: TSQLCommandEh;
begin
  Result := TSQLCommandEh(inherited GetUpdateCommand);
end;

procedure TSQLDataDriverEh.SetDeleteCommand(AValue: TSQLCommandEh);
begin
  inherited SetDeleteCommand(AValue);
end;

procedure TSQLDataDriverEh.SetGetrecCommand(AValue: TSQLCommandEh);
begin
  inherited SetGetrecCommand(AValue);
end;

procedure TSQLDataDriverEh.SetInsertCommand(AValue: TSQLCommandEh);
begin
  inherited SetInsertCommand(AValue);
end;

procedure TSQLDataDriverEh.SetSelectCommand(AValue: TSQLCommandEh);
begin
  inherited SetSelectCommand(AValue);
end;

procedure TSQLDataDriverEh.SetUpdateCommand(AValue: TSQLCommandEh);
begin
  inherited SetUpdateCommand(AValue);
end;

{ TSQLDataDriverResolver }

procedure TSQLDataDriverResolver.DefaultGetUpdatedServerValues(SQLDataDriver: TCustomSQLDataDriverEh;
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean);
begin
  if Assigned(ServerSpecOperations) then
  begin
    ServerSpecOperations.GetBackUpdatedValues(MemRec, Command, ResDataSet);
    Processed := True;
  end else if Assigned(SQLDataDriver.ServerSpecOperations) then
  begin
    SQLDataDriver.ServerSpecOperations.GetBackUpdatedValues(MemRec, Command, ResDataSet);
    Processed := True;
  end else if SQLDataDriver.InternalGetServerSpecOperations <> nil then
  begin
    SQLDataDriver.InternalGetServerSpecOperations.GetBackUpdatedValues(MemRec, Command, ResDataSet);
    Processed := True;
  end;
end;

function TSQLDataDriverResolver.ExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean; var Processed: Boolean): Integer;
begin
  Result := -1;
  if Assigned(OnExecuteCommand)
    then Result := OnExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed)
    else Processed := False;
end;

procedure TSQLDataDriverResolver.GetBackUpdatedValues(SQLDataDriver: TCustomSQLDataDriverEh;
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean);
begin
  if Assigned(FOnGetBackUpdatedValues)
    then OnGetBackUpdatedValues(SQLDataDriver, MemRec, Command, ResDataSet, Processed)
    else DefaultGetUpdatedServerValues(SQLDataDriver, MemRec, Command, ResDataSet, Processed);
end;

function TSQLDataDriverResolver.GetServerSpecOperations(
  var Processed: Boolean): TServerSpecOperationsEh;
begin
  Result := nil;
  if Assigned(OnGetServerSpecOperations) then
    OnGetServerSpecOperations(Processed, Result)
  else if Assigned(ServerSpecOperations) then
  begin
    Result := ServerSpecOperations;
    Processed := True;
  end;
end;

procedure TSQLDataDriverResolver.UpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; var Processed: Boolean);
begin
  if Assigned(FOnUpdateRecord) then
    FOnUpdateRecord(SQLDataDriver, MemTableData, MemRec, Processed);
  if not Processed then
    DefaultUpdateRecord(SQLDataDriver, MemTableData, MemRec, Processed);
end;

procedure TSQLDataDriverResolver.DefaultUpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; var Processed: Boolean);
begin
  if Assigned(ServerSpecOperations) then
    ServerSpecOperations.UpdateRecord(SQLDataDriver, MemTableData, MemRec)
  else if SQLDataDriver.InternalGetServerSpecOperations <> nil then
    SQLDataDriver.InternalGetServerSpecOperations.UpdateRecord(SQLDataDriver, MemTableData, MemRec)
  else
    SQLDataDriver.DoUpdateRecord(MemTableData, MemRec);
  Processed := True;
end;

{ TServerSpecOperationsEh }

procedure TServerSpecOperationsEh.GenerateDynaSQLCommand(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh);

var
  DynaSQLParams: TDynaSQLParamsEh;
  UpdateFieldList, KeyFieldList, ChangedFieldList, UFieldList: TStringList;
  Comma: String;
  I: Integer;

  procedure GenFieldList(const TabName, ParamChar, QuoteChar: String; IncludeInsertFields: Boolean);
  var
    L: string;
    I: integer;
    Comma: string;
  begin
    L := '  (';
    Comma := '';
    if IncludeInsertFields then
      for I := 0 to KeyFieldList.Count - 1 do
      begin
        if not Command.DataDriver.CheckAddFieldInDynaSQL(MemRec.UpdateStatus, KeyFieldList[I]) then Continue;
        if UFieldList.IndexOf(KeyFieldList[I]) >= 0 then Continue;
        L := Format('%s%s%s%s%s%s%4:s',
          [L, Comma, TabName, ParamChar, QuoteChar, KeyFieldList[I]]);
        if (Length(L) > 70) and (I <> KeyFieldList.Count - 1) then
        begin
          Command.CommandText.Add(L);
          L := '   ';
        end;
        Comma := ', ';
      end;
    for I := 0 to UFieldList.Count - 1 do
    begin
//      if I = UFieldList.Count - 1 then Comma := '';
      if not Command.DataDriver.CheckAddFieldInDynaSQL(MemRec.UpdateStatus, UFieldList[I]) then Continue;
      L := Format('%s%s%s%s%s%4:s%5:s',
        [L, Comma, TabName, ParamChar, QuoteChar, UFieldList[I]]);
      if (Length(L) > 70) and (I <> UFieldList.Count - 1) then
      begin
        Command.CommandText.Add(L);
        L := '   ';
      end;
      Comma := ', ';
    end;
    Command.CommandText.Add(L+')');
  end;

begin
  UpdateFieldList := nil;
  KeyFieldList := nil;
  ChangedFieldList := nil;
  Command.CommandType := cthUpdateQuery;
  try
    DynaSQLParams := Command.DataDriver.DynaSQLParams;
    UpdateFieldList := TStringList.Create;
    UpdateFieldList.CommaText := DynaSQLParams.UpdateFields;
    ChangedFieldList := TStringList.Create;
    if Command.DataDriver.DynaSQLParams.SkipUnchangedFields and
      (MemRec.UpdateStatus = usModified) then
    begin
      BuildChangedFieldList(MemRec, UpdateFieldList, ChangedFieldList);
      UFieldList := ChangedFieldList;
    end else
      UFieldList := UpdateFieldList;
    KeyFieldList := TStringList.Create;
    KeyFieldList.CommaText := DynaSQLParams.KeyFields;
    Command.CommandText.Clear;
    if MemRec.UpdateStatus = usInserted then
    begin
      Command.CommandText.Add(Format('insert into %s', [DynaSQLParams.UpdateTable]));
      GenFieldList('', '', '', True);
      Command.CommandText.Add('values');
      GenFieldList('', ':', '', True);
    end else if MemRec.UpdateStatus = usModified then
    begin
      if UFieldList.Count = 0 then
        Command.CommandText.Text := ''
      else
      begin
        Command.CommandText.Add(Format('update %s', [DynaSQLParams.UpdateTable]));
        Command.CommandText.Add('set');
        Comma := ',';
        for I := 0 to UFieldList.Count - 1 do
        begin
          if I = UFieldList.Count -1 then Comma := '';
          Command.CommandText.Add(Format(' %s = :%0:s%1:s', [UFieldList[I], Comma]));
        end;
        GenWhereClause(DynaSQLParams.KeyFields, Command.CommandText);
      end;
    end else if MemRec.UpdateStatus = usDeleted then
    begin
      Command.CommandText.Add(Format('delete from %s', [DynaSQLParams.UpdateTable]));
      GenWhereClause(DynaSQLParams.KeyFields, Command.CommandText);
    end;

{    Params := Command.GetParams;
    if Params <> nil then
    begin
      for I := 0 to Command.GetParams.Count - 1 do
      begin
        if Params[I].DataType = ftUnknown then
          Params[I].DataType := ftString;
      end;
      Command.SetParams(Params);
    end;}
  finally
    ChangedFieldList.Free;
    UpdateFieldList.Free;
    KeyFieldList.Free;
  end;
end;

procedure TServerSpecOperationsEh.GenerateInsertCommand(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh);
begin

end;

procedure TServerSpecOperationsEh.GenerateUpdateCommand(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh);
begin

end;

procedure TServerSpecOperationsEh.GenerateDeleteCommand(
  MemRec: TMemoryRecordEh; Command: TCustomSQLCommandEh);
begin

end;

procedure TServerSpecOperationsEh.GenWhereClause(KeyFields: String; SQL: TStrings);
var
  FieldList: TStringList;
  I: Integer;
  FieldName, BindText: String;
begin
  FieldList := TStringList.Create;
  try
    FieldList.CommaText := KeyFields;
    if FieldList.Count > 0 then
    begin
      SQL.Add('where');
      for I := 0 to FieldList.Count - 1 do
      begin
        FieldName := FieldList[I];
        BindText := Format(' %s = :OLD_%0:s',
          [FieldName]);
        if I < FieldList.Count - 1 then
          BindText := Format('%s and',[BindText]);
        SQL.Add(BindText);
      end;
    end;
  finally
    FieldList.Free;
  end;
end;

procedure TServerSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin
  
end;

class function TServerSpecOperationsEh.GetServerTypeName: String;
begin
  Result := 'AnsiServer';
end;

procedure TServerSpecOperationsEh.BuildChangedFieldList(
  MemRec: TMemoryRecordEh; UpdateFieldList, ChangedFieldList: TStringList);
var
  I, FieldIndex: Integer;
  FieldName: String;
begin
  ChangedFieldList.Clear;
  for I := 0 to UpdateFieldList.Count - 1 do
  begin
    FieldName := UpdateFieldList[I];
    FieldIndex := MemRec.DataStruct.FieldIndex(FieldName);
    if FieldIndex >= 0 then
    begin
      if not VarEquals(MemRec.Value[FieldIndex, dvvOldValueEh],
                   MemRec.Value[FieldIndex, dvvValueEh])
      then
        ChangedFieldList.Add(FieldName);
    end
    else
      raise Exception.Create('Invalid field name "' + FieldName + '"' +
        ' in field list "' + UpdateFieldList.CommaText + '"');
  end;
end;

function TServerSpecOperationsEh.UpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh): Integer;
begin
  Result := SQLDataDriver.DoUpdateRecord(MemTableData, MemRec);
end;

constructor TServerSpecOperationsEh.Create;
begin
  inherited Create;
//  IncludeInsertFieldsInUpdateCommand := False;
end;

{ TOracleSpecOperationsEh }

procedure TOracleSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
(*const
  SEQSQL = 'SELECT %s.curval FROM dual';  {do not localize}
var
  Sequence, SequenceField: String;
  ServiceCommand: TCustomSQLCommandEh;
  DataDriver: TCustomSQLDataDriverEh;
  Params: TParams;
  Cursor: TDataSet;
  FreeOnEof: Boolean;*)
begin
(*  DataDriver := Command.DataDriver;
  if Command <> DataDriver.InsertCommand then Exit;
  Sequence := DataDriver.SpecParams.Values['SEQUENCE'];
  SequenceField := DataDriver.SpecParams.Values['SEQUENCE_FIELD'];
  if MemRec.DataStruct.FindField(SequenceField) = nil then
    SequenceField := '';
  ServiceCommand := DataDriver.ServiceCommand;
  if (Sequence <> '') and (SequenceField <> '') then
  begin
    ServiceCommand.CommandText.Text := Format(SEQSQL, [Sequence, 0]);
    ServiceCommand.CommandType := cthSelectQuery;
    Params := ServiceCommand.GetParams;
    Params.Clear;
    ServiceCommand.SetParams(Params);
    try
      ServiceCommand.Execute(Cursor, FreeOnEof);
      MemRec.DataValues[SequenceField, dvvValueEh] := Cursor.Fields[0].Value;
    finally
      if FreeOnEof then
        Cursor.Free;
    end;
  end;*)
end;

class function TOracleSpecOperationsEh.GetServerTypeName: String;
begin
  Result := 'Oracle';
end;

function TOracleSpecOperationsEh.UpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh): Integer;

  function PromoteInterBaseGenerator: Variant;
  const
    SEQSQL = 'SELECT %s.curval FROM dual';  {do not localize}
  var
    Generator: String;
    ServiceCommand: TCustomSQLCommandEh;
    Params: TParams;
    Cursor: TDataSet;
    FreeOnEof: Boolean;
  begin
    Result := Unassigned;
  { TODO : May be better to use Memrec.UpdateStatus = Inserted ? }
    Generator := SQLDataDriver.SpecParams.Values['SEQUENCE'];
    if Generator <> '' then
    begin
      ServiceCommand := SQLDataDriver.ServiceCommand;
      ServiceCommand.CommandText.Text := Format(SEQSQL, [Generator, 1]);
      ServiceCommand.CommandType := cthSelectQuery;
      Params := ServiceCommand.GetParams;
      Params.Clear;
      ServiceCommand.SetParams(Params);
      try
        ServiceCommand.Execute(Cursor, FreeOnEof);
        // Get current GENERATOR value
        Result := Cursor.Fields[0].Value;
      finally
        if FreeOnEof then
          Cursor.Free;
      end;
    end;
  end;

var
  GenValue: Variant;
  GeneratorField: String;
begin
  if MemRec.UpdateStatus = usInserted then
  begin
    GenValue := PromoteInterBaseGenerator;
    GeneratorField := SQLDataDriver.SpecParams.Values['SEQUENCE_FIELD'];
    if MemRec.DataStruct.FindField(GeneratorField) = nil then
      GeneratorField := '';
    if not VarIsEmpty(GenValue) and (GeneratorField <> '') then
      MemRec.DataValues[GeneratorField, dvvValueEh] := GenValue;
  end;
  Result := inherited UpdateRecord(SQLDataDriver, MemTableData, MemRec);
end;

{ TMSSQLSpecOperationsEh }

constructor TMSSQLSpecOperationsEh.Create;
begin
  inherited Create;
//  IncludeInsertFieldsInUpdateCommand := False;
end;

procedure TMSSQLSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
const
  IDENTITYSQL1 = 'SELECT @@IDENTITY';  {do not localize}
//  IDENTITYSQL2 = 'SELECT @@SCOPE_IDENTITY()';  {do not localize}
var
  IdentityField: String;
  ServiceCommand: TCustomSQLCommandEh;
  DataDriver: TCustomSQLDataDriverEh;
  Params: TParams;
  Cursor: TDataSet;
  FreeOnEof: Boolean;
begin
  DataDriver := Command.DataDriver;
//  if Command <> DataDriver.InsertCommand then Exit;
  if MemRec.UpdateStatus <> usInserted then Exit;
  IdentityField := DataDriver.SpecParams.Values['AUTO_INCREMENT_FIELD'];
  ServiceCommand := DataDriver.ServiceCommand;
  if IdentityField <> '' then
  begin
    ServiceCommand.CommandText.Text := IDENTITYSQL1;
    ServiceCommand.CommandType := cthSelectQuery;
    Params := ServiceCommand.GetParams;
    Params.Clear;
    ServiceCommand.SetParams(Params);
    try
      ServiceCommand.Execute(Cursor, FreeOnEof);
      // Get current Sequence value
      MemRec.DataValues[IdentityField, dvvValueEh] := Cursor.Fields[0].Value;
    finally
      if FreeOnEof then
        Cursor.Free;
    end;
  end;
end;

class function TMSSQLSpecOperationsEh.GetServerTypeName: String;
begin
  Result := 'MSSQL';
end;

{ TInterbaseSpecOperationsEh }

procedure TInterbaseSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
const
  SGENSQL = 'SELECT GEN_ID(%s, %d) FROM RDB$DATABASE';  {do not localize}
var
  Generator, GeneratorField: String;
  ServiceCommand: TCustomSQLCommandEh;
  DataDriver: TCustomSQLDataDriverEh;
  Params: TParams;
  Cursor: TDataSet;
  FreeOnEof: Boolean;
begin
  DataDriver := Command.DataDriver;
//  if Command <> DataDriver.InsertCommand then Exit;
  if MemRec.UpdateStatus <> usInserted then Exit;
  Generator := DataDriver.SpecParams.Values['GENERATOR'];
  GeneratorField := DataDriver.SpecParams.Values['GENERATOR_FIELD'];
  if MemRec.DataStruct.FindField(GeneratorField) = nil then
    GeneratorField := '';
  ServiceCommand := DataDriver.ServiceCommand;
  if (Generator <> '') and (GeneratorField <> '') then
  begin
    ServiceCommand.CommandText.Text := Format(SGENSQL, [Generator, 0]);
    ServiceCommand.CommandType := cthSelectQuery;
    Params := ServiceCommand.GetParams;
    Params.Clear;
    ServiceCommand.SetParams(Params);
    try
      ServiceCommand.Execute(Cursor, FreeOnEof);
      // Get current GENERATOR value
      MemRec.DataValues[GeneratorField, dvvValueEh] := Cursor.Fields[0].Value;
    finally
      if FreeOnEof then
        Cursor.Free;
    end;
  end;
end;

class function TInterbaseSpecOperationsEh.GetServerTypeName: String;
begin
  Result := 'Interbase';
end;

function TInterbaseSpecOperationsEh.UpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh): Integer;

  function PromoteInterBaseGenerator: Variant;
  const
    SGENSQL = 'SELECT GEN_ID(%s, %d) FROM RDB$DATABASE';  {do not localize}
  var
    Generator: String;
    ServiceCommand: TCustomSQLCommandEh;
    Params: TParams;
    Cursor: TDataSet;
    FreeOnEof: Boolean;
  begin
    Result := Unassigned;
  { TODO : May be better to use Memrec.UpdateStatus = Inserted ? }
    Generator := SQLDataDriver.SpecParams.Values['GENERATOR'];
    if Generator <> '' then
    begin
      ServiceCommand := SQLDataDriver.ServiceCommand;
      ServiceCommand.CommandText.Text := Format(SGENSQL, [Generator, 1]);
      ServiceCommand.CommandType := cthSelectQuery;
      Params := ServiceCommand.GetParams;
      Params.Clear;
      ServiceCommand.SetParams(Params);
      try
        ServiceCommand.Execute(Cursor, FreeOnEof);
        // Get current GENERATOR value
        Result := Cursor.Fields[0].Value;
      finally
        if FreeOnEof then
          Cursor.Free;
      end;
    end;
  end;

var
  GenValue: Variant;
  GeneratorField: String;
begin
  if MemRec.UpdateStatus = usInserted then
  begin
    GenValue := PromoteInterBaseGenerator;
    GeneratorField := SQLDataDriver.SpecParams.Values['GENERATOR_FIELD'];
    if MemRec.DataStruct.FindField(GeneratorField) = nil then
      GeneratorField := '';
    if not VarIsEmpty(GenValue) and (GeneratorField <> '') then
      MemRec.DataValues[GeneratorField, dvvValueEh] := GenValue;
  end;
  Result := inherited UpdateRecord(SQLDataDriver, MemTableData, MemRec);
end;

{ TMSAccessSpecOperationsEh }

constructor TMSAccessSpecOperationsEh.Create;
begin
  inherited Create;
//  IncludeInsertFieldsInUpdateCommand := False;
end;

procedure TMSAccessSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
const
  IDENTITYSQL1 = 'SELECT @@IDENTITY';  {do not localize}
//  IDENTITYSQL2 = 'SELECT @@SCOPE_IDENTITY()';  {do not localize}
var
  IdentityField: String;
  ServiceCommand: TCustomSQLCommandEh;
  DataDriver: TCustomSQLDataDriverEh;
  Params: TParams;
  Cursor: TDataSet;
  FreeOnEof: Boolean;
begin
  DataDriver := Command.DataDriver;
//  if Command <> DataDriver.InsertCommand then Exit;
  if MemRec.UpdateStatus <> usInserted then Exit;
  IdentityField := DataDriver.SpecParams.Values['AUTO_INCREMENT_FIELD'];
  ServiceCommand := DataDriver.ServiceCommand;
  if IdentityField <> '' then
  begin
    ServiceCommand.CommandText.Text := IDENTITYSQL1;
    ServiceCommand.CommandType := cthSelectQuery;
    Params := ServiceCommand.GetParams;
    Params.Clear;
    ServiceCommand.SetParams(Params);
    try
      ServiceCommand.Execute(Cursor, FreeOnEof);
      // Get current Sequence value
      MemRec.DataValues[IdentityField, dvvValueEh] := Cursor.Fields[0].Value;
    finally
      if FreeOnEof then
        Cursor.Free;
    end;
  end;
end;

class function TMSAccessSpecOperationsEh.GetServerTypeName: String;
begin
  Result := 'MSAccess';
end;

{ TInfromixSpecOperationsEh }

constructor TInfromixSpecOperationsEh.Create;
begin
  inherited Create;
//  IncludeInsertFieldsInUpdateCommand := False;
end;

procedure TInfromixSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
const
  IDENTITYSQL = 'select DBINFO("sqlca.sqlerrd1") from systables where tabid=1';  {do not localize}
var
  IdentityField: String;
  ServiceCommand: TCustomSQLCommandEh;
  DataDriver: TCustomSQLDataDriverEh;
  Params: TParams;
  Cursor: TDataSet;
  FreeOnEof: Boolean;
begin
  DataDriver := Command.DataDriver;
//  if Command <> DataDriver.InsertCommand then Exit;
  if MemRec.UpdateStatus <> usInserted then Exit;
  IdentityField := DataDriver.SpecParams.Values['AUTO_INCREMENT_FIELD'];
  ServiceCommand := DataDriver.ServiceCommand;
  if IdentityField <> '' then
  begin
    ServiceCommand.CommandText.Text := IDENTITYSQL;
    ServiceCommand.CommandType := cthSelectQuery;
    Params := ServiceCommand.GetParams;
    Params.Clear;
    ServiceCommand.SetParams(Params);
    try
      ServiceCommand.Execute(Cursor, FreeOnEof);
      // Get current Sequence value
      MemRec.DataValues[IdentityField, dvvValueEh] := Cursor.Fields[0].Value;
    finally
      if FreeOnEof then
        Cursor.Free;
    end;
  end;
end;

class function TInfromixSpecOperationsEh.GetServerTypeName: String;
begin
  Result := 'Infromix';
end;

{ TDB2SpecOperationsEh }

procedure TDB2SpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin

end;

class function TDB2SpecOperationsEh.GetServerTypeName: String;
begin
  Result := 'DB2';
end;

{ TSybaseSpecOperationsEh }

procedure TSybaseSpecOperationsEh.GetBackUpdatedValues(MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet);
begin

end;

class function TSybaseSpecOperationsEh.GetServerTypeName: String;
begin
  Result := 'Sybase';
end;

{ TDynaSQLParamsEh }

constructor TDynaSQLParamsEh.Create(ADataDriver: TCustomSQLDataDriverEh);
begin
  inherited Create;
  FDataDriver := ADataDriver;
end;

destructor TDynaSQLParamsEh.Destroy;
begin
  inherited Destroy;
end;

procedure TDynaSQLParamsEh.Assign(Source: TPersistent);
begin
  if Source is TDynaSQLParamsEh then
  begin
    KeyFields := TDynaSQLParamsEh(Source).KeyFields;
    UpdateFields := TDynaSQLParamsEh(Source).UpdateFields;
    UpdateTable := TDynaSQLParamsEh(Source).UpdateTable;
    SkipUnchangedFields := TDynaSQLParamsEh(Source).SkipUnchangedFields;
    Options := TDynaSQLParamsEh(Source).Options;
  end else
    inherited Assign(Source);
end;

procedure TDynaSQLParamsEh.SetKeyFields(const Value: String);
begin
  FKeyFields := Value;
end;

procedure TDynaSQLParamsEh.SetUpdateFields(const Value: String);
begin
  FUpdateFields := Value;
end;

procedure TDynaSQLParamsEh.SetUpdateTable(const Value: String);
begin
  FUpdateTable := Value;
end;

{ TConnectionProviderEh }

procedure TConnectionProviderEh.AddPostponedActivationDataSet(ADataSet: TDataSet);
begin
//
end;

function TConnectionProviderEh.ConnectionIsPostponed: Boolean;
begin
  Result := False;
end;

constructor TConnectionProviderEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TConnectionProviderEh.Destroy;
begin
  FreeAndNil(FServerSpecOperations);
  inherited Destroy;
end;

procedure TConnectionProviderEh.DefaultGetUpdatedServerValues(
  SQLDataDriver: TCustomSQLDataDriverEh; MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean);
begin
  if GetServerSpecOperations <> nil then
  begin
    GetServerSpecOperations.GetBackUpdatedValues(MemRec, Command, ResDataSet);
    Processed := True;
  end else if Assigned(SQLDataDriver.ServerSpecOperations) then
  begin
    SQLDataDriver.ServerSpecOperations.GetBackUpdatedValues(MemRec, Command, ResDataSet);
    Processed := True;
  end else if SQLDataDriver.InternalGetServerSpecOperations <> nil then
  begin
    SQLDataDriver.InternalGetServerSpecOperations.GetBackUpdatedValues(MemRec, Command, ResDataSet);
    Processed := True;
  end;
end;

function TConnectionProviderEh.ExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof, Processed: Boolean): Integer;
begin
  Result := -1;
  if Assigned(OnExecuteCommand)
    then Result := OnExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed)
    else DefaultExecuteCommand(SQLDataDriver, Command, Cursor, FreeOnEof, Processed);
end;

function TConnectionProviderEh.DefaultExecuteCommand(
  SQLDataDriver: TCustomSQLDataDriverEh; Command: TCustomSQLCommandEh;
  var Cursor: TDataSet; var FreeOnEof: Boolean;
  var Processed: Boolean): Integer;
begin
  Result := -1;
  Processed := False;
end;

procedure TConnectionProviderEh.GetBackUpdatedValues(
  SQLDataDriver: TCustomSQLDataDriverEh; MemRec: TMemoryRecordEh;
  Command: TCustomSQLCommandEh; ResDataSet: TDataSet; var Processed: Boolean);
begin
  if Assigned(FOnGetBackUpdatedValues)
    then OnGetBackUpdatedValues(SQLDataDriver, MemRec, Command, ResDataSet, Processed)
    else DefaultGetUpdatedServerValues(SQLDataDriver, MemRec, Command, ResDataSet, Processed);
end;

function TConnectionProviderEh.GetServerSpecOperations: TServerSpecOperationsEh;
var
  Processed: Boolean;
begin
  Result := nil;
  Processed := False;
  if Assigned(OnGetServerSpecOperations) then
    OnGetServerSpecOperations(Processed, Result);

  if not Processed and Assigned(ServerSpecOperations) then
  begin
    Result := ServerSpecOperations;
    Processed := True;
  end;
end;

function TConnectionProviderEh.GetServerType: String;
begin
  if FServerSpecOperations <> nil
    then Result := FServerSpecOperations.GetServerTypeName
    else Result := '';
end;

function TConnectionProviderEh.GetServerTypes(AIndex: Integer): String;
begin
  Result := TServerSpecOperationsEhClass(ServerTypeClasses.Objects[AIndex]).GetServerTypeName;
end;

function TConnectionProviderEh.GetServerTypesCount: Integer;
begin
  Result := ServerTypeClasses.Count;
end;

procedure TConnectionProviderEh.SetServerType(const Value: String);
var
  NewSTIndex: Integer;
  DesignDataBaseIntf: IDesignDataBaseEh;
  FServerSpecOperationsClass: TServerSpecOperationsEhClass;
begin
  if Value <> GetServerType then
  begin
    FreeAndNil(FServerSpecOperations);
    FServerSpecOperationsClass := nil;
    if Value <> '' then
    begin
      NewSTIndex := ServerTypeClasses.IndexOf(Value);
      if NewSTIndex < 0 then
        raise Exception.Create('Server type with name "'+Value+'" does not exist.');
      FServerSpecOperationsClass := TServerSpecOperationsEhClass(ServerTypeClasses.Objects[NewSTIndex]);
      FServerSpecOperations := FServerSpecOperationsClass.Create;

    end;
    if (Supports(GetDesignDataBase, IDesignDataBaseEh, DesignDataBaseIntf)) then
    begin
      DesignDataBaseIntf.SetServerTypeAsServerSpecOperationsClass(FServerSpecOperationsClass);
    end;
  end;
end;

procedure TConnectionProviderEh.UpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; var Processed: Boolean);
begin
  if Assigned(FOnUpdateRecord) then
    FOnUpdateRecord(SQLDataDriver, MemTableData, MemRec, Processed);
  if not Processed then
    DefaultUpdateRecord(SQLDataDriver, MemTableData, MemRec, Processed);
end;

procedure TConnectionProviderEh.DefaultUpdateRecord(
  SQLDataDriver: TCustomSQLDataDriverEh; MemTableData: TMemTableDataEh;
  MemRec: TMemoryRecordEh; var Processed: Boolean);
begin
  if GetServerSpecOperations <> nil then
    GetServerSpecOperations.UpdateRecord(SQLDataDriver, MemTableData, MemRec)
  else if SQLDataDriver.InternalGetServerSpecOperations <> nil then
    SQLDataDriver.InternalGetServerSpecOperations.UpdateRecord(SQLDataDriver, MemTableData, MemRec)
  else
    SQLDataDriver.DoUpdateRecord(MemTableData, MemRec);
  Processed := True;
end;

function TConnectionProviderEh.GetDesignDataBase: TComponent;
begin
  Result := nil;
end;

function TConnectionProviderEh.ExecuteSQL(SQLText: String; AParams: TParams;
  var Processed: Boolean): Integer;
begin
  Processed := False;
  Result := 0;
end;

procedure TConnectionProviderEh.FillMemTableForSQL(SQLText: String;
  AParams: TParams; MemTableData: TMemTableDataEh; var Processed: Boolean);
var
  Cursor: TDataSet;
  FreeOnEof: Boolean;
  i: Integer;
  NewRec: TMemoryRecordEh;
begin
  GetDataReaderForSQL(SQLText, AParams, Cursor, FreeOnEof, Processed);
  if not Processed then Exit;
  MemTableData.DestroyTable;
  MemTableData.DataStruct.BuildStructFromFields(Cursor.Fields);
  while not Cursor.Eof do
  begin
    NewRec := MemTableData.RecordsList.NewRecord;
    for i := 0 to NewRec.DataStruct.Count-1 do
      NewRec.Value[i, dvvValueEh] := Cursor.Fields[i].AsVariant;
    MemTableData.RecordsList.FetchRecord(NewRec);
    Cursor.Next;
  end;
  if FreeOnEof then
    Cursor.Free;
end;

procedure TConnectionProviderEh.GetDataReaderForSQL(SQLText: String;
  AParams: TParams; var Cursor: TDataSet; var FreeOnEof, Processed: Boolean);
begin
  Processed := False;
end;

{ TMacroVarsEh }

procedure TMacroVarsEh.Assign(Source: TPersistent);
begin
  if Source is TMacroVarsEh then
  begin
    SpecMacros := TMacroVarsEh(Source).SpecMacros;
    SpecMacrosUsages := TMacroVarsEh(Source).SpecMacrosUsages;
    Macros := TMacroVarsEh(Source).Macros;
  end;
end;

constructor TMacroVarsEh.Create(ADataDriver: TCustomSQLDataDriverEh);
begin
  inherited Create;
  FDataDriver := ADataDriver;
  FSpecMacros := TSpecMacrosEh.Create(Self);
  FMacros := TStringVarsEh.Create(Self);
  FMacros.OnChange := MacrosChanged;
  FSpecMacrosUsages := [smuFilterAsWhereClauseEh, smuSortOrderAsOrderByClauseEh];
end;

destructor TMacroVarsEh.Destroy;
begin
  FreeAndNil(FSpecMacros);
  FreeAndNil(FMacros);
  inherited Destroy;
end;

procedure TMacroVarsEh.MacrosChanged(Sender: TObject);
begin
  FDataDriver.MacrosChanged;
end;

procedure TMacroVarsEh.ScanAllForMacros(var sl: TStringList);
begin
  ScanStrForMacros(DataDriver.SelectSQL.Text, sl);
  ScanStrForMacros(DataDriver.InsertSQL.Text, sl);
  ScanStrForMacros(DataDriver.UpdateSQL.Text, sl);
  ScanStrForMacros(DataDriver.DeleteSQL.Text, sl);
  ScanStrForMacros(DataDriver.GetrecSQL.Text, sl);
end;

procedure TMacroVarsEh.ScanStrForMacros(SrcStr: String; var sl: TStringList);
var
  i: Integer;
begin
  for i := 1 to Length(SrcStr) do
  begin
{ TODO : //Finish Scanning of Macros }
  end;
end;

procedure TMacroVarsEh.SetMacros(const Value: TStringVarsEh);
begin
  FMacros.Assign(Value);
end;

procedure TMacroVarsEh.SetSpecMacros(const Value: TSpecMacrosEh);
begin
  FSpecMacros.Assign(Value);
end;

procedure TMacroVarsEh.SetSpecMacrosUsages(const Value: TSpecMacrosUsagesEh);
begin
  FSpecMacrosUsages := Value;
end;

function TMacroVarsEh.SubstituteMacro(Text, MacroName, MacroValue: String): String;
var
  PosD, PosS, PosF: Integer;
{$IFDEF EH_LIB_14}
  Strb: TStringBuilder;
{$ELSE}
  Strb: String;
{$ENDIF}
begin
  PosD := 1;
{$IFDEF EH_LIB_14}
  Strb := TStringBuilder.Create(Length(Text));
{$ELSE}
  Strb := '';
{$ENDIF}
  try
    while True do
    begin
      PosS := PosEx(MacroName, Text, PosD);
      if PosS = 0 then
        Break;
      PosF := PosS + Length(MacroName);
      if (Length(Text) <= PosF + 1) and (Text[PosF + 1] = '%') then
      begin
{$IFDEF EH_LIB_14}
        Strb.Append(Copy(Text, PosD, PosF-PosD));
{$ELSE}
        Strb := Strb + Copy(Text, PosD, PosF-PosD);
{$ENDIF}
        PosD := PosF + 1;
      end else
      begin
{$IFDEF EH_LIB_14}
        Strb.Append(Copy(Text, PosD, PosS-PosD));
        Strb.Append(MacroValue);
{$ELSE}
        Strb := Strb + Copy(Text, PosD, PosS-PosD);
        Strb := Strb + MacroValue;
{$ENDIF}
        PosD := PosF;
      end;
    end;
{$IFDEF EH_LIB_14}
    Strb.Append(Copy(Text, PosD, Length(Text)-PosD+1));
    Result := Strb.ToString;
{$ELSE}
    Strb := Strb + Copy(Text, PosD, Length(Text)-PosD+1);
    Result := Strb;
{$ENDIF}
  finally
{$IFDEF EH_LIB_14}
    Strb.Free;
{$ELSE}
    Strb := '';
{$ENDIF}
  end;
end;

{ TSpecMacrosEh }

constructor TSpecMacrosEh.Create(AMacroVars: TMacroVarsEh);
begin
  inherited Create;
  FFilterMacroName := '%Filter%';
  FSortOrderMacroName := '%SortOrder%';
  FMacroVars := AMacroVars;
end;

procedure TSpecMacrosEh.Assign(Source: TPersistent);
begin
  if Source is TSpecMacrosEh then
  begin
    FilterMacroName := TSpecMacrosEh(Source).FilterMacroName;
    SortOrderMacroName := TSpecMacrosEh(Source).SortOrderMacroName;
  end;
end;

function TSpecMacrosEh.IsFilterMacroNameStored: Boolean;
begin
  Result := (FilterMacroName <> '%Filter%');
end;

function TSpecMacrosEh.IsSortOrderMacroNameStored: Boolean;
begin
  Result := (SortOrderMacroName <> '%SortOrder%');
end;

procedure TSpecMacrosEh.SetFilterMacroValue(const Value: String);
begin
  FFilterMacroValue := Value;
  FMacroVars.MacrosChanged(FMacroVars);
end;

procedure TSpecMacrosEh.SetSortOrderMacroValue(const Value: String);
begin
  FSortOrderMacroValue := Value;
  FMacroVars.MacrosChanged(FMacroVars);
end;


{ TCustomInlineConnectionEh }

procedure TCustomInlineConnectionEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

constructor TCustomInlineConnectionEh.Create(AConnectionProvider: TConnectionProviderEh);
begin
  inherited Create;
  FConnectionProvider := AConnectionProvider;

  {$IFDEF FPC}
  {$ELSE}
  FWinControl := TWinControl.Create(nil);
  FWndMethod := FWinControl.WindowProc;
  FWinControl.WindowProc := WinProg;
  FWinControl.ParentWindow := Application.Handle;
  {$ENDIF}
end;

destructor TCustomInlineConnectionEh.Destroy;
begin
  {$IFDEF FPC}
  {$ELSE}
  FreeAndNil(FWinControl);
  {$ENDIF}
  inherited Destroy;
end;

function TCustomInlineConnectionEh.GetConnected: Boolean;
begin
  // Write this method in the inherited DesignConnections
  Result := False;
end;

procedure TCustomInlineConnectionEh.SetConnected(const Value: Boolean);
begin
  {$IFDEF FPC}
  {$ELSE}
  if (csReading in ConnectionProvider.ComponentState) and Value then
    FReadingTimeConnected := True
  else
  {$ENDIF}
    SetDesignConnected(Value);
end;

procedure TCustomInlineConnectionEh.SetConnectionFileName(const Value: String);
begin
  FConnectionFileName := Value;
end;

procedure TCustomInlineConnectionEh.SetDesignConnected(const Value: Boolean);
begin
  // Write this method in the inherited DesignConnections
end;

procedure TCustomInlineConnectionEh.SetKeepConnectionInfoInFile(
  const Value: Boolean);
begin
  FKeepConnectionInfoInFile := Value;
end;

procedure TCustomInlineConnectionEh.Open;
begin
  Connected := True;
end;

procedure TCustomInlineConnectionEh.Close;
begin
  Connected := False;
end;

procedure TCustomInlineConnectionEh.Loaded;
begin
{$IFDEF DESIGNTIME}
  if csDesigning in ConnectionProvider.ComponentState then
{$ENDIF}
    try
      {$IFDEF FPC}
      {$ELSE}
      if FReadingTimeConnected then
      begin
  //      ShowMessage('Path:' + ConnectionProvider.Path);
        PostMessage(FWinControl.Handle, WM_USER, 0, 0);
  //      SetConnected(True);
      end;
      {$ENDIF}
    except
      if csDesigning in ConnectionProvider.ComponentState then
        if Assigned(Classes.ApplicationHandleException) then
          Classes.ApplicationHandleException(ExceptObject)
        else
          ShowException(ExceptObject, ExceptAddr)
      else
        raise;
    end;
end;

{$IFDEF FPC}
{$ELSE}
procedure TCustomInlineConnectionEh.WinProg(var Message: TMessage);
begin
  FWndMethod(Message);
  if Message.Msg = WM_USER then
  begin
    SetConnected(True);
  end;
end;
{$ENDIF}

initialization
  InitializeUnit;
finalization
  FinalizaUnit;
end.

