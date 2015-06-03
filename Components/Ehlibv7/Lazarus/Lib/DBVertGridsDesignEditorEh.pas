{*******************************************************}
{                                                       }
{                       EhLib 7.0                       }
{              Design window for DBVertGrid             }
{                     (Build 7.0.02)                    }
{   Copyright (c) 1998-2012 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}


unit DBVertGridsDesignEditorEh {$IFDEF CIL} platform{$ENDIF};

{$I EhLib.Inc}
interface

uses
  SysUtils,
{$IFDEF CIL} Borland.Vcl.Design.DesignIntf,
             Borland.Vcl.Design.DesignEditors,
             Borland.Vcl.Design.ColnEdit,
             Variants, Types,
  EhLibVCLNET,
{$ELSE}
  {$IFDEF FPC}
  EhLibLCL, DBVertGridsEh,
  PropEdits, ComponentEditors,
  {$ELSE}
  Windows, Messages,
  ColnEdit,
  {$IFDEF EH_LIB_6}Variants, DesignEditors, DesignIntf,
  {$ELSE}DsgnWnds, DsgnIntf, LibIntf, {$ENDIF}

  EhLibVCL, PSAPI, ToolsAPI,
  Graphics, Controls, Forms,
  Dialogs, ImgList, Menus, ActnList, ExtCtrls, ComCtrls,
  DBAxisGridsEh, DBVertGridsEh, DBLookupEh, DBGridEhGrouping,
  ToolWin, MemTableEh,
  {$ENDIF}

{$ENDIF}
//  ColectEditorEh,
  ToolCtrlsEh, GridsEh, DataDriverEh,
  Classes;

type

{$IFDEF FPC}
{$ELSE}

  TDBVertGridEhColumnsEditor = class(TCollectionEditor)
//  TDBVertGridEhColumnsEditor = class(TCollectionEditorEh)
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


{ TDBGridEhColumnsProperty }

  TDBGridEhColumnsProperty = class(TPropertyEditor {TClassProperty})
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    procedure Edit; override;
  end;

{ TDBVertGridEhEditor }

  TDBVertGridEhEditor = class(TComponentEditor)
    procedure ExecuteVerb(Index: Integer); override;
    function GetVerb(Index: Integer): string; override;
    function GetVerbCount: Integer; override;
  end;

{$ENDIF}

{ TDBGridEhFieldProperty }

  TDBGridEhFieldProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{ TDBVertGridEhRowCategoryProperty }

  TDBVertGridEhRowCategoryProperty = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

{$IFDEF FPC}
{$ELSE}

{ TPanelMenuItem }

  TPanelMenuItem = class(TMenuItem)
  public
    ComponentEditor: IComponentEditor;
    VerbNo: Integer;
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

var
  DBVertGridEhColumnsEditor: TDBVertGridEhColumnsEditor;
  ComponentsBitmap: TStringList;
  GlobalHideConnectedComponens: Boolean;
  GlobalHideConnectedComponensLoaded: Boolean;

  function GetGlobalHideConnectedComponens: Boolean;

{$ENDIF}

procedure Register;

implementation

{$R *.dfm}

{$IFDEF FPC}
{$ELSE}
uses
{$IFDEF DESIGNTIME}

  {$IFDEF CIL}
  Borland.Vcl.Design.ComponentDesigner,
  {$ELSE}
  ComponentDesigner,
  {$ENDIF}


{$ELSE}
//  LibIntf,
{$ENDIF}
  Registry, EhLibDesignAbout;
{$ENDIF}

procedure Register;
begin

  RegisterComponents('EhLib Controls', [TDBVertGridEh]);
  RegisterPropertyEditor(TypeInfo(string), TFieldRowEh, 'FieldName', TDBGridEhFieldProperty);
  RegisterPropertyEditor(TypeInfo(string), TFieldRowEh, 'CategoryName', TDBVertGridEhRowCategoryProperty);

  {$IFDEF FPC}
  {$ELSE}
  RegisterComponentEditor(TDBVertGridEh, TDBVertGridEhEditor);
  RegisterPropertyEditor(TypeInfo(TCollection), TCustomDBVertGridEh, 'Rows', TDBGridEhColumnsProperty);
  {$ENDIF}

//  RegisterSelectionEditor(TDBGridEh, TDBGridEhSelectionEditor);
end;

{ TDBGridEhFieldProperty }

function TDBGridEhFieldProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TDBGridEhFieldProperty.GetValueList(List: TStrings);
var
  Ehg: TCustomDBVertGridEh;
begin
  if (GetComponent(0) = nil) then Exit;
  if (GetComponent(0) is TFieldRowEh) then
    Ehg := (GetComponent(0) as TFieldRowEh).Grid
  else
    Exit;

  if (Ehg <> nil) and (TCustomDBVertGridEh(Ehg).DataSource <> nil) and (TCustomDBVertGridEh(Ehg).DataSource.DataSet <> nil) then
  begin
    TCustomDBVertGridEh(Ehg).DataSource.DataSet.GetFieldNames(List);
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

{ TDBVertGridEhRowCategoryProperty }

function TDBVertGridEhRowCategoryProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TDBVertGridEhRowCategoryProperty.GetValueList(List: TStrings);
var
  Ehg: TCustomDBVertGridEh;
  I: Integer;
begin
  if (GetComponent(0) = nil) then Exit;
  if (GetComponent(0) is TFieldRowEh) then
    Ehg := (GetComponent(0) as TFieldRowEh).Grid
  else
    Exit;

  if Ehg <> nil then
  begin
    for I := 0 to TCustomDBVertGridEh(Ehg).RowCategories.CategoryProps.Count - 1 do
      List.Add(TCustomDBVertGridEh(Ehg).RowCategories.CategoryProps[I].Name);
  end;
