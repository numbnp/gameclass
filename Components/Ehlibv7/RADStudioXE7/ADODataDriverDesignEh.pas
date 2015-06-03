{*******************************************************}
{                                                       }
{                     EhLib v7.0                        }
{                                                       }
{         TADODesignDataBaseEh (Build 7.0.03)           }
{                                                       }
{     Copyright (c) 2004-2013 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit ADODataDriverDesignEh;

{$I EHLIB.INC}

interface

{$IFDEF CIL}

//{$R DBXDataDriverEh.TDBXDataDriverEh.bmp}
{$R ADODataDriverEh.TADODataDriverEh.bmp}
//{$R BDEDataDriverEh.TBDEDataDriverEh.bmp}

{$ENDIF}

uses Windows, SysUtils, Classes, Controls, DB,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh, ADODB, Dialogs,
  SQLDriverEditEh, ADODataDriverEh, ComCtrls, MemTableEh, Forms,
  UpdateSQLEditEh;

type

(*{ IADODesignDataBaseEh }

  IADODesignDataBaseEh = interface
  ['{9E53BD33-4E5E-414F-9E4A-4980A8F7637A}']
    function GetConnection: TADOConnection;
  end;*)

{ TADODesignDataBaseEh }

  TADODesignDataBaseEh = class(TDesignDataBaseEh)//, IADODesignDataBaseEh)
  private
    FTablesMT: TMemTableEh;
    FColumnsMT: TMemTableEh;
    FConnection: TADOConnection;
    FTreeNodeMan: TCustomDBService;
    FDBServiceClass: TCustomDBServiceClass;
    FSpecParamsServiceClass: TCustomDBServiceClass;
    FApplicationConnection: TADOConnection;
    procedure SetApplicationConnection(const Value: TADOConnection);
  protected
    function GetConnected: Boolean; override;
    procedure SetConnected(const Value: Boolean); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(IsPublicDataBase: Boolean; AConProvider: TComponent); override;
    destructor Destroy; override;
    function GetEngineName: String; override;
    function ServerTypeName: String;
    function CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh; override;
    function DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    function GetConnection: TADOConnection;
    function BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; override;
    function BuildObjectTree(List: TList): Boolean; override;
    function GetConProvider: TADOConnectionProviderEh;
    function GetIADOConProvider: IADOConnectionProviderEh;
    function BuildOracleObjectTree(TreeView: TTreeView): Boolean;
    function GetFieldList(const TableName: string; DataSet: TDataSet): Boolean; override;
    function GetSpecParamsList: String; override;
    function SupportCustomSQLDataDriver: Boolean; override;
    function GetCustomDBService: TCustomDBService; override;
    function Description: String; override;
    function CanBuildTreeDataSet(var StrReasonOfInable: String): Boolean; override;
    function CanFormSpecParamsList(var StrReasonOfInable: String): Boolean; override;
    procedure EditDatabaseParams; override;
    procedure SetServerTypeAsServerSpecOperationsClass(const Value: TServerSpecOperationsEhClass); override;
    property DBServiceClass: TCustomDBServiceClass read FDBServiceClass;
    property ApplicationConnection: TADOConnection read FApplicationConnection write SetApplicationConnection;
  end;

{ TADOAccessEngineEh }

  TADOAccessEngineEh = class(TAccessEngineEh)
    function AccessEngineName: String; override;
    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
      DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh; override;
//    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh): TDesignDataBaseEh; override;
  end;

{ TADODesignDataBaseEh }

  TADOUniService = class(TCustomDBService)
  private
    FDesignDB: TDesignDataBaseEh;
    FSpecPraramsService: TCustomDBService;
    FNoAskForSpecPraramsService: Boolean;
  protected
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; override;
  public
    constructor Create(ADesignDB: TDesignDataBaseEh); override;
    destructor Destroy; override;
    function GetSpecParamsList: String; override;
    function ShowPopup(Source: TObject; Coord: TPoint; Params: TServicePopupParams): Integer; override;
    procedure GenGetSpecParams(DesignUpdateParams: TDesignUpdateParamsEh; DesignUpdateInfo: TDesignUpdateInfoEh); override;
    class function GetDBServiceName: String; override;
  end;

{ TADODataDriverEditInteractorEh }

  TADODataDriverEditInteractorEh = class(TDataDriverEditInteractorEh)
    class procedure AssignEditDataToCommant(SQLText: String; mtParams: TMemTableEh; Command: TCustomSQLCommandEh); override;
    class procedure AssignCommantToEditData(Command: TCustomSQLCommandEh; SQLText: String; mtParams: TMemTableEh); override;
    class procedure RefreshParams(Command: TCustomSQLCommandEh; SQLEditWin:TSQLDataEditWin); override;
    class procedure DesignDataBaseReassigned(SQLEditWin: TSQLDataEditWin); override;
  end;

{ TADOConnectionProviderDesignSerivceEh }

  TADOConnectionProviderDesignSerivceEh = class(TConnectionProviderDesignSerivceEh)
    function EditDesignData(ConnectionProvider: TConnectionProviderEh): Boolean; override;
    function CreateDesignDataBase(ConnectionProvider: TComponent): TComponent; override;
  end;

procedure UnregisterADOAccessEngines;
procedure RegisterADOAccessEngines;

procedure Register;

implementation

uses
{$IFDEF CIL}
  Borland.Vcl.Design.AdoConEd,
  Borland.Vcl.Design.AdoDBReg,
{$ELSE}
  AdoConEd,
{$ENDIF}
{$IFDEF DESIGNTIME}
	MemTableDesignEh, StorablePropsDesignIntfEh,
{$IFDEF CIL}
  Borland.Vcl.Design.DesignIntf,
  Borland.Vcl.Design.DesignEditors,
{$ELSE}
  {$IFDEF EH_LIB_6}
     DesignIntf,
     DesignEditors,
  {$ELSE} //EH_LIB_6
      DsgnIntf,
  {$ENDIF}
  DBReg,
  ADOReg,
{$ENDIF}
{$ENDIF}
  FormSelectFromList, DesignConnectionListEh, SelectFromListDialog,
  ADOConnectionProviderDesignEdit, ComObj, EhLibDesignAbout, EhLibReg;

(* how to get explain plan in  MSSQL
1. Use SET SHOWPLAN_TEXT { ON | OFF } или SET SHOWPLAN_ALL { ON | OFF } or analog
i.e. on the example add at the begining of SQL SET SHOWPLAN_ALL ON
at the end SET SHOWPLAN_ALL OFF.
Send to server and as aa result we will get result as we needed.
*)

function GetServerName(IBDatabase: TADOConnection; var ServerName: String): Boolean;
begin
  ServerName := 'MSACCESS';//AnsiUpperCase(IBDatabase.DriverName);
  Result := True;
end;

//var
//  DataBaseInc: Integer = 0;

function GUISelectADOAccessEngine(SelectDBService: TSelectDBService): Boolean;
var
  f: TfSelectFromList;
begin
  Result := False;
  f := TfSelectFromList.Create(Application);
  f.cbEngine.Items := AccessEngineList;
  f.cbEngine.ItemIndex := f.cbEngine.Items.IndexOf('ADO');
  f.cbEngine.Enabled := False;
  f.cbDBService.Items := GetDBServiceList;
  f.eDataBaseName.Text := SelectDBService.DBName;
  f.DBServiceEngineList := GetDBServiceEngineList;
  if f.ShowModal = mrOk then
  begin
    if f.cbEngine.ItemIndex >= 0
      then SelectDBService.AccessEngine := TAccessEngineEh(AccessEngineList.Objects[f.cbEngine.ItemIndex])
      else SelectDBService.AccessEngine := nil;
    if f.cbDBService.ItemIndex >= 0
      then SelectDBService.DBServiceClass := TCustomDBServiceClass(f.cbDBService.Items.Objects[f.cbDBService.ItemIndex])
//      then SelectDBService.DBServiceClass := TCustomDBServiceClass(DBServiceList.Objects[f.cbDBService.ItemIndex])
      else SelectDBService.DBServiceClass := nil;
    SelectDBService.DBName := f.eDataBaseName.Text;
    Result := True;
  end;
  f.Free;
end;

{function GetUnicalDataBaseName: String;
begin
  Inc(DataBaseInc);
  Result := 'ADODataDriverEhDataBaseName' + IntToStr(DataBaseInc);
end;
}

{function CreateDesignDataBase(DataDriver: TADODataDriverEh): TComponent;
var
  DesignDataBase: TADODesignDataBaseEh;
//  SourceIBDatabase: TADOConnection;
begin
  DesignDataBase :=  TADODesignDataBaseEh.Create;
//  SourceIBDatabase := TADOConnection.Create(nil);
  if DataDriver.ADOConnection <> nil then
  begin
    DesignDataBase.FConnection.ConnectionString := DataDriver.ADOConnection.ConnectionString;
  end;
//    SourceIBDatabase.FDBEDataBase.DatabaseName := GetUnicalDataBaseName;
  Result := DesignDataBase;
end;
}

procedure SetDesignADODataBaseProcEh(DataDriver: TCustomSQLDataDriverEh);
var
  i: Integer;
  DesignDataBase: TComponent;
  sdb: TSelectDBService;
  ADODesignDataBase: TADODesignDataBaseEh;
  ADODataDriver: TADODataDriverEh;
begin
  ADODataDriver := (DataDriver as TADODataDriverEh);
  if DataDriver.DesignDataBase = nil then
  begin
//    ConnectionString

    for i := 0 to GetDesignDataBaseList.Count-1 do
      if TDesignDataBaseEh(GetDesignDataBaseList[i]).DesignDataBaseConnetionEqual(DataDriver) then
      begin
        DataDriver.DesignDataBase := TComponent(GetDesignDataBaseList[i]);
        Exit;
      end;

    if (ADODataDriver.ADOConnection <> nil) and ADODataDriver.ADOConnection.Connected then
      ;

    if GetDesignDataBaseList.Count > 0 then
    begin
      DesignDataBase := SelectDesignConnectionListEh(DesignDataBaseList);
      if (DesignDataBase <> nil) and (DesignDataBase <> DataDriver.DesignDataBase) then
        DataDriver.DesignDataBase := DesignDataBase;
    end else
    begin
      sdb := TSelectDBService.Create;
      sdb.DBName := 'DesingConnection1';
      if GUISelectADOAccessEngine(sdb) and (sdb.AccessEngine <> nil) then
      begin
        if sdb.AccessEngine is TADOAccessEngineEh then
        begin
          ADODesignDataBase := TADODesignDataBaseEh.Create(True, nil);
          ADODesignDataBase.FDBServiceClass := sdb.DBServiceClass;
          ADODesignDataBase.DesignConnectionName := sdb.DBName;
          if (ADODesignDataBase is TADODesignDataBaseEh) and
              (DataDriver is TADODataDriverEh) and
              (TADODataDriverEh(DataDriver).ADOConnection <> nil)
          then
          begin
            ADODesignDataBase.FConnection.ConnectionString :=
              TADODataDriverEh(DataDriver).ADOConnection.ConnectionString;
            ADODesignDataBase.ApplicationConnection := TADODataDriverEh(DataDriver).ADOConnection;
          end;
          ADODesignDataBase.EditDatabaseParams;
          DataDriver.DesignDataBase := ADODesignDataBase;
        end else
          DataDriver.DesignDataBase :=
            sdb.AccessEngine.CreateDesignDataBase(DataDriver, sdb.DBServiceClass, sdb.DBName);
      end;
      sdb.Free;
    end;
//    DataDriver.DesignDataBase := CreateDesignDataBase(TADODataDriverEh(DataDriver));
  end;
end;

{ TADODesignDataBaseEh }

function TADODesignDataBaseEh.BuildObjectTree(List: TList): Boolean;
var
  NList: Tlist;
  i: Integer;
begin
  Result := False;
  if Assigned(FDBServiceClass) then
  begin
    if FTreeNodeMan <> nil then
      FTreeNodeMan.Free;
    FTreeNodeMan := FDBServiceClass.Create(Self);
    NList := FTreeNodeMan.CreateRootNodes;
    List.Clear;
    for I := 0 to NList.Count - 1 do
      List.Add(NList[I]);

    NList.Free;
    Result := True;
  end;
end;

function TADODesignDataBaseEh.CanBuildTreeDataSet(var StrReasonOfInable: String): Boolean;
begin
  Result := inherited CanBuildTreeDataSet(StrReasonOfInable);
  if not IsPublicDataBase and (FDBServiceClass = nil) then
  begin
    Result := False;
    StrReasonOfInable := 'Unable to build data tree. ConnectionProvider.ServerType is not assigned.'
  end;
end;

function TADODesignDataBaseEh.CanFormSpecParamsList(var StrReasonOfInable: String): Boolean;
begin
  Result := inherited CanBuildTreeDataSet(StrReasonOfInable);
  if not IsPublicDataBase and (FSpecParamsServiceClass = nil) then
  begin
    Result := False;
    StrReasonOfInable := 'Unable to form list of SpecParams. ConnectionProvider.ServerType is not assigned.'
  end;
end;

function TADODesignDataBaseEh.BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := EditDataDriverUpdateSQL(DataDriver as TCustomSQLDataDriverEh);// UpdateSQLEditEh
end;

constructor TADODesignDataBaseEh.Create(IsPublicDataBase: Boolean; AConProvider: TComponent);
begin
  inherited Create(IsPublicDataBase, AConProvider);
  if AConProvider = nil then
    FConnection := TADOConnection.Create(Application);
  FTablesMT := TMemTableEh.Create(nil);
  FColumnsMT := TMemTableEh.Create(nil);
end;

destructor TADODesignDataBaseEh.Destroy;
begin
//  FConnection.Free; Will be deleted in TApplication
  FreeAndNil(FTablesMT);
  FreeAndNil(FColumnsMT);
  FreeAndNil(FTreeNodeMan);
  inherited Destroy;
end;

function TADODesignDataBaseEh.CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh;
begin
  Result := TADODataDriverEh.Create(nil);
  Result.SelectCommand := RTDataDriver.SelectCommand;
  Result.UpdateCommand := RTDataDriver.UpdateCommand;
  Result.InsertCommand := RTDataDriver.InsertCommand;
  Result.DeleteCommand := RTDataDriver.DeleteCommand;
  Result.GetrecCommand := RTDataDriver.GetrecCommand;
  TADODataDriverEh(Result).SpecParams := TADODataDriverEh(RTDataDriver).SpecParams;
  TADODataDriverEh(Result).ADOConnection := FConnection;
  TADODataDriverEh(Result).ConnectionProvider :=  TADODataDriverEh(RTDataDriver).ConnectionProvider;
end;

function TADODesignDataBaseEh.DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := False;
  if DataDriver is TADODataDriverEh then
  begin
    if TADODataDriverEh(DataDriver).ADOConnection <> nil then
      Result := (ApplicationConnection = TADODataDriverEh(DataDriver).ADOConnection)
    else
      Result := (FConnection.ConnectionString = TADODataDriverEh(DataDriver).ConnectionString);
  end;  
end;

function TADODesignDataBaseEh.Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
begin
  Result := -1;
  FreeOnEof := True;
  with Command do
    case CommandType of
      cthSelectQuery, cthUpdateQuery:
        begin
          Cursor := TADOQuery.Create(nil);
          with Cursor as TADOQuery do
          begin
            Connection := GetConnection;
            SQL.Text := Command.FinalCommandText.Text;
            if Command is TADOCommandEh
              then Parameters := TADOCommandEh(Command).Parameters
              else Parameters.Assign(Command.GetParams);
            if CommandType = cthSelectQuery then
              Open
            else
            begin
              ExecSQL;
              Result := RowsAffected;
            end;
          end;
        end;
      cthTable:
        begin
          Cursor := TADOTable.Create(nil);
          with Cursor as TADOTable do
          begin
            Connection := GetConnection;
            TableName := Command.FinalCommandText.Text;
//            Params := Command.Params;
            Open;
          end;
        end;
      cthStoredProc:
        begin
          Cursor := TADOStoredProc.Create(nil);
          with Cursor as TADOStoredProc do
          begin
            Connection := GetConnection;
            ProcedureName := Command.FinalCommandText.Text;
            if Command is TADOCommandEh
              then Parameters := TADOCommandEh(Command).Parameters
              else Parameters.Assign(Command.GetParams);
            ExecProc;
          end;
        end;
    end;
end;

function TADODesignDataBaseEh.GetConnection: TADOConnection;
begin
  Result := nil;
  if FConnection <> nil then
    Result := FConnection
  else if GetConProvider <> nil then
    if GetConProvider.InlineConnection.UseAtDesignTime then
      Result := GetConProvider.InlineConnection.Connection
    else
      Result := GetConProvider.Connection
  else if GetIADOConProvider <> nil then
    Result := GetIADOConProvider.GetConnection;
end;

function TADODesignDataBaseEh.ServerTypeName: String;
var
  Description: String;
begin
//  if not SQLCo.Connected then
//    FDBEDataBase.Open;
  if GetServerName(GetConnection, Description) then
  begin
    Result := UpperCase(Description);
  end;
end;

function TADODesignDataBaseEh.CreateReader(SQL: String; FParams: TParamsArr): TDataSet;
var
  Query: TADOQuery;
  i: Integer;
  dt: TFieldType;
  p: TParam;
  Params: TParams;
begin
  Query := TADOQuery.Create(nil);
  Query.Connection := GetConnection;
  Query.SQL.Text := SQL;
  Params := TParams.Create;
  try
    if High(FParams) > Low(FParams) then
      for i := Low(FParams) to High(FParams) div 2 do
      begin
        dt := VarTypeToDataType(VarType(FParams[i*2+1]));
        if dt = ftUnknown then
          dt := ftString;
        p := Params.CreateParam(dt, FParams[i*2], ptInputOutput);
        p.Value := FParams[i*2+1];
      end;
    Query.Parameters.Assign(Params);
  finally
    Params.Free;
  end;
  try
    Query.Open;
  except
    Query.Free;
    raise;
  end;
  Result := Query;
end;

function TADODesignDataBaseEh.BuildOracleObjectTree(TreeView: TTreeView): Boolean;
begin
  Result := False;
end;

procedure TADODesignDataBaseEh.EditDatabaseParams;
begin
  EditConnectionString(FConnection);
//  inherited;
end;

function TADODesignDataBaseEh.GetEngineName: String;
begin
  Result := 'ADO';
end;

function TADODesignDataBaseEh.GetConnected: Boolean;
begin
  Result := (GetConnection <> nil) and GetConnection.Connected;
end;

procedure TADODesignDataBaseEh.SetConnected(const Value: Boolean);
begin
  if GetConnection <> nil then
    GetConnection.Connected := Value;
end;

function TADODesignDataBaseEh.SupportCustomSQLDataDriver: Boolean;
begin
  Result := True;
end;

function TADODesignDataBaseEh.GetFieldList(const TableName: string;
  DataSet: TDataSet): Boolean;
var
  table: TADOTable;
  list: TStrings;
  i: Integer;

  procedure GetDataFieldNames(Dataset: TDataset; ErrorName: string; List: TStrings);
  var
    I: Integer;
  begin
    with Dataset do
    try
      FieldDefs.Update;
      List.BeginUpdate;
      try
        List.Clear;
        for I := 0 to FieldDefs.Count - 1 do
          List.Add(FieldDefs[I].Name);
      finally
        List.EndUpdate;
      end;
    except
      if ErrorName <> '' then
        MessageDlg(Format('SSQLDataSetOpen', [ErrorName]), mtError, [mbOK], 0);
    end;
  end;

  procedure SetKeyFields;
  var
    SepPos, I, Index: Integer;
    FName, FieldNames: string;
  begin
    table.IndexDefs.Update;
    for I := 0 to table.IndexDefs.Count - 1  do
      if ixPrimary in table.IndexDefs[I].Options then
      begin
        FieldNames := table.IndexDefs[I].Fields + ';';
        while Length(FieldNames) > 0 do
        begin
          SepPos := Pos(';', FieldNames);
          if SepPos < 1 then Break;
          FName := Copy(FieldNames, 1, SepPos - 1);
{$IFDEF CIL}
          Borland.Delphi.System.Delete(FieldNames, 1, SepPos);
{$ELSE}
          System.Delete(FieldNames, 1, SepPos);
{$ENDIF}
          Index := list.IndexOf(FName);
          if Index > -1 then list.Objects[Index] := TObject(1);
        end;
        break;
      end;
  end;

begin
  Result := False;
  table := TADOTable.Create(nil);
  try
  table.Connection := GetConnection;
  if table.Connection = nil then
  begin
    ShowMessage('DataBase is not Connected.');
    Exit;
  end;
  table.TableName := TableName;
  list := TStringList.Create;
  GetDataFieldNames(table, 'Error', list);
  SetKeyFields;
  for i := 0 to list.Count-1 do
    if list.Objects[i] = TObject(1)
      then DataSet.AppendRecord([list[i], True])
      else DataSet.AppendRecord([list[i], False]);
  list.Free;
  finally
    table.Free;
  end;  
  Result := True;
end;

function TADODesignDataBaseEh.GetSpecParamsList: String;
var
  FSpecParams: TCustomDBService;
begin
  if FSpecParamsServiceClass <> nil then
  begin
    FSpecParams := FSpecParamsServiceClass.Create(Self);
    Result := FSpecParams.GetSpecParamsList;
    FSpecParams.Free;
  end else if FTreeNodeMan <> nil then
  begin
    Result := FTreeNodeMan.GetSpecParamsList;
  end;
end;

function TADODesignDataBaseEh.GetCustomDBService: TCustomDBService;
begin
  Result := FTreeNodeMan;
end;

procedure TADODesignDataBaseEh.SetApplicationConnection(const Value: TADOConnection);
begin
  if FApplicationConnection <> Value then
  begin
    FApplicationConnection := Value;
    if FApplicationConnection <> nil then
      FApplicationConnection.FreeNotification(Self);
  end;
end;

procedure TADODesignDataBaseEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FApplicationConnection = AComponent)
  then
    FApplicationConnection := nil;
