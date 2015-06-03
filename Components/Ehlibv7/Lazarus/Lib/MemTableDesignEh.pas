{*******************************************************}
{                                                       }
{                     EhLib v7.0                        }
{                                                       }
{     TMemTableFieldsEditorEh component (Build 7.0.05)  }
{                                                       }
{        Copyright (c) 2003-14 by EhLib Team and        }
{                Dmitry V. Bolshakov                    }
{                                                       }
{*******************************************************}

unit MemTableDesignEh;

{$I EhLib.Inc}

interface

uses
  SysUtils,
{$IFDEF CIL} Borland.Vcl.Design.DesignIntf,
             Borland.Vcl.Design.DesignEditors,
             Borland.Vcl.Design.ColnEdit,
             Borland.Vcl.Design.DSDesign,
             Borland.Vcl.Design.DsnDBCst,
             Borland.Vcl.Design.StringsEdit,
             Borland.Vcl.Design.PicEdit,
  EhLibVCLNET,
{$ELSE}
  {$IFDEF FPC}
  DBGridsEh,
  EhLibLCL, LCLType, Win32Extra,
  PropEdits, ComponentEditors,
  {$ELSE}
  EhLibVCL, DBGridEh,
  DSDesign, DsnDBCst, PicEdit, FldLinks,
  StringsEdit, VCLEditors, DesignEditors, DesignIntf, DesignWindows,
  DesignMenus, MTCreateDataDriver,
  DB, Windows, Messages, StdCtrls, ComCtrls,
  {$ENDIF}
{$ENDIF}
  Classes, Graphics, Controls, Forms, Variants,
  Dialogs, Menus, DBCtrls, ExtCtrls, GridsEh,
  Buttons, ActnList, MemTableEh, DBGridEhImpExp,
  DBGridEhGrouping, MemTableDataEh, ToolCtrlsEh, DBGridEhToolCtrls;

{$IFDEF FPC}
{$ELSE}

type

{$IFNDEF EH_LIB_6}
  IDesigner = IFormDesigner;
{$ENDIF}

  TMemTableFieldsEditorEh = class(TFieldsEditor)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGridEh1: TDBGridEh;
    TabSheet3: TTabSheet;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    ActionList1: TActionList;
    actFetchParams: TAction;
    actAssignLocalData: TAction;
    actLoadFromMyBaseTable: TAction;
    actCreateDataSet: TAction;
    actSaveToMyBaseXmlTable: TAction;
    actSaveToMyBaseXmlUTF8Table: TAction;
    actSaveToBinaryMyBaseTable: TAction;
    actClearData: TAction;
    GridMenu: TPopupMenu;
    GridCut: TMenuItem;
    GridCopy: TMenuItem;
    GridPaste: TMenuItem;
    GridDelete: TMenuItem;
    GridSelectAll: TMenuItem;
    SpeedButton9: TSpeedButton;
    actCreateDataDriver: TAction;
    TabSheet4: TTabSheet;
    gridStructure: TDBGridEh;
    dsStructure: TDataSource;
    mtStructure: TMemTableEh;
    mtStructureFName: TStringField;
    mtStructureFType: TStringField;
    Panel2: TPanel;
    sbCancel: TSpeedButton;
    sbApply: TSpeedButton;
    mtStructureRefDataField: TRefObjectField;
    DBNavigator1: TDBNavigator;
    cbPersistentStructure: TCheckBox;
    procedure actFetchParamsExecute(Sender: TObject);
    procedure actAssignLocalDataExecute(Sender: TObject);
    procedure actLoadFromMyBaseTableExecute(Sender: TObject);
    procedure actCreateDataSetExecute(Sender: TObject);
    procedure actSaveToMyBaseXmlTableExecute(Sender: TObject);
    procedure actSaveToMyBaseXmlUTF8TableExecute(Sender: TObject);
    procedure actSaveToBinaryMyBaseTableExecute(Sender: TObject);
    procedure actClearDataExecute(Sender: TObject);
    procedure actCreateDataSetUpdate(Sender: TObject);
    procedure SelectTable(Sender: TObject);
    procedure GridCutClick(Sender: TObject);
    procedure GridCopyClick(Sender: TObject);
    procedure GridPasteClick(Sender: TObject);
    procedure GridDeleteClick(Sender: TObject);
    procedure GridSelectAllClick(Sender: TObject);
    procedure DBGridEh1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure actCreateDataDriverExecute(Sender: TObject);
    procedure dsStructureDataChange(Sender: TObject; Field: TField);
    procedure sbCancelClick(Sender: TObject);
    procedure sbApplyClick(Sender: TObject);
    procedure DBGridEh2Columns0UpdateData(Sender: TObject;
      var Text: String; var Value: Variant; var UseText, Handled: Boolean);
    procedure mtStructureAfterPost(DataSet: TDataSet);
    procedure mtStructureBeforeDelete(DataSet: TDataSet);
    procedure mtStructureBeforePost(DataSet: TDataSet);
    procedure gridStructureEnter(Sender: TObject);
    procedure gridStructureExit(Sender: TObject);
    procedure cbPersistentStructureClick(Sender: TObject);
    procedure mtStructureNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    MTNotificator: TRecordsListNotificatorEh;
    ChStruct: TMTDataStructEh;
    FChStructChanged: Boolean;
    function GetMemTableEh: TMemTableEh;
    procedure MTStructChanged(AMemTableData: TMemTableDataEh);
    procedure ChStructChanged(Sender: TObject);
    procedure SetMemTableEh(Value: TMemTableEh);
    procedure UpdateStructButtons;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure DataSourceDataChange(Sender: TObject; Field: TField);
    procedure UpdateColumnProps;
    procedure DBGridEh1EditButtonClick(Sender: TObject);
    function EditStrings(sl: TStrings): Boolean;
    function EditPicture(Pic: TPicture): Boolean;
    destructor Destroy; override;
    procedure UpdateStructureList;
    property MemTable: TMemTableEh read GetMemTableEh write SetMemTableEh;
    function GetEditState: TEditState; override;
{$IFDEF EH_LIB_6}
    function EditAction(Action: TEditAction): Boolean; override;
{$ENDIF}
  end;

{ TMemTableEditorEh }

  TMemTableEditorEh = class(TComponentEditor{$IFDEF LINUX}, IDesignerThreadAffinity{$ENDIF})
  protected
    FMenuItem: IMenuItem;
    DDRPropName: String;
    FDataDriversList: TStringList;
    function GetDSDesignerClass: TDSDesignerClass; virtual;
    procedure HandleCreateDataDriverSubMenu(Sender: TObject);
    procedure HandleAssignDataDriverSubMenu(Sender: TObject);
    procedure CheckComponent(const Value: string);
   public
    destructor Destroy; override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
{$IFDEF LINUX}
    procedure Edit; override;
    {IDesignerThreadAffinity}
    function GetThreadAffinity: TThreadAffinity;
{$ENDIF}
  end;

