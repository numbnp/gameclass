{*******************************************************}
{                                                       }
{                      EhLib v7.0                       }
{                SideOwned components.                  }
{         SideOwned components is Not Visible on        }
{                 a Form at design-time                 }
{                     Build 7.0.24                      }
{                                                       }
{      Copyright (c) 2013-14 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

unit SideOwnedComponentsEh;

{$I EHLIB.INC}

interface

uses SysUtils, Classes, Controls, DB, Dialogs,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_17} System.Generics.Collections, Winapi.ActiveX, {$ENDIF}
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF CIL}
  System.Runtime.InteropServices,
  EhLibVCLNET,
{$ELSE}
{$IFDEF FPC}
  EhLibLCL, LCLType, Win32Extra,
{$ELSE}
  EhLibVCL,
{$ENDIF}
{$ENDIF}
  ToolCtrlsEh, MemTableEh, DataDriverEh;

type

{ TNiDataSourceEh }

  TNiDataSourceEh = class(TDataSource, ISideOwnedComponentEh, ISideOwnerEh)
  private
    FSideParent: TComponent;
    FSideParentName: String;
    function GetDataSet: TDataSet;
    procedure SetDataSet(const Value: TDataSet);
    procedure ReadSideParent(Reader: TReader);
    procedure WriteSideParent(Writer: TWriter);
    function IsSideParentStored: Boolean;

  protected
    function IsSideParentableForProperty(PropertyName: String): Boolean;
    function CanSideOwnClass(ComponentClass: TComponentClass): Boolean;

    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;

  public
    constructor CreateWithSideParent(AOwner: TComponent; ASideParent: TComponent);
    destructor Destroy; override;

    function IsSideParentedBy(AComponent: TComponent): Boolean;
    procedure SetSideParent(AComponent: TComponent);

  published
    property DataSet: TDataSet read GetDataSet write SetDataSet;
    property SideParent: TComponent read FSideParent stored False;
  end;

{ TNiMemTableEh }

  TNiMemTableEh = class(TMemTableEh, ISideOwnedComponentEh, ISideOwnerEh)
  private
    FSideParent: TComponent;
    FSideParentName: String;
    procedure ReadSideParent(Reader: TReader);
    procedure WriteSideParent(Writer: TWriter);
    function IsSideParentStored: Boolean;
    function GetDataDriver: TDataDriverEh;
    procedure SetDataDriver(const Value: TDataDriverEh);

  protected
    function IsSideParentableForProperty(PropertyName: String): Boolean;
    function CanSideOwnClass(ComponentClass: TComponentClass): Boolean;

    procedure DefineProperties(Filer: TFiler); override;
    procedure Loaded; override;

  public
    constructor CreateWithSideParent(AOwner: TComponent; ASideParent: TComponent);
    destructor Destroy; override;

    function IsSideParentedBy(AComponent: TComponent): Boolean;
    procedure SetSideParent(AComponent: TComponent);

  published
    property DataDriver: TDataDriverEh read GetDataDriver write SetDataDriver;
    property SideParent: TComponent read FSideParent stored False;
  end;

{ TNiDataSetDriverEh }

  TNiDataSetDriverEh = class(TDataSetDriverEh)
  public
    constructor Create(AOwner: TComponent); override;
  published
    property SideParent;
  end;

const
  SelectSideParentComponentProc: procedure(const AComp: TComponent;
    var SideParentComp: TComponent; Description: String) = nil;

implementation

{ TNiDataSourceEh }

constructor TNiDataSourceEh.CreateWithSideParent(AOwner,
  ASideParent: TComponent);
begin
  inherited Create(AOwner);
  FSideParent := ASideParent;
end;

destructor TNiDataSourceEh.Destroy;
begin
  OnStateChange := nil;
  DataSet := nil;
  inherited Destroy;
end;

procedure TNiDataSourceEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('SideParentName', ReadSideParent, WriteSideParent, IsSideParentStored);
end;

function TNiDataSourceEh.IsSideParentableForProperty(
  PropertyName: String): Boolean;
begin
  if PropertyName = 'DataSet'
    then Result := True
    else Result := False;
end;