end;

procedure TADODesignDataBaseEh.SetServerTypeAsServerSpecOperationsClass(
  const Value: TServerSpecOperationsEhClass);
begin
//  FDBServiceClass := GetDBServiceByServerSpecOperationsClass(Value);
  FSpecParamsServiceClass := GetDBServiceByServerSpecOperationsClass(Value);
  FDBServiceClass := TADOUniService;
{  if FSpecParamsServiceClass <> Value then
  begin
    ResetDesignInfo;
    FreeAndNil(FTreeNodeMan);
  end;}
end;

function TADODesignDataBaseEh.Description: String;
begin
  if GetConnection <> nil then
    Result := GetConnection.ConnectionString;
end;

function TADODesignDataBaseEh.GetConProvider: TADOConnectionProviderEh;
begin
  if FConProvider is TADOConnectionProviderEh
    then Result := TADOConnectionProviderEh(FConProvider)
    else Result := nil;
end;

function TADODesignDataBaseEh.GetIADOConProvider: IADOConnectionProviderEh;
begin
  Supports(FConProvider, IADOConnectionProviderEh, Result);
end;

{ TADOAccessEngineEh }

function TADOAccessEngineEh.AccessEngineName: String;
begin
  Result := 'ADO';
end;

//function TADOAccessEngineEh.CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh): TDesignDataBaseEh;
function TADOAccessEngineEh.CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
  DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh;
