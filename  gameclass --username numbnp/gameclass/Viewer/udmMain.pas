unit udmMain;

interface

uses
  SysUtils, Classes, DB, ADODB, DBClient;

type
  TdmMain = class(TDataModule)
    cnnMain: TADOConnection;
    dstFreeComps: TADOQuery;
    dsrcFreeComps: TDataSource;
    dstClubName: TADOQuery;
    dstClubNameValue: TStringField;
    dsrcCompStates: TDataSource;
    dstCompStateGroups: TADOQuery;
    dstSessionsSelect84: TADOStoredProc;
    dstCompsSelect: TADOStoredProc;
    dstCompStates: TADODataSet;
    dstCompRelease: TADODataSet;
    dsrcCompRelease: TDataSource;
    dstTimes: TADODataSet;
    dsrcCompStatesSecond: TDataSource;
    dstCompStatesSecond: TADODataSet;
    dstIsManager: TADOQuery;
    dstSessionsSelect85: TADOStoredProc;
    dstBaseVersionSelect: TADOQuery;
  public
    dstSessionsSelect: TADOStoredProc;
    function GetClubName: String;
    function IsManager(AcnnServer: TADOConnection): Boolean;
    function GetBaseVersion(AcnnServer: TADOConnection): String;
    procedure SetSessionsSelect(AcnnServer: TADOConnection);
    procedure SetSessionsSelectMoment(const AdtMoment: TDateTime);
  end;

var
  dmMain: TdmMain;

implementation

uses
  uY2KString;
{$R *.dfm}

function TdmMain.GetClubName: String;
begin
  Result := '';
  if Assigned(cnnMain) and cnnMain.Connected then
    try
      dstClubName.Open;
      Result := dstClubName.FieldValues['Value'];
    except
    end;
end;

function TdmMain.IsManager(AcnnServer: TADOConnection): Boolean;
begin
  Result := False;
  if Assigned(AcnnServer) and AcnnServer.Connected then
    try
      dstIsManager.Connection := AcnnServer;
      dstIsManager.Open;
      Result := (dstIsManager.FieldValues['value'] <> 0);
      dstIsManager.Close;
    except
    end;
end;

function TdmMain.GetBaseVersion(AcnnServer: TADOConnection): String;
begin
  Result := '';
  if Assigned(AcnnServer) and AcnnServer.Connected then
    try
      dstBaseVersionSelect.Connection := AcnnServer;
      dstBaseVersionSelect.Open;
      Result := dstBaseVersionSelect.FieldValues['value'];
      dstBaseVersionSelect.Close;
    except
    end;
end;

procedure TdmMain.SetSessionsSelect(AcnnServer: TADOConnection);
var
  fVersion: Double;
begin
  fVersion := StrToFloatDefWithReplace(GetBaseVersion(AcnnServer), 0);
  if fVersion >= 3.85 then begin
    dstSessionsSelect := dstSessionsSelect85;
  end else begin
    dstSessionsSelect := dstSessionsSelect84;
  end;
end;

procedure TdmMain.SetSessionsSelectMoment(const AdtMoment: TDateTime);
begin
  if dstSessionsSelect = dstSessionsSelect85 then begin
    dstSessionsSelect.Parameters[2].Value := Now;
  end else begin
    dstSessionsSelect.Parameters[1].Value := Now;
  end;
end;

end.
