{*******************************************************}
{                                                       }
{                     EhLib v7.0                        }
{                                                       }
{         TDBXDesignDataBaseEh (Build 7.0.02)           }
{                                                       }
{     Copyright (c) 2004-2013 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit DBXDataDriverDesignEh;

{$I EHLIB.INC}

interface

{$IFDEF CIL}
{$R DBXDataDriverEh.TDBXDataDriverEh.bmp}
{$ENDIF}

uses Windows, SysUtils, Classes, Controls, DB,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh, SqlExpr,
  SQLDriverEditEh, DBXDataDriverEh, ComCtrls, MemTableEh, SQLConnEdEh,
//design-time
{$IFDEF DESIGNTIME}
{$IFDEF CIL}
  Borland.Vcl.Design.DBConnEd,
  Borland.Vcl.Design.ComponentDesigner,
{$ELSE}
{$IFDEF EH_LIB_12}
  DBDrvEd,
{$ELSE}
  DBConnEd,
{$ENDIF}
  ComponentDesigner,
{$ENDIF}
{$ENDIF}

{$IFDEF EH_LIB_11}
{$IFDEF CIL}
//   DBXCommon,
{$ELSE}
   DBXCommon,
{$ENDIF}
{$ENDIF}
  UpdateSQLEditEh, Forms, Dialogs;

type

{ IDBXDesignDataBaseEh }

  IDBXDesignDataBaseEh = interface
  ['{9E53BD33-4E5E-414F-9E4A-4980A8F7637A}']
    function GetSQLConnection: TSQLConnection;
  end;

{ TDBXDesignDataBaseEh }

  TDBXDesignDataBaseEh = class(TDesignDataBaseEh, IDBXDesignDataBaseEh)
  private
    FTablesMT: TMemTableEh;
    FColumnsMT: TMemTableEh;
    FSQLConnection: TSQLConnection;
    FTreeNodeMan: TCustomDBService;
    FDBService: TCustomDBService;
    FApplicationConnection: TSQLConnection;
    FSpecParamsServiceClass: TCustomDBServiceClass;
    procedure SetApplicationConnection(const Value: TSQLConnection);
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetConnected: Boolean; override;
    procedure SetConnected(const Value: Boolean); override;
  public
    constructor Create(IsPublicDataBase: Boolean; AConProvider: TComponent); override;
//    constructor Create;
    destructor Destroy; override;
    function GetEngineName: String; override;
    function GetDBServiceClass: TCustomDBServiceClass;
    function GetServerTypeName: String; override;
    function CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh; override;
    function DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    function GetSQLConnection: TSQLConnection;
    function GetConProvider: TDBXConnectionProviderEh;
    function BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; override;
    function BuildObjectTree(List: TList): Boolean; override;
    function BuildInterbaseObjectTree2(List: TList): Boolean;
    function BuildOracleObjectTree(List: TList): Boolean;
    function SupportCustomSQLDataDriver: Boolean; override;
    function GetFieldList(const TableName: string; DataSet: TDataSet): Boolean; override;
    function GetSpecParamsList: String; override;
    function CanFormSpecParamsList(var StrReasonOfInable: String): Boolean; override;
    procedure EditDatabaseParams; override;
    procedure SetServerTypeAsServerSpecOperationsClass(const Value: TServerSpecOperationsEhClass); override;
    property ApplicationConnection: TSQLConnection read FApplicationConnection write SetApplicationConnection;
  end;

  TDBXAccessEngineEh = class(TAccessEngineEh)
    function AccessEngineName: String; override;
//    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh): TDesignDataBaseEh; override;
    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
      DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh; override;
  end;

{ TDBXConnectionProviderDesignSerivceEh }

  TDBXConnectionProviderDesignSerivceEh = class(TConnectionProviderDesignSerivceEh)
    function EditDesignData(ConnectionProvider: TConnectionProviderEh): Boolean; override;
    function CreateDesignDataBase(ConnectionProvider: TComponent): TComponent; override;
  end;

procedure RegisterDBXAccessEngines;

procedure Register;

implementation

uses
{$IFDEF DESIGNTIME}
	MemTableDesignEh,
{$IFDEF CIL}
  Borland.Vcl.Design.DesignIntf,
{$ELSE}
  {$IFDEF EH_LIB_6}
     DesignIntf,
     DesignEditors,
  {$ELSE} //EH_LIB_6
      DsgnIntf,
  {$ENDIF}
  DBReg,
{$ENDIF}
{$ENDIF}
  DesignConnectionListEh;

function CreateDesignDataBase(DataDriver: TDBXDataDriverEh): TComponent;
var
  DesignDataBase: TDBXDesignDataBaseEh;
//  SourceSQLConnection: TSQLConnection;
begin
  DesignDataBase :=  TDBXDesignDataBaseEh.Create(True, nil);
//  SourceSQLConnection := TSQLConnection.Create(nil);
  if DataDriver.SQLConnection <> nil then
  begin
    DesignDataBase.FSQLConnection.ConnectionName := DataDriver.SQLConnection.ConnectionName;
    DesignDataBase.FSQLConnection.DriverName := DataDriver.SQLConnection.DriverName;
    DesignDataBase.FSQLConnection.GetDriverFunc := DataDriver.SQLConnection.GetDriverFunc;
    DesignDataBase.FSQLConnection.KeepConnection := DataDriver.SQLConnection.KeepConnection;
    DesignDataBase.FSQLConnection.LibraryName := DataDriver.SQLConnection.LibraryName;
    DesignDataBase.FSQLConnection.LoadParamsOnConnect := DataDriver.SQLConnection.LoadParamsOnConnect;
    DesignDataBase.FSQLConnection.LoginPrompt := DataDriver.SQLConnection.LoginPrompt;
    DesignDataBase.FSQLConnection.Params := DataDriver.SQLConnection.Params;
    DesignDataBase.FSQLConnection.TableScope := DataDriver.SQLConnection.TableScope;
    DesignDataBase.FSQLConnection.VendorLib := DataDriver.SQLConnection.VendorLib;
    try
      DesignDataBase.FSQLConnection.Connected := True;
    except
      on E: EDatabaseError do
        Application.HandleException(E);
{$IFDEF EH_LIB_11}
{$IFDEF CIL}
//      on E: TDBXError do
//        Application.HandleException(E);
{$ELSE}
      on E: TDBXError do
        Application.HandleException(E);
{$ENDIF}
{$ENDIF}
    end;
    DesignDataBase.ApplicationConnection := DataDriver.SQLConnection;
  end;
  EditSQLConnection(DesignDataBase.FSQLConnection);

  Result := DesignDataBase;
end;

procedure SetDesignDBXDataBaseProcEh(DataDriver: TCustomSQLDataDriverEh);
var
  i: Integer;
  DesignDataBase: TComponent;
begin
  if DataDriver.DesignDataBase = nil then
  begin
    for i := 0 to GetDesignDataBaseList.Count-1 do
      if TDesignDataBaseEh(GetDesignDataBaseList[i]).DesignDataBaseConnetionEqual(DataDriver) then
      begin
        DataDriver.DesignDataBase := TComponent(GetDesignDataBaseList[i]);
        Exit;
      end;

    if GetDesignDataBaseList.Count > 0 then
    begin
      DesignDataBase := SelectDesignConnectionListEh(DesignDataBaseList);
      if (DesignDataBase <> nil) and (DesignDataBase <> DataDriver.DesignDataBase) then
        DataDriver.DesignDataBase := DesignDataBase;
    end else
      DataDriver.DesignDataBase := CreateDesignDataBase(TDBXDataDriverEh(DataDriver));
  end;
end;

procedure RegisterDBXAccessEngines;
begin
  RegisterDesignDataBuilderProcEh(TDBXDataDriverEh, SetDesignDBXDataBaseProcEh);
  RegisterAccessEngine('DBX', TDBXAccessEngineEh.Create);
  DBXConnectionProviderDesignService := TDBXConnectionProviderDesignSerivceEh.Create;
end;

procedure UnregisterDBXAccessEngines;
begin
  UnregisterDesignDataBuilderProcEh(TDBXDataDriverEh);
  UnregisterAccessEngine('DBX');
  DBXConnectionProviderDesignService := nil; //Not Free, Interface
end;

function GetServerName(SQLConnection: TSQLConnection; var ServerName: String): Boolean;
begin
  ServerName := AnsiUpperCase(SQLConnection.DriverName);
  Result := True;
end;

var
  DataBaseInc: Integer = 0;

function GetUnicalDataBaseName: String;
begin
  Inc(DataBaseInc);
  Result := 'DBXDataDriverEhDataBaseName' + IntToStr(DataBaseInc);
end;

{ TDBXDesignDataBaseEh }

function TDBXDesignDataBaseEh.BuildObjectTree(List: TList): Boolean;
var
  NList: Tlist;
begin
  Result := False;
  if GetDBServiceClass <> nil then
    FDBService := GetDBServiceClass.Create(Self);
  if FDBService <> nil then
  begin
    NList := FDBService.CreateRootNodes;
    List.Assign(NList, laCopy);
    NList.Free;
    Result := True;
  end;

  Exit;
//  TreeView.Items.Clear;
  if GetServerTypeName = 'INFORMIX' then
//    Result := BuildInformixObjectTree(TreeView)
  else if GetServerTypeName = 'INTERBASE' then
    Result := BuildInterbaseObjectTree2(List)
  else
    Result := False;
end;

function TDBXDesignDataBaseEh.BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := EditDataDriverUpdateSQL(DataDriver as TCustomSQLDataDriverEh);// UpdateSQLEditEh
end;

constructor TDBXDesignDataBaseEh.Create(IsPublicDataBase: Boolean; AConProvider: TComponent);
begin
  inherited Create(IsPublicDataBase, AConProvider);
  if AConProvider = nil then
  begin
    FSQLConnection := TSQLConnection.Create(Application);
  end;
  FTablesMT := TMemTableEh.Create(nil);
  FColumnsMT := TMemTableEh.Create(nil);
end;

destructor TDBXDesignDataBaseEh.Destroy;
begin
  if not (csDestroying in Application.ComponentState) then
    FreeAndNil(FSQLConnection);
  FreeAndNil(FTablesMT);
  FreeAndNil(FColumnsMT);
  FreeAndNil(FTreeNodeMan);
  inherited Destroy;
end;

function TDBXDesignDataBaseEh.CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh;
begin
  Result := TDBXDataDriverEh.Create(nil);
  Result.SelectCommand := RTDataDriver.SelectCommand;
  Result.UpdateCommand := RTDataDriver.UpdateCommand;
  Result.InsertCommand := RTDataDriver.InsertCommand;
  Result.DeleteCommand := RTDataDriver.DeleteCommand;
  Result.GetrecCommand := RTDataDriver.GetrecCommand;
  TDBXDataDriverEh(Result).SpecParams := TDBXDataDriverEh(RTDataDriver).SpecParams;
  TDBXDataDriverEh(Result).SQLConnection := GetSQLConnection;
end;

function TDBXDesignDataBaseEh.DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := False;
  if DataDriver is TDBXDataDriverEh then
  begin
    if TDBXDataDriverEh(DataDriver).SQLConnection <> nil then
      Result := (ApplicationConnection = TDBXDataDriverEh(DataDriver).SQLConnection);
  end;
end;

function TDBXDesignDataBaseEh.Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
begin
  Result := -1;
  FreeOnEof := True;
  with Command do
    case CommandType of
      cthSelectQuery, cthUpdateQuery:
        begin
          Cursor := TSQLQuery.Create(nil);
          with Cursor as TSQLQuery do
          begin
            SQLConnection := GetSQLConnection;
            SQL.Text := Command.FinalCommandText.Text;
            Params := Command.GetParams;
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
          Cursor := TSQLTable.Create(nil);
          with Cursor as TSQLTable do
          begin
            SQLConnection := GetSQLConnection;
            TableName := Command.FinalCommandText.Text;
//            Params := Command.GetParams;
            Open;
          end;
        end;
      cthStoredProc:
        begin
          Cursor := TSQLStoredProc.Create(nil);
          with Cursor as TSQLStoredProc do
          begin
            SQLConnection := GetSQLConnection;
            StoredProcName := Command.FinalCommandText.Text;
            Params := Command.GetParams;
            ExecProc;
          end;
        end;
    end;
end;

function TDBXDesignDataBaseEh.GetSQLConnection: TSQLConnection;
begin
  Result := nil;
  if FSQLConnection <> nil then
    Result := FSQLConnection
  else if GetConProvider <> nil then
    Result := GetConProvider.CurrentTimeConnection;
end;

function TDBXDesignDataBaseEh.GetServerTypeName: String;
var
  Description: String;
begin
  if GetServerName(GetSQLConnection, Description) then
  begin
    Result := UpperCase(Description);
  end;
end;

function TDBXDesignDataBaseEh.BuildInterbaseObjectTree2(List: TList): Boolean;
var
  NList: Tlist;
begin
  if FTreeNodeMan <> nil then
    FTreeNodeMan.Free;
  FTreeNodeMan := TInterbaseDBService.Create(Self);
  NList := FTreeNodeMan.CreateRootNodes;
  List.Assign(NList, laCopy);
  NList.Free;
  Result := True;
end;

function TDBXDesignDataBaseEh.CreateReader(SQL: String; FParams: TParamsArr): TDataSet;
var
  Query: TSQLQuery;
  i: Integer;
  dt: TFieldType;
  p: TParam;
begin
  Query := TSQLQuery.Create(nil);
  Query.SQLConnection := GetSQLConnection;
  Query.SQL.Text := SQL;
  if High(FParams) > Low(FParams) then
    for i := Low(FParams) to High(FParams) div 2 do
    begin
      dt := VarTypeToDataType(VarType(FParams[i*2+1]));
      if dt = ftUnknown then
        dt := ftString;
      p := Query.Params.CreateParam(dt, FParams[i*2], ptInputOutput);
      p.Value := FParams[i*2+1];
    end;
  try
    Query.Open;
  except
    Query.Free;
    raise;
  end;
  Result := Query;
end;

function TDBXDesignDataBaseEh.BuildOracleObjectTree(List: TList): Boolean;
begin
  Result := False;
end;

procedure TDBXDesignDataBaseEh.EditDatabaseParams;
begin
//design-time   EditConnection(GetSQLConnection);
  EditSQLConnection(FSQLConnection);
end;

function TDBXDesignDataBaseEh.GetEngineName: String;
begin
  Result := 'DBX';
end;

function TDBXDesignDataBaseEh.GetConnected: Boolean;
begin
  Result := (GetSQLConnection <> nil) and GetSQLConnection.Connected;
end;
procedure TDBXDesignDataBaseEh.SetConnected(const Value: Boolean);
begin
  if GetSQLConnection <> nil then
    GetSQLConnection.Connected := Value;
end;

function TDBXDesignDataBaseEh.SupportCustomSQLDataDriver: Boolean;
begin
  Result := True;
end;

function TDBXDesignDataBaseEh.GetDBServiceClass: TCustomDBServiceClass;
begin
  Result := GetDBServiceByName(GetServerTypeName);
end;

function TDBXDesignDataBaseEh.GetFieldList(const TableName: string;
  DataSet: TDataSet): Boolean;
var
  table: TSQLTable;
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
  table := TSQLTable.Create(nil);
  table.SQLConnection := GetSQLConnection;
  table.TableName := TableName;
  list := TStringList.Create;
  GetDataFieldNames(table, 'Error', list);
  SetKeyFields;
  for i := 0 to list.Count-1 do
    if list.Objects[i] = TObject(1)
      then DataSet.AppendRecord([list[i], True])
      else DataSet.AppendRecord([list[i], False]);
  list.Free;
  table.Free;
  Result := True;
end;

procedure TDBXDesignDataBaseEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FSQLConnection = AComponent)
  then
    FSQLConnection := nil;
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FApplicationConnection = AComponent)
  then
    FApplicationConnection := nil;