function TNiDataSourceEh.CanSideOwnClass(
  ComponentClass: TComponentClass): Boolean;
begin
//  ShowMessage('TNiDataSourceEh.CanSideOwnClass ' + ComponentClass.ClassName);
  if ComponentClass.InheritsFrom(TDataSet)
    then Result := True
    else Result := False;
end;

function TNiDataSourceEh.IsSideParentedBy(AComponent: TComponent): Boolean;
begin
  Result := (SideParent = AComponent);
end;

procedure TNiDataSourceEh.ReadSideParent(Reader: TReader);
begin
  FSideParentName := Reader.ReadString;
end;

procedure TNiDataSourceEh.WriteSideParent(Writer: TWriter);
begin
  Writer.WriteString(FSideParent.Name);
end;

function TNiDataSourceEh.IsSideParentStored: Boolean;
begin
  Result := (FSideParent <> nil);
end;

procedure TNiDataSourceEh.Loaded;
begin
  inherited Loaded;
  if FSideParentName <> '' then
    FSideParent := Owner.FindComponent(FSideParentName);
  FSideParentName := '';

  if (csDesigning in ComponentState) and
     (FSideParent = nil) and
     Assigned(SelectSideParentComponentProc)
  then
    SelectSideParentComponentProc(Self, FSideParent,
    'SideOwnerable component + "' + Name + ' : ' + ClassName + '" doesn''t have SideOwner. ' + sLineBreak +
    'Plasse select SideOwner for SideOwnerable component.'
    );
end;

procedure TNiDataSourceEh.SetSideParent(AComponent: TComponent);
begin
  FSideParent := AComponent;
end;

function TNiDataSourceEh.GetDataSet: TDataSet;
begin
  Result := inherited DataSet;
end;

procedure TNiDataSourceEh.SetDataSet(const Value: TDataSet);
var
  NiComponentItfs: ISideOwnedComponentEh;
  DoFreeDataSet: TDataSet;
  JustCreatedNiComponentItfs: ISideOwnedComponentEh;
  ModRes: Integer;
begin
  if Value = DataSet then Exit;

  DoFreeDataSet := nil;
  if (csDesigning in ComponentState) and
//     not (csDestroying in ComponentState) and
     not (csLoading in ComponentState) and
     Supports(DataSet, ISideOwnedComponentEh, NiComponentItfs)
  then
    if NiComponentItfs.IsSideParentedBy(Self) then
      DoFreeDataSet := DataSet;

  JustCreatedNiComponentItfs := nil;
  if (csDesigning in ComponentState) and
     not (csLoading in ComponentState) and
     Supports(Value, ISideOwnedComponentEh, JustCreatedNiComponentItfs)
  then
    if not JustCreatedNiComponentItfs.IsSideParentedBy(nil) then
      JustCreatedNiComponentItfs := nil;

  if (DoFreeDataSet <> nil) and
     not (csDestroying in ComponentState) then
  begin
    ModRes :=
      MessageDlg('Component "' + DataSet.Name + '" belongs to "' + Name + '"' +
      'and will be deleted if DataSet property is assigned by a new component or nil.' +  sLineBreak +
        'Do you want to assign new component to the DataSet property and delete "' + DataSet.Name + '" ?',
        mtConfirmation, [mbYes, mbNo], 0);
    if ModRes <> mrYes then
    begin
      if JustCreatedNiComponentItfs <> nil then
        Value.Free;
     Exit;
    end;
  end;

  try
    inherited DataSet := Value;
  except
    if JustCreatedNiComponentItfs <> nil then
      Value.Free;
    raise;
  end;

  if JustCreatedNiComponentItfs <> nil then
    JustCreatedNiComponentItfs.SetSideParent(Self);

  if DoFreeDataSet <> nil then
    DoFreeDataSet.Free;
end;

{ TNiMemTableEh }

constructor TNiMemTableEh.CreateWithSideParent(AOwner,
  ASideParent: TComponent);
begin
  inherited Create(AOwner);
  FSideParent := ASideParent;
end;

destructor TNiMemTableEh.Destroy;
begin
  Destroying;
  DataDriver := nil;
  inherited Destroy;
end;

