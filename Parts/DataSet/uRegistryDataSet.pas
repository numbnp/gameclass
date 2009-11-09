unit uRegistryDataSet;


interface
uses uGCDataSet, ADODB;

type
  TRegistryDataSet = class(TGCDataSet)
  protected
    function DoSelectAll(
        var AdtsResult: TADODataSet): Boolean; override;
    function DoUpdate(const AnId: Integer): Boolean; override;
    function DoDelete (const AnId: Integer): Boolean; override;
    function DoInsert(var AdtsResult: TADODataSet): Boolean; override;
    function DoSelect(const AnId: Integer;
        var AdtsResult: TADODataSet): Boolean; override;
  public
    function LocateByKey(AstrKey: String;
        AstrDefaultValue: String): Boolean;
    function LocateByKeyWithUserName(AstrKey: String;
        AstrDefaultValue: String): Boolean;
    function IsPresent(AstrKey: String): Boolean;
  end;

implementation

uses
  uSQLTools,
  SysUtils,
  DB,
  gccomputers;

function TRegistryDataSet.DoSelectAll(
    var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult, 'exec RegistrySelect');
end;

function TRegistryDataSet.DoSelect(const AnId: Integer;
  var AdtsResult: TADODataSet): Boolean;
begin
  Result := dsDoQuery(Connection, AdtsResult,
      'exec RegistrySelect @id=' + IntToStr(AnId));
end;

function TRegistryDataSet.DoUpdate(const AnId: Integer): Boolean;
var
  cmd: TADOCommand;
begin
  Result := dsDoCommand(Connection,
      'exec RegistryUpdate @id='+ IntToStr(FieldValues['id'])
      + ', @key=''' + FieldValues['key']
      + ''', @value=''' + FieldValues['value'] + '''');
end;

function TRegistryDataSet.DoDelete(const AnId: Integer): Boolean;
begin
  Result := False;
end;

function TRegistryDataSet.DoInsert(var AdtsResult: TADODataSet): Boolean;
var
  str: String;
begin
{  str :=       'exec RegistryInsert @key=''' + FieldValues['key']
      + ''', @value=''' + FieldValues['value'] + '''';
}  {str :=       'exec RegistryInsert @key=''' + FieldValues['key']
      + ''', @value=''' + FieldValues['value'] + '''';    }
  Result := dsDoQuery(Connection, AdtsResult, 'exec RegistryInsert');
end;

function TRegistryDataSet.LocateByKey(AstrKey: String;
    AstrDefaultValue: String): Boolean;
var
  nId: Integer;
begin
  if Not(Locate('key', AstrKey, [loCaseInsensitive])) then begin
   if Insert(nId) then begin
      Select(nId);
      LocateById(nId);
      Edit;
      FieldValues['key'] := AstrKey;
      FieldValues['value'] := AstrDefaultValue;
      Post;
    end;
{
//    FbEnableInheritedInternalMethods := True;
    //Append;      //переделать инсерт и сделать апдейт
    FieldValues['key'] := AstrKey;
    FieldValues['value'] := AstrDefaultValue;
    Post;
 } end;
  Result := True;
end;

function TRegistryDataSet.LocateByKeyWithUserName(AstrKey: String;
    AstrDefaultValue: String): Boolean;
var
  nId: Integer;
  strKey: String;
begin
  strKey := CurOperatorName + '\'+ AstrKey;
  if Not(Locate('key', strKey, [loCaseInsensitive])) then begin
{    if Insert(nId) then begin
      FRegistryRecord.Key := AstrKey;
      FRegistryRecord.Value := AstrDefaultValue;
    end;
}
    Append;
    if State <> dsInsert then
      Edit;	
    FieldValues['key'] := strKey;
    FieldValues['value'] := AstrDefaultValue;
    Post;
  end;
  Result := True;
end;

function TRegistryDataSet.IsPresent(AstrKey: String): Boolean;
begin
  Result := Locate('key', AstrKey, [loCaseInsensitive]);
end;
end.
