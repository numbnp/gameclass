{*******************************************************}
{                                                       }
{                       EhLib 7.0                       }
{              Design window for TDBGridEh              }
{                     (Build 7.0.04)                    }
{   Copyright (c) 1998-2012 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}


unit GridEhEd {$IFDEF CIL} platform{$ENDIF};

{$I EhLib.Inc}

interface

uses
  SysUtils,
{$IFDEF CIL}
  Borland.Vcl.Design.DesignIntf,
  Borland.Vcl.Design.DesignEditors,
  Borland.Vcl.Design.ColnEdit,
  Variants, Types,
  EhLibVCLNET,
{$ELSE}

  {$IFDEF FPC}
  EhLibLCL, DBGridsEh,
  PropEdits, ComponentEditors,
  {$ELSE}
  Windows, Messages,
  ColnEdit, DesignMenus, DBGridEh,
  {$IFDEF EH_LIB_6}Variants, DesignEditors, DesignIntf,
  {$ELSE}DsgnWnds, DsgnIntf, LibIntf, {$ENDIF}
  EhLibVCL, PSAPI, ToolsAPI,
  ImgList, Menus, ActnList, ExtCtrls, ComCtrls,
  DBLookupEh, ToolCtrlsEh, MemTableEh, DataDriverEh,
  ToolWin,
  {$ENDIF}

{$ENDIF}
  Graphics, Controls, Forms,
  DBGridEhGrouping,
//  ColectEditorEh,
  GridsEh, DBAxisGridsEh,
  Classes, TypInfo;

type
{ TDBGridEhFieldProperty }

  TDBGridEhFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

  {$IFDEF FPC}
  {$ELSE}
  TDBGridEhColumnsEditor = class(TCollectionEditor)
//  TDBGridEhColumnsEditor = class(TCollectionEditorEh)
    N1: TMenuItem;
    AddAllFields1: TMenuItem;
    RestoreDefaults1: TMenuItem;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    AddAllFieldsCmd: TAction;
    RestoreDefaultsCmd: TAction;
    procedure AddAllFieldsCmdExecute(Sender: TObject);
    procedure RestoreDefaultsCmdExecute(Sender: TObject);
    procedure AddAllFieldsCmdUpdate(Sender: TObject);
    procedure RestoreDefaultsCmdUpdate(Sender: TObject);
  private
    { Private declarations }
  protected
    function CanAdd(Index: Integer): Boolean; override;
  public
    { Public declarations }
  end;

{ TDBGridEhGroupFooterItemsEditor }
   
  TDBGridEhGroupFooterItemsEditor = class(TCollectionEditor)
  protected
    function CanAdd(Index: Integer): Boolean; override;
  public
    { Public declarations }
  end;

{ TDBGridEhEditor }

  TDBGridEhEditor = class(TComponentEditor)
    FMenuItem: IMenuItem;
    DDRPropName: String;
    FDataSetList: TStringList;
    procedure HandleCreateDataSourceSubMenu(Sender: TObject);
    procedure HandleAssignDataSourceSubMenu(Sender: TObject);
    procedure CheckComponent(const Value: string);
   public
    destructor Destroy; override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
  end;

{ TDBGridEhDesignControler }

  TDBGridEhDesignControler = class(TDesignControlerEh, IDesignNotification)
  private
    FGridList: TList;
    FCornerImage: TBitmap;
  protected
    FOldSelection: IDesignerSelections;
   { IDesignNotification }
    procedure ItemDeleted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemInserted(const ADesigner: IDesigner; AItem: TPersistent);
    procedure ItemsModified(const ADesigner: IDesigner);
    procedure SelectionChanged(const ADesigner: IDesigner; const ASelection: IDesignerSelections);
    procedure DesignerOpened(const ADesigner: IDesigner; AResurrecting: Boolean);
    procedure DesignerClosed(const ADesigner: IDesigner; AGoingDormant: Boolean);
    procedure CreateDesingPanel(DBGridEh: TCustomDBAxisGridEh);
  public
    constructor Create;
    destructor Destroy; override;
    function IsDesignHitTest(Control: TPersistent; X, Y: Integer; AShift: TShiftState): Boolean; override;
    function IsObjectBelongToGrid(Grid: TCustomDBAxisGridEh; AObject: TPersistent): Boolean;
    function ControlIsObjInspSelected(Control: TPersistent): Boolean; override;
    function GetObjInspSelectedControl(BaseControl: TPersistent): TPersistent; override;
    function GetSelectComponentCornerImage: TBitmap; override;
    function GetDesignInfoItemClass: TCollectionItemClass; override;
    procedure DesignMouseDown(Control: TPersistent; X, Y: Integer; AShift: TShiftState); override;
    procedure DrawDesignSelectedBorder(Canvas: TCanvas; ARect: TRect); override;
    procedure RegisterChangeSelectedNotification(Control: TPersistent); override;
    procedure UnregisterChangeSelectedNotification(Control: TPersistent); override;
    procedure KeyProperyModified(Control: TControl); override;
    procedure SelectComponent(Component: TComponent; Instance: TPersistent); override;
    procedure AdjustLookupParamsMenuClick(Sender: TObject);
  end;

  TNotAssignedPropertyEh = class(TPersistent)
  end;

{ TGridDesignPanelEh }

  TGridDesignPanelEh = class(TCustomPanel)
  private
    Grid: TCustomDBAxisGridEh;
    DropdownMenu: TPopupMenu;
    FComponentList: TStringList;
    FNotAssignedProperty: TNotAssignedPropertyEh;
  protected
    procedure Paint; override;
    procedure CMDesignHitTest(var Msg: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WndProc(var Message: TMessage); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure CheckComponent(const Value: string);
  public
    constructor CreateForGrid(AOwner: TCustomDBAxisGridEh);
    destructor Destroy; override;
    function GetDesigner: IDesigner;
    procedure MenuClick(Sender: TObject);
    procedure UpdateState;
  end;

  TPanelMenuItem = class(TMenuItem)
  public
    ComponentEditor: IComponentEditor;
    VerbNo: Integer;
  end;

{ TAssignComponentPropertyMenuItem }

  TAssignComponentPropertyMenuItem = class(TMenuItem)
  public
    PropValueClass: TComponentClass;
    Component: TObject;
    PropName: String;
    PropValue: TObject;
    LDesigner: IDesigner;
    Owner: TComponent;
    DesignPanel: TGridDesignPanelEh;
    procedure Click; override;
  end;

{ TFavoriteComponentListMenuItem }

  TFavoriteComponentListMenuItem = class(TMenuItem)
  public
    FClass: TComponentClass;
    procedure Click; override;
  end;

{ TSaveComponentDesignInfoEh }

  TSaveComponentDesignInfoItemEh = class(TCollectionItem)
  private
    FLeft: Integer;
    FTop: Integer;
    FComponentName: String;
  public
    InGrid: Boolean;
  published
    property Left: Integer read FLeft write FLeft;
    property Top: Integer read FTop write FTop;
    property ComponentName: String read FComponentName write FComponentName;
  end;

{ TDBGridEhColumnsProperty }

  TDBGridEhColumnsProperty = class(TPropertyEditor {TClassProperty})
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

{ TDBGridEhFieldProperty }

  TDBGridEhFieldAggProperty = class(TDBGridEhFieldProperty)
  public
    procedure GetValueList(List: TStrings); override;
  end;

{ TDBLookupComboboxEhEditor }

  TDBLookupComboboxEhEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{ TDBGridEhGroupFooterItemsProperty }

  TDBGridEhGroupFooterItemsProperty = class(TPropertyEditor {TClassProperty})
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

{$ENDIF}

{ TDBGridEhGroupLelelColumnProperty }

  TDBGridEhGroupLelelColumnProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{$IFDEF FPC}
{$ELSE}
var
  DBGridEhColumnsEditor: TDBGridEhColumnsEditor;
  ComponentsBitmap: TStringList;
  GlobalHideConnectedComponens: Boolean;
  GlobalHideConnectedComponensLoaded: Boolean;

  function GetGlobalHideConnectedComponens: Boolean;
{$ENDIF}

implementation

{$R *.dfm}

uses
{$IFDEF DESIGNTIME}

{$IFDEF CIL}
  Borland.Vcl.Design.ComponentDesigner,
{$ELSE}
  {$IFDEF FPC}
  {$ELSE}
  ComponentDesigner,
  LookupLinkDesignEh,
  EhLibDesignEditFavouriteComponents,
  Registry, Db, EhLibDesignAbout, DBLookupUtilsEh, EhLibReg,
  {$ENDIF}
{$ENDIF}

{$ELSE}
//  LibIntf,
{$ENDIF}
  Dialogs;

{ TDBGridEhFieldProperty }

function TDBGridEhFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TDBGridEhFieldProperty.GetValueList(List: TStrings);
var
  Ehg: TCustomDBGridEh;
begin
  if (GetComponent(0) = nil) then Exit;
  if (GetComponent(0) is TColumnEh) then
    Ehg := (GetComponent(0) as TColumnEh).Grid
  else if (GetComponent(0) is TColumnFooterEh) then
    Ehg := (GetComponent(0) as TColumnFooterEh).Column.Grid
  else Exit;

  if (Ehg <> nil) and (TCustomDBGridEh(Ehg).DataSource <> nil) and (TCustomDBGridEh(Ehg).DataSource.DataSet <> nil) then
  begin
    TCustomDBGridEh(Ehg).DataSource.DataSet.GetFieldNames(List);
  end;
end;

procedure TDBGridEhFieldProperty.GetValues(Proc: TGetStrProc);
var
  i: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for i := 0 to Values.Count - 1 do Proc(Values[i]);
  finally
    Values.Free;
  end;
end;

{ TDBGridEhGroupLelelColumnProperty }

function TDBGridEhGroupLelelColumnProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, {paSortList, }paMultiSelect];
end;

procedure TDBGridEhGroupLelelColumnProperty.GetValueList(List: TStrings);
var
  Ehg : TCustomDBGridEh;