{ TDataSourceEditor }

  TDataSourceEditor = class(TComponentEditor)
  protected
    FMenuItem: IMenuItem;
    DDRPropName: String;
    FDataSetList: TStringList;
    procedure HandleCreateDataSetSubMenu(Sender: TObject);
    procedure HandleAssignDataSetSubMenu(Sender: TObject);
    procedure CheckComponent(const Value: string);
   public
    destructor Destroy; override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
  end;

{ TDataSetDriverEhEditor }

  TDataSetDriverEhEditor = class(TComponentEditor)
    FMenuItem: IMenuItem;
    DDRPropName: String;
    FDataSetList: TStringList;
    procedure HandleCreateDataSetSubMenu(Sender: TObject);
    procedure HandleAssignDataSetSubMenu(Sender: TObject);
    procedure CheckComponent(const Value: string);
  public
    destructor Destroy; override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
  end;

{ TSQLDataDriverEhEditor }

  TSQLDataDriverEhEditor = class(TComponentEditor)
  public
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TServerTypePropertyEditor }

  TServerTypePropertyEditor = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{ TMemTableFieldLinkProperty }

  TMemTableFieldLinkProperty = class(TFieldLinkProperty)
  private
    FMemTable: TMemTableEh;
  protected
    function GetIndexFieldNames: string; override;
    function GetMasterFields: string; override;
    procedure SetIndexFieldNames(const Value: string); override;
    procedure SetMasterFields(const Value: string); override;
  public
    procedure Edit; override;
  end;

  TSQLCommandProperty  = class(TClassProperty)
  public
{$IFDEF EH_LIB_6}
    FCommandTextProp: IProperty;
{$ELSE}
    FCommandTextProp: TPropertyEditor;
{$ENDIF}
    function GetAttributes: TPropertyAttributes; override;
    procedure Edit; override;
{$IFDEF EH_LIB_6}
    procedure SetCommandTextProp(const Prop: IProperty);
{$ELSE}
    procedure SetCommandTextProp(Prop: TPropertyEditor);
{$ENDIF}
  end;

 TDataDriverEhSelectionEditor = class(TSelectionEditor)
 public
   procedure RequiresUnits(Proc: TGetStrProc); override;
 end;

procedure ShowFieldsEditorEh(Designer: IDesigner; MemTable: TMemTableEh;
  DesignerClass: TDSDesignerClass);
function CreateFieldsEditorEh(Designer: IDesigner; MemTable: TMemTableEh;
  DesignerClass: TDSDesignerClass; var Shared: Boolean): TMemTableFieldsEditorEh;

//function CreateUniqueName(Dataset: TDataset; const FieldName: string;
//  FieldClass: TFieldClass; Component: TComponent): string;

var
  MemTableFieldsEditor: TMemTableFieldsEditorEh;

{$ENDIF}

//procedure GetComponentNames(lst: TStrings; TargetClass: TClass; DividePackages: Boolean);

procedure Register;

implementation

uses Clipbrd,
  DataDriverEh, TypInfo, DBAxisGridsEh,
{$IFDEF CIL}
  Borland.Vcl.Design.FldLinks,
{$ELSE}
  {$IFDEF FPC}
  {$ELSE}
  MemTableEditEh, SQLDriverEditEh, ToolsAPI,
  EhLibDesignEditFavouriteComponents, EhLibDesignAbout,
  {$ENDIF}
{$ENDIF}
//  DBTables, bdeconst,
//  BDEDataDriverEh, BDEDataDriverDesignEh,
  EhLibReg;
  
{$IFDEF FPC}
{$ELSE}
{$R *.dfm}
{$ENDIF}

procedure Register;
begin
    // Ampy table
  // Fields Editor...
  // Fetch Params
  // Assign Local Data...
  // Load from MyBase table...

    // Ampy table with created fields
  // Fields Editor...
  // Fetch Params
  // Assign Local Data...
  // Load from MyBase table...
  //
  // Create DataSet

    // Ampy table with created fields and created table
  // Fields Editor...
  // Fetch Params
  // Assign Local Data...
  // Load from MyBase table...
  //
  // Save to MyBase Xml table...
  // Save to MyBase Xml UTF8 table...
  // Save to binary MyBase table...
  // Clear Data

  RegisterComponents('EhLib Components', [TMemTableEh]);
  RegisterComponents('EhLib Components', [TDataSetDriverEh, TSQLDataDriverEh]);
  RegisterComponents('EhLib Components', [TSQLConnectionProviderEh]);

  RegisterClasses([TMTStringFieldEh]);
  RegisterClasses([TRefObjectField]);

{$IFDEF FPC}
{$ELSE}
  RegisterFields([TMTStringFieldEh]);
  RegisterFields([TRefObjectField]);

  RegisterComponentEditor(TCustomMemTableEh, TMemTableEditorEh);
  RegisterComponentEditor(TDataSource, TDataSourceEditor);
  RegisterComponentEditor(TSQLDataDriverEh, TSQLDataDriverEhEditor);
  RegisterComponentEditor(TDataSetDriverEh, TDataSetDriverEhEditor);


  RegisterPropertyEditor(TypeInfo(string), TCustomMemTableEh, 'MasterFields', TMemTableFieldLinkProperty);
  RegisterPropertyEditor(TypeInfo(string), TCustomMemTableEh, 'DetailFields', TMemTableFieldLinkProperty);
  RegisterPropertyEditor(TypeInfo(TSQLCommandEh), TSQLDataDriverEh, '', TSQLCommandProperty);
  RegisterPropertyEditor(TypeInfo(string), TConnectionProviderEh, 'ServerType', TServerTypePropertyEditor);

  RegisterSelectionEditor(TDataDriverEh, TDataDriverEhSelectionEditor);
  RegisterSelectionEditor(TMemTableEh, TDataDriverEhSelectionEditor);
{$ENDIF}

end;

{$IFDEF FPC}
{$ELSE}
{ TSQLCommandProperty }

procedure TSQLCommandProperty.Edit;
var
  Command: TSQLCommandEh;
{$IFDEF EH_LIB_6}
  FSQLCommandSel: IDesignerSelections;
{$ELSE}
  FSQLCommandSel: TDesignerSelectionList;
{$ENDIF}
begin
  FCommandTextProp := nil;
{$IFDEF CIL}
  Command := TSQLCommandEh(GetObjValue);
{$ELSE}
  Command := TSQLCommandEh(GetOrdValue);
{$ENDIF}
{$IFDEF EH_LIB_6}
  FSQLCommandSel := CreateSelectionList;
  FSQLCommandSel.Add(Command);
  GetComponentProperties(FSQLCommandSel, [tkClass], Designer, SetCommandTextProp, nil);
  if FCommandTextProp <> nil then
    FCommandTextProp.Edit;
{$ELSE}
  FSQLCommandSel := TDesignerSelectionList.Create;
  FSQLCommandSel.Add(Command);
  GetComponentProperties(FSQLCommandSel, [tkClass], Designer, SetCommandTextProp);
  if FCommandTextProp <> nil then
    FCommandTextProp.Edit;
{$ENDIF}
end;