procedure TNiMemTableEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('SideParentName', ReadSideParent, WriteSideParent, IsSideParentStored);
end;

procedure TNiMemTableEh.ReadSideParent(Reader: TReader);
begin
  FSideParentName := Reader.ReadString;
end;

procedure TNiMemTableEh.WriteSideParent(Writer: TWriter);
begin
  Writer.WriteString(FSideParent.Name);
end;

function TNiMemTableEh.IsSideParentStored: Boolean;
begin
  Result := (FSideParent <> nil);
end;

procedure TNiMemTableEh.Loaded;
begin
  inherited Loaded;
  if FSideParentName <> '' then
    FSideParent := Owner.FindComponent(FSideParentName);
  FSideParentName := '';

  if (csDesigning in ComponentState) and
     (FSideParent = nil) and
     Assigned(SelectSideParentComponentProc)
  then
    SelectSideParentComponentProc(Self, FSideParent,
    'SideOwnerable component + "' + Name + ' : ' + ClassName + '" doesn''t have SideOwner. ' + sLineBreak +
    'Plasse select SideOwner for SideOwnerable component.'
    );
end;

function TNiMemTableEh.IsSideParentedBy(AComponent: TComponent): Boolean;
begin
  Result := (SideParent = AComponent);
end;

procedure TNiMemTableEh.SetSideParent(AComponent: TComponent);
begin
  FSideParent := AComponent;
end;

function TNiMemTableEh.GetDataDriver: TDataDriverEh;
begin
  Result := inherited DataDriver;
end;

procedure TNiMemTableEh.SetDataDriver(const Value: TDataDriverEh);
var
  NiComponentItfs: ISideOwnedComponentEh;
  DoFreeDataDriver: TDataDriverEh;
  JustCreatedNiComponentItfs: ISideOwnedComponentEh;
  ModRes: Integer;
begin
  if Value = DataDriver then Exit;

  DoFreeDataDriver := nil;
  if (csDesigning in ComponentState) and
//     not (csDestroying in ComponentState) and
     not (csLoading in ComponentState) and
     Supports(DataDriver, ISideOwnedComponentEh, NiComponentItfs)
  then
    if NiComponentItfs.IsSideParentedBy(Self) then
      DoFreeDataDriver := DataDriver;

  JustCreatedNiComponentItfs := nil;
  if (csDesigning in ComponentState) and
     not (csDestroying in ComponentState) and
     not (csLoading in ComponentState) and
     Supports(Value, ISideOwnedComponentEh, JustCreatedNiComponentItfs)
  then
    if not JustCreatedNiComponentItfs.IsSideParentedBy(nil) then
      JustCreatedNiComponentItfs := nil;

  if (DoFreeDataDriver <> nil) and
     not (csDestroying in ComponentState) then
  begin
    ModRes :=
      MessageDlg('Component "' + DataDriver.Name + '" belongs to "' + Name + '"' +
      'and will be deleted if DataDriver property is assigned by a new component.' +  sLineBreak +
        'Do you want to assign new component to the DataDriver property and delete "' + DataDriver.Name + '" ?',
        mtConfirmation, [mbYes, mbNo], 0);
    if ModRes <> mrYes then
    begin
      if JustCreatedNiComponentItfs <> nil then
        Value.Free;
     Exit;
    end;
  end;

  try
    inherited DataDriver := Value;
  except
    if JustCreatedNiComponentItfs <> nil then
      Value.Free;
    raise;
  end;

  if JustCreatedNiComponentItfs <> nil then
    JustCreatedNiComponentItfs.SetSideParent(Self);

  if DoFreeDataDriver <> nil then
    DoFreeDataDriver.Free;
end;

function TNiMemTableEh.CanSideOwnClass(
  ComponentClass: TComponentClass): Boolean;
begin
  if ComponentClass.InheritsFrom(TDataDriverEh)
    then Result := True
    else Result := False;
end;

function TNiMemTableEh.IsSideParentableForProperty(
  PropertyName: String): Boolean;
begin
  if PropertyName = 'DataDriver'
    then Result := True
    else Result := False;
end;

{ TNiDataSetDriverEh }

constructor TNiDataSetDriverEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSideParentable := True;
end;

end.