begin
  if (GetComponent(0) = nil) then Exit;
  if (GetComponent(0) is TDBGridEhDataGroupLevelEh) then
    Ehg := TCustomDBGridEh(TGridDataGroupLevelsEh(TDBGridEhDataGroupLevelEh(GetComponent(0)).Collection).Grid)
  else Exit;

  if Ehg <> nil then
  begin
    TCustomDBGridEh(Ehg).Columns.GetColumnNames(List);
  end;
end;

procedure TDBGridEhGroupLelelColumnProperty.GetValues(Proc: TGetStrProc);
var
  i: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for i := 0 to Values.Count - 1 do Proc(Values[i]);
  finally
    Values.Free;
  end;
end;

{$IFDEF FPC}
{$ELSE}

type
  TPersistentCrack = class(TPersistent) end;
  TCustomDBAxisGridEhCrack = class(TCustomDBAxisGridEh);

function EditLookupParams(LookupData: TDBLookupDataEh
{$IFDEF DESIGNTIME}
  ; ADesigner: IDesigner
{$ENDIF}
): Boolean;
var
  AChanged: Boolean;
  ADataSet: TDataSet;
  AKeyFieldNames: String;
  ALookupKeyFieldNames: String;
  ALookupResultField: String;
  ALookupDataSet: TDataSet;
  DataSource: TDataSource;
  AxisBar: TAxisBarEh;
begin
  Result := False;
  AxisBar := TAxisBarEh(LookupData.AxisBar);
  DataSource := AxisBar.Grid.DataSource;
  if (DataSource <> nil) and (DataSource.DataSet <> nil)
    then ADataSet := DataSource.DataSet
    else Exit;
  AKeyFieldNames := LookupData.KeyFieldNames;
  ALookupKeyFieldNames := LookupData.LookupKeyFieldNames;
  ALookupResultField := LookupData.LookupDisplayFieldName;
  ALookupDataSet := LookupData.LookupDataSet;
  AChanged := EditLookupLink(
    AxisBar.Grid,
    ADesigner, ADataSet,
    AKeyFieldNames, ALookupKeyFieldNames, ALookupResultField, ALookupDataSet);
  if AChanged then
  begin
    LookupData.KeyFieldNames := AKeyFieldNames;
    LookupData.LookupKeyFieldNames := ALookupKeyFieldNames;
    LookupData.LookupDisplayFieldName := ALookupResultField;
    LookupData.LookupDataSet := ALookupDataSet;
    ADesigner.Modified;
  end;
end;

(*procedure GetComponentNames(lst: TStrings; TargetClass: TClass; DividePackages: Boolean);
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

  for I := 0 to NiClasses.Count-1 do
  begin
    if DividePackages and TheNewOne then
      lst.AddObject('-', nil);
    CRef := TClass(NiClasses[i]);
    if (CRef <> nil) and CRef.InheritsFrom(TargetClass) then
    begin
      lst.AddObject(CRef.ClassName, TObject(CRef));
      TheNewOne := False;
    end;
 end;
end;
*)