var
  ADODesignDataBase: TADODesignDataBaseEh;
begin
  ADODesignDataBase := TADODesignDataBaseEh.Create(True, nil);
  ADODesignDataBase.FDBServiceClass := DBServiceClass;
  ADODesignDataBase.EditDatabaseParams;
  Result := ADODesignDataBase;
//  DataDriver.DesignDataBase := ADODesignDataBase;
end;

procedure RegisterADOAccessEngines;
var
  Engine: TADOAccessEngineEh;
begin
  RegisterDesignDataBuilderProcEh(TADODataDriverEh, SetDesignADODataBaseProcEh);
  Engine := TADOAccessEngineEh.Create;
  RegisterAccessEngine('ADO', Engine);
  RegisterDBServiceEngine(Engine, TADOUniService);
  RegisterDBServiceEngine(Engine, TMSSQLDBService);
  RegisterDBServiceEngine(Engine, TOracleDBService);
  RegisterDBServiceEngine(Engine, TInterbaseDBService);
  RegisterDBServiceEngine(Engine, TInformixDBService);
  RegisterDBService('ADOUniService', TADOUniService);
  RegisterDataDriverEditInteractorEh(TADODataDriverEditInteractorEh, TADODataDriverEh);
  ADOConnectionProviderDesignService := TADOConnectionProviderDesignSerivceEh.Create;
