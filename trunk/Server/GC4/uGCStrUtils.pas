unit uGCStrUtils;

interface

function FilterString(instr: string):string;

implementation

// фильтруем строку от лишних символов
function FilterString(instr: string):string;
var
  i: integer;
begin
  for i:= 1 to Length(instr) do
  begin
    { недопустимый символ в s - значит недопустимый адрес }
    if not (instr[i] in ['a'..'z', 'A'..'Z','а'..'я', 'А'..'Я', '0'..'9', '_', '-', '.', ' ']) then
      instr[i] := '*';
  end;
  FilterString := instr;
end;

end.
 