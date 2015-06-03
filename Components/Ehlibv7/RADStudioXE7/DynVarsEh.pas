{*******************************************************}
{                                                       }
{                     EhLib v7.0                        }
{              Realizatoion Collection of               }
{                 Dynamic Variables                     }
{                   (Build 7.0.02)                      }
{                                                       }
{        Copyright (c) 2012 by EhLib Team and           }
{                Dmitry V. Bolshakov                    }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DynVarsEh;


interface

uses
  Classes, SysUtils, Variants;

type
  TCustomDynVarsEh = class;
  TDynVarsEh = class;

  IDynParamsInteractableEh = interface
   ['{6ECDE882-A30A-4D34-9C4F-6618FB50CB76}']
//    function GetValues: TStrings;
    procedure SetInDynParams(DynParams: TDynVarsEh);
    procedure GetOutDynParams(var DynParams: TDynVarsEh);
  end;

{ TCustomDynVarEh }

  TCustomDynVarEh = class(TCollectionItem)
  private
    FData : Variant;
    FIsDummy: Boolean;
    FName: string;
    FOwnerWhenDummy: TCustomDynVarsEh;
    function GetAsBoolean: Boolean;
    function GetAsCurrency: Currency;
    function GetAsDateTime: TDateTime;
    function GetAsFloat: Double;
    function GetAsInteger: Longint;
    function GetAsRefObject: TObject;
    function GetAsString: string;
    function GetIsNull: Boolean;
    function IsEqual(Value: TCustomDynVarEh): Boolean;
    procedure SetAsBoolean(Value: Boolean);
    procedure SetAsCurrency(const Value: Currency);
    procedure SetAsDateTime(const Value: TDateTime);
    procedure SetAsFloat(const Value: Double);
    procedure SetAsInteger(Value: Longint);
    procedure SetAsRefObject(const Value: TObject);
    procedure SetAsString(const Value: string);
    procedure SetData(const Value: Variant);
    procedure SetName(const Value: string);
  protected
    procedure AssignTo(Dest: TPersistent); override;
    property IsDummy: Boolean read FIsDummy;

    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsCurrency: Currency read GetAsCurrency write SetAsCurrency;
    property AsDateTime: TDateTime read GetAsDateTime write SetAsDateTime;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsInteger: LongInt read GetAsInteger write SetAsInteger;
    property AsRefObject: TObject read GetAsRefObject write SetAsRefObject;
    property AsString: string read GetAsString write SetAsString;
    property IsNull: Boolean read GetIsNull;
    property Name: string read FName write SetName;
    property Value: Variant read FData write SetData;
  public
    constructor Create(Collection: TCollection); overload; override;
    constructor CreateAsDummy(AOwnerWhenDummy: TCustomDynVarsEh); overload;
    destructor Destroy; override;

    function VarCollection: TCustomDynVarsEh;
    procedure Clear;
  end;

  TCustomDynVarClassEh = class of TCustomDynVarEh;

{ TDynVarEh }

  TDynVarEh = class(TCustomDynVarEh)
  public
    property AsBoolean;
    property AsCurrency;
    property AsDateTime;
    property AsFloat;
    property AsInteger;
    property AsRefObject;
    property AsString;
    property IsNull;
  published
    property Name;
    property Value;
  end;