end;

procedure TDBXDesignDataBaseEh.SetApplicationConnection(const Value: TSQLConnection);
begin
  if FApplicationConnection <> Value then
  begin
    FApplicationConnection := Value;
    if FApplicationConnection <> nil then
      FApplicationConnection.FreeNotification(Self);
  end;
end;

function TDBXDesignDataBaseEh.GetConProvider: TDBXConnectionProviderEh;
begin
  Result := TDBXConnectionProviderEh(FConProvider);
end;

function TDBXDesignDataBaseEh.GetSpecParamsList: String;
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

function TDBXDesignDataBaseEh.CanFormSpecParamsList(var StrReasonOfInable: String): Boolean;
begin
  Result := inherited CanBuildTreeDataSet(StrReasonOfInable);
  if not IsPublicDataBase and (FSpecParamsServiceClass = nil) then
  begin
    Result := False;
    StrReasonOfInable := 'Unable to form list of SpecParams. ConnectionProvider.ServerType is not assigned.'
  end;
end;

procedure TDBXDesignDataBaseEh.SetServerTypeAsServerSpecOperationsClass(
  const Value: TServerSpecOperationsEhClass);
begin
  FSpecParamsServiceClass := GetDBServiceByServerSpecOperationsClass(Value);
end;

{ TDBXAccessEngineEh }