end;

procedure TDBVertGridEhRowCategoryProperty.GetValues(Proc: TGetStrProc);
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
  AClassName := UpperCase(Component.ClassName);
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
  ShowCollectionEditorClass(Designer, TDBVertGridEhColumnsEditor, TComponent(Obj),
//    TCustomDBVertGridEh(Obj).Columns, 'Columns', [coAdd, coDelete, coMove]);
{$IFDEF CIL}
    TCollection(GetObjValue),
{$ELSE}
    TCollection(GetOrdValue),
{$ENDIF}
     'Rows', [coAdd, coDelete, coMove]);
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

{ TDBVertGridEhEditor }

procedure TDBVertGridEhEditor.ExecuteVerb(Index: Integer);
//var
//  Msg: TCMChanged;
begin
  case Index of
    0:
      ShowCollectionEditorClass(Designer, TDBVertGridEhColumnsEditor, Component,
        TCustomDBVertGridEh(Component).Rows, 'Rows', [coAdd, coDelete, coMove]);
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
//        Msg.Child := TCustomDBVertGridEh(Component);
//        Msg.Result := 0;
{$IFDEF CIL}
{$ELSE}
        if (TCustomDBVertGridEh(Component).Owner is TWinControl) then
          BroadcastPerformMessageFor(TCustomDBVertGridEh(Component).Owner,
            TCustomDBVertGridEh, CM_CHANGED, 0, Longint(Component));
{$ENDIF}
//          TWinControl(TCustomDBVertGridEh(Component).Owner).Broadcast(Msg);
      end;*)
    2:
      ShowAboutForm;
  end;
end;

function TDBVertGridEhEditor.GetVerb(Index: Integer): string;
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
    1: Result := '-';
    2: Result := EhLibVerInfo + ' '  + EhLibBuildInfo + ' ' + EhLibEditionInfo;
  end;
end;

function TDBVertGridEhEditor.GetVerbCount: Integer;
begin
//  Result := 2;
  Result := 3;
end;

{ TCustomDBGridEhCracker }

type
  TCustomDBGridEhCracker = class(TCustomDBVertGridEh)
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
{ TDBVertGridEhColumnsEditor }

procedure TDBVertGridEhColumnsEditor.AddAllFieldsCmdExecute(Sender: TObject);
var msgValue: Word;
//    i:Integer;
//    Col:TColumnEh;
  DBGridEh: TCustomDBVertGridEh;
begin
{$IFDEF CIL}
  DBGridEh := TCustomDBVertGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBVertGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  if not Assigned(DBGridEh) then Exit;
  if (DBGridEh.Rows.State = csDefault) then
    DBGridEh.Rows.State := csCustomized
  else
  begin
{$IFDEF CIL}
    DBGridEh.Columns.BeginUpdate;
{$ELSE}
    TCustomDBGridEhCracker(DBGridEh).BeginLayout;
{$ENDIF}
    try
      if (DBGridEh.Rows.Count > 0) then
      begin
        msgValue := MessageDlg('Delete existing columns?',
          mtConfirmation, [mbYes, mbNo, mbCancel], 0);
        case msgValue of
          mrYes:
            begin
              SelectNone(True);
              DBGridEh.Rows.Clear;
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
      DBGridEh.Rows.AddAllRows(False);
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

procedure TDBVertGridEhColumnsEditor.RestoreDefaultsCmdExecute(Sender: TObject);
var i: Integer;
  DBGridEh: TCustomDBVertGridEh;
begin
{$IFDEF CIL}
  DBGridEh := TCustomDBVertGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBVertGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  if not Assigned(DBGridEh) then Exit;
  if (ListView1.SelCount > 0) then
  begin
    for i := 0 to ListView1.SelCount - 1 do
      DBGridEh.Rows[i].RestoreDefaults;
    Designer.Modified;
    UpdateListbox;
  end;
end;

procedure TDBVertGridEhColumnsEditor.AddAllFieldsCmdUpdate(Sender: TObject);
var DBGridEh: TCustomDBVertGridEh;
begin
{$IFDEF CIL}
  DBGridEh := TCustomDBVertGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBVertGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  AddAllFieldsCmd.Enabled := Assigned(DBGridEh) and
    Assigned(DBGridEh.DataSource) and Assigned(DBGridEh.Datasource.Dataset) and
    (DBGridEh.Datasource.Dataset.FieldCount > 0);
end;

procedure TDBVertGridEhColumnsEditor.RestoreDefaultsCmdUpdate(Sender: TObject);
begin
  RestoreDefaultsCmd.Enabled := ListView1.Items.Count > 0;
end;

function TDBVertGridEhColumnsEditor.CanAdd(Index: Integer): Boolean;
var DBGridEh: TCustomDBVertGridEh;
begin
  Result := False;
{$IFDEF CIL}
  DBGridEh := TCustomDBVertGridEh(Collection.Owner);
{$ELSE}
  DBGridEh := TCustomDBVertGridEh(TCollectionCracker(Collection).GetOwner);
{$ENDIF}
  if Assigned(DBGridEh) then
    Result := (DBGridEh.Rows.State = csCustomized);
end;

procedure Init;
begin
end;

{ DoFinalize }

procedure DoFinalize;
var
  i: Integer;
begin

  for i := 0 to ComponentsBitmap.Count-1 do
    ComponentsBitmap.Objects[i].Free;
  FreeAndNil(ComponentsBitmap);
end;

initialization
  Init;
  RestoreGlobalHideConnectedComponens;
  ComponentsBitmap := TStringList.Create;
  ComponentsBitmap.Sorted := True;
finalization
  DoFinalize;
{$ENDIF} //FPC

end.