{ TCustomDynVarsEh }

  TCustomDynVarsEh = class(TCollection)
  private
    FDummyVar: TCustomDynVarEh;
    FOwner: TPersistent;
    FOnChange: TNotifyEvent;
    function GetDynVar(const VarName: string): TCustomDynVarEh;
    function GetItem(Index: Integer): TCustomDynVarEh;
    procedure DeleteDynVar(DynVar: TCustomDynVarEh); overload;
    procedure SetItem(Index: Integer; Value: TCustomDynVarEh);
  protected
    function GetInitDummyVar(AVarName: String): TCustomDynVarEh;
    function GetOwner: TPersistent; override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure CreateDynVarFromDummy(ADummyVar: TCustomDynVarEh);
    procedure Update(Item: TCollectionItem); override;
    property DummyVar: TCustomDynVarEh read FDummyVar;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  public
    constructor Create(Owner: TPersistent); overload;
    destructor Destroy; override;

    function GetDynVarClass: TCustomDynVarClassEh; virtual;
    function CreateDynVar(const VarName: string; const AValue: TObject): TCustomDynVarEh; overload;
    function CreateDynVar(const VarName: string; const AValue: Variant): TCustomDynVarEh; overload;
    function FindDynVar(const VarName: string) : TCustomDynVarEh;
    function IsEqual(Value: TCustomDynVarsEh): Boolean;
    function VarExists(const VarName: string): Boolean;

    procedure AddDynVar(Value: TCustomDynVarEh);
    procedure AssignValues(Value: TCustomDynVarsEh);
    procedure DeleteDynVar(const VarName: string); overload;
    procedure RemoveDynVar(Value: TCustomDynVarEh);

    property Items[Index: Integer]: TCustomDynVarEh read GetItem write SetItem;
    property DynVar[const VarName: string]: TCustomDynVarEh read GetDynVar; default;
  end;

  TCustomDynVarsClassEh = class of TCustomDynVarsEh;

{ TDynVarsEh }

  TDynVarsEh = class(TCustomDynVarsEh)
  private
    function GetDynVar(const VarName: string): TDynVarEh;
    function GetItem(Index: Integer): TDynVarEh;
    procedure SetItem(Index: Integer; Value: TDynVarEh);
  public
    function CreateDynVar(const VarName: string; const AValue: TObject): TDynVarEh; overload;
    function CreateDynVar(const VarName: string; const AValue: Variant): TDynVarEh; overload;
    function FindDynVar(const VarName: string) : TDynVarEh;
    function GetDynVarClass: TCustomDynVarClassEh; override;
    property Items[Index: Integer]: TDynVarEh read GetItem write SetItem;
    property DynVar[const VarName: string]: TDynVarEh read GetDynVar; default;
  end;

{ TStringVarEh }

  TStringVarEh = class(TCustomDynVarEh)
  private
    function GetValue: String;
    procedure SetValue(const Value: String);
  public
  published
    property Name;
    property Value: String read GetValue write SetValue;
  end;

{ TStringVarsEh }

  TStringVarsEh = class(TCustomDynVarsEh)
  private
    function GetItem(Index: Integer): TStringVarEh;
    procedure SetItem(Index: Integer; Value: TStringVarEh);
    function GetVarValue(const VarName: string): String;
    procedure SetVarValue(const VarName, Value: String);
  public
    function CreateDynVar(const VarName: string; const AValue: String): TStringVarEh; overload;
    function FindDynVar(const VarName: string) : TStringVarEh;
    function GetDynVarClass: TCustomDynVarClassEh; override;
    function GetAsTextString: String;
    procedure SetFromTextString(const TextString: String);
    property Items[Index: Integer]: TStringVarEh read GetItem write SetItem;
    property Str[const VarName: string]: String read GetVarValue write SetVarValue; default;
    property OnChange;
  end;

implementation

uses EhLibConsts;

{ TCustomDynVarEh }

constructor TCustomDynVarEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FData := Unassigned;
end;

constructor TCustomDynVarEh.CreateAsDummy(AOwnerWhenDummy: TCustomDynVarsEh);
begin
  inherited Create(nil);
  FIsDummy := True;
  FOwnerWhenDummy := AOwnerWhenDummy;
end;

destructor TCustomDynVarEh.Destroy;
begin
  inherited Destroy;
end;

procedure TCustomDynVarEh.Clear;
begin
  FData := Unassigned;
end;

function TCustomDynVarEh.IsEqual(Value: TCustomDynVarEh): Boolean;
begin
  Result := (VarType(FData) = VarType(Value.FData)) and
    (VarIsClear(FData) or (FData = Value.FData)) and
    (Name = Value.Name) and (IsNull = Value.IsNull);
end;

function TCustomDynVarEh.GetIsNull: Boolean;
begin
  Result := (FData = Unassigned) or VarIsNull(FData) or VarIsClear(FData);
end;

procedure TCustomDynVarEh.SetAsBoolean(Value: Boolean);
begin
  if IsDummy then
    FOwnerWhenDummy.CreateDynVarFromDummy(Self);
  Self.Value := Value;
