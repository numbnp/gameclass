program LngRecoder;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Classes,
  StrUtils;

var
  fLng, fDrc: TextFile;
  lstResourceStrings: TStringList;
  lstLngStrings: TStringList;
  str, strRight, strName: String;
  i, nPosUnderline, nPosEqual, nIndex: Integer;
  bResourceStringSection: Boolean;

begin
  if ParamCount <> 2 then begin
    WriteLn('Example: LngRecoder.exe <lng-file> <drc-file>');
    ExitCode := 1;
    Exit;
  end;
  AssignFile(fDrc, ParamStr(2));
  Reset(fDrc);
  lstResourceStrings := TStringList.Create;
  while not Eof(fDrc) do begin
    Readln(fDrc, str);
    if AnsiLeftStr(str,8) = '#define ' then
      lstResourceStrings.Add(AnsiReplaceStr(AnsiRightStr(str, Length(str) - 8),
          ' ', '='));
      // чтобы TStrings работал в виде Name=Value
  end;
  CloseFile(fDrc);
  AssignFile(fLng, ParamStr(1));
  Reset(fLng);
  bResourceStringSection := False;
  lstLngStrings := TStringList.Create;
  while not Eof(fLng) do begin
    Readln(fLng, str);
    if str = '' then
      bResourceStringSection := False;
    if bResourceStringSection then begin
      nPosUnderline := AnsiPos('_', str);
      nPosEqual := AnsiPos('=', str);
      strName := AnsiMidStr(str, nPosUnderline + 1,
          nPosEqual - nPosUnderline - 1);
      strRight := AnsiRightStr(str, Length(str) - nPosUnderline + 1);
      nIndex := lstResourceStrings.IndexOfName(strName);
      if nIndex <> -1 then
         str := lstResourceStrings.ValueFromIndex[nIndex] + strRight;
    end;
    if str = '[ResourceStrings]' then
      bResourceStringSection := True;
    lstLngStrings.Add(str);
  end;
  Rewrite(fLng);
  for i := 0 to lstLngStrings.Count - 1 do
    WriteLn(fLng, lstLngStrings[i]);
  CloseFile(fLng);
  lstResourceStrings.Free;
  lstLngStrings.Free;
end.

