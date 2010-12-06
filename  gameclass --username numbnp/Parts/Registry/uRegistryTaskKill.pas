unit uRegistryTaskKill;

interface

uses
  Classes,
  uRegistryRecord,
  uRegistryDataSet,
  uTaskKillConst;

type

  TRegistryTaskKill = class(TObject)
  private
    FRegistryDataSet: TRegistryDataSet;
    FRegistryRecord: TRegistryRecord;
    function LocateTemplate: Boolean;
    function GetTemplate: TStringList;
    procedure SetTemplate(AValue: TStringList);
    function LocateMode: Boolean;
    function GetMode: TTaskKillMode;
    procedure SetMode(AValue: TTaskKillMode);
    function LocateAutoKillMins: Boolean;
    function GetAutoKillMins: Integer;
    procedure SetAutoKillMins(AValue: Integer);

  public
    constructor Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
    destructor Destroy; override;

   property Template: TStringList
        read GetTemplate write SetTemplate;
    property Mode: TTaskKillMode
        read GetMode write SetMode;
    property AutoKillMins: Integer
        read GetAutoKillMins write SetAutoKillMins;
  end;

implementation

uses
  SysUtils,
  DB, uGCDataSet;

{*******************************************************************************
                      class  TRegistryTaskKill
*******************************************************************************}
constructor TRegistryTaskKill.Create(ARegistryDataSet: TRegistryDataSet;
        ARegistryRecord: TRegistryRecord);
begin
  FRegistryDataSet := ARegistryDataSet;
  FRegistryRecord := ARegistryRecord;
end;

destructor TRegistryTaskKill.Destroy;
begin
  inherited Destroy;
end;


function TRegistryTaskKill.LocateTemplate: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('TasksTemplate', 'hl.exe');
end;

function TRegistryTaskKill.GetTemplate: TStringList;
begin
  LocateTemplate;
  // переконвертировать старую
  Result := TStringList.Create;
  Result.Text := FRegistryRecord.Value;
end;

procedure TRegistryTaskKill.SetTemplate(AValue: TStringList);
begin
  LocateTemplate;
  FRegistryRecord.Value := AValue.Text;
end;

function TRegistryTaskKill.LocateMode: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('TasksTemplateMode', '0');
end;

function TRegistryTaskKill.GetMode: TTaskKillMode;
begin
  LocateMode;
  Result := TTaskKillMode(FRegistryRecord.ValueAsInteger);
end;

procedure TRegistryTaskKill.SetMode(AValue: TTaskKillMode);
begin
  LocateMode;
  FRegistryRecord.ValueAsInteger := Integer(AValue);
end;

function TRegistryTaskKill.LocateAutoKillMins: Boolean;
begin
  Result := FRegistryDataSet.LocateByKey('TasksTemplateAutoKillMins', '30');
end;

function TRegistryTaskKill.GetAutoKillMins: Integer;
begin
  LocateAutoKillMins;
  Result := FRegistryRecord.ValueAsInteger;
end;

procedure TRegistryTaskKill.SetAutoKillMins(AValue: Integer);
begin
  LocateAutoKillMins;
  FRegistryRecord.ValueAsInteger := AValue;
end;

end.