end;

function TCustomDynVarEh.GetAsBoolean: Boolean;
begin
  if IsNull
    then Result := False
    else Result := FData;
end;

procedure TCustomDynVarEh.SetAsDateTime(const Value: TDateTime);
begin
  if IsDummy then
    FOwnerWhenDummy.CreateDynVarFromDummy(Self);
  Self.Value := Value;
end;

function TCustomDynVarEh.GetAsDateTime: TDateTime;
begin
  if IsNull
    then Result := 0
    else Result := VarToDateTime(FData);
end;

procedure TCustomDynVarEh.SetAsFloat(const Value: Double);
begin
  if IsDummy then
    FOwnerWhenDummy.CreateDynVarFromDummy(Self);
  Self.Value := Value;
end;

function TCustomDynVarEh.GetAsFloat: Double;
begin
  if IsNull
    then Result := 0
    else  Result := FData;
end;

procedure TCustomDynVarEh.SetAsCurrency(const Value: Currency);
begin
  if IsDummy then
    FOwnerWhenDummy.CreateDynVarFromDummy(Self);
  Self.Value := Value;
end;

function TCustomDynVarEh.GetAsCurrency: Currency;
begin
  if IsNull
    then Result := 0
    else Result := FData;
end;

function TCustomDynVarEh.GetAsInteger: Longint;
begin
  if IsNull
    then Result := 0
    else Result := FData;
end;

procedure TCustomDynVarEh.SetAsInteger(Value: Longint);
begin
  if IsDummy then
    FOwnerWhenDummy.CreateDynVarFromDummy(Self);
  Self.Value := Value;
end;

function TCustomDynVarEh.GetAsRefObject: TObject;
begin
  Result := TObject(AsInteger);
end;

procedure TCustomDynVarEh.SetAsRefObject(const Value: TObject);
begin
  if IsDummy then
    FOwnerWhenDummy.CreateDynVarFromDummy(Self);
  AsInteger := Integer(Value);
end;

procedure TCustomDynVarEh.SetAsString(const Value: string);
begin
  if IsDummy then
    FOwnerWhenDummy.CreateDynVarFromDummy(Self);
  FData := Value;
end;

procedure TCustomDynVarEh.SetData(const Value: Variant);
begin
  if IsDummy then
    FOwnerWhenDummy.CreateDynVarFromDummy(Self);
  FData := Value;
  Changed(False);
end;

procedure TCustomDynVarEh.SetName(const Value: string);
var
  ADinVar: TCustomDynVarEh;
begin
  ADinVar := VarCollection.FindDynVar(Value);
  if (ADinVar <> nil) and (ADinVar <> Self) then
    raise Exception.CreateResFmt(@SDuplicateVarNameEh, [Value]);
  if IsDummy then
    FOwnerWhenDummy.CreateDynVarFromDummy(Self);
  FName := Value;
  Changed(False);
end;

function TCustomDynVarEh.GetAsString: string;
begin
  Result := VarToStr(FData);
end;

procedure TCustomDynVarEh.AssignTo(Dest: TPersistent);
begin
  if Dest is TCustomDynVarEh then
  begin
    TCustomDynVarEh(Dest).Name := Name;
    TCustomDynVarEh(Dest).Value := FData;
  end else inherited AssignTo(Dest);
end;

function TCustomDynVarEh.VarCollection: TCustomDynVarsEh;
begin
  Result := TCustomDynVarsEh(Collection);
end;

{ TCustomDynVarsEh }

constructor TCustomDynVarsEh.Create(Owner: TPersistent);
begin
  FOwner := Owner;
  inherited Create(GetDynVarClass);
  FDummyVar := GetDynVarClass.CreateAsDummy(Self);
end;

destructor TCustomDynVarsEh.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FDummyVar);
end;

procedure TCustomDynVarsEh.CreateDynVarFromDummy(ADummyVar: TCustomDynVarEh);
begin
  if ADummyVar <> FDummyVar then
    raise Exception.Create('DummyVar must be same as collection DummyVar');

  AddDynVar(FDummyVar);
  FDummyVar.FIsDummy := False;
  FDummyVar.FOwnerWhenDummy := nil;

  FDummyVar := GetDynVarClass.CreateAsDummy(Self);
