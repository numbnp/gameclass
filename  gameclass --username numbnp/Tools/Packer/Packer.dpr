program Packer;

{$APPTYPE CONSOLE}

uses
  Classes,
  SysUtils,
  ZipMstr;
var
  ZipMaster: TZipMaster;

begin
  if ParamCount <> 4 then begin
    WriteLn('Packer 1.0');
    WriteLn('Example: Packer.exe <command> <zip-file> <file> <password>');
    WriteLn('Ñcommand: [a]rchivate, e[x]tract');
    ExitCode := 1;
    Exit;
  end;
  ZipMaster := TZipMaster.Create(Nil);
  with (ZipMaster) do begin
    ZipFilename := ParamStr(2);
    Password := ParamStr(4);
    if (ParamStr(1) = 'a') or (ParamStr(1) = 'archivate') then begin
      AddOptions := [AddUpdate, AddEncrypt];
      FSpecArgs.Clear;
      FSpecArgs.Add(ParamStr(3));
      try
        Add;
      except
        WriteLn('Error in Add; Fatal DLL Exception in mainunit');
      end;
      WriteLn(IntToStr(SuccessCnt) + ' file(s) added');
    end else if (ParamStr(1) = 'x') or (ParamStr(1) = 'extract') then begin
      if not FileExists(ZipFilename) then begin
        WriteLn('Error: file not found: ' + ZipFilename);
        ExitCode := 2;
        Exit;
      end;
      ExtrBaseDir := ExtractFileDir(ParamStr(3));
      ExtrOptions := [ExtrDirNames, ExtrOverwrite];
      try
        Extract;
      except
        WriteLn('Error in Extract; Fatal DLL Exception in mainunit');
      end;
      WriteLn(IntToStr(SuccessCnt) + ' file(s) extracted');
    end;
  end;
  FreeAndNil(ZipMaster);
end.

