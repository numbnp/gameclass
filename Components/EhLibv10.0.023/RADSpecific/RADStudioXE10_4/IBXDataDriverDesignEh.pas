{*******************************************************}
{                                                       }
{                     EhLib 10.0                        }
{                                                       }
{                TIBXDesignDataBaseEh                   }
{                                                       }
{     Copyright (c) 2004-2020 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit IBXDataDriverDesignEh;

{$I EHLIB.INC}

interface

uses Windows, SysUtils, Classes, Controls, DB, Variants, Contnrs,
  ToolCtrlsEh, DBCommon, MemTableDataEh, DataDriverEh,
{$IFDEF EH_LIB_20}
  IBX.IBDatabase, IBX.IBQuery, IBX.IBTable, IBX.IBStoredProc,
{$ELSE}
  IBDatabase, IBQuery, IBTable, IBStoredProc,
{$ENDIF}
  SQLDriverEditEh, IBXDataDriverEh,
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  EhLibVCL,
{$ENDIF}
  ComCtrls, MemTableEh, Forms, UpdateSQLEditEh, Dialogs
{$IFDEF DESIGNTIME}
  {$IFDEF CIL}
   ,Borland.Vcl.Design.Ibdatabaseedit
  {$ELSE}
    {$IFDEF EH_LIB_20}
     ,IBX.Ibdatabaseedit
    {$ELSE}
     ,Ibdatabaseedit
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
  ;

type

{ IIBXDesignDataBaseEh }

  IIBXDesignDataBaseEh = interface
  ['{9E53BD33-4E5E-414F-9E4A-4980A8F7637A}']
    function GetDatabase: TIBDatabase;
  end;

{ TIBXDesignDataBaseEh }

  TIBXDesignDataBaseEh = class(TDesignDataBaseEh, IIBXDesignDataBaseEh)
  private
    FTablesMT: TMemTableEh;
    FColumnsMT: TMemTableEh;
    FDatabase: TIBDatabase;
    FTransaction: TIBTransaction;
    FTreeNodeMan: TCustomDBService;
    FDBService: TCustomDBService;
    FUpdateObjectsList: TStringList;
    FApplicationDatabase: TIBDatabase;
    procedure SetApplicationDatabase(const Value: TIBDatabase);

  protected
    function GetConnected: Boolean; override;
    procedure SetConnected(const Value: Boolean); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

  public
    constructor Create(IsPublicDataBase: Boolean; AConProvider: TComponent); override;
    destructor Destroy; override;

    function BuildInterbaseObjectTree2(List: TObjectList): Boolean;
    function BuildObjectTree(List: TObjectList): Boolean; override;
    function BuildOracleObjectTree(TreeView: TTreeView): Boolean;
    function BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh; override;
    function CreateReader(SQL: String; FParams: TParamsArr): TDataSet; override;
    function DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean; override;
    function Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer; override;
    function GetConProvider: TIBXConnectionProviderEh;
    function GetCustomDBService: TCustomDBService; override;
    function GetDatabase: TIBDatabase;
    function GetEngineName: String; override;
    function GetFieldList(const TableName: string; DataSet: TDataSet): Boolean; override;
    function GetIncrementObjectsList: TStrings; override;
    function GetSpecParamsList: String; override;
    function ServerTypeName: String;
    function SupportCustomSQLDataDriver: Boolean; override;

    procedure EditDatabaseParams; override;

    property ApplicationDatabase: TIBDatabase read FApplicationDatabase write SetApplicationDatabase;
  end;

  TIBXAccessEngineEh = class(TAccessEngineEh)
    function AccessEngineName: String; override;
    function CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh; DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh; override;
  end;

{ TIBXConnectionProviderDesignSerivceEh }

  TIBXConnectionProviderDesignSerivceEh = class(TConnectionProviderDesignSerivceEh)
    function EditDesignData(ConnectionProvider: TConnectionProviderEh): Boolean; override;
    function CreateDesignDataBase(ConnectionProvider: TComponent): TComponent; override;
  end;

procedure RegisterIBXAccessEngines;
procedure UnregisterIBXAccessEngines;

procedure Register;

implementation

uses
{$IFDEF DESIGNTIME}
	MemTableDesignEh,
{$IFDEF CIL}
  Borland.Vcl.Design.DesignIntf,
{$ELSE}
  DesignIntf,
  DesignEditors,
  DBReg,
{$ENDIF}
{$ENDIF}
  DesignConnectionListEh, EhLibDesignAbout;

function CreateDesignDataBase(DataDriver: TIBXDataDriverEh): TComponent;
var
  DesignDataBase: TIBXDesignDataBaseEh;
begin
  DesignDataBase :=  TIBXDesignDataBaseEh.Create(True, nil);;
  if DataDriver.Database <> nil then
  begin
    DesignDataBase.FDatabase.DataBaseName := DataDriver.Database.DataBaseName;
    DesignDataBase.FDatabase.Params := DataDriver.Database.Params;
    DesignDataBase.FDatabase.SQLDialect := DataDriver.Database.SQLDialect;
    DesignDataBase.ApplicationDatabase := DataDriver.Database;
  end;
{$IFDEF DESIGNTIME}
    EditIBDatabase(DesignDataBase.FDatabase);
{$ENDIF}
  Result := DesignDataBase;
end;

procedure SetDesignIBXDataBaseProcEh(DataDriver: TCustomSQLDataDriverEh);
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
      DataDriver.DesignDataBase := CreateDesignDataBase(TIBXDataDriverEh(DataDriver));
  end;
end;

procedure RegisterIBXAccessEngines;
begin
  RegisterDesignDataBuilderProcEh(TIBXDataDriverEh, SetDesignIBXDataBaseProcEh);
  RegisterAccessEngine('IBX', TIBXAccessEngineEh.Create);
  IBXConnectionProviderDesignService := TIBXConnectionProviderDesignSerivceEh.Create;
end;

procedure UnregisterIBXAccessEngines;
begin
  UnregisterDesignDataBuilderProcEh(TIBXDataDriverEh);
  UnregisterAccessEngine('IBX');
  IBXConnectionProviderDesignService := nil; 
end;

function GetServerName(IBDatabase: TIBDatabase; var ServerName: String): Boolean;
begin
  ServerName := 'INTERBASE';
  Result := True;
end;

{ TIBXDesignDataBaseEh }

function TIBXDesignDataBaseEh.BuildObjectTree(List: TObjectList): Boolean;
begin
  Result := False;
  if ServerTypeName = 'INFORMIX' then
  else if ServerTypeName = 'INTERBASE' then
    Result := BuildInterbaseObjectTree2(List)
  else
    Result := False;
end;

function TIBXDesignDataBaseEh.BuildUpdates(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := EditDataDriverUpdateSQL(DataDriver as TCustomSQLDataDriverEh);
end;

constructor TIBXDesignDataBaseEh.Create(IsPublicDataBase: Boolean; AConProvider: TComponent);
begin
  inherited Create(IsPublicDataBase, AConProvider);

  if AConProvider = nil then
  begin
    FDatabase := TIBDatabase.Create(Application);
    FTransaction := TIBTransaction.Create(Application);
    FTransaction.DefaultDatabase := FDatabase;
  end;

  FTablesMT := TMemTableEh.Create(nil);
  FColumnsMT := TMemTableEh.Create(nil);
  FDBService := TInterbaseDBService.Create(Self)
end;

destructor TIBXDesignDataBaseEh.Destroy;
begin
  if not (csDestroying in Application.ComponentState) then
    FreeAndNil(FDatabase);
  if not (csDestroying in Application.ComponentState) then
    FreeAndNil(FTransaction);
  FreeAndNil(FTablesMT);
  FreeAndNil(FColumnsMT);
  FreeAndNil(FTreeNodeMan);
  FreeAndNil(FDBService);
  FreeAndNil(FUpdateObjectsList);
  inherited Destroy;
end;

function TIBXDesignDataBaseEh.CreateDesignCopy(RTDataDriver: TCustomSQLDataDriverEh): TCustomSQLDataDriverEh;
begin
  Result := TIBXDataDriverEh.Create(nil);
  Result.SelectCommand := RTDataDriver.SelectCommand;
  Result.UpdateCommand := RTDataDriver.UpdateCommand;
  Result.InsertCommand := RTDataDriver.InsertCommand;
  Result.DeleteCommand := RTDataDriver.DeleteCommand;
  Result.GetrecCommand := RTDataDriver.GetrecCommand;
  TIBXDataDriverEh(Result).SpecParams := TIBXDataDriverEh(RTDataDriver).SpecParams;
  TIBXDataDriverEh(Result).Database := GetDatabase;
  TIBXDataDriverEh(Result).ConnectionProvider :=  TIBXDataDriverEh(RTDataDriver).ConnectionProvider;
end;

function TIBXDesignDataBaseEh.DesignDataBaseConnetionEqual(DataDriver: TCustomSQLDataDriverEh): Boolean;
begin
  Result := False;
  if DataDriver is TIBXDataDriverEh then
  begin
    if TIBXDataDriverEh(DataDriver).Database <> nil then
      Result := (ApplicationDatabase = TIBXDataDriverEh(DataDriver).Database);
  end;
end;

function TIBXDesignDataBaseEh.Execute(Command: TCustomSQLCommandEh; var Cursor: TDataSet; var FreeOnEof: Boolean): Integer;
var
  q: TIBQuery;
  t: TIBTable;
  sp: TIBStoredProc;
begin
  Result := -1;
  FreeOnEof := True;
  case Command.CommandType of
    cthSelectQuery, cthUpdateQuery:
      begin
        q := TIBQuery.Create(nil);
        q.Database := GetDatabase;
        q.SQL := Command.FinalCommandText;
        q.Params := Command.GetParams;
        if Command.CommandType = cthSelectQuery then
          q.Open
        else
        begin
          q.ExecSQL;
          Result := q.RowsAffected;
        end;
        Cursor := q;
      end;
    cthTable:
      begin
        t := TIBTable.Create(nil);
        t.Database := GetDatabase;
        t.TableName := Command.FinalCommandText.Text;
        t.Open;
        Cursor := t;
      end;
    cthStoredProc:
      begin
        sp := TIBStoredProc.Create(nil);
        sp.Database := GetDatabase;
        sp.StoredProcName := Command.FinalCommandText.Text;
        sp.Params := Command.GetParams;
        sp.ExecProc;
        Cursor := sp;
      end;
  end;
end;

function TIBXDesignDataBaseEh.GetDatabase: TIBDatabase;
begin
  Result := nil;
  if FDatabase <> nil then
    Result := FDatabase
  else if GetConProvider <> nil then
    Result := GetConProvider.CurrentTimeDatabase;
end;

function TIBXDesignDataBaseEh.ServerTypeName: String;
var
  Description: String;
begin
  if GetServerName(GetDatabase, Description) then
  begin
    Result := UpperCase(Description);
  end;
end;

function TIBXDesignDataBaseEh.BuildInterbaseObjectTree2(List: TObjectList): Boolean;
var
  NList: TObjectList;
  i: Integer;
begin
  if FTreeNodeMan <> nil then
    FTreeNodeMan.Free;
  FTreeNodeMan := TInterbaseDBService.Create(Self);
  NList := FTreeNodeMan.CreateRootNodes;
  List.Clear;
  for I := 0 to NList.Count - 1 do
    List.Add(NList[I]);
  NList.Free;
  Result := True;
end;

function TIBXDesignDataBaseEh.CreateReader(SQL: String; FParams: TParamsArr): TDataSet;
var
  Query: TIBQuery;
  i: Integer;
  dt: TFieldType;
  p: TParam;
begin
  Query := TIBQuery.Create(nil);
  Query.Database := GetDatabase;
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

function TIBXDesignDataBaseEh.BuildOracleObjectTree(TreeView: TTreeView): Boolean;
begin
  Result := False;
end;

procedure TIBXDesignDataBaseEh.EditDatabaseParams;
begin
{$IFDEF DESIGNTIME}
  EditIBDatabase(FDatabase);
{$ENDIF}
end;

function TIBXDesignDataBaseEh.GetEngineName: String;
begin
  Result := 'IBX';
end;

function TIBXDesignDataBaseEh.SupportCustomSQLDataDriver: Boolean;
begin
  Result := True;
end;

function TIBXDesignDataBaseEh.GetFieldList(const TableName: string;
  DataSet: TDataSet): Boolean;
var
  table: TIBTable;
  list: TStrings;
  i: Integer;

  procedure GetDataFieldNames(Dataset: TDataset; ErrorName: string; List: TStrings);
  var
    I: Integer;
  begin
    try
      Dataset.FieldDefs.Update;
      List.BeginUpdate;
      try
        List.Clear;
        for I := 0 to Dataset.FieldDefs.Count - 1 do
          List.Add(Dataset.FieldDefs[I].Name);
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
          System.Delete(FieldNames, 1, SepPos);
          Index := list.IndexOf(FName);
          if Index > -1 then list.Objects[Index] := TObject(1);
        end;
        break;
      end;
  end;

begin
  table := TIBTable.Create(nil);
  table.Database := GetDatabase;
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

function TIBXDesignDataBaseEh.GetConnected: Boolean;
begin
  Result := (GetDatabase <> nil) and GetDatabase.Connected;
end;

function TIBXDesignDataBaseEh.GetConProvider: TIBXConnectionProviderEh;
begin
  Result := TIBXConnectionProviderEh(FConProvider);
end;

procedure TIBXDesignDataBaseEh.SetConnected(const Value: Boolean);
begin
  if GetDataBase <> nil then
    GetDatabase.Connected := Value;
end;

function TIBXDesignDataBaseEh.GetCustomDBService: TCustomDBService;
begin
  Result := FDBService;
end;

function TIBXDesignDataBaseEh.GetIncrementObjectsList: TStrings;
begin
  if FUpdateObjectsList = nil then
    FUpdateObjectsList := TStringList.Create;
  if GetCustomDBService <> nil then
  begin
    FUpdateObjectsList.Assign(GetCustomDBService.GetIncrementObjectsList);
    Result := FUpdateObjectsList;
  end else
    Result := nil;
end;

function TIBXDesignDataBaseEh.GetSpecParamsList: String;
begin
  if GetCustomDBService <> nil then
    Result := GetCustomDBService.GetSpecParamsList;
end;

procedure TIBXDesignDataBaseEh.SetApplicationDatabase(const Value: TIBDatabase);
begin
  if FApplicationDatabase <> Value then
  begin
    FApplicationDatabase := Value;
    if FApplicationDatabase <> nil then
      FApplicationDatabase.FreeNotification(Self);
  end;
end;

procedure TIBXDesignDataBaseEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and
     (AComponent <> nil) and
     (FApplicationDatabase = AComponent)
  then
    FApplicationDatabase := nil;
end;

{ TIBXAccessEngineEh }

function TIBXAccessEngineEh.AccessEngineName: String;
begin
  Result := 'IBX';
end;

function TIBXAccessEngineEh.CreateDesignDataBase(DataDriver: TCustomSQLDataDriverEh;
  DBServiceClass: TCustomDBServiceClass; DataBaseName: String): TDesignDataBaseEh;
var
  IBXDesignDataBase: TIBXDesignDataBaseEh;
begin
  IBXDesignDataBase := TIBXDesignDataBaseEh.Create(True, nil);
  IBXDesignDataBase.EditDatabaseParams;
  Result := IBXDesignDataBase;
end;

{ TIBXConnectionProviderEhEditor }

{$IFDEF DESIGNTIME}
type

  TIBXConnectionProviderEhEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

procedure TIBXConnectionProviderEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: if EditIBDatabase(TIBXConnectionProviderEh(Component).InlineConnection.DataBase) then
         Designer.Modified;
    2:
      ShowAboutForm;
  end;
end;

function TIBXConnectionProviderEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Design-time Database Editor ...';
    1: Result := '-';
    2: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TIBXConnectionProviderEhEditor.GetVerbCount: Integer;
begin
  Result := 0;
  if (Component <> nil) and (Component is TIBXConnectionProviderEh) then
    if TIBXConnectionProviderEh(Component).InlineConnection.UseAtDesignTime then
      Inc(Result);
  if Result > 0 then
    Result := 3;
end;
{$ENDIF}

procedure Register;
begin
  RegisterComponents('EhLib Components', [TIBXDataDriverEh]);
{$IFDEF DESIGNTIME}
  RegisterComponentEditor(TIBXDataDriverEh, TSQLDataDriverEhEditor);
  RegisterComponents('EhLib Components', [TIBXConnectionProviderEh]);
  RegisterComponentEditor(TIBXConnectionProviderEh, TIBXConnectionProviderEhEditor);
{$ENDIF}
end;

{ TIBXConnectionProviderDesignSerivceEh }

function TIBXConnectionProviderDesignSerivceEh.CreateDesignDataBase(
  ConnectionProvider: TComponent): TComponent;
begin
  Result := TIBXDesignDataBaseEh.Create(False, ConnectionProvider);
end;

function TIBXConnectionProviderDesignSerivceEh.EditDesignData(
  ConnectionProvider: TConnectionProviderEh): Boolean;
begin
  Result := False;
end;

initialization
  RegisterIBXAccessEngines;
finalization
  UnregisterIBXAccessEngines;
end.