function TSQLCommandProperty.GetAttributes: TPropertyAttributes;
begin
  Result := inherited GetAttributes + [paDialog];
end;

{$IFDEF EH_LIB_6}
procedure TSQLCommandProperty.SetCommandTextProp(const Prop: IProperty);
{$ELSE}
procedure TSQLCommandProperty.SetCommandTextProp(Prop: TPropertyEditor);
{$ENDIF}
begin
  if Prop.GetName = 'CommandText' then
    FCommandTextProp := Prop;
end;

{ TMemTableFieldLinkProperty }

procedure TMemTableFieldLinkProperty.Edit;
begin
  FMemTable := DataSet as TMemTableEh;
  inherited Edit;
end;

function TMemTableFieldLinkProperty.GetIndexFieldNames: string;
begin
  Result := FMemTable.DetailFields;
end;

function TMemTableFieldLinkProperty.GetMasterFields: string;
begin
  Result := FMemTable.MasterFields;
end;

procedure TMemTableFieldLinkProperty.SetIndexFieldNames(const Value: string);
begin
  FMemTable.DetailFields := Value;
end;

procedure TMemTableFieldLinkProperty.SetMasterFields(const Value: string);
begin
  FMemTable.MasterFields := Value;
end;

{ Utility functions }

procedure ShowFieldsEditorEh(Designer: IDesigner; MemTable: TMemTableEh;
  DesignerClass: TDSDesignerClass);
var
  FieldsEditor: TFieldsEditor;
  vShared: Boolean;
begin
  FieldsEditor := CreateFieldsEditorEh(Designer, MemTable, DesignerClass, vShared);
  if FieldsEditor <> nil then
    FieldsEditor.Show;
end;

function CreateFieldsEditorEh(Designer: IDesigner; MemTable: TMemTableEh;
  DesignerClass: TDSDesignerClass; var Shared: Boolean): TMemTableFieldsEditorEh;
begin
  Shared := True;
  if MemTable.Designer <> nil then
  begin
    Result := TMemTableFieldsEditorEh((MemTable.Designer as TDSDesigner).FieldsEditor);
  end
  else
  begin
    Result := TMemTableFieldsEditorEh.Create(Application);
    Result.DSDesignerClass := DesignerClass;
{$IFDEF EH_LIB_6}
    Result.Designer := Designer;
{$ELSE}
    Result.Designer := IFormDesigner(Designer);
    Result.Form := Designer.Form;
{$ENDIF}
    Result.MemTable := MemTable;
    Shared := False;
  end;
end;

{ TMTDesigner }

type

  TMTDesigner = class(TDSDesigner)
  public
    function SupportsAggregates: Boolean; override;
    function SupportsInternalCalc: Boolean; override;
    procedure BeginUpdateFieldDefs; override;
  end;

{ TMTDesigner }

function TMTDesigner.SupportsAggregates: Boolean;
begin
  Result := True;
end;

function TMTDesigner.SupportsInternalCalc: Boolean;
begin
  Result := True;
end;

procedure TMTDesigner.BeginUpdateFieldDefs;
begin
  if FieldsEditor.Dataset.Active then
    ShowMessage('Close DataSet before adding new fields');
end;

{ TDataSetEditor }

destructor TMemTableEditorEh.Destroy;
begin
  FreeAndNil(FDataDriversList);
  inherited Destroy;
end;

procedure TMemTableEditorEh.CheckComponent(const Value: string);
var
  AComponent: TComponent;
begin
  AComponent := Designer.GetComponent(Value);
  if (AComponent.Owner <> Component.Owner) then
    FDataDriversList.AddObject(Concat(AComponent.Owner.Name, '.', AComponent.Name), AComponent)
  else
    if AnsiCompareText(AComponent.Name, Component.Name) <> 0 then
      FDataDriversList.AddObject(AComponent.Name, AComponent);
end;

function TMemTableEditorEh.GetDSDesignerClass: TDSDesignerClass;
begin
  Result := TMTDesigner;
end;

procedure TMemTableEditorEh.ExecuteVerb(Index: Integer);
begin
  case Index of
    0:
      ShowFieldsEditorEh(Designer, TMemTableEh(Component), GetDSDesignerClass);
    1:
      begin
        TCustomMemTableEh(Component).FetchParams;
        Designer.Modified;
      end;
    2: if EditMemTable(TCustomMemTableEh(Component), Designer)
         then Designer.Modified;

//    3: EditMTCreateDataDriver(TCustomMemTableEh(Component), Designer);
      //if LoadFromFile(TClientDataSet(Component))
      //  then Designer.Modified;
    8:
      ShowAboutForm;
  else
    if TDataSet(Component).Active then
      case Index of
//        4: ;//SaveToFile(TClientDataSet(Component) {$IFDEF EH_LIB_6},dfXML{$ENDIF} );
//        5: ;//SaveToFile(TClientDataSet(Component) {$IFDEF EH_LIB_6},dfXMLUTF8{$ENDIF} );
//        6: ;//SaveToFile(TClientDataSet(Component) {$IFDEF EH_LIB_6},dfBinary{$ENDIF} );
        5:
          begin
            TCustomMemTableEh(Component).Close;
            TCustomMemTableEh(Component).FieldDefs.Clear;
            Designer.Modified;
          end;
      end
    else if ((TDataSet(Component).FieldCount > 0) or
             (TDataSet(Component).FieldDefs.Count > 0)) and
            not TDataSet(Component).Active
    then
      case Index of
        6:
          begin
            TCustomMemTableEh(Component).CreateDataSet;
            Designer.Modified;
          end;
      end;
  end;
end;

function TMemTableEditorEh.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Fields Editor...';
    1: Result := 'Fetch Params';
    2: Result := 'Assign Local Data...';
    3: Result := 'Create DataDriver as';
    4: Result := 'Assign DataDriver by';
    5: Result := 'Clear Data';
    6: Result := 'Create DataSet Struct';
    7: Result := '-';
    8: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TMemTableEditorEh.GetVerbCount: Integer;
begin
  Result := 9;
end;

(*
procedure GetComponentNames(lst: TStrings; TargetClass: TClass; DividePackages: Boolean);
var
  i, k: Integer;
  CRef: TClass;
//  strName: ShortString;
  LServices: IOTAPackageServices;
  TheNewOne: Boolean;
begin
  lst.Clear;
  LServices := BorlandIDEServices as IOTAPackageServices;
  TheNewOne := False;
  for i := 0 to LServices.PackageCount-1 do
  begin
    for k := 0 to LServices.ComponentCount[i]-1 do
    begin
      CRef := TClass(GetClass(LServices.GetComponentName(i, k)));
      if (CRef <> nil) and CRef.InheritsFrom(TargetClass) then
      begin
        if DividePackages and TheNewOne then
          lst.AddObject('-', nil);
        lst.AddObject({LServices.PackageNames[i]+'.'+}CRef.ClassName, TObject(CRef));
        TheNewOne := False;
      end;
    end;
    TheNewOne := True;
  end;
end;
*)

