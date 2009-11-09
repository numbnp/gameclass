unit uGCDBTools;

interface
uses
  ADODB;

const
  GCDB_GET_BASE_VERSION = 'exec RegistrySelectByKey ''BaseVersion''';
  GCDB_GET_BASE_VERSION_OLD = 'exec RegistrySelect ''BaseVersion''';
  GCDB_REGISTRY_FIELD_VALUE_NAME = 'value';
  GCDB_USE_COMMAND = 'use GameClass';
  GCDB_LOGS_INSERT_COMMAND = 'LogsInsert @prioritet=%d, @message=N''%s'''
    + ', @moment=''%s''';


function GetDatabaseVersion(const AcnnMain: TADOCOnnection;
  var AstrVersion: String): Boolean;
function UseGCDB(const AcnnMain: TADOCOnnection): Boolean;
procedure LogInsert(const AcnnMain: TADOCOnnection;
    const AnLevel: Integer; const AstrEvent: String);


implementation

uses
  SysUtils,
  uSQLTools;

function UseGCDB(const AcnnMain: TADOCOnnection): Boolean;
begin
  Result := dsDoCommand(AcnnMain, GCDB_USE_COMMAND);
end;

function GetDatabaseVersion(const AcnnMain: TADOCOnnection;
  var AstrVersion: String): Boolean;
var
  dsResult: TADODataSet;
begin
  Result := False;
  AstrVersion := '';
  if Assigned(AcnnMain) and AcnnMain.Connected then begin
    dsResult := TADODataSet.Create(Nil);
    try
      uSQLTools.dsDoQuery(AcnnMain, dsResult, GCDB_GET_BASE_VERSION);
      if (dsResult.RecordCount > 0) then
      AstrVersion := dsResult.FieldValues[GCDB_REGISTRY_FIELD_VALUE_NAME];
    except
    end;
    dsResult.Free;
    if Length(AstrVersion) = 0 then begin
      dsResult := TADODataSet.Create(Nil);
      try
        uSQLTools.dsDoQuery(AcnnMain, dsResult, GCDB_GET_BASE_VERSION_OLD);
        if (dsResult.RecordCount > 0) then
          AstrVersion := dsResult.FieldValues[GCDB_REGISTRY_FIELD_VALUE_NAME];
      except
      end;
      dsResult.Free;
      Result := True;
    end else
      Result := True;
  end;
end;

procedure LogInsert(const AcnnMain: TADOCOnnection;
    const AnLevel: Integer; const AstrEvent: String);
var
  strSQLCode: String;
begin
  if (AnLevel = 0) or (AnLevel = 1) then
  begin
    strSQLCode := Format(GCDB_LOGS_INSERT_COMMAND, [AnLevel,
        AstrEvent, DateTimeToSQLStr(Now)]);
    dsDoCommand(AcnnMain, strSQLCode);
  end;
end;

end.