end;

function TCustomDynVarsEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

procedure TCustomDynVarsEh.AssignValues(Value: TCustomDynVarsEh);
var
  I: Integer;
  P: TCustomDynVarEh;
begin
  for I := 0 to Value.Count - 1 do
  begin
    P := FindDynVar(Value.Items[I].Name);
    if P <> nil then
      P.Assign(Items[I]);
  end;
end;

function TCustomDynVarsEh.GetInitDummyVar(AVarName: String): TCustomDynVarEh;
begin
  FDummyVar.FName := AVarName;
  Result := FDummyVar;
end;

function TCustomDynVarsEh.GetItem(Index: Integer): TCustomDynVarEh;
begin
  Result := TDynVarEh(inherited Items[Index]);
end;

procedure TCustomDynVarsEh.SetItem(Index: Integer; Value: TCustomDynVarEh);
begin
  inherited SetItem(Index, TCollectionItem(Value));
end;

procedure TCustomDynVarsEh.AddDynVar(Value: TCustomDynVarEh);
begin
  if Assigned(FindDynVar(Value.Name)) then
    raise Exception.CreateResFmt(@SDuplicateVarNameEh, [Value.Name])
  else
    Value.Collection := Self;
end;

procedure TCustomDynVarsEh.RemoveDynVar(Value: TCustomDynVarEh);
begin
  if Value.Collection = Self then
    Value.Collection := nil;
end;

function TCustomDynVarsEh.IsEqual(Value: TCustomDynVarsEh): Boolean;
var
  I: Integer;
begin
  Result := Count = Value.Count;
  if Result then
    for I := 0 to Count - 1 do
    begin
      Result := Items[I].IsEqual(Value.Items[I]);
      if not Result then Break;
    end
end;

procedure TCustomDynVarsEh.AssignTo(Dest: TPersistent);
begin
  if Dest is TCustomDynVarsEh
    then TCustomDynVarsEh(Dest).Assign(Self)
    else inherited AssignTo(Dest);
end;

procedure TCustomDynVarsEh.DeleteDynVar(DynVar: TCustomDynVarEh);
begin
  if Assigned(DynVar) then
    DynVar.Free;
end;

function TCustomDynVarsEh.CreateDynVar(const VarName: string; const AValue: Variant): TCustomDynVarEh;
begin
  Result := FindDynVar(VarName);
  if Assigned(Result) then
    raise Exception.CreateResFmt(@SDuplicateVarNameEh, [VarName])
  else
    begin
      Result := Add as TCustomDynVarEh;
      Result.Name := VarName;
      Result.Value := AValue;
    end;
end;

function TCustomDynVarsEh.CreateDynVar(const VarName: string; const AValue: TObject): TCustomDynVarEh;
begin
  Result := CreateDynVar(VarName, Integer(AValue));
end;

procedure TCustomDynVarsEh.DeleteDynVar(const VarName: string);
var
  DynVar : TCustomDynVarEh;
begin
  DynVar := FindDynVar(VarName);
  if DynVar <> nil then
    DeleteDynVar(DynVar);
end;

function TCustomDynVarsEh.FindDynVar(const VarName: string): TCustomDynVarEh;
var
  I: Integer;
begin
  for I := 0 to Count - 1 do
  begin
    Result := TDynVarEh(inherited Items[I]);
    if SameText(Result.Name, VarName) then
      Exit;
  end;
  Result := nil;
end;

function TCustomDynVarsEh.VarExists(const VarName: string): Boolean;
begin
  Result := (FindDynVar(VarName) <> nil);
end;

function TCustomDynVarsEh.GetDynVar(const VarName: string) : TCustomDynVarEh;
var
  DynVar : TCustomDynVarEh;
begin
  DynVar := FindDynVar(VarName);
  if DynVar <> nil then
    Result := DynVar
  else
    Result := GetInitDummyVar(VarName);
//    raise Exception.Create('Var ''' + VarName + ''' does not exist!');
end;

function TCustomDynVarsEh.GetDynVarClass: TCustomDynVarClassEh;
begin
  Result := TCustomDynVarEh;