procedure TMemTableEditorEh.PrepareItem(Index: Integer; const AItem: IMenuItem);
var
  lst: TStrings;
  i: Integer;
  LMenuItem: IMenuItem;
  S: String;
begin
  inherited PrepareItem(Index, AItem);

  case Index of
    3:
      begin
        FMenuItem := AItem;
        with AItem do
        begin
          DDRPropName := 'DataDriver';
          lst := TStringList.Create;
          GetComponentNamesEh(lst, TDataDriverEh, False);
          for i := 0 to lst.Count-1 do
          begin
            LMenuItem := AddItem(lst[i], 0, False, True, HandleCreateDataDriverSubMenu);
            LMenuItem.Tag := LongInt(lst.Objects[i]);
          end;
          lst.Free;

        end;
        FMenuItem := nil;
      end;

    4:
      begin
        if FDataDriversList = nil then
          FDataDriversList := TStringList.Create;
        FMenuItem := AItem;
        with AItem do
        begin
          DDRPropName := 'DataDriver';

          FDataDriversList.Clear;
          Designer.GetComponentNames(GetTypeData(TDataDriverEh.ClassInfo), CheckComponent);

          for i := 0 to FDataDriversList.Count-1 do
          begin
            S := FDataDriversList[i] + ': ' + FDataDriversList.Objects[i].ClassName;
            if FDataDriversList.Objects[i] = TCustomMemTableEh(Component).DataDriver then
              S := S + ' (assigned)';
            LMenuItem := AddItem(S, 0, False, True, HandleAssignDataDriverSubMenu);
            LMenuItem.Tag := LongInt(FDataDriversList.Objects[i]);
          end;

        end;
        FMenuItem := nil;
      end;

    5: //Result := 'Clear Data';
      begin
        AItem.Visible := TDataSet(Component).Active;
      end;
    6: //Result := 'Create DataSet';
      begin
        AItem.Visible := ((TDataSet(Component).FieldCount > 0) or
             (TDataSet(Component).FieldDefs.Count > 0)) and
            not TDataSet(Component).Active;
      end;
  end;
end;

procedure TMemTableEditorEh.HandleCreateDataDriverSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataDriverClass: TComponentClass;
  NewComponent: TComponent;
  ABaseComponent: TComponent;
  ADDRPropName: String;
begin
  MenuItem := TMenuItem(Sender);
  DataDriverClass := TComponentClass(MenuItem.Tag);
  ABaseComponent := Component;
  ADDRPropName := DDRPropName;
  NewComponent := Designer.CreateComponent(DataDriverClass, Component.Owner, 0, 0, 0, 0);
  SetObjectProp(ABaseComponent, ADDRPropName, NewComponent);
end;

procedure TMemTableEditorEh.HandleAssignDataDriverSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataDriver: TComponent;
begin
  MenuItem := TMenuItem(Sender);
  DataDriver := TComponent(MenuItem.Tag);
  SetObjectProp(Component, DDRPropName, DataDriver);
  Designer.Modified;
end;

{$IFDEF LINUX}
function TMemTableEditorEh.GetThreadAffinity: TThreadAffinity;
begin
  Result  := taQT;
end;

procedure TMemTableEditorEh.Edit;
begin
  ShowFieldsEditorEh(Designer, TDataSet(Component), GetDSDesignerClass);
end;

{$ENDIF}

{ TDataSourceEditor }

destructor TDataSourceEditor.Destroy;
begin
  FreeAndNil(FDataSetList);
  inherited Destroy;
end;

procedure TDataSourceEditor.CheckComponent(const Value: string);
var
  AComponent: TComponent;
begin
  AComponent := Designer.GetComponent(Value);
  if (AComponent.Owner <> Component.Owner) then
    FDataSetList.AddObject(Concat(AComponent.Owner.Name, '.', AComponent.Name), AComponent)
  else
    if AnsiCompareText(AComponent.Name, Component.Name) <> 0 then
      FDataSetList.AddObject(AComponent.Name, AComponent);
end;

procedure TDataSourceEditor.ExecuteVerb(Index: Integer);
begin
  inherited ExecuteVerb(Index);
end;

function TDataSourceEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Create DataSet as';
    1: Result := 'Assign DataSet by';
  end;
end;

function TDataSourceEditor.GetVerbCount: Integer;
begin
  Result := 2;
end;

procedure TDataSourceEditor.HandleCreateDataSetSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataSetClass: TComponentClass;
  NewComponent: TComponent;
  ABaseComponent: TComponent;
  ADDRPropName: String;
  ADesigner: IDesigner;
  slFavourite, slAll: TStringList;
begin
  MenuItem := TMenuItem(Sender);
  if MenuItem.Caption = 'Change Favorite DataSets...' then
  begin
    slFavourite := TStringList.Create;
    slAll := TStringList.Create;

    GetComponentNamesEh(slAll, TDataSet, False);

    GetFavouriteComponentList(TDataSet, slFavourite, False);
    if SelectFavouriteComponentList(slFavourite, slAll) then
      SetFavouriteComponentList(TDataSet, slFavourite);

    slFavourite.Free;
    slAll.Free;
  end else
  begin
    DataSetClass := TComponentClass(MenuItem.Tag);
    ABaseComponent := Component;
    ADDRPropName := DDRPropName;
    ADesigner := Designer;
    NewComponent := Designer.CreateComponent(DataSetClass, Component.Owner, 0, 0, 0, 0);
    SetObjectProp(ABaseComponent, ADDRPropName, NewComponent);
    ADesigner.Modified;
  end;
end;

procedure TDataSourceEditor.HandleAssignDataSetSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataSet: TComponent;
begin
  MenuItem := TMenuItem(Sender);
  DataSet := TComponent(MenuItem.Tag);
  SetObjectProp(Component, DDRPropName, DataSet);
  Designer.Modified;
end;

procedure TDataSourceEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
var
  lst: TStringList;
  i: Integer;
  LMenuItem: IMenuItem;
  S: String;
  FullLst: TStringList;
begin
  inherited PrepareItem(Index, AItem);

  case Index of
    0:
      begin
        FMenuItem := AItem;
        with AItem do
        begin
          DDRPropName := 'DataSet';
          lst := TStringList.Create;
//          GetComponentNames(lst, TDataSet, True);
          GetFavouriteComponentList(TDataSet, lst, True);

          FullLst := TStringList.Create;
