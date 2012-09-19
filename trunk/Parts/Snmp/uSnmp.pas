unit uSnmp;

interface

uses
  GCComputers;

function GetSnmpIntegerValue(Comp:TComputer):integer;
procedure SetSnmpIntegerValue(Comp:TComputer; Value:integer);

implementation

uses
  IdSNMP,
  SysUtils;

function GetSnmpIntegerValue(Comp:TComputer):integer;
var
  SNMP:TIdSNMP;
  iResult:integer;
begin
  iResult := -1;
  Snmp := TIdSNMP.Create(nil);
  Snmp.Query.Clear;
  Snmp.Query.Community := Comp.SNMP_Password;
  Snmp.Query.Version := 0;
  Snmp.Query.Port := 161;
  Snmp.Query.Host := Comp.ipaddr ; //insert your host here...
  Snmp.Query.PDUType := PDUGetRequest;
  Snmp.Query.MIBAdd(Comp.SNMP_MIB_Port,'');
  Snmp.SendQuery;
  if Snmp.Reply.ValueCount >0 then
    iResult := StrToIntDef(Snmp.Reply.Value[0],0);
  Snmp.Free;

  Result := iResult;

end;

procedure SetSnmpIntegerValue(Comp:TComputer; Value:integer);
var
  SNMP:TIdSNMP;
  iResult:integer;
begin
  Snmp := TIdSNMP.Create(nil);
  Snmp.Query.Clear;
  Snmp.Query.Community := Comp.SNMP_Password;
  Snmp.Query.Version := 0;
  Snmp.Query.Host := Comp.ipaddr ; //insert your host here...
  Snmp.Query.Port := 161;
  Snmp.Query.PDUType := PDUSetRequest;
  Snmp.Query.MIBAdd(Comp.SNMP_MIB_Port,inttostr(Value),2);
  Snmp.SendQuery;
  Snmp.Free;
end;
end.
