program ShowTopText;

uses
  Forms,
  Windows,
  Messages,
  uD3DShowText in '..\..\Parts\Direct3D\uD3DShowText.pas';

{$R *.res}

Var
  Msg:TMsg;

begin
  if ParamCount >0 then
    UAPIMessageBox(ParamStr(1) ,5)
  else
    halt;

  while GetMessage(Msg,0,0,0) do
  begin
    TranslateMessage(Msg);
    DispatchMessage(Msg);
    if Flag then halt;
  end;


end.