//          ShowMessage('FullCheck');
          GetComponentNamesEh(FullLst, TDataSet, False, Component, 'DataSet');

          for i := lst.Count-1 downto 0 do
          begin
            if FullLst.IndexOf(lst[i]) < 0 then
            begin
//              ShowMessage('Delete ' + lst[i]);
              lst.Delete(i);
            end;
          end;

          if lst.Count = 0 then
            lst.AddObject('TMemTableEh', TObject(TMemTableEh))
          else
          begin
            i := lst.IndexOf('TMemTableEh');
            if i >= 0 then
            begin
              if (i > 0) and (lst[i-1] = '-') then
                lst.Move(i-1, 0);
              lst.Move(i, 0);
            end;
          end;

          for i := 0 to lst.Count-1 do
          begin
            LMenuItem := AddItem(lst[i], 0, False, True, HandleCreateDataSetSubMenu);
            LMenuItem.Tag := LongInt(lst.Objects[i]);
          end;
          lst.Free;
          FullLst.Free;

          LMenuItem := AddItem('-', 0, False, True, HandleCreateDataSetSubMenu);

          LMenuItem := AddItem('Change Favorite DataSets...', 0, False, True, HandleCreateDataSetSubMenu);
          LMenuItem.Tag := LongInt(TDataSet);

        end;
        FMenuItem := nil;
      end;

    1:
      begin
        if FDataSetList = nil then
          FDataSetList := TStringList.Create;
        FMenuItem := AItem;
        with AItem do
        begin
          DDRPropName := 'DataSet';

          FDataSetList.Clear;
          Designer.GetComponentNames(GetTypeData(TDataSet.ClassInfo), CheckComponent);

          for i := 0 to FDataSetList.Count-1 do
          begin
            S := FDataSetList[i] + ': ' + FDataSetList.Objects[i].ClassName;
            if FDataSetList.Objects[i] = TDataSource(Component).DataSet then
              S := S + ' (assigned)';
            LMenuItem := AddItem(S, 0, False, True, HandleAssignDataSetSubMenu);
            LMenuItem.Tag := LongInt(FDataSetList.Objects[i]);
          end;

        end;
        FMenuItem := nil;
      end;
  end;
end;

{ TSQLDataDriverEhEditor }

procedure TSQLDataDriverEhEditor.ExecuteVerb(Index: Integer);
begin
  EditSQLDataDriverEh(Component as TCustomSQLDataDriverEh);
end;

function TSQLDataDriverEhEditor.GetVerb(Index: Integer): string;
begin
  Result := 'UpdateSQL Editor...';
end;

function TSQLDataDriverEhEditor.GetVerbCount: Integer;
begin
  Result := 1;
end;

{$IFDEF EH_LIB_6}

{ TDataDriverEhSelectionEditor }

procedure TDataDriverEhSelectionEditor.RequiresUnits(Proc: TGetStrProc);
begin
   inherited RequiresUnits(Proc);
   Proc('MemTableDataEh');
{$IFDEF EH_LIB_16}
   Proc('Data.DB');
{$ELSE}
   Proc('Db');
{$ENDIF}
end;
{$ENDIF}

{ TMemTableFieldsEditorEh }

constructor TMemTableFieldsEditorEh.Create(AOwner: TComponent);
var
  NonClientMetrics: TNonClientMetrics;
begin
  inherited Create(AOwner);
  if ParentFont then
  begin
    NonClientMetrics.cbSize := sizeof(NonClientMetrics);

{$IFDEF CIL}
  { TODO : To do for CIL }
//    if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
//      Font.Name := NonClientMetrics.lfMessageFont.lfFaceName;
{$ELSE}
    if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
      Font.Name := NonClientMetrics.lfMessageFont.lfFaceName;
{$ENDIF}
  end;
  AggListBox.Parent := TabSheet1;
  FieldListBox.Parent := TabSheet1;
  Splitter1.Parent := TabSheet1;
  Splitter1.Top := 0;
  DBNavigator.VisibleButtons := [nbFirst..nbRefresh];
  PopupMenu := nil;
  FieldListBox.PopupMenu := LocalMenu;
  SpeedButton1.Align := alTop;
  SpeedButton2.Align := alTop;
  SpeedButton3.Align := alTop;
  SpeedButton4.Align := alTop;
  SpeedButton5.Align := alTop;
  SpeedButton6.Align := alTop;
  SpeedButton7.Align := alTop;
  SpeedButton8.Align := alTop;
  DBGridEh1.DrawGraphicData := True;
  DBGridEh1.DrawMemoText := True;
//  DBGridEh1.OnEditButtonClick := DBGridEh1EditButtonClick;
  DataSource.OnDataChange := DataSourceDataChange;

  Panel1.Parent := TabSheet2;

  MTNotificator := TRecordsListNotificatorEh.Create(Self);
  MTNotificator.OnStructChanged :=  MTStructChanged;

end;

destructor TMemTableFieldsEditorEh.Destroy;
begin
  FreeAndNil(ChStruct);
  inherited Destroy;
end;

procedure TMemTableFieldsEditorEh.DataSourceDataChange(Sender: TObject; Field: TField);
begin
  UpdateColumnProps;
end;

procedure TMemTableFieldsEditorEh.UpdateColumnProps;
var
  i: Integer;
begin
  for i := 0 to DBGridEh1.Columns.Count-1 do
  begin
    if (DBGridEh1.Columns[i].Field <> nil) and
       (DBGridEh1.Columns[i].Field.DataType in [ftMemo, ftGraphic, ftFmtMemo{$IFDEF EH_LIB_10}, ftWideMemo {$ENDIF}]) then
      DBGridEh1.Columns[i].ButtonStyle := cbsEllipsis;
  end;
end;

procedure TMemTableFieldsEditorEh.DBGridEh1EditButtonClick(Sender: TObject);
var
  Field: TField;
  sl: TStringList;
  Pic: TPicture;
  ms: TMemoryStream;
begin
  if DBGridEh1.SelectedField <> nil then
  begin
    Field := DBGridEh1.SelectedField;
    if Field.DataType in [ftMemo, ftFmtMemo{$IFDEF EH_LIB_10}, ftWideMemo {$ENDIF}] then
    begin
      sl := TStringList.Create;
      try
        sl.Text := Field.AsString;
        if EditStrings(sl) then
        begin
          Field.DataSet.Edit;
          Field.AsString := sl.Text;
        end;
      finally
        sl.Free;
      end;
    end else if Field.DataType in [ftGraphic] then
    begin
      Pic := TPicture.Create;
      ms := nil;
      try
        ms := TMemoryStream.Create;
        try
          Pic.Assign(Field);
        except
          on EInvalidGraphic do ;
          else raise;
        end;

