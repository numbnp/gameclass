program ReplaceVerInfo;

{$APPTYPE CONSOLE}

uses
  Classes,
  PJResFile,
  PJIStreams,
  UVerInfoData,
  UVerInfoRec in 'UVerInfoRec.pas',
  IntfBinaryVerInfo in 'IntfBinaryVerInfo.pas',
  UVerInfoBinIO in 'UVerInfoBinIO.pas';

var
  resFile: TPJResourceFile;
  resEntry: TPJResourceEntry;
  n, j: Integer;
  c: Array [0..10240] of Char;
  w: WideChar;
  viData: TVerInfoData;
  streamWrapperIn, streamWrapperOut: TPJIStreamWrapper;
  memStream: TMemoryStream;
  str, strRight, strName: String;
  i, nPosUnderline, nPosEqual, nIndex: Integer;
  bResourceStringSection: Boolean;

begin
  if ParamCount <> 3 then begin
    WriteLn('Version Info Resource File Editor 1.0');
    WriteLn(
    'Example: VIResEdit.exe <res-file> <VersionInfoParameterName> <NewValue>');
    ExitCode := 1;
    Exit;
  end;
  resFile := TPJResourceFile.Create;
  resFile.LoadFromFile(ParamStr(1));
  if resFile.EntryCount <> 3 then begin
    WriteLn('res-file должен содержать 3 секции');
    ExitCode := 2;
    Exit;
  end;
  // секция Version Info
  resEntry := resFile.Entries[2];
  viData := TVerInfoData.Create(vrtUnicode);
  streamWrapperIn := TPJIStreamWrapper.Create(resEntry.Data, False);
  viData.ReadFromStream(streamWrapperIn);
  for i := 0 to viData.GetStringCount(0) - 1 do
    if viData.GetStringName(0, i) = ParamStr(2) then begin
      viData.SetStringValue(0, i, ParamStr(3));
      Break;
    end;
  memStream := TMemoryStream.Create;
  streamWrapperOut := TPJIStreamWrapper.Create(memStream, False);
  viData.WriteToStream(streamWrapperOut);
  resEntry.Data.Seek(0,0);
  resEntry.Data.CopyFrom(memStream,0);
  resFile.SaveToFile(ParamStr(1));
end.