end;

procedure UnregisterADOAccessEngines;
begin
  UnregisterDesignDataBuilderProcEh(TADODataDriverEh);
  UnregisterAccessEngine('ADO');
  UnregisterDBServiceEngine(TADOUniService);
  UnregisterDBServiceEngine(TMSSQLDBService);
  UnregisterDBServiceEngine(TOracleDBService);
  UnregisterDBServiceEngine(TInterbaseDBService);
  UnregisterDBServiceEngine(TInformixDBService);
  UnregisterDBService('ADOUniService');
  UnregisterDataDriverEditInteractorEh(TADODataDriverEditInteractorEh);
  ADOConnectionProviderDesignService := nil; //Not Free, Interface
//  UnregisterDBServiceEngine(Engine, BDEUniService);
end;

{ TADOUniService }

constructor TADOUniService.Create(ADesignDB: TDesignDataBaseEh);
var
  Template: TSQLTreeNodeTemplate;
begin
  inherited Create(ADesignDB);
  FDesignDB := ADesignDB;

  AddSQLClass('ServerItems', 'ServerItems');
  AddSQLClass('Tables', 'Tables');
  AddSQLClass('Views', 'Views');
  AddSQLClass('Synonyms', 'Synonyms');
  AddSQLClass('SystemTables', 'SystemTables');
  AddSQLClass('TableColumns', 'TableColumns');
  AddSQLClass('Procedures', 'Procedures');
  AddSQLClass('ProcedureParameters', 'ProcedureParameters');