{        TBlobField(Field).SaveToStream(ms);
        ms.Position := 0;
        (Pic as IStreamPersist).LoadFromStream(ms);}
        if EditPicture(Pic) then
        begin
          Field.DataSet.Edit;
{          ms.Clear;
          (Pic as IStreamPersist).SaveToStream(ms);
          ms.Position := 0;
          TBlobField(Field).LoadFromStream(ms);}
          Field.Assign(Pic.Graphic);
        end;
      finally
        Pic.Free;
        ms.Free;
      end;
    end;
  end;
//  if (DBGridEh1.Columns[i].Field <> nil) and
//     (DBGridEh1.Columns[i].Field.DataType in [ftMemo, ftGraphic, ftFmtMemo{$IFDEF EH_LIB_10}, ftWideMemo {$ENDIF}]) then
end;

{$IFDEF EH_LIB_6}
type
  TStringsEditDlgCrack = class(TStringsEditDlg);
{$ENDIF}

function TMemTableFieldsEditorEh.EditStrings(sl: TStrings): Boolean;
{$IFDEF EH_LIB_6}
var
  sed: TStringsEditDlg;
{$ENDIF}
begin
  Result := False;
{$IFDEF EH_LIB_6}
  sed := TStringsEditDlg.Create(Application);
  try
    sed.Lines := sl;
//    UpdateStatus(nil);
{$IFDEF CIL}
{$ELSE}
    TStringsEditDlgCrack(sed).FModified := False;
{$ENDIF}
    sed.ActiveControl := nil;
    sed.CodeEditorItem.Enabled := False;
    sed.CodeWndBtn.Enabled := False;
    case sed.ShowModal of
      mrOk:
        begin
          sl.Assign(sed.Lines);
          Result := True;
        end;
     end;
  finally
    FreeAndNil(sed);
  end;
{$ENDIF}
end;

function TMemTableFieldsEditorEh.EditPicture(Pic: TPicture): Boolean;
var
  PictureEditor: TPictureEditor;
begin
  Result := False;
  PictureEditor := TPictureEditor.Create(nil);
  try
    PictureEditor.Picture := Pic;
    if PictureEditor.Execute then
    begin
      Pic.Assign(PictureEditor.Picture);
      Result := True;
    end;
  finally
    PictureEditor.Free;
  end;
end;

type
  TCustomDBGridEhCrack = class(TCustomDBGridEh) end;

function TMemTableFieldsEditorEh.GetEditState: TEditState;
var
  Grid: TCustomDBGridEhCrack;
begin
  if PageControl1.ActivePage = TabSheet1 then
    Result := inherited GetEditState
  else
  begin
    if ActiveControl is TCustomDBGridEh then
    begin
      Grid := TCustomDBGridEhCrack(ActiveControl);
      Result := [];
      if Clipboard.HasFormat(CF_TEXT) then Result := [esCanPaste];
      if Grid.EditorMode then
{$IFDEF EH_LIB_6} 
{$IFDEF CIL}
{$ELSE}
        Result := GetEditStateFor(Grid.InplaceEditor)
{$ENDIF}
{$ENDIF}
      else
        Result := Result + [esCanCopy, esCanSelectAll];
    end;
  end;
end;

{$IFDEF EH_LIB_6} 
function TMemTableFieldsEditorEh.EditAction(Action: TEditAction): Boolean;
var
  Grid: TCustomDBGridEhCrack;
begin
  if PageControl1.ActivePage = TabSheet1 then
    Result := inherited EditAction(Action)
  else
  begin
    Result := False;
    if ActiveControl is TCustomDBGridEh then
    begin
      Grid := TCustomDBGridEhCrack(ActiveControl);
      Result := True;
      if Grid.EditorMode then
{$IFDEF CIL}
{$ELSE}
        Result := EditActionFor(Grid.InplaceEditor, Action)
{$ENDIF}
      else
        case Action of
          eaCut: DBGridEh_DoCutAction(Grid, False);
          eaCopy: DBGridEh_DoCopyAction(Grid, False);
          eaPaste: DBGridEh_DoPasteAction(Grid, False);
//          eaDelete: RemoveFields(GetActiveListbox);
          eaSelectAll: Grid.Selection.SelectAll;
        else
          Result := False;
        end;
    end;
  end;
end;
{$ENDIF}

procedure TMemTableFieldsEditorEh.actFetchParamsExecute(Sender: TObject);
begin
  TCustomMemTableEh(Dataset).FetchParams;
  Designer.Modified;
end;

procedure TMemTableFieldsEditorEh.actAssignLocalDataExecute(
  Sender: TObject);
begin
  if EditMemTable(TCustomMemTableEh(Dataset), Designer)
    then Designer.Modified;
end;

procedure TMemTableFieldsEditorEh.actLoadFromMyBaseTableExecute(
  Sender: TObject);
begin
//  if LoadFromFile(TClientDataSet(Dataset))
//    then Designer.Modified;
end;

procedure TMemTableFieldsEditorEh.actCreateDataSetExecute(
  Sender: TObject);
begin
  TCustomMemTableEh(Dataset).CreateDataSet;
  Designer.Modified;
end;

procedure TMemTableFieldsEditorEh.actSaveToMyBaseXmlTableExecute(Sender: TObject);
begin
//  SaveToFile(TClientDataSet(Dataset) {$IFDEF EH_LIB_6},dfXML{$ENDIF} );
end;

procedure TMemTableFieldsEditorEh.actSaveToMyBaseXmlUTF8TableExecute(
  Sender: TObject);
begin
//  SaveToFile(TClientDataSet(Dataset) {$IFDEF EH_LIB_6},dfXMLUTF8{$ENDIF} );
end;

procedure TMemTableFieldsEditorEh.actSaveToBinaryMyBaseTableExecute(
  Sender: TObject);
begin
//  SaveToFile(TClientDataSet(Dataset) {$IFDEF EH_LIB_6},dfBinary{$ENDIF} );
end;

procedure TMemTableFieldsEditorEh.actClearDataExecute(Sender: TObject);
begin
//  TCustomMemTableEh(Dataset).Close;
  TCustomMemTableEh(Dataset).DestroyTable;
  TCustomMemTableEh(Dataset).FieldDefs.Clear;
  Designer.Modified;
end;

procedure TMemTableFieldsEditorEh.actCreateDataSetUpdate(
  Sender: TObject);
begin
  actCreateDataSet.Enabled := ((Dataset.FieldCount > 0) or
                               (Dataset.FieldDefs.Count > 0)) and
                              not Dataset.Active;
  actSaveToMyBaseXmlTable.Enabled := Dataset.Active;
  actSaveToMyBaseXmlTable.Visible := False;
  actSaveToMyBaseXmlUTF8Table.Enabled := Dataset.Active;
  actSaveToMyBaseXmlUTF8Table.Visible := False;
  actSaveToBinaryMyBaseTable.Enabled := Dataset.Active;
  actSaveToBinaryMyBaseTable.Visible := False;
  actLoadFromMyBaseTable.Visible := False;
  actClearData.Enabled := Dataset.Active;
