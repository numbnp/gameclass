unit ufrmDinamicConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ValEdit;

type
  TfrmDinamicConfig = class(TForm)
    lstParameters: TValueListEditor;
    memoInfo: TMemo;
    procedure lstParametersClick(Sender: TObject);
    procedure lstParametersValidate(Sender: TObject; ACol, ARow: Integer;
      const KeyName, KeyValue: String);
    procedure lstParametersKeyPress(Sender: TObject; var Key: Char);
  private
    FstrConfig: String;
    FstrConfigTypes: String;
    FstrParameterSeparator: String;
    FstrKeySeparator: String;
    FstrTypeSeparator: String;
    FlstParameterTypes: TStringList;
    FlstParameterInfo: TStringList;
    procedure _BuildParameterControls;
    procedure _UpdateValues;
    procedure _RebuildConfig;
  public
    constructor Create(AOwner: TComponent); overload;
    constructor Create(const AOwner: TComponent;
        const AstrConfigTypes: String;
        const AstrConfig: String = ''); overload;
    destructor Destroy(); override;
    procedure SetConfig(const AstrConfig: String);
    procedure SetConfigTypes(const AstrConfigTypes: String);

    property Config: String
        read FstrConfig write SetConfig;
    property ConfigTypes: String
        read FstrConfigTypes write SetConfigTypes;
    property ParameterSeparator: String
        read FstrParameterSeparator write FstrParameterSeparator;
    property KeySeparator: String
        read FstrKeySeparator write FstrKeySeparator;
    property TypeSeparator: String
        read FstrTypeSeparator write FstrTypeSeparator;
  end;

implementation

uses
  uY2KString, StrUtils;
{$R *.dfm}

const
  VALUE_YES = 'Да';
  VALUE_NO = 'Нет';

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor
constructor TfrmDinamicConfig.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FstrConfigTypes := '';
  FstrConfig := '';
  FstrParameterSeparator := DEF_PARAMETER_SEPARATOR;
  FstrKeySeparator  := DEF_KEY_SEPARATOR;
  FstrTypeSeparator := DEF_TYPE_SEPARATOR;
  FlstParameterTypes := TStringList.Create;
  FlstParameterInfo := TStringList.Create;
end;

constructor TfrmDinamicConfig.Create(const AOwner: TComponent;
        const AstrConfigTypes: String;
        const AstrConfig: String = '');
begin
  Create(AOwner);
  FstrConfigTypes := AstrConfigTypes;
  FstrConfig := AstrConfig;
  _BuildParameterControls;
  if AstrConfig <> '' then
    _UpdateValues;
  _RebuildConfig;
end;

destructor TfrmDinamicConfig.Destroy();
begin
  FreeAndNil(FlstParameterInfo);
  FreeAndNil(FlstParameterTypes);
  inherited Destroy;
end;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods
procedure TfrmDinamicConfig.SetConfig(const AstrConfig: String);
begin
  FstrConfig := AstrConfig;
  _UpdateValues;
  _RebuildConfig;
end;

procedure TfrmDinamicConfig.SetConfigTypes(const AstrConfigTypes: String);
begin
  FstrConfigTypes := AstrConfigTypes;
  _BuildParameterControls;
  _RebuildConfig;
end;

procedure TfrmDinamicConfig.lstParametersClick(Sender: TObject);
begin
  memoInfo.Text := FlstParameterInfo.Strings[lstParameters.Row - 1];
end;

procedure TfrmDinamicConfig.lstParametersValidate(Sender: TObject; ACol,
  ARow: Integer; const KeyName, KeyValue: String);
var
  strKey, strValue,  strType: String;
  nValue: Integer;
begin
  strKey := FlstParameterTypes.Names[ARow - 1];
  strType := FlstParameterTypes.ValueFromIndex[ARow - 1];
  if strType = TYPE_BOOL then begin
    if KeyValue <> VALUE_YES then
      ReplaceValueInConfig(FstrConfig, strKey, BoolToStr(False))
    else
      ReplaceValueInConfig(FstrConfig, strKey, BoolToStr(True));
  end else if strType = TYPE_LIST then begin
    nValue := lstParameters.ItemProps[ARow - 1].PickList.IndexOf(KeyValue);
    ReplaceValueInConfig(FstrConfig, strKey, IntToStr(nValue));
  end else if strType = TYPE_STRING then begin
    ReplaceValueInConfig(FstrConfig, strKey, strValue);
  end else if strType = TYPE_INT then begin
     nValue := 0;
     TryStrToInt(strValue, nValue);
     ReplaceValueInConfig(FstrConfig, strKey, IntToStr(nValue));
  end;
end;

procedure TfrmDinamicConfig.lstParametersKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    _RebuildConfig;
end;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmDinamicConfig._BuildParameterControls;
var
  strKeyAndValue, strKey, strValue, strParameterName, strType: String;
  i, j, nCount, nTypeCount: Integer;