//Some ADO Server
  Template := TSQLTreeNodeTemplate.Create(Self, 'ADO Server');
  with Template do
  begin
    NodesSQLClassName :=  'ServerItems';
    MasterTemplateName := '';
    NodesMemTableName :=  'ServerItems';
    // Params             [], //Params
    ObjIdFieldName :=     'OBJ_NAME';
    InTreeTextFieldName :='OBJ_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'OBJ_NAME';
    //ColumnAttributesStr :=
  end;

//Tables
  Template := TSQLTreeNodeTemplate.Create(Self, 'Tables');
  with Template do
  begin
    NodesSQLClassName :=  'Tables';
    MasterTemplateName := 'Tables';
    NodesMemTableName :=  'TableObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'TABLE_NAME';
    InTreeTextFieldName :='TABLE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid := 'TABLE_NAME';
    ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
    '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
    '"TABLE_SCHEMA", "Table Schema", 100 ';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//Views
  Template := TSQLTreeNodeTemplate.Create(Self, 'Views');
  with Template do
  begin
    NodesSQLClassName :=  'Views';
    MasterTemplateName := 'Views';
    NodesMemTableName :=  'ViewObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'TABLE_NAME';
    InTreeTextFieldName :='TABLE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid := 'TABLE_NAME';
    ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
    '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
    '"TABLE_SCHEMA", "Table Schema", 100 ';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//Sinonims
  Template := TSQLTreeNodeTemplate.Create(Self, 'Synonyms');
  with Template do
  begin
    NodesSQLClassName :=  'Synonyms';
    MasterTemplateName := 'Synonyms';
    NodesMemTableName :=  'SynonymObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'TABLE_NAME';
    InTreeTextFieldName :='TABLE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid := 'TABLE_NAME';
    ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
    '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
    '"TABLE_SCHEMA", "Table Schema", 100 ';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//SystemTables
  Template := TSQLTreeNodeTemplate.Create(Self, 'SystemTables');
  with Template do
  begin
    NodesSQLClassName :=  'SystemTables';
    MasterTemplateName := 'SystemTables';
    NodesMemTableName :=  'SystemTableObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'TABLE_NAME';
    InTreeTextFieldName :='TABLE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid := 'TABLE_NAME';
    ColumnAttributesStr := '"TABLE_NAME", "Table Name", "100", ' +
    '"DESCRIPTION", "Description", 100, "TABLE_CATALOG", "Table Catalog", 100, ' +
    '"TABLE_SCHEMA", "Table Schema", 100 ';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//TableColumns
  Template := TSQLTreeNodeTemplate.Create(Self, 'TableColumns');
  with Template do
  begin
    NodesSQLClassName :=  'TableColumns';
    MasterTemplateName := '';
    NodesMemTableName :=  'TableColumns';
    // Params             [], //Params
    ObjIdFieldName :=     'ID';
    InTreeTextFieldName :='COLUMN_NAME';
    HasNodes :=           False;
    NodesFilter :=        '[TABLE_NAME] = ''%[TABLE_NAME]''';