function TDBXAccessEngineEh.AccessEngineName: String;
begin
  Result := 'DBX';
end;

function TDBXAccessEngineEh.CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
  DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh;
var
  DBXDesignDataBase: TDBXDesignDataBaseEh;
begin
  DBXDesignDataBase := TDBXDesignDataBaseEh.Create(True, nil);
  DBXDesignDataBase.EditDatabaseParams;
  Result := DBXDesignDataBase;
end;

procedure Register;
begin
  RegisterComponents('EhLib Components', [TDBXDataDriverEh]);
{$IFDEF DESIGNTIME}
  RegisterComponentEditor(TDBXDataDriverEh, TSQLDataDriverEhEditor);

  RegisterComponents('EhLib Components', [TDBXConnectionProviderEh]);

  UnlistPublishedProperty(TDBXInlineConnectionEh, 'ValidatePeerCertificate');
  UnlistPublishedProperty(TDBXInlineConnectionEh, 'AfterConnect');
  UnlistPublishedProperty(TDBXInlineConnectionEh, 'AfterDisconnect');
  UnlistPublishedProperty(TDBXInlineConnectionEh, 'BeforeConnect');
  UnlistPublishedProperty(TDBXInlineConnectionEh, 'BeforeDisconnect');
  UnlistPublishedProperty(TDBXInlineConnectionEh, 'OnLogin');

  UnlistPublishedProperty(TDBXInlineConnectionEh, 'Name');
  UnlistPublishedProperty(TDBXInlineConnectionEh, 'Tag');
  UnlistPublishedProperty(TDBXInlineConnectionEh, 'KeepConnection');
  //  RegisterComponentEditor(TDBXConnectionProviderEh, TDBXConnectionProviderEhEditor);
{$ENDIF}
end;

{ TDBXConnectionProviderDesignSerivceEh }

function TDBXConnectionProviderDesignSerivceEh.CreateDesignDataBase(
  ConnectionProvider: TComponent): TComponent;
begin
  Result := TDBXDesignDataBaseEh.Create(False, ConnectionProvider);
end;

function TDBXConnectionProviderDesignSerivceEh.EditDesignData(
  ConnectionProvider: TConnectionProviderEh): Boolean;
begin
  Result := False;
end;

initialization
  RegisterDBXAccessEngines;
finalization
  UnregisterDBXAccessEngines;
end.
