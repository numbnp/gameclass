unit uRunPadStatusBar;

interface

const
// Кол-во условных статусов для RunPad
  RunPadStatusCount = 10;

type
  TConditionalStatusText = class (TObject)
    private

    public
      Conditional:String;
      Status:String;
  end;

  TConditionalStatusTexts = class (TObject)
    private
      ConditionalStatusText: array [0..RunPadStatusCount-1] of TConditionalStatusText;
    public
      constructor Create();
  end;


implementation


constructor TConditionalStatusTexts.Create();
var
  i: integer;
begin
  inherited Create();

  for i:=0 to RunPadStatusCount do
  begin
    if ConditionalStatusText[i] = nil then
      ConditionalStatusText[i]:= TConditionalStatusText.Create;
  end;
end;

end.