//    NodesFieldsInGrid :=  'COLUMN_NAME;DATA_TYPE;IS_NULLABLE;COLUMN_DEFAULT';
    ColumnAttributesStr :='"COLUMN_NAME", "Column name", "100", '+
      '"DATA_TYPE",  "Type", "50", '+
      '"IS_NULLABLE", "Can Null", "20", ' +
      '"COLUMN_DEFAULT", "Def. Value", "50" ';
    OnNodeDragDrop := Template.TableEditorDrop;
  end;

//Procedures
  Template := TSQLTreeNodeTemplate.Create(Self, 'Procedures');
  with Template do
  begin
    NodesSQLClassName :=  'Procedures';
    MasterTemplateName := 'Procedures';
    NodesMemTableName :=  'ProceduresObjects';
    // Params             [], //Params
    ObjIdFieldName :=     'PROCEDURE_NAME';
    InTreeTextFieldName :='PROCEDURE_NAME';
    HasNodes :=           True;
    NodesFilter :=        '';
//    NodesFieldsInGrid :=  'PROCEDURE_NAME';
    ColumnAttributesStr := '"PROCEDURE_NAME", "Name", "100", ' +
    '"DESCRIPTION", "Description", 100, ' +
    '"PROCEDURE_TYPE", "Type", 30, ' +
    '"PROCEDURE_CATALOG", "Catalog", 100, ' +
    '"PROCEDURE_SCHEMA", "Schema", 100, ' +
    '"PROCEDURE_DEFINITION", "Definition", 100 ';
  end;

//Parameters
  Template := TSQLTreeNodeTemplate.Create(Self, 'ProcedureParameters');
  with Template do
  begin
    NodesSQLClassName :=  'ProcedureParameters';
    MasterTemplateName := '';
    NodesMemTableName :=  'ProcedureParameters';
    // Params             [], //Params
    ObjIdFieldName :=     'ID';
    InTreeTextFieldName :='PARAMETER_NAME';
    HasNodes :=           False;
    NodesFilter :=        '[PROCEDURE_NAME] = ''%[PROCEDURE_NAME]''';
//    NodesFieldsInGrid :=  'PARAMETER_NAME;DATA_TYPE;IS_RESULT';
    ColumnAttributesStr :='"PARAMETER_NAME", "Param name", "100", '+
      '"DATA_TYPE",  "Type", "50", '+
      '"IS_RESULT", "Is Result", "20"';
  end;

(*
//Views
  TSQLTreeNodeTemplate.Create(
    Self,
    'Views',
    'Views', //NodesSQLClassName

    'Views', //MasterTemplateName
    'ViewsObjects', //NodesMemTableName
    [], //Params
    'TABLE_NAME', //ObjIdFieldName
    'TABLE_NAME', //InTreeTextFieldName
    True,
    '',
    'TABLE_NAME',
    '"TABLE_NAME", "View name", "200" '
    );

*)
end;

destructor TADOUniService.Destroy;
begin
  FreeAndNil(FSpecPraramsService);
  inherited Destroy;
end;

function TADOUniService.ShowPopup(Source: TObject; Coord: TPoint;
  Params: TServicePopupParams): Integer;
begin
  Result := -1;
end;

function TADOUniService.CreateReader(SQL: String; FParams: TParamsArr): TDataSet;
var
  Connection: TADOConnection;
  ADOReader: TADODataSet;
  Reader: TMemTableEh;
  DataField: TMTDataFieldEh;

  procedure CreateAdditionalFields(DataStruct: TMTDataStructEh);
  begin
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
    DataField.FieldName := 'TEMPLATE_NAME';
    DataField.Size := 20;
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
    DataField.FieldName := 'NODES_SQLCLASS_NAME';
    DataField.Size := 20;
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
    DataField.FieldName := 'LOCAL_FILTER';
    DataField.Size := 20;
    DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTNumericDataFieldEh);
    DataField.FieldName := 'Image_Index';
  end;
begin
  Connection := TADODesignDataBaseEh(FDesignDB).GetConnection;
//  Connection.CheckActive;
  Reader := nil;
  ADOReader := TADODataSet.Create(nil);
  try
    if SQL = 'ServerItems' then
    begin
      Reader := TMemTableEh.Create(nil);
//Build Struct
      DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
      DataField.FieldName := 'OBJ_NAME';
      DataField.Size := 20;
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
//      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      Reader.Open;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Tables';
      Reader['TEMPLATE_NAME'] := 'Tables';
      Reader['NODES_SQLCLASS_NAME'] := 'TableObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 0;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Views';
      Reader['TEMPLATE_NAME'] := 'Views';
      Reader['NODES_SQLCLASS_NAME'] := 'ViewsObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 4;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Synonyms';
      Reader['TEMPLATE_NAME'] := 'Synonyms';
      Reader['NODES_SQLCLASS_NAME'] := 'SynonymObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 4;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'SystemTables';
      Reader['TEMPLATE_NAME'] := 'SystemTables';
      Reader['NODES_SQLCLASS_NAME'] := 'SystemTablesObjects';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 4;
      Reader.Post;

      Reader.Append;
      Reader['OBJ_NAME'] := 'Procedures';
      Reader['TEMPLATE_NAME'] := 'Procedures';
      Reader['NODES_SQLCLASS_NAME'] := 'Procedures';
      Reader['LOCAL_FILTER'] := '';
      Reader['Image_Index'] := 3;
      Reader.Post;

{      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TEMPLATE_NAME';
        Reader['NODES_SQLCLASS_NAME'] := 'NODES_SQLCLASS_NAME';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;}
    end else if SQL = 'Tables' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('TABLE')]), EmptyParam, ADOReader);
