{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{                    DBLookupUtilsEh                    }
{                      Build 7.0.04                     }
{                                                       }
{      Copyright (c) 2001-2014 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBLookupUtilsEh;

interface

uses
  SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
{$IFDEF EH_LIB_6}Variants, {$ENDIF}
  Db, DBCtrls, Buttons, ToolCtrlsEh, Menus,
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  {$IFDEF FPC}
    EhLibLCL, LCLType, Win32Extra,
  {$ELSE}
    EhLibVCL, Messages,
  {$ENDIF}
{$ENDIF}
  DBCtrlsEh;

type

  TDBLookupDataEh = class;

{ TLookupListEh }

  PLookupPairEh = ^TLookupPairEh;
  TLookupPairEh = record
    KeyValue: Variant;
    DisplayValue: Variant;
  end;

  TLookupListEh = class(TObject)
  private
    FList: TList;
  protected
    function FindKeyValueIndex(const KeyValue: Variant; var Index: Integer): Boolean;
    procedure QuickSort(L, R: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    function ValueOfKey(const AKeyValue: Variant): Variant;
    procedure Add(const AKeyValue, ADisplayValue: Variant);
    procedure Clear;
    procedure SortData;
  end;

{ TDataSourceLinkEh }

  TDataSourceLinkEh = class(TDataLink)
  private
    FLookupData: TDBLookupDataEh;
  protected
    procedure ActiveChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create;
  end;

{ TListSourceLinkEh }

  TListSourceLinkEh = class(TDataLink)
  private
    FLookupData: TDBLookupDataEh;
  protected
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure LayoutChanged; override;
  public
    constructor Create;
  end;

{ TDBLookupDataEh }

  TDBLookupDataEh = class(TPersistent)
  private
    FAxisBar: TCollectionItem;
    FDataLink: TDataSourceLinkEh;
    FInternalLookupSource: TDataSource;
    FKeyFieldNames: String;
    FKeyFields: TFieldsArrEh;
    FLookupActive: Boolean;
    FLookupCache: Boolean;
    FLookupDataSet: TDataSet;
    FLookupDisplayField: TField;
    FLookupDisplayFieldName: String;
    FLookupInDataField: Boolean;
    FLookupIsSetUp: Boolean;
    FLookupKeyFieldNames: String;
    FLookupKeyFields: TFieldsArrEh;
    FLookupLink: TListSourceLinkEh;
    FLookupListActive: Boolean;
    FLookupListCache: TLookupListEh;
//    FLookupSource: TDataSource;

    function GetDataLink: TDataSourceLinkEh;
    function GetDataSource: TDataSource;
    function GetKeyFieldNames: String;
    function GetKeyFields: TFieldsArrEh;
    function GetLookupActive: Boolean;
    function GetLookupDataSet: TDataSet;
    function GetLookupDisplayField: TField;
    function GetLookupDisplayFieldName: String;
    function GetLookupIsSetUp: Boolean;
    function GetLookupKeyFieldNames: String;
    function GetLookupKeyFields: TFieldsArrEh;

    procedure CheckLookupInDataField;
    procedure CheckNotCircular;
    procedure SetKeyFieldNames(const Value: String);
    procedure SetLookupCache(const Value: Boolean);
    procedure SetLookupDataSet(const Value: TDataSet);
    procedure SetLookupDisplayFieldName(const Value: String);
    procedure SetLookupInDataField(Value: Boolean);
    procedure SetLookupKeyFieldNames(const Value: String);

  protected
    FDataFieldsUpdating: Boolean;

    function  GetOwner: TPersistent; override;

    procedure ActiveChanged; virtual;
    procedure DataChanged; virtual;
    procedure ListLinkDataChanged; virtual;
    procedure Notification(AComponent: TComponent; Operation: TOperation);
    procedure UpdateDataFields; virtual;
    procedure UpdateListFields; virtual;
    procedure UpdateListLinkDataSource; virtual;
    procedure UpdateLookupActiveState;
    procedure UpdateLookupSetupState;

    property DataLink: TDataSourceLinkEh read GetDataLink;
    property LookupListActive: Boolean read FLookupListActive;
    property ListLink: TListSourceLinkEh read FLookupLink;
  public
    constructor Create(AColumn: TCollectionItem);
    destructor Destroy; override;

    function GetLookupValue: Variant;
    function LookupDataIsStored: Boolean;

    procedure Assign(Source: TPersistent); override;
    procedure RefreshLookupListCache;
    procedure UpdateLookupState;

    property AxisBar: TCollectionItem read FAxisBar;
    property DataSource: TDataSource read GetDataSource;
    property KeyFields: TFieldsArrEh read GetKeyFields;
    property LookupActive: Boolean read GetLookupActive; {write SetLookupActive;}
    property LookupDisplayField: TField read GetLookupDisplayField;
    property LookupInDataField: Boolean read FLookupInDataField;
    property LookupIsSetUp: Boolean read GetLookupIsSetUp;
    property LookupKeyFields: TFieldsArrEh read GetLookupKeyFields;
    property LookupListSource: TDataSource read FInternalLookupSource;

  published
    property KeyFieldNames: String read GetKeyFieldNames write SetKeyFieldNames stored LookupDataIsStored;
    property LookupCache: Boolean read FLookupCache write SetLookupCache default True;
    property LookupDataSet: TDataSet read GetLookupDataSet write SetLookupDataSet stored LookupDataIsStored;
    property LookupDisplayFieldName: String read GetLookupDisplayFieldName write SetLookupDisplayFieldName stored LookupDataIsStored;
    property LookupKeyFieldNames: String read GetLookupKeyFieldNames write SetLookupKeyFieldNames stored LookupDataIsStored;
  end;

implementation

uses
  {$IFDEF FPC}
  DbConst,
  {$ELSE}
  DbConsts,
  {$ENDIF}
  DBAxisGridsEh, Clipbrd;

type
  TAxisBarEhCrack = class(TAxisBarEh);

{ TDataSourceLinkEh }

procedure TDataSourceLinkEh.ActiveChanged;
begin
  inherited ActiveChanged;
  if FLookupData <> nil then FLookupData.UpdateDataFields;
end;

constructor TDataSourceLinkEh.Create;
begin
  inherited Create;
end;

procedure TDataSourceLinkEh.LayoutChanged;
begin
  if FLookupData <> nil then FLookupData.UpdateDataFields;
end;

procedure TDataSourceLinkEh.RecordChanged(Field: TField);
begin
  inherited RecordChanged(Field);
end;

{ TListSourceLinkEh }

constructor TListSourceLinkEh.Create;
begin
  inherited Create;
  VisualControl := True;
end;

procedure TListSourceLinkEh.ActiveChanged;
begin
  if FLookupData <> nil then
    FLookupData.UpdateListFields;
end;

procedure TListSourceLinkEh.DataSetChanged;
begin
  if FLookupData <> nil then
    FLookupData.ListLinkDataChanged;
end;

procedure TListSourceLinkEh.LayoutChanged;
begin
  if FLookupData <> nil then
    FLookupData.UpdateListFields;
end;

{ TDBLookupDataEh }

constructor TDBLookupDataEh.Create(AColumn: TCollectionItem);
begin
  inherited Create;

  FAxisBar := AColumn;

  FDataLink := TDataSourceLinkEh.Create;
  FDataLink.FLookupData := Self;

  FInternalLookupSource := TDataSource.Create(nil);
  FInternalLookupSource.Name := 'FInternalLookupSource';
  FLookupLink := TListSourceLinkEh.Create;
  FLookupLink.FLookupData := Self;
  FLookupLink.DataSource := FInternalLookupSource;

  FLookupListCache := TLookupListEh.Create;
  FLookupCache := True;
end;

destructor TDBLookupDataEh.Destroy;
begin
  FreeAndNil(FDataLink);
  FreeAndNil(FInternalLookupSource);
  FreeAndNil(FLookupLink);
  FreeAndNil(FLookupListCache);
  inherited Destroy;
end;

procedure TDBLookupDataEh.CheckNotCircular;
begin
  if FLookupLink.Active and FLookupLink.DataSet.IsLinkedTo(TAxisBarEh(FAxisBar).Grid.DataSource) then
  {$IFDEF FPC}
    DatabaseError(SErrCircularDataSourceReferenceNotAllowed);
  {$ELSE}
    DatabaseError(SCircularDataLink);
  {$ENDIF}
end;

procedure TDBLookupDataEh.CheckLookupInDataField;
begin
  {$IFDEF FPC}
  if FLookupInDataField then DatabaseError('SPropDefByLookup');
  if FDataLink.DataSourceFixed then DatabaseError('SDataSourceFixed');
  {$ELSE}
  if FLookupInDataField then DatabaseError('SPropDefByLookup');
  if FDataLink.DataSourceFixed then DatabaseError('SDataSourceFixed');
  {$ENDIF}
end;

procedure TDBLookupDataEh.UpdateDataFields;
begin
  if FDataFieldsUpdating then Exit;
  FDataFieldsUpdating := True;
  SetLength(FKeyFields, 0);
  CheckNotCircular;
  if (TAxisBarEhCrack(FAxisBar).FField <> nil) and
     not (csDestroying in TAxisBarEhCrack(FAxisBar).FField.ComponentState) and
     (TAxisBarEhCrack(FAxisBar).FField.FieldKind = fkLookup) then
  begin
    if Length(TAxisBarEhCrack(FAxisBar).FField.KeyFields) > 0
      then FDataLink.DataSource := DataSource
      else FDataLink.DataSource := nil;
    if (FDataLink.DataSet <> nil) and FDataLink.DataSet.Active then
      FKeyFields := GetFieldsProperty(FDataLink.DataSet,
        TAxisBarEh(FAxisBar).Grid, TAxisBarEhCrack(FAxisBar).FField.KeyFields);
    SetLookupInDataField(True);
  end else
  begin
    if Length(FKeyFieldNames) > 0
      then FDataLink.DataSource := DataSource
      else FDataLink.DataSource := nil;
    if FDataLink.DataSet <> nil then
      FKeyFields := GetFieldsProperty(FDataLink.DataSet, TAxisBarEh(FAxisBar).Grid, FKeyFieldNames);
    SetLookupInDataField(False);
  end;
  UpdateListFields;
  FDataFieldsUpdating := False;
  UpdateLookupSetupState;
  UpdateLookupActiveState;
end;

procedure TDBLookupDataEh.UpdateListFields;
var
  ListDataset: TDataSet;
  ALookupListActive: Boolean;
begin
  ALookupListActive := False;
  FLookupDisplayField := nil;
  SetLength(FLookupKeyFields, 0);
  FLookupLink.DataSource := FInternalLookupSource;
  if FLookupLink.Active and (LookupKeyFieldNames <> '') then
  begin
    CheckNotCircular;
    ListDataset := FLookupLink.DataSet;
    FLookupKeyFields := GetFieldsProperty(ListDataset, TAxisBarEh(FAxisBar).Grid, LookupKeyFieldNames);
    if FLookupInDataField and (TAxisBarEhCrack(FAxisBar).FField <> nil) then
      FLookupDisplayField := GetFieldProperty(ListDataset,
        TAxisBarEh(FAxisBar).Grid, TAxisBarEhCrack(FAxisBar).FField.LookupResultField)
    else if LookupDisplayFieldName <> '' then
      FLookupDisplayField := GetFieldProperty(ListDataset, TAxisBarEh(FAxisBar).Grid, LookupDisplayFieldName)
    else
      FLookupDisplayField := nil;
    ALookupListActive := (Length(FLookupKeyFields) > 0) and (FLookupDisplayField <> nil);
  end;
  if ALookupListActive <> FLookupListActive then
  begin
    FLookupListActive := ALookupListActive;
    RefreshLookupListCache;
  end;
  if not FDataFieldsUpdating then
  begin
    UpdateLookupSetupState;
    UpdateLookupActiveState;
  end;
end;

procedure TDBLookupDataEh.UpdateListLinkDataSource;
begin
  FInternalLookupSource.DataSet := LookupDataSet;
end;

procedure TDBLookupDataEh.UpdateLookupActiveState;
var
  NewState: Boolean;
begin
  NewState := (Length(KeyFields) > 0) and
    (Length(LookupKeyFields) > 0) and
    (LookupDisplayField <> nil) and
     DataLink.Active and
     ListLink.Active;

  if NewState or (FLookupActive <> NewState) then
  begin
    FLookupActive := NewState;
//    RefreshLookupListCache;
    TAxisBarEhCrack(FAxisBar).LookupStateChanged;
  end;
end;

procedure TDBLookupDataEh.UpdateLookupSetupState;
var
  NewLookupIsSetUp: Boolean;
begin
  FLookupActive := (Length(KeyFields) > 0) and
    (Length(LookupKeyFields) > 0) and
    (LookupDisplayField <> nil) and
     DataLink.Active and
     ListLink.Active;

  NewLookupIsSetUp := (KeyFieldNames <> '') and
    (LookupKeyFieldNames <> '') and
    (LookupDisplayFieldName <> '') and
    (LookupDataSet <> nil);

  if NewLookupIsSetUp or (FLookupIsSetUp <> NewLookupIsSetUp) then
  begin
    FLookupIsSetUp := NewLookupIsSetUp;
    TAxisBarEhCrack(FAxisBar).LookupStateChanged;
  end;
end;

procedure TDBLookupDataEh.UpdateLookupState;
begin
  UpdateDataFields;
//  UpdateListFields;
end;

procedure TDBLookupDataEh.SetLookupInDataField(Value: Boolean);

  function FieldLookupDataSetChanged: Boolean;
  begin
    if (TAxisBarEhCrack(FAxisBar).FField = nil) and (FInternalLookupSource.DataSet = nil) then
      Result := False
    else if (TAxisBarEhCrack(FAxisBar).FField = nil) and (FInternalLookupSource.DataSet <> nil) then
      Result := True
    else
      Result := FInternalLookupSource.DataSet <> TAxisBarEhCrack(FAxisBar).FField.LookupDataSet;
  end;

begin
  if (FLookupInDataField <> Value) or FieldLookupDataSetChanged then
  begin
    if Value then
    begin
      FLookupInDataField := True;
      FInternalLookupSource.DataSet := TAxisBarEhCrack(FAxisBar).FField.LookupDataSet;
      FLookupLink.DataSource := FInternalLookupSource;
      UpdateListFields;
    end else
    begin
      FLookupInDataField := False;
//      FLookupLink.DataSource := FInternalLookupSource;
      FInternalLookupSource.DataSet := LookupDataSet;
      UpdateListFields;
    end;
  end;
end;

procedure TDBLookupDataEh.DataChanged;
begin
end;

procedure TDBLookupDataEh.ActiveChanged;
begin
  UpdateDataFields;
end;

function TDBLookupDataEh.GetLookupKeyFieldNames: String;
begin
  if LookupInDataField and (TAxisBarEhCrack(FAxisBar).FField <> nil)
    then Result := TAxisBarEhCrack(FAxisBar).FField.LookupKeyFields
    else Result := FLookupKeyFieldNames;
end;

procedure TDBLookupDataEh.SetLookupKeyFieldNames(const Value: String);
begin
  CheckLookupInDataField;
  if FLookupKeyFieldNames <> Value then
  begin
    FLookupKeyFieldNames := Value;
    UpdateListFields;
  end;
end;

function TDBLookupDataEh.GetLookupValue: Variant;
var
  KeyValue: Variant;
begin
  Result := Null;
  if DataLink.Active and LookupListActive then
  begin
    DataSetGetFieldValues(DataLink.DataSet, KeyFields, KeyValue);
    if LookupCache then
      Result := FLookupListCache.ValueOfKey(KeyValue)
    else if (LookupDataSet <> nil) and LookupDataSet.Active then
      Result := ListLink.DataSet.Lookup(LookupKeyFieldNames, KeyValue, LookupDisplayFieldName);
  end;
end;

procedure TDBLookupDataEh.ListLinkDataChanged;
begin
end;

procedure TDBLookupDataEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if Operation = opRemove then
    if (FLookupLink <> nil) and (AComponent = LookupDataSet) then
      LookupDataSet := nil;
end;

procedure TDBLookupDataEh.SetKeyFieldNames(const Value: String);
begin
  CheckLookupInDataField;
  if FKeyFieldNames <> Value then
  begin
    FKeyFieldNames := Value;
    UpdateDataFields;
  end;
end;

function TDBLookupDataEh.GetLookupDisplayFieldName: String;
begin
  if LookupInDataField
    then Result := TAxisBarEhCrack(FAxisBar).Field.LookupResultField
    else Result := FLookupDisplayFieldName;
end;

function TDBLookupDataEh.GetLookupIsSetUp: Boolean;
begin
  Result := FLookupIsSetUp;
end;

procedure TDBLookupDataEh.SetLookupDisplayFieldName(const Value: String);
begin
  CheckLookupInDataField;
  if FLookupDisplayFieldName <> Value then
  begin
    FLookupDisplayFieldName := Value;
    UpdateListFields;
  end;
end;

function TDBLookupDataEh.GetDataLink: TDataSourceLinkEh;
begin
  Result := TDataSourceLinkEh(FDataLink);
end;

function TDBLookupDataEh.GetDataSource: TDataSource;
begin
  Result := TAxisBarEhCrack(FAxisBar).Grid.DataSource;
end;

function TDBLookupDataEh.GetKeyFieldNames: String;
begin
  if LookupInDataField and (TAxisBarEhCrack(FAxisBar).FField <> nil)
    then Result := TAxisBarEhCrack(FAxisBar).FField.KeyFields
    else Result := FKeyFieldNames;
end;

function TDBLookupDataEh.GetKeyFields: TFieldsArrEh;
begin
  Result := FKeyFields;
end;

function TDBLookupDataEh.GetLookupDisplayField: TField;
begin
  Result := FLookupDisplayField;
end;

function TDBLookupDataEh.GetLookupKeyFields: TFieldsArrEh;
begin
  Result := FLookupKeyFields;
end;

function TDBLookupDataEh.GetLookupActive: Boolean;
begin
  Result := FLookupActive;
end;

procedure TDBLookupDataEh.SetLookupDataSet(const Value: TDataSet);
begin
  CheckLookupInDataField;
  if FLookupDataSet <> Value then
  begin
    FLookupDataSet := Value;
    UpdateListLinkDataSource;
    if Value <> nil then
      Value.FreeNotification(TAxisBarEh(FAxisBar).Grid);
  end;
end;

function TDBLookupDataEh.GetLookupDataSet: TDataSet;
begin
  if LookupInDataField and (TAxisBarEhCrack(FAxisBar).FField <> nil)
    then Result := TAxisBarEhCrack(FAxisBar).FField.LookupDataSet
    else Result := FLookupDataSet;
end;

function TDBLookupDataEh.GetOwner: TPersistent;
begin
  Result := FAxisBar;
end;

procedure TDBLookupDataEh.Assign(Source: TPersistent);
var
  SourceLD: TDBLookupDataEh;
begin
  if Source is TDBLookupDataEh then
  begin
    SourceLD := TDBLookupDataEh(Source);
    KeyFieldNames := SourceLD.KeyFieldNames;
    LookupCache := SourceLD.LookupCache;
    LookupDataSet := SourceLD.LookupDataSet;
    LookupDisplayFieldName := SourceLD.LookupDisplayFieldName;
    LookupKeyFieldNames := SourceLD.LookupKeyFieldNames;
  end
  else
    inherited Assign(Source);
end;

procedure TDBLookupDataEh.SetLookupCache(const Value: Boolean);
begin
  if FLookupCache <> Value then
  begin
    FLookupCache := Value;
    RefreshLookupListCache;
  end;
end;

procedure TDBLookupDataEh.RefreshLookupListCache;
var
  WasActive: Boolean;
begin
  FLookupListCache.Clear;

  if LookupListActive and LookupCache then
  begin
    WasActive := LookupDataSet.Active;
    try
      LookupDataSet.DisableControls;
      try
        LookupDataSet.First;
        while not LookupDataSet.Eof do
        begin
          FLookupListCache.Add(
            LookupDataSet.FieldValues[LookupKeyFieldNames],
            LookupDataSet.FieldValues[LookupDisplayFieldName]);
          LookupDataSet.Next;
        end;
      finally
        LookupDataSet.EnableControls;
      end;
      FLookupListCache.SortData;
    finally
      LookupDataSet.Active := WasActive;
    end;
  end;
end;

function TDBLookupDataEh.LookupDataIsStored: Boolean;
begin
  Result := not LookupInDataField;
end;

{ TLookupListEh }

constructor TLookupListEh.Create;
begin
  inherited Create;
  FList := TList.Create;
end;

destructor TLookupListEh.Destroy;
begin
  Clear;
  FreeAndNil(FList);
  inherited Destroy;
end;

procedure TLookupListEh.Add(const AKeyValue, ADisplayValue: Variant);
var
  LookupPair: PLookupPairEh;
begin
  New(LookupPair);
  LookupPair.KeyValue := AKeyValue;
  LookupPair.DisplayValue := ADisplayValue;
  FList.Add(LookupPair);
end;

procedure TLookupListEh.Clear;
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
    Dispose(PLookupPairEh(FList.Items[I]));
  FList.Clear;
end;

function TLookupListEh.ValueOfKey(const AKeyValue: Variant): Variant;
var
  Idx: Integer;
begin
  if FindKeyValueIndex(AKeyValue, Idx) then
    Result :=PLookupPairEh(FList[Idx]).DisplayValue;
end;

function TLookupListEh.FindKeyValueIndex(const KeyValue: Variant; var Index: Integer): Boolean;
var
  L, H, I: Integer;
  C: TVariantRelationship;
begin
  Result := False;
  L := 0;
  H := FList.Count - 1;
  while L <= H do
  begin
    I := (L + H) shr 1;
    C := DBVarCompareValue(PLookupPairEh(FList[i]).KeyValue, KeyValue);
    if C = vrNotEqual then
      raise Exception.Create('TMTIndexEh.FindKeyValueIndex: values is not comparable.');
    if C = vrLessThan then
      L := I + 1
    else
    begin
      H := I - 1;
      if C = vrEqual then
      begin
        Result := True;
        {if Duplicates <> dupAccept then} L := I;
      end;
    end;
  end;
  Index := L;
end;

procedure TLookupListEh.QuickSort(L, R: Integer);
var
  I, J, P: Integer;
begin
  repeat
    I := L;
    J := R;
    P := (L + R) shr 1;
    repeat
      while DBVarCompareValue(
              PLookupPairEh(FList[I]).KeyValue,
              PLookupPairEh(FList[P]).KeyValue) = vrLessThan do
        Inc(I);
      while DBVarCompareValue(
              PLookupPairEh(FList[J]).KeyValue,
              PLookupPairEh(FList[P]).KeyValue) = vrGreaterThan do
        Dec(J);
      if I <= J then
      begin
        FList.Exchange(I, J);
        if P = I then
          P := J
        else if P = J then
          P := I;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then QuickSort(L, J);
    L := I;
  until I >= R;
end;

procedure TLookupListEh.SortData;
begin
  if FList.Count > 0 then
    QuickSort(0, FList.Count-1);
end;

end.