end;

procedure TMemTableFieldsEditorEh.SelectTable(Sender: TObject);
var
  I: Integer;
begin
  FieldListBox.ItemIndex := 0;
  with FieldListBox do
    for I := 0 to Items.Count - 1 do
      if Selected[I] then Selected[I] := False;
  Activated;   //UpdateSelection;
  case PageControl1.ActivePageIndex of
    0: FieldListBox.SetFocus;
    1: gridStructure.SetFocus;
  end;
end;

procedure TMemTableFieldsEditorEh.GridCutClick(Sender: TObject);
begin
  DBGridEh_DoCutAction(DBGridEh1,False);
end;

procedure TMemTableFieldsEditorEh.GridCopyClick(Sender: TObject);
begin
  DBGridEh_DoCopyAction(DBGridEh1,False);
end;

procedure TMemTableFieldsEditorEh.GridPasteClick(Sender: TObject);
begin
  DBGridEh_DoPasteAction(DBGridEh1,False);
end;

procedure TMemTableFieldsEditorEh.GridDeleteClick(Sender: TObject);
begin
  DBGridEh_DoDeleteAction(DBGridEh1,False);
end;

procedure TMemTableFieldsEditorEh.GridSelectAllClick(Sender: TObject);
begin
  DBGridEh1.Selection.SelectAll;
end;

procedure TMemTableFieldsEditorEh.DBGridEh1ContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var Pos: TPoint;
begin
  if not ((DBGridEh1.InplaceEditor <> nil) and
          (DBGridEh1.InplaceEditor.Visible)) then
  begin
    GridCut.Enabled := (DBGridEh1.Selection.SelectionType <> gstNon);
    GridCopy.Enabled := (DBGridEh1.Selection.SelectionType <> gstNon);
    GridPaste.Enabled := Clipboard.HasFormat(CF_VCLDBIF) or
                         Clipboard.HasFormat(CF_TEXT);
    GridDelete.Enabled := (DBGridEh1.Selection.SelectionType <> gstNon);
    GridSelectAll.Enabled := (DBGridEh1.Selection.SelectionType <> gstAll);
    Pos := DBGridEh1.ClientToScreen(MousePos);
    GridMenu.Popup(Pos.X,Pos.Y);
  end;
end;

procedure TMemTableFieldsEditorEh.actCreateDataDriverExecute(
  Sender: TObject);
begin
  EditMTCreateDataDriver(TCustomMemTableEh(Dataset), Designer);
end;

procedure TMemTableFieldsEditorEh.dsStructureDataChange(Sender: TObject;
  Field: TField);
var
{$IFDEF EH_LIB_6}
  ComponentList: IDesignerSelections;
{$ELSE}
  ComponentList: TDesignerSelectionList;
{$ENDIF}
begin
  if (mtStructure.FieldByName('FName').AsString <> '') then
  begin
{$IFDEF EH_LIB_6}
    ComponentList := TDesignerSelections.Create;
{$ELSE}
    ComponentList := TDesignerSelectionList.Create;
{$ENDIF}
    if mtStructureRefDataField.Value <> nil then
      ComponentList.Add(TPersistent(mtStructureRefDataField.Value));
    Designer.SetSelections(ComponentList);
  end else if ActiveControl = gridStructure then
    Designer.NoSelection;
end;

procedure TMemTableFieldsEditorEh.UpdateStructureList;
var
//  DataStruct: TMTDataStructEh;
  i: Integer;
begin
  FreeAndNil(ChStruct);
  FChStructChanged := False;
  ChStruct := MemTable.RecordsView.MemTableData.DataStruct.GetCopy;
  ChStruct.OnStructChanged := ChStructChanged;
  dsStructure.OnDataChange := nil;
  mtStructure.AfterPost := nil;
  mtStructure.EmptyTable;
//  DataStruct := TCustomMemTableEh(DataSource.Dataset).RecordsView.MemTableData.DataStruct;
  for i := 0 to ChStruct.Count-1 do
  begin
    mtStructure.AppendRecord([ChStruct[i].FieldName, ChStruct[i].ClassName]);
    mtStructure.Edit;
    mtStructureRefDataField.Value := ChStruct[i];
    mtStructure.Post;
  end;
  mtStructure.First;
  dsStructure.OnDataChange := dsStructureDataChange;
  mtStructure.AfterPost := mtStructureAfterPost;
  sbCancel.Enabled := FChStructChanged;
  sbApply.Enabled := FChStructChanged;
  cbPersistentStructure.Checked := (mtoPersistentStructEh in MemTable.Options);
end;

function TMemTableFieldsEditorEh.GetMemTableEh: TMemTableEh;
begin
  Result := TMemTableEh(DataSet);
end;

procedure TMemTableFieldsEditorEh.SetMemTableEh(Value: TMemTableEh);
begin
  DataSet := Value;
  MTNotificator.DataObject := Value.RecordsView.MemTableData;
  UpdateStructureList;
end;

procedure TMemTableFieldsEditorEh.MTStructChanged(AMemTableData: TMemTableDataEh);
begin
  UpdateStructureList;
end;

procedure TMemTableFieldsEditorEh.ChStructChanged(Sender: TObject);
begin
  FChStructChanged := True;
//  ShowMessage('TMemTableFieldsEditorEh.ChStructChanged');
  UpdateStructButtons;
end;

procedure TMemTableFieldsEditorEh.UpdateStructButtons;
begin
  sbCancel.Enabled := FChStructChanged;
  sbApply.Enabled := FChStructChanged;
end;

procedure TMemTableFieldsEditorEh.sbCancelClick(Sender: TObject);
begin
  UpdateStructureList;
end;

procedure TMemTableFieldsEditorEh.sbApplyClick(Sender: TObject);
begin
  MemTable.RecordsView.MemTableData.DataStruct.Assign(ChStruct);
end;

procedure TMemTableFieldsEditorEh.DBGridEh2Columns0UpdateData(
  Sender: TObject; var Text: String; var Value: Variant; var UseText,
  Handled: Boolean);
var
  Col: TColumnEh;
begin
  Col := TColumnEh(Sender);
  Col.Field.AsString := Text;
  Col.Field.DataSet.Post;
  Handled := True;
end;

procedure TMemTableFieldsEditorEh.mtStructureAfterPost(DataSet: TDataSet);
var
  NewField: TMTDataFieldEh;
begin
  if mtStructureRefDataField.Value = nil then
  begin
    if (mtStructureFName.AsString <> '') and (mtStructureFType.AsString <> '') then
    begin
      NewField := ChStruct.CreateField(TMTDataFieldClassEh(FindClass(mtStructureFType.AsString)));
      NewField.FieldName := mtStructureFName.AsString;
      NewField.Index := mtStructure.RecNo - 1;
      mtStructure.Edit;
      mtStructureRefDataField.Value := NewField;
      mtStructure.AfterPost := nil;
      mtStructure.Post;
      mtStructure.AfterPost := mtStructureAfterPost;
    end;
  end else
  begin
  end;