begin
  FlstParameterTypes.Clear;
  FlstParameterInfo.Clear;
  lstParameters.Strings.Clear;
  nCount := GetParamCountFromString(FstrConfigTypes, FstrParameterSeparator);
  // идем с конца т.к. у TValueListEditor есть только Insert
  for i := nCount - 1 downto 0 do begin
    strKeyAndValue := GetParamFromString(FstrConfigTypes, i ,
        FstrParameterSeparator);
    strKey := GetParamFromString(strKeyAndValue, 0, FstrKeySeparator);
    strParameterName := GetParamFromString(strKey, 0, FstrTypeSeparator);
    lstParameters.InsertRow(GetParamFromString(strKey, 1, FstrTypeSeparator),
        '', False);
    FlstParameterTypes.Insert(0, strParameterName + '=');
    FlstParameterInfo.Insert(0, GetParamFromString(strKey, 2,
        FstrTypeSeparator));
    strValue := GetParamFromString(strKeyAndValue, 1, FstrKeySeparator);
    nTypeCount := GetParamCountFromString(strValue, FstrTypeSeparator);
    strType := GetParamFromString(strValue, 0, FstrTypeSeparator);
    FlstParameterTypes.ValueFromIndex[0] := strType;
    if strType = TYPE_BOOL then begin
      lstParameters.ItemProps[0].EditStyle := esPickList;
      lstParameters.ItemProps[0].ReadOnly := true;
      lstParameters.ItemProps[0].PickList.Add(VALUE_YES);
      lstParameters.ItemProps[0].PickList.Add(VALUE_NO);
    end else if strType = TYPE_LIST then begin
      lstParameters.ItemProps[0].EditStyle := esPickList;
      lstParameters.ItemProps[0].ReadOnly := true;
      for j := 1 to nTypeCount - 1 do
        lstParameters.ItemProps[0].PickList.Add(
            GetParamFromString(strValue, j, FstrTypeSeparator));
    end else if strType = TYPE_STRING then begin
    end else if strType = TYPE_INT then begin
    end
  end;
end;

procedure TfrmDinamicConfig._UpdateValues;
var
  strKeyAndValue, strKey, strValue, strType: String;
  i, nCount, nParameterIndex, nValue: Integer;

begin
  nCount := GetParamCountFromString(FstrConfig, FstrParameterSeparator);
  for i := 0 to nCount - 1 do begin
    strKeyAndValue := GetParamFromString(FstrConfig, i ,
        FstrParameterSeparator);
    strKey := GetParamFromString(strKeyAndValue, 0, FstrKeySeparator);
    strValue := GetParamFromString(strKeyAndValue, 1, FstrKeySeparator);
    nParameterIndex := FlstParameterTypes.IndexOfName(strKey);
    if nParameterIndex <> -1 then begin
      strType := FlstParameterTypes.ValueFromIndex[nParameterIndex];
      nValue := 0;
      if strType <> TYPE_STRING then
        TryStrToInt(strValue, nValue);
      if strType = TYPE_BOOL then begin
        if strValue <> BoolToStr(False) then
          lstParameters.Values[lstParameters.Keys[nParameterIndex + 1]] :=
              VALUE_YES
        else
          lstParameters.Values[lstParameters.Keys[nParameterIndex + 1]] :=
              VALUE_NO;
      end else if strType = TYPE_LIST then begin
        lstParameters.Values[lstParameters.Keys[nParameterIndex + 1]] :=
            lstParameters.ItemProps[nParameterIndex].PickList.Strings[
            nValue];
      end else if strType = TYPE_STRING then begin
        lstParameters.Values[lstParameters.Keys[nParameterIndex + 1]] :=
            strValue;
      end else if strType = TYPE_INT then begin
        lstParameters.Values[lstParameters.Keys[nParameterIndex + 1]] :=
            IntToStr(nValue);
      end;
    end;
  end;
end;

procedure TfrmDinamicConfig._RebuildConfig;
var
  strKey, strValue, strType: String;
  i, nValue: Integer;
  strConfig: String;
begin
  strConfig := '';
  for i := 0 to FlstParameterTypes.Count - 1 do begin
    strKey := FlstParameterTypes.Names[i];
    strType := FlstParameterTypes.ValueFromIndex[i];
    strValue := lstParameters.Values[lstParameters.Keys[i + 1]];
    strConfig := strConfig + DEF_PARAMETER_SEPARATOR + strKey
        + DEF_KEY_SEPARATOR;
    if strType = TYPE_BOOL then begin
      if strValue <> VALUE_YES then
        strConfig := strConfig + BoolToStr(False)
      else
        strConfig := strConfig + BoolToStr(True);
    end else if strType = TYPE_LIST then begin
      nValue := lstParameters.ItemProps[i].PickList.IndexOf(strValue);
      strConfig := strConfig + IntToStr(nValue);
    end else if strType = TYPE_STRING then begin
      strConfig := strConfig + strValue;
    end else if strType = TYPE_INT then begin
       nValue := 0;
       TryStrToInt(strValue, nValue);
       strConfig := strConfig + IntToStr(nValue);
    end;
  end;
  strConfig := AnsiRightStr(strConfig, Length(strConfig) - 1);
end;

end. ////////////////////////// end of file //////////////////////////////////


