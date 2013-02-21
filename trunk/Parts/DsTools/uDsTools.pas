unit uDsTools;

interface

uses ADODB;

type
  PTADODataSet = ^TADODataSet;

procedure dsDoQueryEx(Connection:TADOConnection; str: string; pdts: PTADODataSet);

implementation

procedure dsDoQueryEx(Connection:TADOConnection; str: string; pdts: PTADODataSet);
begin
   pdts^.Connection := Connection;
   pdts^.LockType := ltOptimistic;
   pdts^.CursorLocation := clUseClient;
   pdts^.CursorType := ctStatic;
   pdts^.CommandText := str;
   pdts^.ParamCheck := false;
   pdts^.Open;
end;

end.