end;

procedure TMemTableFieldsEditorEh.mtStructureBeforePost(DataSet: TDataSet);
var
  NewFieldClass: TMTDataFieldClassEh;
  NewField: TMTDataFieldEh;
begin
  if mtStructureRefDataField.Value <> nil then
  begin
    if TMTDataFieldEh(mtStructureRefDataField.Value).FieldName <> mtStructureFName.AsString then
      TMTDataFieldEh(mtStructureRefDataField.Value).FieldName := mtStructureFName.AsString;
    if TMTDataFieldEh(mtStructureRefDataField.Value).ClassName <> mtStructureFType.AsString then
    begin
//      ShowMessage('mtStructureBeforePost ChangeFieldType');
      NewFieldClass := TMTDataFieldClassEh(FindClass(mtStructureFType.AsString));
      NewField := ChStruct.ChangeFieldType(mtStructureFName.AsString, NewFieldClass);
//      mtStructure.Edit;
      mtStructureRefDataField.Value := NewField;
//      mtStructure.AfterPost := nil;
//      mtStructure.Post;
//      mtStructure.AfterPost := mtStructureAfterPost;
    end;
  end;
end;

procedure TMemTableFieldsEditorEh.mtStructureBeforeDelete(DataSet: TDataSet);
var
  OldField: TMTDataFieldEh;
begin
  OldField := ChStruct.FindField(mtStructureFName.AsString);
  if OldField <> nil then
  begin
    ChStruct.RemoveField(OldField);
    OldField.Free;
  end;
end;

procedure TMemTableFieldsEditorEh.mtStructureNewRecord(DataSet: TDataSet);
begin
  DataSet['FType'] := 'TMTStringDataFieldEh'
end;

procedure TMemTableFieldsEditorEh.gridStructureEnter(Sender: TObject);
begin
  dsStructureDataChange(nil, nil);
end;

procedure TMemTableFieldsEditorEh.gridStructureExit(Sender: TObject);
begin
  inherited;
  Designer.SelectComponent(Dataset);
end;

procedure TMemTableFieldsEditorEh.cbPersistentStructureClick(
  Sender: TObject);
begin
  if cbPersistentStructure.Checked
    then MemTable.Options := MemTable.Options + [mtoPersistentStructEh]
    else MemTable.Options := MemTable.Options - [mtoPersistentStructEh];
  Designer.Modified;
end;

{ TServerTypePropertyEditor }

function TServerTypePropertyEditor.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TServerTypePropertyEditor.GetValues(Proc: TGetStrProc);
var
  ConProv: TConnectionProviderEh;
  i: Integer;
begin
  ConProv := GetComponent(0) as TConnectionProviderEh;
  for i := 0 to ConProv.ServerTypesCount-1 do
  begin
    Proc(ConProv.ServerTypes[i]);
  end;
end;

{ TDataSetDriverEhEditor }

procedure TDataSetDriverEhEditor.CheckComponent(const Value: string);
var
  AComponent: TComponent;
begin
  AComponent := Designer.GetComponent(Value);
  if (AComponent.Owner <> Component.Owner) then
    FDataSetList.AddObject(Concat(AComponent.Owner.Name, '.', AComponent.Name), AComponent)
  else
    if AnsiCompareText(AComponent.Name, Component.Name) <> 0 then
      FDataSetList.AddObject(AComponent.Name, AComponent);
end;

destructor TDataSetDriverEhEditor.Destroy;
begin
  FreeAndNil(FDataSetList);
  inherited Destroy;
end;

procedure TDataSetDriverEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0: inherited ExecuteVerb(Index);
    1: inherited ExecuteVerb(Index);
    2: ;
    3: ShowAboutForm;
  end;
end;

function TDataSetDriverEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Create ProviderDataSet as';
    1: Result := 'Assign ProviderDataSet by';
    2: Result := '-';
    3: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TDataSetDriverEhEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;

procedure TDataSetDriverEhEditor.HandleAssignDataSetSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataSet: TComponent;
begin
  MenuItem := TMenuItem(Sender);
  DataSet := TComponent(MenuItem.Tag);
  SetObjectProp(Component, DDRPropName, DataSet);
  Designer.Modified;
end;

procedure TDataSetDriverEhEditor.HandleCreateDataSetSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataSetClass: TComponentClass;
  NewComponent: TComponent;
  ABaseComponent: TComponent;
  ADDRPropName: String;
begin
  MenuItem := TMenuItem(Sender);
  DataSetClass := TComponentClass(MenuItem.Tag);
  ABaseComponent := Component;
  ADDRPropName := DDRPropName;
  NewComponent := Designer.CreateComponent(DataSetClass, Component.Owner, 0, 0, 0, 0);
  SetObjectProp(ABaseComponent, ADDRPropName, NewComponent);
end;

procedure TDataSetDriverEhEditor.PrepareItem(Index: Integer;
  const AItem: IMenuItem);
var
  lst: TStrings;
  i: Integer;
  LMenuItem: IMenuItem;
  S: String;
begin
  inherited PrepareItem(Index, AItem);

  case Index of
    0:
      begin
        FMenuItem := AItem;
        with AItem do
        begin
          DDRPropName := 'ProviderDataSet';
          lst := TStringList.Create;
          GetComponentNamesEh(lst, TDataSet, True);
          i := lst.IndexOf('TMemTableEh');
          if i >= 0 then
          begin
//            if True then
            lst.Move(i, 0);
          end;
          for i := 0 to lst.Count-1 do
          begin
            LMenuItem := AddItem(lst[i], 0, False, True, HandleCreateDataSetSubMenu);
            LMenuItem.Tag := LongInt(lst.Objects[i]);
          end;
          lst.Free;

        end;
        FMenuItem := nil;
      end;

    1:
      begin
        if FDataSetList = nil then
          FDataSetList := TStringList.Create;
        FMenuItem := AItem;
        with AItem do
        begin
          DDRPropName := 'ProviderDataSet';

          FDataSetList.Clear;
          Designer.GetComponentNames(GetTypeData(TDataSet.ClassInfo), CheckComponent);

          for i := 0 to FDataSetList.Count-1 do
          begin
            S := FDataSetList[i] + ': ' + FDataSetList.Objects[i].ClassName;
            if FDataSetList.Objects[i] = TDataSetDriverEh(Component).ProviderDataSet then
              S := S + ' (assigned)';
            LMenuItem := AddItem(S, 0, False, True, HandleAssignDataSetSubMenu);
            LMenuItem.Tag := LongInt(FDataSetList.Objects[i]);
          end;

        end;
        FMenuItem := nil;
      end;
  end;
end;
{$ENDIF}

end.