//      Connection.OpenSchema(siTables, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'Views' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('VIEW')]), EmptyParam, ADOReader);
//      Connection.OpenSchema(siViews, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'Synonyms' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('SYNONYM')]), EmptyParam, ADOReader);
//      Connection.OpenSchema(siViews, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'SystemTables' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siTables,
        VarArrayOf([Unassigned, Unassigned, Unassigned, WideString('SYSTEM TABLE')]), EmptyParam, ADOReader);
//      Connection.OpenSchema(siViews, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'TableColumns';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'TableColumns' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siColumns, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
      DataField.FieldName := 'ID';
      DataField.Size := 100;
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'ViewColumnsProps';
        Reader['NODES_SQLCLASS_NAME'] := 'NODES_SQLCLASS_NAME';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 4;
        Reader['ID'] := Reader['COLUMN_NAME'] + '.' + Reader['TABLE_NAME'];
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'Procedures' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siProcedures, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'ProcedureParameters';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 0;
        Reader.Post;
        Reader.Next;
      end;
    end else if SQL = 'ProcedureParameters' then
    begin
      Reader := TMemTableEh.Create(nil);
      Connection.OpenSchema(siProcedureParameters, EmptyParam, EmptyParam, ADOReader);
      Reader.RecordsView.MemTableData.DataStruct.BuildStructFromFields(ADOReader.Fields);
      CreateAdditionalFields(Reader.RecordsView.MemTableData.DataStruct);
      DataField := Reader.RecordsView.MemTableData.DataStruct.CreateField(TMTStringDataFieldEh);
      DataField.FieldName := 'ID';
      DataField.Size := 100;
      Reader.Open;
      Reader.LoadFromDataSet(ADOReader, -1, lmAppend, False);
      Reader.First;
      while not Reader.Eof do
      begin
        Reader.Edit;
        Reader['TEMPLATE_NAME'] := 'ViewProceduresColumnsProps';
        Reader['NODES_SQLCLASS_NAME'] := '';
        Reader['LOCAL_FILTER'] := '';
        Reader['Image_Index'] := 4;
        Reader['ID'] := Reader['PARAMETER_NAME'] + '.' + Reader['PROCEDURE_NAME'];
        Reader.Post;
        Reader.Next;
      end;
     end;
  finally
    ADOReader.Free;
  end;
  Result := Reader;
end;

class function TADOUniService.GetDBServiceName: String;
begin
  Result := 'ADOUniService';
end;

function TADOUniService.GetSpecParamsList: String;
var
  s: TStringList;
  i: Integer;
  FSpecParams: TCustomDBService;
begin
  if (FDesignDB is TADODesignDataBaseEh) and (TADODesignDataBaseEh(FDesignDB).FSpecParamsServiceClass <> nil) then
  begin
    FSpecParams := TADODesignDataBaseEh(FDesignDB).FSpecParamsServiceClass.Create(FDesignDB);
    Result := FSpecParams.GetSpecParamsList;
    FSpecParams.Free;
  end else if (FSpecPraramsService = nil) and not FNoAskForSpecPraramsService then
  begin
    s := TStringList.Create;
    for i := 0 to GetDBServiceList.Count-1 do
      s.Add(GetDBServiceList[i]);
    i := SelectFromList(s);
    if i <> -1 then
      FSpecPraramsService := GetDBServiceByName(s[i]).Create(FDesignDB);
    s.Free;
  end;
  if FSpecPraramsService <> nil then
    Result := FSpecPraramsService.GetSpecParamsList;
end;

procedure TADOUniService.GenGetSpecParams(
  DesignUpdateParams: TDesignUpdateParamsEh;
  DesignUpdateInfo: TDesignUpdateInfoEh);
var
  s: TStringList;
  i: Integer;
  FSpecParams: TCustomDBService;
begin
  if (FDesignDB is TADODesignDataBaseEh) and (TADODesignDataBaseEh(FDesignDB).FSpecParamsServiceClass <> nil) then
  begin
    FSpecParams := TADODesignDataBaseEh(FDesignDB).FSpecParamsServiceClass.Create(FDesignDB);
    FSpecParams.GenGetSpecParams(DesignUpdateParams, DesignUpdateInfo);
    FSpecParams.Free;
  end else if (FSpecPraramsService = nil) and not FNoAskForSpecPraramsService then
  begin
    s := TStringList.Create;
    for i := 0 to GetDBServiceList.Count-1 do
      s.Add(GetDBServiceList[i]);
    i := SelectFromList(s);
    if i <> -1 then
      FSpecPraramsService := GetDBServiceByName(s[i]).Create(FDesignDB);
    s.Free;
  end;
  if FSpecPraramsService <> nil then
    FSpecPraramsService.GenGetSpecParams(DesignUpdateParams, DesignUpdateInfo);
end;

{$IFDEF EH_LIB_6}
{$IFDEF DESIGNTIME}
{ TDataDriverEhSelectionEditor }

type
 TADODataDriverEhSelectionEditor = class(TSelectionEditor)
 public
   procedure RequiresUnits(Proc: TGetStrProc); override;
 end;

procedure TADODataDriverEhSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
   inherited RequiresUnits(Proc);
{$IFDEF EH_LIB_16}
   Proc('Data.Win.ADODB');
{$ELSE}
   Proc('ADODB');
{$ENDIF}
end;

type
{ TADOConnectionProviderEhEditor }

  TADOConnectionProviderEhEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TADOConnectionProviderEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: if EditFormADOConnProvider(TADOConnectionProviderEh(Component)) then
         Designer.Modified;
    2:
      ShowAboutForm;
  end;
end;

function TADOConnectionProviderEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'ConnectionProvider Editor ...';
    1: Result := '-';
    2: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TADOConnectionProviderEhEditor.GetVerbCount: Integer;
begin
  Result := 3;
end;

{$ENDIF}
{$ENDIF}

