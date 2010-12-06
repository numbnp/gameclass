unit uTextReader;

interface
const
  TEXT_READER_BUF_SIZE = 1024;

type
  //доп. байт для null-terminator
  TBuffer = array [1..TEXT_READER_BUF_SIZE+1] of Byte;
//  TDoubleBuffer = array [1..2*TEXT_READER_BUF_SIZE] of Byte;
  PBuffer = ^TBuffer;
  TTextReader = class
  private
    FnFileHandle: Integer;
    FnFilePos: Integer;
    FnHotBufPos: Integer;
    FnHotBufLen: Integer;
    FnOldBufPos: Integer;
    FnOldBufLen: Integer;
    Fstr: String;
    FaHotBuf: TBuffer;
    FaOldBuf: TBuffer;
    FpHotBuf: PBuffer;
    FpOldBuf: PBuffer;
    function _FindEolInOldBuf(var AnEolPos: Integer): Boolean;
    function _FindEolInHotBuf(var AnEolPos: Integer): Boolean;

  public
    constructor Create(
        AstrFileName: String;
        AnFilePos: Longint
        );
    destructor Destroy; override;

    function ReadString(var AstrString: String): Boolean;
    property FilePos: Integer read FnFilePos;
  end;

implementation

uses SysUtils, Math;

constructor TTextReader.Create(
        AstrFileName: String;
        AnFilePos: Longint
        );
begin
  inherited Create;
  FpHotBuf := @FaHotBuf;
  FpOldBuf := @FaOldBuf;
  FaHotBuf[TEXT_READER_BUF_SIZE+1] := 0; //null-terminator
  FaOldBuf[TEXT_READER_BUF_SIZE+1] := 0; //null-terminator
  FnFileHandle := FileOpen(AstrFileName, fmOpenRead or fmShareDenyNone);
  FnFilePos := FileSeek(FnFileHandle, AnFilePos, 0);
  // Делаем вид что второй буфер полностью просканен
  FnHotBufPos := 1;
  FnHotBufLen := 0;
  FnOldBufPos := 1;
  FnOldBufLen := 0;
end;


destructor TTextReader.Destroy;
begin
  FileClose(FnFileHandle);
  inherited Destroy;
end;

function TTextReader.ReadString(var AstrString: String): Boolean;
var
  nReadBytes: Integer;
  nPosEol: Integer;
  pBuf: PBuffer;
begin
  Result := False;
  //Если в буфере еще что-то есть и что-то содержит EOL,
  //то из файла читать не надо
  if _FindEolInOldBuf(nPosEol) then begin
    FpOldBuf^[nPosEol] := 0; //ставим Null-terminator
    SetString(AstrString, PChar(FpOldBuf) + FnOldBufPos - 1, nPosEol - FnOldBufPos);
    FnFilePos := FnFilePos  + nPosEol + 2 - FnOldBufPos;
    FnOldBufPos := nPosEol + 2;
    Result := True;
  end else begin
    nReadBytes := FileRead(FnFileHandle, FpHotBuf^, TEXT_READER_BUF_SIZE);
    if (nReadBytes = 0) then
      exit;
    FnHotBufPos := 1;
    FnHotBufLen := nReadBytes;
    //одна строка тут должна быть по-любому, но мало ли
    if _FindEolInHotBuf(nPosEol) then begin
      FpHotBuf^[nPosEol] := 0; //ставим Null-terminator
      if (FnOldBufPos < FnOldBufLen) then begin
        AstrString := String(PChar(FpOldBuf) + FnOldBufPos -1)
            + String(PChar(FpHotBuf));
        FnFilePos := FnFilePos  + FnOldBufLen - FnOldBufPos
            + nPosEol + 2;
      end else begin
        SetString(AstrString, PChar(FpHotBuf), nPosEol-1);
        FnFilePos := FnFilePos  + nPosEol + 1;
      end;
      FnHotBufPos := nPosEol + 2;
    end;
    //Переносим текущий буфер в старый
    pBuf := FpHotBuf;
    FpHotBuf := FpOldBuf;
    FpOldBuf := pBuf;
    nPosEol := FnHotBufPos;
    FnHotBufPos := FnOldBufPos;
    FnOldBufPos := nPosEol;
    nPosEol := FnHotBufLen;
    FnHotBufLen := FnOldBufLen;
    FnOldBufLen := nPosEol;
    Result := True;
  end;
end;

function TTextReader._FindEolInOldBuf(var AnEolPos: Integer): Boolean;
var
  nReadBytes: Integer;
  i: Integer;
begin
  Result := False;
  //В буфере должны быть оба символа OD OA
  if (FnOldBufPos < FnOldBufLen-1) then begin
    for i := FnOldBufPos to FnOldBufLen-1 do
      if (FpOldBuf^[i] = $0D) then
        if (FpOldBuf^[i+1] = $0A) then begin
          Result := True;
          AnEolPos := i;
          exit;
        end;
  end;
end;

function TTextReader._FindEolInHotBuf(var AnEolPos: Integer): Boolean;
var
  nReadBytes: Integer;
  i: Integer;
begin
  Result := False;
  //В буфере должны быть оба символа OD OA
  if (FnHotBufPos < FnHotBufLen-1) then begin
    for i := FnHotBufPos to FnHotBufLen-1 do
      if (FpHotBuf^[i] = $0D) then
        if (FpHotBuf^[i+1] = $0A) then begin
          Result := True;
          AnEolPos := i;
          exit;
        end;
  end;
end;

end.