procedure RestoreGlobalHideConnectedComponens;
begin
  GlobalHideConnectedComponensLoaded := True;
  Exit;
{$IFDEF DESIGNTIME}
{$IFDEF EH_LIB_6}
  if ActiveDesigner = nil then
  begin
    Exit;
  end;
  with TRegIniFile.Create(ActiveDesigner.Environment.GetBaseRegKey + '\' + EhLibRegKey) do
{$ELSE}
  with TRegIniFile.Create(DelphiIDE.GetBaseRegKey + '\' + EhLibRegKey) do
{$ENDIF}
  try
    GlobalHideConnectedComponens := ReadBool('', 'HideConnectedComponens', GlobalHideConnectedComponens);
//    ShowMessage('GlobalHideConnectedComponens:' + BoolToStr(GlobalHideConnectedComponens));
  finally
    Free;
  end;
{$ENDIF}
  GlobalHideConnectedComponensLoaded := True;
end;

function GetGlobalHideConnectedComponens: Boolean;
begin
  if not GlobalHideConnectedComponensLoaded then
    RestoreGlobalHideConnectedComponens;
  Result := GlobalHideConnectedComponens;
end;

procedure SaveGlobalHideConnectedComponens;
begin
{$IFDEF DESIGNTIME}
  {$IFDEF EH_LIB_6}
  if ActiveDesigner = nil then Exit;
  with TRegIniFile.Create(ActiveDesigner.Environment.GetBaseRegKey + '\' + EhLibRegKey) do
  {$ELSE}
  with TRegIniFile.Create(DelphiIDE.GetBaseRegKey + '\' + EhLibRegKey) do
  {$ENDIF}
  try
    WriteBool('', 'HideConnectedComponens', GlobalHideConnectedComponens);
  finally
    Free;
  end;
{$ENDIF}
end;

type
  TDataDriverEhCracker = class(TDataDriverEh)
  end;

{$IFDEF CIL}
{$ELSE}
function FindResourceGlobal(AClassName: String; ResType: PChar; var InModule: HMODULE): HRSRC;
var
  ph: THandle;
  ProcModules: array[0..1000] of HMODULE;
  cbNeeded, ModCount: Cardinal;
  i: Integer;
  FileName: array[0..MAX_PATH-1] of Char;
//  FN, RS: String;
begin
  Result := 0;
  ph := GetCurrentProcess;
  if EnumProcessModules(ph, @ProcModules[0], SizeOf(ProcModules), cbNeeded) then
  begin
    ModCount := cbNeeded div SizeOf(HMODULE);
    if ModCount > 1000 then ModCount := 1000;
//    ShowMessage('ModCount: ' + IntToStr(ModCount));
    for i := 0 to ModCount-1 do
    begin
      InModule := ProcModules[i];
      GetModuleFileNameEx(ph, InModule, FileName, SizeOf(FileName));
//      FN := FileName;
//      SetString(RS, ResType, StrLen(ResType));
//      if FileName = 'C:\RADStudio\6.0\bin\vcldesigner120.bpl' then
//        ShowMessage( FN + ':' + AClassName + ':' + RS );
      Result := FindResource(InModule, PChar(AClassName), ResType);
      if Result <> 0 then
        Exit;
    end;
  end;
end;

function GetDesigntimeBitmapOfComponent(Component: TComponent): TBitmap;
var
  HResInfo: THandle;
  BIndex: Integer;
  NewBM: TBitmap;
  TmpImage: TImage;
  AClassName, ResClassName: String;
  InModule: HMODULE;
  ResClass: TClass;
  ATextSize, ATextPos: TSize;

  procedure BevelRect(R: TRect);
  begin
    R.Right := R.Right-1;
    R.Bottom := R.Bottom-1;
    with NewBM.Canvas do
    begin
      Pen.Color := clBtnHighlight;
      PolyLine([Point(R.Left, R.Bottom), Point(R.Left, R.Top),
        Point(R.Right, R.Top)]);
      Pen.Color := clBtnShadow;
      PolyLine([Point(R.Right, R.Top), Point(R.Right, R.Bottom),
        Point(R.Left, R.Bottom)]);
    end;
  end;

begin
  if Component <> nil then
    AClassName := UpperCase(Component.ClassName)
  else
    AClassName := '';
  BIndex := ComponentsBitmap.IndexOf(AClassName);
  if BIndex >= 0 then
  begin
    Result := TBitmap(ComponentsBitmap.Objects[BIndex]);
    Exit;
  end;
  NewBM := TBitmap.Create;
  NewBM.Width := 28;
  NewBM.Height := 28;
  NewBM.Canvas.Brush.Color := clBtnFace;
  NewBM.Canvas.FillRect(NewBM.Canvas.ClipRect);
  TmpImage := TImage.Create(nil);
  TmpImage.Center := True;
  TmpImage.Transparent := True;
  HResInfo := 0;
  if Component <> nil then
  begin
    ResClass := Component.ClassType;
    ResClassName := UpperCase(ResClass.ClassName);
    while True do
    begin
  {$IFDEF CIL}
  {$ELSE}
      HResInfo := FindResourceGlobal(ResClassName, RT_BITMAP, InModule);
  {$ENDIF}
      if HResInfo <> 0 then
      begin
        TmpImage.Picture.Bitmap.LoadFromResourceName(InModule, ResClassName);
        NewBM.Canvas.Draw(2,2,TmpImage.Picture.Graphic);
        Break;
      end;
      ResClass := ResClass.ClassParent;
      if ResClass = nil then Break;
      ResClassName := UpperCase(ResClass.ClassName);
    end;
    if HResInfo = 0 then
    begin
      HResInfo := FindResourceGlobal('NEWCOMP', RT_BITMAP, InModule);
      if HResInfo <> 0 then
      begin
        TmpImage.Picture.Bitmap.LoadFromResourceName(InModule, 'NEWCOMP');
        NewBM.Canvas.Draw(2,2,TmpImage.Picture.Graphic);
      end;
    end;
  end else
  begin
    NewBM.Canvas.Font.Name := 'Tahoma';
    ATextSize := NewBM.Canvas.TextExtent('N/A');
    ATextPos.cx := (NewBM.Canvas.ClipRect.Left + NewBM.Canvas.ClipRect.Right - ATextSize.cx) div 2;
    ATextPos.cy := (NewBM.Canvas.ClipRect.Top + NewBM.Canvas.ClipRect.Bottom - ATextSize.cy) div 2;
    NewBM.Canvas.TextRect(NewBM.Canvas.ClipRect, ATextPos.cx, ATextPos.cy, 'N/A');
  end;
  BevelRect(NewBM.Canvas.ClipRect);
  TmpImage.Free;
  ComponentsBitmap.AddObject(AClassName, NewBM);
  Result := NewBM;
end;
{$ENDIF}

{ TDBGridEhColumnsProperty }

procedure TDBGridEhColumnsProperty.Edit;
var
  Obj: TPersistent;
begin
  Obj := GetComponent(0);
  while (Obj <> nil) and not (Obj is TComponent) do
    Obj := GetUltimateOwner(Obj);
  ShowCollectionEditorClass(Designer, TDBGridEhColumnsEditor, TComponent(Obj),
//    TCustomDBGridEh(Obj).Columns, 'Columns', [coAdd, coDelete, coMove]);
{$IFDEF CIL}
    TCollection(GetObjValue),
{$ELSE}
    TCollection(GetOrdValue),
{$ENDIF}
     'Columns', [coAdd, coDelete, coMove]);
end;

function TDBGridEhColumnsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly {, paSubProperties}];
end;

function TDBGridEhColumnsProperty.GetValue: string;
begin
{$IFDEF CIL}
  FmtStr(Result, '(%s)', [GetPropType.Name]);
{$ELSE}
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
{$ENDIF}
end;

{ TDBGridEhEditor }

destructor TDBGridEhEditor.Destroy;
begin
  FreeAndNil(FDataSetList);
  inherited Destroy;
end;

procedure TDBGridEhEditor.CheckComponent(const Value: string);
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

procedure TDBGridEhEditor.ExecuteVerb(Index: Integer);
//var
//  Msg: TCMChanged;
begin
  case Index of
    0:
      ShowCollectionEditorClass(Designer, TDBGridEhColumnsEditor, Component,
        TCustomDBGridEh(Component).Columns, 'Columns', [coAdd, coDelete, coMove]);
(*    1:
      begin
        if GetGlobalHideConnectedComponens then
        begin
          GlobalHideConnectedComponens := False;
          SaveGlobalHideConnectedComponens;
        end else
        begin
          GlobalHideConnectedComponens := True;
          SaveGlobalHideConnectedComponens;
        end;

//        Msg.Msg := CM_CHANGED;
//        Msg.Unused := 0;
//        Msg.Child := TCustomDBGridEh(Component);
//        Msg.Result := 0;
{$IFDEF CIL}
{$ELSE}
        if (TCustomDBGridEh(Component).Owner is TWinControl) then
          BroadcastPerformMessageFor(TCustomDBGridEh(Component).Owner,
            TCustomDBGridEh, CM_CHANGED, 0, Longint(Component));
{$ENDIF}
//          TWinControl(TCustomDBGridEh(Component).Owner).Broadcast(Msg);
      end;*)
    4:
      ShowAboutForm;
  end;
end;

function TDBGridEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'Columns Editor ...';
{    1:
      begin
//        ShowMessage('GlobalHideConnectedComponens:' + BoolToStr(GlobalHideConnectedComponens));
        if GetGlobalHideConnectedComponens
          then Result := 'Show connected components'
          else Result := 'Hide connected components';
      end;}
    1: Result := 'Create DataSource as';
    2: Result := 'Assign DataSource by';
    3: Result := '-';
    4: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TDBGridEhEditor.GetVerbCount: Integer;
begin
//  Result := 2;
  Result := 5;
end;

procedure TDBGridEhEditor.HandleCreateDataSourceSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataSourceClass: TComponentClass;
  NewComponent: TComponent;
  ABaseComponent: TComponent;
  ADDRPropName: String;
begin
  MenuItem := TMenuItem(Sender);
  DataSourceClass := TComponentClass(MenuItem.Tag);
  ShowMessage(DataSourceClass.ClassName);
  ABaseComponent := Component;
  ADDRPropName := DDRPropName;
  NewComponent := Designer.CreateComponent(DataSourceClass, Component.Owner, 0, 0, 0, 0);
  SetObjectProp(ABaseComponent, ADDRPropName, NewComponent);
end;

procedure TDBGridEhEditor.HandleAssignDataSourceSubMenu(Sender: TObject);
var
  MenuItem: TMenuItem;
  DataSource: TComponent;
begin
  MenuItem := TMenuItem(Sender);
  DataSource := TComponent(MenuItem.Tag);
  SetObjectProp(Component, DDRPropName, DataSource);
  Designer.Modified;
end;

procedure TDBGridEhEditor.PrepareItem(Index: Integer; const AItem: IMenuItem);
var
  lst: TStrings;
  i: Integer;
  LMenuItem: IMenuItem;
  S: String;
begin
  inherited PrepareItem(Index, AItem);

  case Index of
    1:
      begin
        FMenuItem := AItem;
        with AItem do
        begin
          DDRPropName := 'DataSource';
          lst := TStringList.Create;
          GetComponentNamesEh(lst, TDataSource, False, Component, 'DataSource');
          for i := 0 to lst.Count-1 do
          begin
            LMenuItem := AddItem(lst[i], 0, False, True, HandleCreateDataSourceSubMenu);
            LMenuItem.Tag := LongInt(lst.Objects[i]);
          end;
          lst.Free;

        end;
        FMenuItem := nil;
      end;

    2:
      begin
        if FDataSetList = nil then
          FDataSetList := TStringList.Create;
        FMenuItem := AItem;
        with AItem do
        begin
          DDRPropName := 'DataSource';

          FDataSetList.Clear;
          Designer.GetComponentNames(GetTypeData(TDataSource.ClassInfo), CheckComponent);

          for i := 0 to FDataSetList.Count-1 do
          begin
            S := FDataSetList[i] + ': ' + FDataSetList.Objects[i].ClassName;
            if FDataSetList.Objects[i] = TCustomDBGridEh(Component).DataSource then
              S := S + ' (assigned)';
            LMenuItem := AddItem(S, 0, False, True, HandleAssignDataSourceSubMenu);
            LMenuItem.Tag := LongInt(FDataSetList.Objects[i]);
          end;

        end;
        FMenuItem := nil;
      end;
  end;
end;

{ TCustomDBGridEhCracker }

type
  TCustomDBGridEhCracker = class(TCustomDBGridEh)
  public
    procedure BeginLayout;
    procedure EndLayout;
  end;

procedure TCustomDBGridEhCracker.BeginLayout;
begin
  inherited BeginLayout;
end;

procedure TCustomDBGridEhCracker.EndLayout;
begin
  inherited EndLayout;
end;

type
  TCollectionCracker = class(TCollection);
{ TDBGridEhColumnsEditor }

procedure TDBGridEhColumnsEditor.AddAllFieldsCmdExecute(Sender: TObject);
var msgValue: Word;
//    i:Integer;
//    Col:TColumnEh;
  DBGridEh: TCustomDBGridEh;
begin
{$IFDEF CIL}
  DBGridEh := TCustomDBGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  if not Assigned(DBGridEh) then Exit;
  if (DBGridEh.Columns.State = csDefault) then
    DBGridEh.Columns.State := csCustomized
  else
  begin
{$IFDEF CIL}
    DBGridEh.Columns.BeginUpdate;
{$ELSE}
    TCustomDBGridEhCracker(DBGridEh).BeginLayout;
{$ENDIF}
    try
      if (DBGridEh.Columns.Count > 0) then
      begin
        msgValue := MessageDlg('Delete existing columns?',
          mtConfirmation, [mbYes, mbNo, mbCancel], 0);
        case msgValue of
          mrYes:
            begin
              SelectNone(True);
              DBGridEh.Columns.Clear;
            end;
          mrCancel:
            Exit;
        end;
      end;
     {for i := 0 to DBGridEh.DataSource.DataSet.FieldCount - 1 do
     begin
       Col := DBGridEh.Columns.Add;
       Col.FieldName := DBGridEh.DataSource.DataSet.Fields[i].FieldName;
     end;}
      DBGridEh.Columns.AddAllColumns(False);
    finally
{$IFDEF CIL}
      DBGridEh.Columns.EndUpdate;
{$ELSE}
      TCustomDBGridEhCracker(DBGridEh).EndLayout;
{$ENDIF}
      UpdateListbox;
    end;
  end;
  Designer.Modified;
end;

procedure TDBGridEhColumnsEditor.RestoreDefaultsCmdExecute(Sender: TObject);
var i: Integer;
  DBGridEh: TCustomDBGridEh;
begin
{$IFDEF CIL}
  DBGridEh := TCustomDBGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  if not Assigned(DBGridEh) then Exit;
  if (ListView1.SelCount > 0) then
  begin
    for i := 0 to ListView1.SelCount - 1 do
      DBGridEh.Columns[i].RestoreDefaults;
    Designer.Modified;
    UpdateListbox;
  end;
end;

procedure TDBGridEhColumnsEditor.AddAllFieldsCmdUpdate(Sender: TObject);
var DBGridEh: TCustomDBGridEh;
begin
{$IFDEF CIL}
  DBGridEh := TCustomDBGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  AddAllFieldsCmd.Enabled := Assigned(DBGridEh) and
    Assigned(DBGridEh.DataSource) and Assigned(DBGridEh.Datasource.Dataset) and
    (DBGridEh.Datasource.Dataset.FieldCount > 0);
end;

procedure TDBGridEhColumnsEditor.RestoreDefaultsCmdUpdate(Sender: TObject);
begin
  RestoreDefaultsCmd.Enabled := ListView1.Items.Count > 0;
end;

function TDBGridEhColumnsEditor.CanAdd(Index: Integer): Boolean;
var DBGridEh: TCustomDBGridEh;
begin
  Result := False;
{$IFDEF CIL}
  DBGridEh := TCustomDBGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  if Assigned(DBGridEh) then
    Result := (DBGridEh.Columns.State = csCustomized);
end;

{ TDBGridEhFieldAggProperty }

procedure TDBGridEhFieldAggProperty.GetValueList(List: TStrings);
var
  Ehg: TCustomDBGridEh;
  AggList: TStringList;
begin
  if (GetComponent(0) = nil) then Exit;
  if (GetComponent(0) is TColumnEh) then
    Ehg := (GetComponent(0) as TColumnEh).Grid
  else if (GetComponent(0) is TColumnFooterEh) then
    Ehg := (GetComponent(0) as TColumnFooterEh).Column.Grid
  else Exit;

  if (Ehg <> nil) and (TCustomDBGridEh(Ehg).DataSource <> nil) and (TCustomDBGridEh(Ehg).DataSource.DataSet <> nil) then
  begin
    TCustomDBGridEh(Ehg).DataSource.DataSet.GetFieldNames(List);
    if TCustomDBGridEh(Ehg).DataSource.DataSet.AggFields.Count > 0 then
    begin
      AggList := TStringList.Create;
      try
        TCustomDBGridEh(Ehg).DataSource.DataSet.AggFields.GetFieldNames(AggList);
        List.AddStrings(AggList);
      finally
        AggList.Free;
      end;
    end;
  end;
end;

{ TDBLookupComboboxEhEditor }

function TDBLookupComboboxEhEditor.GetVerbCount: Integer;
begin
  Result := 4;
end;

function TDBLookupComboboxEhEditor.GetVerb(Index: Integer): string;
begin
  case Index of
    0: Result := 'DropDownBox.Columns Editor ...';
    1: Result := 'Edit buttons';
    2: Result := '-';
    3: Result := EhLibVerInfo + ' ' + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

procedure TDBLookupComboboxEhEditor.ExecuteVerb(Index: Integer);
begin
  case Index of
    0:
      ShowCollectionEditorClass(Designer, TDBGridEhColumnsEditor, Component,
        TDBLookupComboboxEh(Component).DropDownBox.Columns, 'Columns', [coAdd, coDelete, coMove]);
    1:
      ShowCollectionEditorClass(Designer, TCollectionEditor, Component,
        TDBLookupComboboxEh(Component).EditButtons, 'EditButtons', [coAdd, coDelete, coMove]);
    3:
      ShowAboutForm;
  end;
end;

{ TDBGridEhDesignControler }

constructor TDBGridEhDesignControler.Create;
var
  LIDesignNotification: IDesignNotification;
  HResInfo: THandle;
  InModule: HMODULE;
//  Stream: TCustomMemoryStream;
//  Icon: TIcon;
  TmpImage: TImage;
begin
  inherited Create;
  FGridList := TList.Create;
  if Supports(TObject(Self), IDesignNotification, LIDesignNotification) then
  begin
  {$IFDEF EH_LIB_6}
    RegisterDesignNotification(LIDesignNotification);
  {$ENDIF}
  end;
  FCornerImage := TBitmap.Create;

{$IFDEF CIL}
{$ELSE}
  HResInfo := FindResourceGlobal('SELECT_BALL', RT_GROUP_ICON{RT_ICON}{RT_BITMAP}, InModule);
  if HResInfo <> 0 then
  begin
    TmpImage := TImage.Create(nil);
//    TmpImage.Transparent := True;
//    TmpImage.Picture.Icon.LoadFromResourceName(InModule, 'SELECT_BALL');
    TmpImage.Picture.Icon.Handle := LoadIcon(InModule, PChar('SELECT_BALL'));


//    DrawIconEx(FCornerImage.Canvas.Handle,
//      0, 0, TmpImage.Picture.Icon.Handle, 8, 8, 0, 0, DI_NORMAL);
    FCornerImage.Width := 32;
    FCornerImage.Height := 32;
    FCornerImage.Transparent := True;
    FCornerImage.Canvas.Brush.Color := clBtnFace;
    FCornerImage.Canvas.FillRect(Rect(0, 0, 32, 32));
    FCornerImage.Canvas.Draw(0,0, TmpImage.Picture.Graphic);
    TmpImage.Free;
  end;
{$ENDIF}
end;

destructor TDBGridEhDesignControler.Destroy;
//var
//  LIDesignNotification: IDesignNotification;
begin
  FOldSelection := nil;
  FreeAndNil(FGridList);
  FreeAndNil(FCornerImage);
//  if Supports(Self, IDesignNotification, LIDesignNotification) then
//    UnregisterDesignNotification(LIDesignNotification);
  inherited Destroy;
end;

procedure TDBGridEhDesignControler.DrawDesignSelectedBorder(Canvas: TCanvas; ARect: TRect);
begin
  if GetSelectComponentCornerImage <> nil then
  begin
    Canvas.StretchDraw(Rect(ARect.Left, ARect.Top, ARect.Left+8, ARect.Top+8), DBGridEhDesigntControler.GetSelectComponentCornerImage);
    Canvas.StretchDraw(Rect(ARect.Right-7, ARect.Top, ARect.Right+1, ARect.Top+8), DBGridEhDesigntControler.GetSelectComponentCornerImage);
    Canvas.StretchDraw(Rect(ARect.Right-7, ARect.Bottom-7, ARect.Right+1, ARect.Bottom+1), DBGridEhDesigntControler.GetSelectComponentCornerImage);
    Canvas.StretchDraw(Rect(ARect.Left, ARect.Bottom-7, ARect.Left+8, ARect.Bottom+1), DBGridEhDesigntControler.GetSelectComponentCornerImage);
  end else
  begin
    Canvas.Brush.Color := clBlack;
    Canvas.FillRect(Rect(ARect.Left, ARect.Top, ARect.Left+4, ARect.Top+4));
    Canvas.FillRect(Rect(ARect.Right, ARect.Top, ARect.Right-4, ARect.Top+4));
    Canvas.FillRect(Rect(ARect.Right, ARect.Bottom, ARect.Right-4, ARect.Bottom-4));
    Canvas.FillRect(Rect(ARect.Left, ARect.Bottom, ARect.Left+4, ARect.Bottom-4));
  end;
end;

function TDBGridEhDesignControler.ControlIsObjInspSelected(
  Control: TPersistent): Boolean;
begin
  Result := False;
  if GetObjInspSelectedControl(Control) = Control then
    Result := True;
end;

function TDBGridEhDesignControler.GetObjInspSelectedControl(BaseControl: TPersistent): TPersistent;
var
  List: IDesignerSelections;
  LDesigner: IDesigner;
begin
  Result := nil;
  if Supports(FindRootDesigner(BaseControl), IDesigner, LDesigner) then
  begin
    List := CreateSelectionList;
    LDesigner.GetSelections(List);
    if (List <> nil) and (List.Count = 1) then
      Result := List[0];
  end;
end;

function TDBGridEhDesignControler.GetSelectComponentCornerImage: TBitmap;
begin
  if not FCornerImage.Empty
    then Result := FCornerImage
    else Result := nil;
end;

function TDBGridEhDesignControler.GetDesignInfoItemClass: TCollectionItemClass;
begin
  Result := TSaveComponentDesignInfoItemEh;
end;

procedure TDBGridEhDesignControler.DesignMouseDown(Control: TPersistent;
  X, Y: Integer; AShift: TShiftState);
var
  DBGridEh: TCustomDBAxisGridEhCrack;
  SelObject: TPersistent;
  Cell: TGridCoord;
//  ARect: TRect;
  LDesigner: IDesigner;
  P: TPoint;
  DSPanel: TGridDesignPanelEh;
  MenuItem: TMenuItem;
  i: Integer;
  AssignCompPropMenuItem: TAssignComponentPropertyMenuItem;
  FavoriteMenuItem: TFavoriteComponentListMenuItem;
  lst: TStringList;
begin
  if not IsDesignHitTest(Control, X, Y, AShift) then
    Exit;
  if Control is TCustomDBAxisGridEh then
    DBGridEh := TCustomDBAxisGridEhCrack(Control)
  else
    raise Exception.Create('TDBGridEhDesignControler.DesignMouseDown - Control is NOT TCustomDBAxisGridEh');

  Cell := DBGridEh.MouseCoord(X, Y);

  SelObject := DBGridEh.DesignHitTestObject(X, Y);

  if SelObject <> nil then

//   (DBGridEh.AxisBars.State = csCustomized) and DBGridEh.AxisBarsTitleVisible
//   and (Cell.Y = 0) and (Cell.X >= DBGridEh.IndicatorOffset) then
  begin
//    if DBGridEh.RowPanel.Active then
//    begin
//     ARect := DBGridEh.CellRect(Cell.X, Cell.Y);
//{$IFDEF CIL}
//{$ELSE}
//      Column := DBGridEh.GetColumnInRowPanelAtPos(Point(X-ARect.Left+TCustomDBGridEhCracker(DBGridEh).FDataOffset.cx, Y-ARect.Top), True);
//{$ENDIF}
//    end else
//      Column := DBGridEh.Columns[Cell.X-DBGridEh.IndicatorOffset];
 //   if Column = nil then Exit;
    if Supports(FindRootDesigner(DBGridEh), IDesigner, LDesigner) then
    begin
      LDesigner.SelectComponent(SelObject);
      DBGridEh.Invalidate;

      if ssRight in AShift then
      begin
        DSPanel := TGridDesignPanelEh(DBGridEh.FindComponent('DesignTimePanel'));
        if DSPanel <> nil then

        if DSPanel.DropdownMenu = nil then
          DSPanel.DropdownMenu := TPopupMenu.Create(DSPanel);
        DSPanel.DropdownMenu.Items.Clear;

//        if NotAssignedComponent then
        begin

//   Create Lookup DataSet as
          MenuItem := TMenuItem.Create(DSPanel);
          MenuItem.Caption := 'Create LookupParams.LookupDataSet as ';
          DSPanel.DropdownMenu.Items.Add(MenuItem);

          lst := TStringList.Create;
//          GetComponentNames(lst, TDataSet, True);
          GetFavouriteComponentList(TDataSet, lst, True);
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
            AssignCompPropMenuItem := TAssignComponentPropertyMenuItem.Create(DSPanel);
            AssignCompPropMenuItem.Caption := lst[i];
            AssignCompPropMenuItem.PropValueClass := TComponentClass(lst.Objects[i]);
            AssignCompPropMenuItem.Component := TColumnEh(SelObject).LookupParams;
            AssignCompPropMenuItem.PropName := 'LookupDataSet';
            AssignCompPropMenuItem.Owner := TColumnEh(SelObject).Grid.Owner;
            AssignCompPropMenuItem.LDesigner := LDesigner;
            AssignCompPropMenuItem.DesignPanel := DSPanel;
            MenuItem.Add(AssignCompPropMenuItem);
          end;
          lst.Free;

          MenuItem.NewBottomLine;

          FavoriteMenuItem := TFavoriteComponentListMenuItem.Create(DSPanel);
          FavoriteMenuItem.Caption := 'Change Favorite DataSets...';
          FavoriteMenuItem.FClass := TDataSet;
          MenuItem.Add(FavoriteMenuItem);


//   Assign LookupDataSet by
          MenuItem := TMenuItem.Create(DSPanel);
          MenuItem.Caption := 'Assign LookupParams.LookupDataSet by ';
          DSPanel.DropdownMenu.Items.Add(MenuItem);

          DSPanel.FComponentList.Clear;
          LDesigner.GetComponentNames(GetTypeData(TDataSet.ClassInfo), DSPanel.CheckComponent);

          for i := 0 to DSPanel.FComponentList.Count-1 do
          begin
            AssignCompPropMenuItem := TAssignComponentPropertyMenuItem.Create(DSPanel);
            AssignCompPropMenuItem.Caption := DSPanel.FComponentList[i] + ': ' + DSPanel.FComponentList.Objects[i].ClassName;
            if DSPanel.FComponentList.Objects[i] = TColumnEh(SelObject).LookupParams.LookupDataSet then
              AssignCompPropMenuItem.Caption := AssignCompPropMenuItem.Caption + ' (assigned)';
            AssignCompPropMenuItem.Component := TColumnEh(SelObject).LookupParams;
            AssignCompPropMenuItem.PropName := 'LookupDataSet';
            AssignCompPropMenuItem.PropValue := DSPanel.FComponentList.Objects[i];
            AssignCompPropMenuItem.DesignPanel := DSPanel;
//            AssignCompPropMenuItem.PropValueClass := TDataSet;
    //        AssignCompPropMenuItem.OnClick := MenuClick;
            MenuItem.Add(AssignCompPropMenuItem);
          end;

//   Adjust LookupParams...
          MenuItem := TMenuItem.Create(DSPanel);
          MenuItem.Caption := 'Adjust LookupParams...';
          MenuItem.Tag := Longint(SelObject);
          MenuItem.OnClick := AdjustLookupParamsMenuClick;
          DSPanel.DropdownMenu.Items.Add(MenuItem);

          P := DBGridEh.ClientToScreen(Point(X, Y));
          DSPanel.DropdownMenu.Popup(P.X, P.Y);

        end;
      end;
    end;
  end;
end;

function TDBGridEhDesignControler.IsDesignHitTest(Control: TPersistent;
  X, Y: Integer; AShift: TShiftState): Boolean;
var
  DBGridEh: TCustomDBAxisGridEhCrack;
  Cell: TGridCoord;
  DSPanel: TGridDesignPanelEh;
  OutBRect: TRect;
  SelObject: TPersistent;
begin
  Result := False;
  if not (Control is TCustomDBAxisGridEh)
    then Exit
    else DBGridEh := TCustomDBAxisGridEhCrack(Control);
  Cell := DBGridEh.MouseCoord(X, Y);
{$IFDEF CIL}
// To do
{$ELSE}
  if DBGridEh.Sizing(X,Y) then
    Exit;
{$ENDIF}

  SelObject := DBGridEh.DesignHitTestObject(X, Y);

  if SelObject <> nil then
//  if (ssLeft in AShift) and (dgTitles in DBGridEh.Options) and
//     (Cell.Y = 0) and (Cell.X >= DBGridEh.IndicatorOffset) then
  begin
    Result := True;
  end else if (ssLeft in AShift) and Assigned(DBGridEh.DataSource) then
  begin
    DSPanel := TGridDesignPanelEh(DBGridEh.FindComponent('DesignTimePanel'));
    if DSPanel <> nil then
    begin
//      ShowMessage('X:'+IntToStr(X)+' Y:'+IntToStr(X)+'  Left:'+IntToStr(DSPanel.BoundsRect.Left));
{$IFDEF CIL}
{$ELSE}
      if PtInRect(DSPanel.BoundsRect, Point(X,Y)) then
{$ENDIF}
      begin
        Result := True;
      end;
    end;
  end;
  if not Result
{$IFDEF CIL}
{$ELSE}
      and DBGridEh.OutBoundaryData.GetOutBoundaryRect(OutBRect, cbtTopEh)
{$ENDIF}
      and PtInRect(OutBRect, Point(X, Y))
  then
    Result := True;
end;

procedure TDBGridEhDesignControler.DesignerClosed(
  const ADesigner: IDesigner; AGoingDormant: Boolean);
begin

end;

procedure TDBGridEhDesignControler.DesignerOpened(
  const ADesigner: IDesigner; AResurrecting: Boolean);
begin

end;

procedure TDBGridEhDesignControler.ItemDeleted(const ADesigner: IDesigner;
  AItem: TPersistent);
begin
{  if AItem is TCustomDBAxisGridEh then
  begin
//    TCustomDBAxisGridEh(AItem).DataSource := nil; //To restore hiden design-time components.
    ShowMessage('AItem.ClassName');
  end;}
end;

procedure TDBGridEhDesignControler.ItemInserted(const ADesigner: IDesigner;
  AItem: TPersistent);
begin

end;

procedure TDBGridEhDesignControler.ItemsModified(const ADesigner: IDesigner);
var
  i: Integer;
  DSPanel: TGridDesignPanelEh;
begin
  if FGridList = nil then Exit;
  for i := 0 to FGridList.Count-1 do
  begin
    DSPanel := TGridDesignPanelEh(TCustomDBAxisGridEh(FGridList[i]).FindComponent('DesignTimePanel'));
    if DSPanel <> nil then DSPanel.UpdateState;
  end;
end;

procedure TDBGridEhDesignControler.SelectionChanged(const ADesigner: IDesigner;
  const ASelection: IDesignerSelections);
var
  i,j: Integer;
  DSPanel: TGridDesignPanelEh;
begin
  if FGridList = nil then Exit;
  for i := 0 to FGridList.Count-1 do
  begin
{    if FOldSelection <> nil then
      for j := 0 to FOldSelection.Count-1 do
        if IsObjectBelongToGrid(TCustomDBAxisGridEh(FGridList[i]), FOldSelection.Items[j]) then
          TCustomDBAxisGridEh(FGridList[i]).Invalidate;}

    if ASelection <> nil then
      for j := 0 to ASelection.Count-1 do
        if IsObjectBelongToGrid(TCustomDBAxisGridEh(FGridList[i]), ASelection.Items[j]) then
          TCustomDBAxisGridEh(FGridList[i]).Invalidate;

//    TCustomDBAxisGridEh(FGridList[i]).InvalidateTitle;
    DSPanel := TGridDesignPanelEh(TCustomDBAxisGridEh(FGridList[i]).FindComponent('DesignTimePanel'));
    if DSPanel <> nil then DSPanel.Invalidate;
  end;
  FOldSelection := ASelection;
end;

function TDBGridEhDesignControler.IsObjectBelongToGrid(Grid: TCustomDBAxisGridEh;
  AObject: TPersistent): Boolean;
var
  AOwner: TPersistent;
begin
  Result := False;
  if AObject = Grid then
  begin
    Result := True;
    Exit;
  end;

  AOwner := TPersistentCrack(AObject).GetOwner;
  while AOwner <> nil do
  begin
    if AOwner = Grid then
    begin
      Result := True;
      Exit;
    end;
    AOwner :=  TPersistentCrack(AOwner).GetOwner;
  end;
end;

procedure TDBGridEhDesignControler.RegisterChangeSelectedNotification(Control: TPersistent);
begin
  if FGridList = nil then Exit;
  if FGridList.IndexOf(Control) < 0 then
    FGridList.Add(Control);
  if Control is TCustomDBAxisGridEh then
    CreateDesingPanel(Control as TCustomDBAxisGridEh);
end;

procedure TDBGridEhDesignControler.CreateDesingPanel(DBGridEh: TCustomDBAxisGridEh);
begin
  TGridDesignPanelEh.CreateForGrid(DBGridEh);
end;

procedure TDBGridEhDesignControler.UnregisterChangeSelectedNotification(
  Control: TPersistent);
begin
  if FGridList = nil then Exit;
  FGridList.Remove(Control);
end;

procedure TDBGridEhDesignControler.KeyProperyModified(Control: TControl);
var
  i: Integer;
  DSPanel: TGridDesignPanelEh;
begin
  if FGridList = nil then Exit;
  for i := 0 to FGridList.Count-1 do
  begin
    DSPanel := TGridDesignPanelEh(TCustomDBAxisGridEh(FGridList[i]).FindComponent('DesignTimePanel'));
    if DSPanel <> nil then DSPanel.UpdateState;
  end;
end;

procedure TDBGridEhDesignControler.SelectComponent(Component: TComponent;
  Instance: TPersistent);
var
  LDesigner: IDesigner;
begin
  if Supports(FindRootDesigner(Component), IDesigner, LDesigner) then
  begin
    LDesigner.SelectComponent(Instance);
//    Component.Invalidate;
  end;
end;

type
  TAxisBarEhCrack = class(TAxisBarEh);

procedure TDBGridEhDesignControler.AdjustLookupParamsMenuClick(
  Sender: TObject);
var
  AxisBar: TAxisBarEh;
  LDesigner: IDesigner;
begin
  AxisBar := TAxisBarEh(TMenuItem(Sender).Tag);
  if AxisBar = nil then Exit;
  if not Supports(FindRootDesigner(AxisBar.Grid), IDesigner, LDesigner) then Exit;
  EditLookupParams(TAxisBarEhCrack(AxisBar).LookupParams, LDesigner);
end;

{ TGridDesignPanelEh }

constructor TGridDesignPanelEh.CreateForGrid(AOwner: TCustomDBAxisGridEh);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csAcceptsControls];
  Name := 'DesignTimePanel';
  Grid := AOwner;
  Parent := Grid;
  Width := 0;
  Height := 32 + 2;
  Left := Grid.Width - 32 * 4 - 2;
  Top := Grid.Height - 36;
  BevelOuter := bvNone;
  BorderStyle := bsSingle;
  Ctl3D := False;
  ParentCtl3D := False;
  Anchors := [akRight, akBottom];
  Caption := '';
//  Color := clInactiveCaptionText;
  Color := clSkyBlue;
  FComponentList := TStringList.Create;
  FNotAssignedProperty := TNotAssignedPropertyEh.Create;
end;

destructor TGridDesignPanelEh.Destroy;
begin
  FreeAndNil(FComponentList);
  FreeAndNil(FNotAssignedProperty);
  inherited Destroy;
end;

procedure TGridDesignPanelEh.Paint;
var
  ImageComponent: TComponent;
  bm: TBitmap;
  bf : BLENDFUNCTION;

{$IFDEF CIL}
{$ELSE}
  procedure DrawSelectedBorder(ARect: TRect);
  var
    bm: TBitmap;
  begin
    bm := DBGridEhDesigntControler.GetSelectComponentCornerImage;
//    bm := nil;
    if bm <> nil then
    begin
      Canvas.StretchDraw(Rect(ARect.Left-2, ARect.Top-2, ARect.Left+6, ARect.Top+6), bm);
      Canvas.StretchDraw(Rect(ARect.Right-4, ARect.Top-2, ARect.Right+4, ARect.Top+6), bm);
      Canvas.StretchDraw(Rect(ARect.Right-4, ARect.Bottom-4, ARect.Right+4, ARect.Bottom+4), bm);
      Canvas.StretchDraw(Rect(ARect.Left-2, ARect.Bottom-4, ARect.Left+6, ARect.Bottom+4), bm);
    end else
    begin
      Canvas.Brush.Color := clBlack;
      Canvas.FillRect(Rect(ARect.Left-2, ARect.Top-2, ARect.Left+3, ARect.Top+3));
      Canvas.FillRect(Rect(ARect.Right-2, ARect.Top-2, ARect.Right+3, ARect.Top+3));
      Canvas.FillRect(Rect(ARect.Right-2, ARect.Bottom-2, ARect.Right+3, ARect.Bottom+3));
      Canvas.FillRect(Rect(ARect.Left-2, ARect.Bottom-2, ARect.Left+3, ARect.Bottom+3));
    end;
  end;
{$ENDIF}

  procedure DrawSemiTransparentBitmap(bm: TBitmap; SrcRect: TRect; TargetRect: TRect);
  begin
    bf.BlendOp := AC_SRC_OVER;
    bf.BlendFlags := 0;
    bf.SourceConstantAlpha := Trunc(255/100*40); // 40% transparency
    bf.AlphaFormat := 0;
    Windows.AlphaBlend(Canvas.Handle,
        TargetRect.Left, TargetRect.Top, TargetRect.Right, TargetRect.Bottom,
      bm.Canvas.Handle,
        SrcRect.Left, SrcRect.Top, SrcRect.Right, SrcRect.Bottom,
    bf);
  end;

begin
  inherited Paint;
{$IFDEF CIL}
{$ELSE}
  if not Assigned(Grid.DataSource) then
  begin
    bm := GetDesigntimeBitmapOfComponent(nil);
    if bm <> nil then
      DrawSemiTransparentBitmap(bm, Rect(0, 0, 28, 28), Rect(2, 2, 28, 28));
    if DBGridEhDesigntControler.GetObjInspSelectedControl(Grid) = FNotAssignedProperty then
      DrawSelectedBorder(Rect(2,2,32-3,29));
  end;

  if Assigned(Grid.DataSource) and (Grid.DataSource.Owner = Grid.Owner) then
  begin
    ImageComponent := Grid.DataSource;
    bm := GetDesigntimeBitmapOfComponent(ImageComponent);
    if bm <> nil then
      DrawSemiTransparentBitmap(bm, Rect(0, 0, 28, 28), Rect(2, 2, 28, 28));
    if DBGridEhDesigntControler.GetObjInspSelectedControl(Grid) = ImageComponent then
    begin
      DrawSelectedBorder(Rect(2,2,32-3,29));
    end;
{    if not Assigned(Grid.DataSource.DataSet) then
    begin
      bm := GetDesigntimeBitmapOfComponent(nil);
      DrawSemiTransparentBitmap(bm, Rect(0, 0, 28, 28), Rect(32+2, 2, 28, 28));
      if DBGridEhDesigntControler.GetObjInspSelectedControl(Grid) = FNotAssignedProperty then
        DrawSelectedBorder(Rect(32+2,2,32*2-3,29));
    end;}
  end;

  if Assigned(Grid.DataSource) and Assigned(Grid.DataSource.DataSet) and
    (Grid.DataSource.DataSet.Owner = Grid.Owner) then
  begin
    ImageComponent := Grid.DataSource.DataSet;
    bm := GetDesigntimeBitmapOfComponent(ImageComponent);
    if bm <> nil then
      DrawSemiTransparentBitmap(bm, Rect(0, 0, 28, 28), Rect(32+2, 2, 28, 28));
    if DBGridEhDesigntControler.GetObjInspSelectedControl(Grid) = ImageComponent then
    begin
      DrawSelectedBorder(Rect(32+2,2,32*2-3,29));
    end;
  end;

  if Assigned(Grid.DataSource) and
     Assigned(Grid.DataSource.DataSet) and
     (Grid.DataSource.DataSet is TCustomMemTableEh) and
     Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
     ((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver.Owner = Grid.Owner) then
  begin
    ImageComponent := (Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver;
    bm := GetDesigntimeBitmapOfComponent(ImageComponent);
    if bm <> nil then
      DrawSemiTransparentBitmap(bm, Rect(0, 0, 28, 28), Rect(32*2+2, 2, 28, 28));
    if DBGridEhDesigntControler.GetObjInspSelectedControl(Grid) = ImageComponent then
    begin
      DrawSelectedBorder(Rect(32*2+2,2,32*3-3,29));
    end;
  end;

  if Assigned(Grid.DataSource) and
     Assigned(Grid.DataSource.DataSet) and
     (Grid.DataSource.DataSet is TCustomMemTableEh) and
     Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
     Assigned(TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet) and
     (TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet.Owner = Grid.Owner)
  then
  begin
    ImageComponent := TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet;
    bm := GetDesigntimeBitmapOfComponent(ImageComponent);
    if bm <> nil then
      DrawSemiTransparentBitmap(bm, Rect(0, 0, 28, 28), Rect(32*3+2, 2, 28, 28));
    if DBGridEhDesigntControler.GetObjInspSelectedControl(Grid) = ImageComponent then
    begin
      DrawSelectedBorder(Rect(32*3+2,2,32*4-3,29));
    end;
  end;
{$ENDIF}
end;

procedure TGridDesignPanelEh.CMDesignHitTest(var Msg: TCMDesignHitTest);
begin
//  if (ssLeft in KeysToShiftState(Msg.Keys)) then
    Msg.Result := Longint(BOOL(True));
//    ShowMessage('IsDesignHitTest = True');
end;

procedure TGridDesignPanelEh.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  ARect: TRect;
  P: TPoint;
  MenuItem: TMenuItem;
  PanelMenuItem: TPanelMenuItem;
//  CreateComponentMenuItem: TCreateComponentMenuItem;
  AssignCompPropMenuItem: TAssignComponentPropertyMenuItem;
  ComponentEditor: IComponentEditor;
  SelComponent: TPersistent;
  i: Integer;
  NotAssignedComponent: Boolean;
  LDesigner: IDesigner;
  LDesignLocalMenu: IDesignLocalMenu;
  Sel: IDesignerSelections;
  LPopupMenu: IPopupMenu;
  lst: TStringList;
begin
{$IFDEF CIL}
{$ELSE}
  SelComponent := nil;
  NotAssignedComponent := False;
  if Supports(FindRootDesigner(Grid), IDesigner, LDesigner) then
  begin
    ARect := Rect(2, 2, 32-2, ClientHeight-2);
    if PtInRect(ARect, Point(X,Y)) then
    begin
      if not Assigned(Grid.DataSource) then
      begin
        NotAssignedComponent := True;
        SelComponent := FNotAssignedProperty;
        LDesigner.SelectComponent(SelComponent);
        Invalidate;
      end
      else if Assigned(Grid.DataSource) and
        (Grid.DataSource.Owner = Grid.Owner) then
      begin
        SelComponent := Grid.DataSource;
        LDesigner.SelectComponent(SelComponent);
        Invalidate;
      end;
    end;

    ARect := Rect(32+2, 2, 32*2-2, ClientHeight-2);
    if PtInRect(ARect, Point(X,Y)) then
      if Assigned(Grid.DataSource) and
         not Assigned(Grid.DataSource.DataSet) then
      begin
        SelComponent := FNotAssignedProperty;
        LDesigner.SelectComponent(SelComponent);
        Invalidate;
      end else
      if
         Assigned(Grid.DataSource) and
         Assigned(Grid.DataSource.DataSet) and
         (Grid.DataSource.DataSet.Owner = Grid.Owner) then
    begin
      SelComponent := Grid.DataSource.DataSet;
      LDesigner.SelectComponent(SelComponent);
      Invalidate;
    end;

    ARect := Rect(32*2+2, 2, 32*3-2, ClientHeight-2);
    if PtInRect(ARect, Point(X,Y)) and
       Assigned(Grid.DataSource) and
       Assigned(Grid.DataSource.DataSet) and
       (Grid.DataSource.DataSet is TCustomMemTableEh) and
       Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
       ((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver.Owner = Grid.Owner) then
    begin
      SelComponent := (Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver;
      LDesigner.SelectComponent(SelComponent);
      Invalidate;
    end;

    ARect := Rect(32*3+2, 2, 32*4-2, ClientHeight-2);
    if PtInRect(ARect, Point(X,Y)) and
       Assigned(Grid.DataSource) and
       Assigned(Grid.DataSource.DataSet) and
       (Grid.DataSource.DataSet is TCustomMemTableEh) and
       Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
       Assigned(TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet) and
       (TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet.Owner = Grid.Owner)
    then
    begin
      SelComponent := TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet;
      LDesigner.SelectComponent(SelComponent);
      Invalidate;
    end;

  end;

  if (ssRight in Shift) or ((ssLeft in Shift) and (ssDouble in Shift)) then
  begin
    if SelComponent <> FNotAssignedProperty then
      if Supports(FindRootDesigner(Grid), IDesignLocalMenu, LDesignLocalMenu) then
      begin
        Sel := CreateSelectionList;
        LDesigner.GetSelections(Sel);
  {$IFDEF EH_LIB_13}
        LPopupMenu := LDesignLocalMenu.BuildLocalMenu(Sel, [lmComponent]);
  {$ELSE}
        LPopupMenu := LDesignLocalMenu.BuildLocalMenu([lmComponent]);
  {$ENDIF}
        P := ClientToScreen(Point(X, Y));

//        if (ssLeft in Shift) and (ssDouble in Shift) and (DropdownMenu.Items.Count > 0)
//          then (LPopupMenu.Items.GetItem(0) as IMenuItem2).Click
//          else
        LPopupMenu.Popup(P.X, P.Y);

        Exit;
      end;

    if DropdownMenu = nil then
      DropdownMenu := TPopupMenu.Create(Self);
    DropdownMenu.Items.Clear;

    if NotAssignedComponent then
    begin
      MenuItem := TMenuItem.Create(Self);
      MenuItem.Caption := 'Create DataSource as ';
      DropdownMenu.Items.Add(MenuItem);

      lst := TStringList.Create;
      GetComponentNamesEh(lst, TDataSource, False, Grid, 'DataSource');
      for i := 0 to lst.Count-1 do
      begin
        AssignCompPropMenuItem := TAssignComponentPropertyMenuItem.Create(Self);
        AssignCompPropMenuItem.Caption := lst[i];
        AssignCompPropMenuItem.PropValueClass := TComponentClass(lst.Objects[i]);
        AssignCompPropMenuItem.Component := Grid;
        AssignCompPropMenuItem.PropName := 'DataSource';
        AssignCompPropMenuItem.Owner := Grid.Owner;
        AssignCompPropMenuItem.LDesigner := LDesigner;
        AssignCompPropMenuItem.DesignPanel := Self;
        MenuItem.Add(AssignCompPropMenuItem);
      end;
      lst.Free;

      MenuItem := TMenuItem.Create(Self);
      MenuItem.Caption := 'Assign DataSource by ';
      DropdownMenu.Items.Add(MenuItem);

      FComponentList.Clear;
      LDesigner.GetComponentNames(GetTypeData(TDataSource.ClassInfo), CheckComponent);

      for i := 0 to FComponentList.Count-1 do
      begin
        AssignCompPropMenuItem := TAssignComponentPropertyMenuItem.Create(Self);
        AssignCompPropMenuItem.Caption := 'Assign DataSource to ' + FComponentList[i] + ': ' + FComponentList.Objects[i].ClassName;
        AssignCompPropMenuItem.Component := Grid;
        AssignCompPropMenuItem.PropName := 'DataSource';
        AssignCompPropMenuItem.PropValue := FComponentList.Objects[i];
        AssignCompPropMenuItem.DesignPanel := Self;
//        AssignCompPropMenuItem.OnClick := MenuClick;
        MenuItem.Add(AssignCompPropMenuItem);
      end;

    end else if (SelComponent = FNotAssignedProperty) and Assigned(Grid.DataSource) then
    begin
(*      AssignCompPropMenuItem := TAssignComponentPropertyMenuItem.Create(Self);
      AssignCompPropMenuItem.Caption := 'Create and assign TMemTableEh component';
      AssignCompPropMenuItem.PropValueClass := TMemTableEh;
      AssignCompPropMenuItem.Component := Grid.DataSource;
      AssignCompPropMenuItem.PropName := 'DataSet';
      AssignCompPropMenuItem.Owner := Grid.Owner;
      AssignCompPropMenuItem.LDesigner := LDesigner;
      AssignCompPropMenuItem.DesignPanel := Self;
//      AssignCompPropMenuItem.OnClick := MenuClick;
      DropdownMenu.Items.Add(AssignCompPropMenuItem);

      MenuItem := TMenuItem.Create(Self);
      MenuItem.Caption := '-';
      DropdownMenu.Items.Add(MenuItem);

      FComponentList.Clear;
      LDesigner.GetComponentNames(GetTypeData(TDataSet.ClassInfo), CheckComponent);

      for i := 0 to FComponentList.Count-1 do
      begin
        AssignCompPropMenuItem := TAssignComponentPropertyMenuItem.Create(Self);
        AssignCompPropMenuItem.Caption := 'Assign DataSet to ' + FComponentList[i] + ':' + FComponentList.Objects[i].ClassName;
        AssignCompPropMenuItem.Component := Grid.DataSource;
        AssignCompPropMenuItem.PropName := 'DataSet';
        AssignCompPropMenuItem.PropValue := FComponentList.Objects[i];
        AssignCompPropMenuItem.DesignPanel := Self;
        AssignCompPropMenuItem.OnClick := MenuClick;
        DropdownMenu.Items.Add(AssignCompPropMenuItem);
      end;*)
    end else begin
//    DropdownMenu.Name := '';
      ComponentEditor := nil;
      if SelComponent is TComponent then
        ComponentEditor := GetComponentEditor(TComponent(SelComponent), LDesigner);
      if ComponentEditor = nil then Exit;
      for i := 0 to ComponentEditor.GetVerbCount-1 do
      begin
        PanelMenuItem := TPanelMenuItem.Create(Self);
        PanelMenuItem.Caption := ComponentEditor.GetVerb(i);
        PanelMenuItem.ComponentEditor := ComponentEditor;
        PanelMenuItem.VerbNo := i;
        PanelMenuItem.OnClick := MenuClick;
        DropdownMenu.Items.Add(PanelMenuItem);
      end;
    end;
    P := ClientToScreen(Point(X, Y));
    if (ssLeft in Shift) and (ssDouble in Shift) and (DropdownMenu.Items.Count > 0)
      then DropdownMenu.Items[0].Click
      else DropdownMenu.Popup(P.X, P.Y);

//    DropdownMenu.Free;
  end;
//  inherited MouseDown(Button, Shift, X, Y);
{$ENDIF}
end;

procedure TGridDesignPanelEh.MenuClick(Sender: TObject);
//var
//  DS: TDataSource;
//  LDesigner: IDesigner;
begin
//  ShowMessage('TGridDesignPanelEh.MenuClick-' + Sender.ClassName);
  if Sender is TPanelMenuItem then
  begin
    if TPanelMenuItem(Sender).ComponentEditor <> nil then
      TPanelMenuItem(Sender).ComponentEditor.ExecuteVerb(TPanelMenuItem(Sender).VerbNo)
{  end else if Sender is TCreateComponentMenuItem then
  begin
    if Supports(FindRootDesigner(Grid), IDesigner, LDesigner) then
    begin
      DS := TDataSource(LDesigner.CreateComponent(TDataSource, Grid.Owner,
        Grid.Left, Grid.Top+Grid.Width, 0, 0));
//    DS := TDataSource.Create(Grid.Owner);
      Grid.DataSource := DS;
    end;}
  end;
end;

procedure TGridDesignPanelEh.UpdateState;
var
  WidthX: Integer;

  i: Integer;
{$IFDEF CIL}
{$ELSE}
  function GetDesignInfoItem(ComponentName: String): TSaveComponentDesignInfoItemEh;
  var
    i: Integer;
    DesignInfoItem: TSaveComponentDesignInfoItemEh;
  begin
    Result := nil;
    for i := 0 to TCustomDBAxisGridEhCrack(Grid).FDesignInfoCollection.Count-1 do
    begin
      DesignInfoItem := TSaveComponentDesignInfoItemEh(TCustomDBAxisGridEhCrack(Grid).FDesignInfoCollection.Items[i]);
      if DesignInfoItem.ComponentName = ComponentName then
      begin
        Result := DesignInfoItem;
        Exit;
      end;
    end;
//    Result := TSaveComponentDesignInfoItemEh(TCustomDBAxisGridEhCracker(Grid).FDesignInfoCollection.Add);
  end;

  procedure XModuleServicesSaveAll;
  var
    Form: TCustomForm;
    XModuleServices: IOTAModuleServices;
    XResult: HResult;
  begin
    if csDesigning in Grid.ComponentState then
    begin
      Form := GetParentForm(Self);
      if (Form <> nil) and (Form.Designer <> nil) then Form.Designer.Modified;

      XResult := BorlandIDEServices.QueryInterface(IOTAModuleServices, XModuleServices);
      if (XResult=S_Ok) and Assigned(XModuleServices) then XModuleServices.SaveAll;
    end;
  end;

  procedure HideComponent(Component: TComponent);
  var
    DesignInfoItem: TSaveComponentDesignInfoItemEh;
  begin
    if not (csLoading in Grid.ComponentState) and (Component.Name <> '') then
    begin
      if TCustomDBAxisGridEhCrack(Grid).FDesignInfoCollection <> nil then
      begin
        DesignInfoItem := GetDesignInfoItem(Component.Name);
        if DesignInfoItem <> nil then
          DesignInfoItem.InGrid := True
        else
        begin
          DesignInfoItem := TSaveComponentDesignInfoItemEh(
            TCustomDBAxisGridEhCrack(Grid).FDesignInfoCollection.Add);
//          if (Component.DesignInfo <> MakeLong(Word(-20), Word(-20))) then
//          begin
            DesignInfoItem.Left := LongRec(Component.DesignInfo).Lo;
            DesignInfoItem.Top := LongRec(Component.DesignInfo).Hi;
            DesignInfoItem.ComponentName := Component.Name;
            DesignInfoItem.InGrid := True;

            Component.DesignInfo := MakeLong(Word(-20), Word(-20));
            XModuleServicesSaveAll;

//          end;
        end;
      end;
    end;
  end;

  procedure RestoreNotUsedComponents();
  var
    i: Integer;
    DesignInfoItem: TSaveComponentDesignInfoItemEh;
    Component: TComponent;
  begin
    for i := TCustomDBAxisGridEhCrack(Grid).FDesignInfoCollection.Count-1 downto 0 do
    begin
      DesignInfoItem := TSaveComponentDesignInfoItemEh(
        TCustomDBAxisGridEhCrack(Grid).FDesignInfoCollection.Items[i]);
      if not DesignInfoItem.InGrid then
      begin
        Component := Grid.Owner.FindComponent(DesignInfoItem.ComponentName);
//        if Component <> nil
//          then ShowMessage(DesignInfoItem.ComponentName)
//          else ShowMessage(DesignInfoItem.ComponentName+' not found');
        if (Component <> nil) then
        begin
          if MakeLong(Word(DesignInfoItem.Left), Word(DesignInfoItem.Top)) <>
            MakeLong(Word(-20), Word(-20)) then
          begin
            Component.DesignInfo := MakeLong(Word(DesignInfoItem.Left), Word(DesignInfoItem.Top));
            XModuleServicesSaveAll;
          end;  
        end;
        TCustomDBAxisGridEhCrack(Grid).FDesignInfoCollection.Delete(i);
      end;
    end;
  end;
{$ENDIF}
begin
{$IFDEF CIL}
{$ELSE}
//  if not Grid.HandleAllocated or (csDestroying in  ComponentState) then
//    ShowMessage(Grid.Name+':not HandleAllocated or (csDestroying in  ComponentState)');
  if not Grid.HandleAllocated or (csDestroying in  ComponentState) then Exit;
  WidthX := 0;

  if TCustomDBAxisGridEhCrack(Grid).FDesignInfoCollection <> nil then
    for i := 0 to TCustomDBAxisGridEhCrack(Grid).FDesignInfoCollection.Count-1 do
      TSaveComponentDesignInfoItemEh(
        TCustomDBAxisGridEhCrack(Grid).FDesignInfoCollection.Items[i]).InGrid := False;

  if not Assigned(Grid.DataSource) then
  begin
    Inc(WidthX);
  end;

  if Assigned(Grid.DataSource) and (Grid.DataSource.Owner = Grid.Owner)
  then
  begin
    Inc(WidthX);
    if GetGlobalHideConnectedComponens then
      HideComponent(Grid.DataSource);
//    if not Assigned(Grid.DataSource.DataSet) then
//      Inc(WidthX);
  end;

  if Assigned(Grid.DataSource) and Assigned(Grid.DataSource.DataSet) and
    (Grid.DataSource.DataSet.Owner = Grid.Owner) then
  begin
    Inc(WidthX);
    if GetGlobalHideConnectedComponens then
      HideComponent(Grid.DataSource.DataSet);
  end;

  if Assigned(Grid.DataSource) and
     Assigned(Grid.DataSource.DataSet) and
     (Grid.DataSource.DataSet is TCustomMemTableEh) and
     Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
     ((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver.Owner = Grid.Owner) then
  begin
    Inc(WidthX);
    if GetGlobalHideConnectedComponens then
      HideComponent((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver);
  end;

  if Assigned(Grid.DataSource) and
     Assigned(Grid.DataSource.DataSet) and
     (Grid.DataSource.DataSet is TCustomMemTableEh) and
     Assigned((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver) and
     Assigned(TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet) and
     (TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet.Owner = Grid.Owner)
  then
  begin
    Inc(WidthX);
    if GetGlobalHideConnectedComponens then
      HideComponent(TDataDriverEhCracker((Grid.DataSource.DataSet as TCustomMemTableEh).DataDriver).ProviderDataSet);
  end;

  RestoreNotUsedComponents();

  if WidthX = 0
    then Width := 0
    else ClientWidth := 32 * WidthX;
  Left := Grid.ClientWidth - 32 * WidthX - 4 - TCustomDBAxisGridEhCrack(Grid).OutBoundaryData.RightIndent;
  Visible := (WidthX > 0);

  Height := 32 + 2;
  Top := Grid.ClientHeight - 36 - TCustomDBAxisGridEhCrack(Grid).OutBoundaryData.BottomIndent;
//  BringToFront;

//  if not Visible then
//    ShowMessage(Grid.Name+':not Visible');
//  ShowMessage(Grid.Name);

  Invalidate;
{$ENDIF}
end;

procedure TGridDesignPanelEh.WndProc(var Message: TMessage);
var
  AMouseMessage: TWMMouse;
begin
  if (Message.Msg = WM_LBUTTONDOWN) then
  begin
  {$IFDEF CIL}
    AMouseMessage := TWMMouse.Create(Message);
  {$ELSE}
    AMouseMessage := TWMMouse(Message);
  {$ENDIF}
    begin
      if not IsControlMouseMsg(AMouseMessage) then
      begin
        ControlState := ControlState + [csLButtonDown];
        Dispatch(Message);
        ControlState := ControlState - [csLButtonDown];
      end;
      Exit;
    end;
  end;
  inherited WndProc(Message);
end;

procedure TGridDesignPanelEh.CheckComponent(const Value: string);
var
  Component: TComponent;
  LDesigner: IDesigner;
begin
  if not Supports(FindRootDesigner(Grid), IDesigner, LDesigner) then Exit;
  Component := LDesigner.GetComponent(Value);
//  ShowMessage('TGridDesignPanelEh.CheckComponent - ' + Component.ClassName);
  if (Component.Owner <> Grid.Owner) then
    FComponentList.AddObject(Concat(Component.Owner.Name, '.', Component.Name), Component)
  else
    if AnsiCompareText(Component.Name, Grid.Name) <> 0 then
      FComponentList.AddObject(Component.Name, Component);
end;

function TGridDesignPanelEh.GetDesigner: IDesigner;
begin
  Supports(FindRootDesigner(Grid), IDesigner, Result);
end;

{ TDBGridEhGroupFooterItemsProperty }

procedure TDBGridEhGroupFooterItemsProperty.Edit;
var
  Obj: TPersistent;
begin
  Obj := GetComponent(0);
  while (Obj <> nil) and not (Obj is TComponent) do
    Obj := GetUltimateOwner(Obj);
  ShowCollectionEditorClass(Designer, TDBGridEhGroupFooterItemsEditor, TComponent(Obj),
//    TCustomDBAxisGridEh(Obj).Columns, 'Columns', [coAdd, coDelete, coMove]);
{$IFDEF CIL}
    TCollection(GetObjValue),
{$ELSE}
    TCollection(GetOrdValue),
{$ENDIF}
     'FooterItems', []);
end;

function TDBGridEhGroupFooterItemsProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly {, paSubProperties}];
end;

function TDBGridEhGroupFooterItemsProperty.GetValue: string;
begin
{$IFDEF CIL}
  FmtStr(Result, '(%s)', [GetPropType.Name]);
{$ELSE}
  FmtStr(Result, '(%s)', [GetPropType^.Name]);
{$ENDIF}
end;


type
  TGridDataGroupFootersEhCrack = class(TGridDataGroupFootersEh);
  TGridDataGroupFooterColumnItemsEhCrack = class(TGridDataGroupFooterColumnItemsEh);

{ TDBGridEhGroupFooterItemsEditor }

function TDBGridEhGroupFooterItemsEditor.CanAdd(Index: Integer): Boolean;
var
  Grid: TCustomDBGridEh;
begin
  Result := False;
  Grid := TCustomDBGridEh(TGridDataGroupFootersEhCrack(TGridDataGroupFooterColumnItemsEhCrack(Collection).Footer.FootersCollection).GridComponent);
  if Grid <> nil then
    Result := (Grid.Columns.State = csCustomized);
end;

{ TAssignComponentPropertyMenuItem }

procedure TAssignComponentPropertyMenuItem.Click;
var
  APropValue: TObject;
begin
  inherited Click;
  if Assigned(PropValueClass) then
  begin
//    ShowMessage(PropValueClass.ClassName + ':'+ Owner.ClassName);
    APropValue := LDesigner.CreateComponent(PropValueClass, Owner,
      0, 0, 0, 0);
  end else
    APropValue := PropValue;

  if Assigned(Component) and  Assigned(APropValue) and (PropName <> '') then
  begin
//    ShowMessage('Component.ClassName' + ':'+ 'APropValue.ClassName');
    SetObjectProp(Component, PropName, APropValue);
    DesignPanel.GetDesigner.Modified;
  end;

  DesignPanel.UpdateState;
end;

{ TFavoriteComponentListMenuItem }

procedure TFavoriteComponentListMenuItem.Click;
var
  slFavourite, slAll: TStringList;
begin
  slFavourite := TStringList.Create;
  slAll := TStringList.Create;

  GetComponentNamesEh(slAll, FClass, False);

  GetFavouriteComponentList(FClass, slFavourite, False);
  if SelectFavouriteComponentList(slFavourite, slAll) then
    SetFavouriteComponentList(FClass, slFavourite);

  slFavourite.Free;
  slAll.Free;
end;
{$ENDIF}

procedure Init;
begin
(*
{$IFDEF EH_LIB_9}
  SplashScreenServices.AddPluginBitmap(EhLibVerInfo,
    LoadBitmap(FindResourceHInstance(HInstance), 'SPLASH_ICON'),
{$IFDEF EH_LIB_DEMO}
    True, 'Evaluation version'
{$ELSE}
    False, 'Registered version'
{$ENDIF});
{$ENDIF}
*)
end;

{ DoFinalize }

procedure DoFinalize;
{$IFDEF FPC}
begin
end;
{$ELSE}
var
  LIDesignNotification: IDesignNotification;
  i: Integer;
begin
  if Assigned(DBGridEhDesigntControler) then
  begin
    Supports(TObject(DBGridEhDesigntControler), IDesignNotification, LIDesignNotification);
    UnregisterDesignNotification(LIDesignNotification);
  end;
  DBGridEhDesigntControler := nil;
  for i := 0 to ComponentsBitmap.Count-1 do
    ComponentsBitmap.Objects[i].Free;
  FreeAndNil(ComponentsBitmap);
end;
{$ENDIF}

initialization
  Init;
  {$IFDEF FPC}
  {$ELSE}
  RestoreGlobalHideConnectedComponens;
  DBGridEhDesigntControler := TDBGridEhDesignControler.Create;
  ComponentsBitmap := TStringList.Create;
  ComponentsBitmap.Sorted := True;
  {$ENDIF}
finalization
  DoFinalize;
end.