end;

procedure TCustomDynVarsEh.Update(Item: TCollectionItem);
begin
  if Assigned(OnChange) then
    OnChange(Self);
end;

{ TDynVarsEh }

function TDynVarsEh.GetDynVarClass: TCustomDynVarClassEh;
begin
  Result := TDynVarEh;
end;

function TDynVarsEh.GetDynVar(const VarName: string): TDynVarEh;
begin
  Result := TDynVarEh(inherited DynVar[VarName]);
end;

function TDynVarsEh.GetItem(Index: Integer): TDynVarEh;
begin
  Result := TDynVarEh(inherited Items[Index]);
end;

procedure TDynVarsEh.SetItem(Index: Integer; Value: TDynVarEh);
begin
  inherited Items[Index] := Value;
end;

function TDynVarsEh.CreateDynVar(const VarName: string; const AValue: TObject): TDynVarEh;
begin
  Result := TDynVarEh(inherited CreateDynVar(VarName, AValue));
end;

function TDynVarsEh.CreateDynVar(const VarName: string; const AValue: Variant): TDynVarEh;
begin
  Result := TDynVarEh(inherited CreateDynVar(VarName, AValue));
end;

function TDynVarsEh.FindDynVar(const VarName: string): TDynVarEh;
begin
  Result := TDynVarEh(inherited FindDynVar(VarName));
end;

{ TStringVarEh }

function TStringVarEh.GetValue: String;
begin
  Result := VarToStr(inherited Value);
end;

procedure TStringVarEh.SetValue(const Value: String);
begin
  inherited Value := Value;
end;

{ TStringVarsEh }

function TStringVarsEh.CreateDynVar(const VarName, AValue: String): TStringVarEh;
begin
  Result := FindDynVar(VarName);
  if Assigned(Result) then
    raise Exception.CreateResFmt(@SDuplicateVarNameEh, [VarName])
  else
    begin
      Result := Add as TStringVarEh;
      Result.Name := VarName;
      Result.Value := AValue;
    end;
end;

function TStringVarsEh.FindDynVar(const VarName: string): TStringVarEh;
begin
  Result := TStringVarEh(inherited FindDynVar(VarName));
end;

function TStringVarsEh.GetDynVarClass: TCustomDynVarClassEh;
begin
  Result := TStringVarEh;
end;

function TStringVarsEh.GetItem(Index: Integer): TStringVarEh;
begin
  Result := TStringVarEh(inherited Items[Index]);
end;

procedure TStringVarsEh.SetItem(Index: Integer; Value: TStringVarEh);
begin
  inherited Items[Index] := Value;
end;

function TStringVarsEh.GetVarValue(const VarName: string): String;
var
  AVar: TStringVarEh;
begin
  AVar := FindDynVar(VarName);
  if Assigned(AVar) then
    raise Exception.CreateFmt('A Variable named ''%s'' doesn''t exist in the Collection ''%s''', [VarName, TStringVarsEh.ClassName])
  else
    Result := AVar.Value;
end;

procedure TStringVarsEh.SetVarValue(const VarName, Value: String);
var
  AVar: TStringVarEh;
begin
  AVar := FindDynVar(VarName);
  if not Assigned(AVar) then
    raise Exception.CreateFmt('A Variable named ''%s'' doesn''t exist in the Collection ''%s''', [VarName, TStringVarsEh.ClassName])
  else
    AVar.Value := Value;
end;

function TStringVarsEh.GetAsTextString: String;
var
  i: Integer;
  sl: TStringList;
begin
  sl := TStringList.Create;
  for i := 0 to Count-1 do
    sl.Add(Items[i].Name + '=' + Items[i].Value);
  Result := sl.Text;
  sl.Free;
end;

procedure TStringVarsEh.SetFromTextString(const TextString: String);
var
  i: Integer;
  sl: TStringList;
begin
  BeginUpdate;
  try
    Clear;
    sl := TStringList.Create;
    sl.Text := TextString;
    for i := 0 to sl.Count-1 do
      CreateDynVar(sl.Names[i], sl.ValueFromIndex[i]);
    sl.Free;
  finally
    EndUpdate;
  end;
end;

end.
