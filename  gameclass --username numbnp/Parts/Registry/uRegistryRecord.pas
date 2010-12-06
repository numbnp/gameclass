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
end.