procedure Register;
begin
//To make TNiADODataDriverEh component be real Registered
//if over real ADODataDriver components was not on the Form
{$IFDEF EH_LIB_9}
  ForceDemandLoadState(dlDisable);
{$ENDIF}

  RegisterComponents('EhLib Components', [TADODataDriverEh]);
{$IFDEF DESIGNTIME}
  RegisterComponentEditor(TADODataDriverEh, TSQLDataDriverEhEditor);
  RegisterPropertyEditor(TypeInfo(WideString), TADODataDriverEh, 'ConnectionString', TConnectionStringProperty);
  RegisterComponentEditor(TADOConnectionProviderEh, TADOConnectionProviderEhEditor);

  RegisterPropertyEditor(TypeInfo(Boolean), TADOInlineConnectionEh, 'UseAtDesignTime', TStoreableBoolProperty);
  UnlistPublishedProperty(TADOInlineConnectionEh, 'UseAtDesignTimeStored');

  RegisterPropertyEditor(TypeInfo(Boolean), TADOInlineConnectionEh, 'UseAtRunTime', TStoreableBoolProperty);
  UnlistPublishedProperty(TADOInlineConnectionEh, 'UseAtRunTimeStored');
  
{$IFDEF EH_LIB_6}
  RegisterSelectionEditor(TADODataDriverEh, TADODataDriverEhSelectionEditor);
{$ENDIF}
{$ENDIF}
  RegisterComponents('EhLib Components', [TADOConnectionProviderEh]);
  RegisterNoIconEh([TNiADODataDriverEh]);
end;

procedure AssignTableParToADOParams(mtParams: TMemTableEh; Params: TParameters);
var
  i: Integer;
  ParamDataType: TDataType;
begin
  for i := Params.Count-1 downto 0 do
  begin
    if not mtParams.Locate('ParName', Params[i].Name, []) then
      Params.Delete(i);
  end;

  for i := 0 to mtParams.RecordsView.Count-1 do
  begin
    if Params.FindParam(mtParams.RecordsView.Rec[i].DataValues['ParName', dvvValueEh]) = nil then
    begin
      Params.CreateParameter(
         mtParams.RecordsView.Rec[i].DataValues['ParName', dvvValueEh],
         GetDataTypeByName(mtParams.RecordsView.Rec[i].DataValues['ParType', dvvValueEh]),
         pdInput,
         0,
         mtParams.RecordsView.Rec[i].DataValues['ParVarValue', dvvValueEh]);
    end;
  end;

  for i := 0 to Params.Count-1  do
  begin
    mtParams.Locate('ParName', Params[i].Name, []);
    try
      ParamDataType := GetDataTypeByName(mtParams['ParType']);
      if ParamDataType <> ftUnknown then
        Params[i].DataType := GetDataTypeByName(mtParams['ParType']);
    except
      on E: EOleException do
        Application.HandleException(E);
    end;
    Params[i].Value := mtParams['ParVarValue'];
  end;

end;

{ TADODataDriverEditInteractorEh }

class procedure TADODataDriverEditInteractorEh.AssignCommantToEditData(
  Command: TCustomSQLCommandEh; SQLText: String; mtParams: TMemTableEh);
begin
  inherited AssignCommantToEditData(Command, SQLText, mtParams);
end;

class procedure TADODataDriverEditInteractorEh.AssignEditDataToCommant(
  SQLText: String; mtParams: TMemTableEh; Command: TCustomSQLCommandEh);
var
//  Params: TParameters;
  ParCommand: TADOCommand;
begin
  ParCommand := TADOCommand.Create(nil);
//  Params := TParameters.Create(nil, TParameter);
  try
    ParCommand.Parameters.Assign(TADOCommandEh(Command).Parameters);
    Command.CommandText.Text := SQLText;
    AssignTableParToADOParams(mtParams, ParCommand.Parameters);
    TADOCommandEh(Command).Parameters := ParCommand.Parameters;
  finally
    ParCommand.Free;
  end;
end;

class procedure TADODataDriverEditInteractorEh.DesignDataBaseReassigned(
  SQLEditWin: TSQLDataEditWin);
begin
  inherited DesignDataBaseReassigned(SQLEditWin);
  if (SQLEditWin.DesignDataBase = nil) or not (SQLEditWin.DesignDataBase is TADODesignDataBaseEh)
    then TADODataDriverEh(SQLEditWin.DesignDriver).ADOConnection := nil
    else TADODataDriverEh(SQLEditWin.DesignDriver).ADOConnection := TADODesignDataBaseEh(SQLEditWin.DesignDataBase).ApplicationConnection;
end;

class procedure TADODataDriverEditInteractorEh.RefreshParams(
  Command: TCustomSQLCommandEh; SQLEditWin: TSQLDataEditWin);
begin
  SQLEditWin.CheckRequestDesignDataBaseEh;
  if (SQLEditWin.DesignDataBase <> nil) and
    (TADODesignDataBaseEh(SQLEditWin.DesignDataBase).ApplicationConnection <> nil) then
  begin
    TADODataDriverEh(Command.DataDriver).ADOConnection := TADODesignDataBaseEh(SQLEditWin.DesignDataBase).ApplicationConnection;
    inherited RefreshParams(Command, SQLEditWin);
  end;  
end;

{ TADOConnectionProviderDesignSerivceEh }

function TADOConnectionProviderDesignSerivceEh.CreateDesignDataBase(
  ConnectionProvider: TComponent): TComponent;
begin
  Result := TADODesignDataBaseEh.Create(False, ConnectionProvider);
end;

function TADOConnectionProviderDesignSerivceEh.EditDesignData(
  ConnectionProvider: TConnectionProviderEh): Boolean;
begin
  Result := EditFormADOConnProvider(TADOConnectionProviderEh(ConnectionProvider));
end;

initialization
  RegisterADOAccessEngines();
finalization
//  ShowMessage('UnRegistering ADO');
  UnregisterADOAccessEngines();
//  ShowMessage('UnRegistered ADO');
end.

