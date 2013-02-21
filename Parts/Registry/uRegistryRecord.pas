unit uRegistryRecord;

interface

uses
  Graphics,
  uRegistryDataSet;

type
  TRegistryRecord = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    function GetId: Integer;
    function GetKey: String;
    procedure SetKey(AValue: String);
    function GetValue: String;
    procedure SetValue(AValue: String);
    function GetValueAsBoolean: Boolean;
    procedure SetValueAsBoolean(AValue: Boolean);
    function GetValueAsInteger: Integer;
    procedure SetValueAsInteger(AValue: Integer);
    function GetValueAsInt64: Int64;
    procedure SetValueAsInt64(AValue: Int64);
    function GetValueAsDouble: Double;
    procedure SetValueAsDouble(AValue: Double);
  public
    constructor Create(ARegistryDataSet: TRegistryDataSet);

    // Public property
    property Id: Integer
        read GetId;
    property Key: String
        read GetKey write SetKey;
    property Value: String
        read GetValue write SetValue;
    property ValueAsBoolean: Boolean
        read GetValueAsBoolean write SetValueAsBoolean;
    property ValueAsInteger: Integer
        read GetValueAsInteger write SetValueAsInteger;
    property ValueAsInt64: Int64
        read GetValueAsInt64 write SetValueAsInt64;
    property ValueAsDouble: Double
        read GetValueAsDouble write SetValueAsDouble;

    function GetValueStringEx(AstrKey: String;
        AstrDefaultValue: String): String;
    procedure SetValueStringEx(AstrKey: String; AValue: String;
        AstrDefaultValue: String);
    function GetValueAsBooleanEx(AstrKey: String;
        AstrDefaultValue: Boolean): Boolean;
    procedure SetValueAsBooleanEx(AstrKey: String; AValue: Boolean;
        AstrDefaultValue: Boolean);
    function GetValueAsIntegerEx(AstrKey: String;
        AstrDefaultValue: Integer): Integer;
    procedure SetValueAsIntegerEx(AstrKey: String; AValue: Integer;
        AstrDefaultValue: Integer);
    function GetValueAsInt64Ex(AstrKey: String;
        AstrDefaultValue: Int64): Int64;
    procedure SetValueAsInt64Ex(AstrKey: String; AValue: Int64;
        AstrDefaultValue: Int64);
    function GetValueAsDoubleEx(AstrKey: String;
        AstrDefaultValue: Double): Double;
    procedure SetValueAsDoubleEx(AstrKey: String; AValue: Double;
        AstrDefaultValue: Double);

  end;

implementation

uses
  SysUtils,
  Classes,
  uY2KString;

constructor TRegistryRecord.Create(ARegistryDataSet: TRegistryDataSet);
begin
  FRegistryDataSet := ARegistryDataSet;
end;

function TRegistryRecord.GetId: Integer;
begin
  Result := FRegistryDataSet.FieldValues['id'];
end;
function TRegistryRecord.GetKey: String;
begin
  Result := FRegistryDataSet.FieldValues['key'];
end;

procedure TRegistryRecord.SetKey(AValue: String);
begin
  FRegistryDataSet.Edit;
  FRegistryDataSet.FieldValues['key'] := AValue;
  FRegistryDataSet.Post;
end;

function TRegistryRecord.GetValue: String;
begin
  Result := FRegistryDataSet.FieldValues['value'];
end;

procedure TRegistryRecord.SetValue(AValue: String);
begin
  if (FRegistryDataSet.FieldValues['value'] <> AValue) then begin
    FRegistryDataSet.Edit;
    FRegistryDataSet.FieldValues['value'] := AValue;
    FRegistryDataSet.Post;
  end;
end;

function TRegistryRecord.GetValueAsBoolean: Boolean;
begin
  TryStrToBool(GetValue,Result);
end;

procedure TRegistryRecord.SetValueAsBoolean(AValue: Boolean);
begin
  SetValue(BoolToStr(AValue));
end;

function TRegistryRecord.GetValueAsInteger: Integer;
begin
  TryStrToInt(GetValue,Result);
end;

procedure TRegistryRecord.SetValueAsInteger(AValue: Integer);
begin
  SetValue(IntToStr(AValue));
end;

function TRegistryRecord.GetValueAsInt64: Int64;
begin
  TryStrToInt64(GetValue,Result);
end;

procedure TRegistryRecord.SetValueAsInt64(AValue: Int64);
begin
  SetValue(IntToStr(AValue));
end;

function TRegistryRecord.GetValueAsDouble: Double;
begin
  Result := StrToFloatDefWithReplace(GetValue, 0);
end;

procedure TRegistryRecord.SetValueAsDouble(AValue: Double);
begin
  SetValue(FloatToStr(AValue));
end;
// By Napad
function TRegistryRecord.GetValueAsBooleanEx(AstrKey: String;
  AstrDefaultValue: Boolean): Boolean;
begin
  FRegistryDataSet.LocateByKey(AstrKey, BoolToStr(AstrDefaultValue));
  Result := GetValueAsBoolean;
end;

function TRegistryRecord.GetValueAsDoubleEx(AstrKey: String;
  AstrDefaultValue: Double): Double;
begin
  FRegistryDataSet.LocateByKey(AstrKey, FloatToStr(AstrDefaultValue));
  Result := GetValueAsDouble;
end;

function TRegistryRecord.GetValueAsInt64Ex(AstrKey: String;
  AstrDefaultValue: Int64): Int64;
begin
  FRegistryDataSet.LocateByKey(AstrKey, IntToStr(AstrDefaultValue));
  Result := GetValueAsInt64;
end;

function TRegistryRecord.GetValueAsIntegerEx(AstrKey: String;
  AstrDefaultValue: Integer): Integer;
begin
  FRegistryDataSet.LocateByKey(AstrKey, IntToStr(AstrDefaultValue));
  Result := GetValueAsInteger;
end;

function TRegistryRecord.GetValueStringEx(AstrKey,
  AstrDefaultValue: String): String;
begin
  FRegistryDataSet.LocateByKey(AstrKey, AstrDefaultValue);
  Result := GetValue;
end;

procedure TRegistryRecord.SetValueAsBooleanEx(AstrKey: String; AValue,
  AstrDefaultValue: Boolean);
begin
  FRegistryDataSet.LocateByKey(AstrKey, BoolToStr(AstrDefaultValue));
  SetValueAsBoolean(AValue);
end;

procedure TRegistryRecord.SetValueAsDoubleEx(AstrKey: String; AValue,
  AstrDefaultValue: Double);
begin
  FRegistryDataSet.LocateByKey(AstrKey, FloatToStr(AstrDefaultValue));
  SetValueAsDouble(AValue);
end;

procedure TRegistryRecord.SetValueAsInt64Ex(AstrKey: String; AValue,
  AstrDefaultValue: Int64);
begin
  FRegistryDataSet.LocateByKey(AstrKey, IntToStr(AstrDefaultValue));
  SetValueAsInt64 (AValue);
end;

procedure TRegistryRecord.SetValueAsIntegerEx(AstrKey: String; AValue,
  AstrDefaultValue: Integer);
begin
  FRegistryDataSet.LocateByKey(AstrKey, IntToStr(AstrDefaultValue));
  SetValueAsInteger(AValue);
end;

procedure TRegistryRecord.SetValueStringEx(AstrKey, AValue,
  AstrDefaultValue: String);
begin
  FRegistryDataSet.LocateByKey(AstrKey, AstrDefaultValue);
  SetValue(AValue);
end;

end.
