unit uComPort;

interface

uses Windows,  SysUtils, Classes;

type
  TMyComPort = class
    private
      com_port:THandle;
      _PortOpened: boolean;
    public
      inQueue : Cardinal;
      outQueue : Cardinal;
      com_dcb: TDCB;
      com_CommTimeouts: TCommTimeouts;

      property PortOpened:boolean read _PortOpened;

      constructor Create();
      destructor Destroy; override;

      function OpenPort (Port:string):boolean;
      function ClosePort():boolean;

      function WriteData(var Buf; size: word): integer; //пеpедача в поpт
      function ReadData(var Buf; size: word): integer; //Чтение из поpта

      function FlushBuffer():boolean;

      function Set_RTS:boolean;
      function Clear_RTS:boolean;


    end;

procedure ReadComportList(AList: TStrings);

implementation


{ TMyComPort }

function TMyComPort.ClosePort: boolean;
begin
   _PortOpened := false;
   ClosePort := Windows.CloseHandle(com_port);
end;

function TMyComPort.Clear_RTS: boolean;
begin
  if not _PortOpened then exit;
  EscapeCommFunction(com_port,ClrRTS);
end;

constructor TMyComPort.Create;
begin
  inQueue := 2048;
  outQueue := 2048;

  com_dcb.BaudRate := 9600;
  com_dcb.StopBits := 0;
  com_dcb.Parity := 2;
  com_dcb.ByteSize := 8;

  com_CommTimeouts.ReadTotalTimeoutConstant := 50;
  com_CommTimeouts.ReadIntervalTimeout := 50;
  com_CommTimeouts.ReadTotalTimeoutMultiplier := 1;
  com_CommTimeouts.WriteTotalTimeoutMultiplier := 0;
  com_CommTimeouts.WriteTotalTimeoutConstant := 10;

  _PortOpened := false;

end;

destructor TMyComPort.Destroy;
begin
  if _PortOpened then ClosePort;
  inherited;
end;

function TMyComPort.FlushBuffer: boolean;
begin
  if not _PortOpened then exit;
  PurgeComm(com_port, PURGE_TXCLEAR or PURGE_RXCLEAR);
end;

function TMyComPort.OpenPort(Port: string): boolean;
var
    ct: TCommTimeouts;
    dcb: TDCB;
begin
  com_port := Windows.CreateFile(PChar(Port), GENERIC_READ or   // comport - переменная типа string, номер компорта в формате 'COM3', 'COM11', 'COM1' и т.п.
                              GENERIC_WRITE,
                              FILE_SHARE_READ or FILE_SHARE_WRITE,
                              nil, OPEN_EXISTING,
                              FILE_ATTRIBUTE_NORMAL, 0);
  if (com_port <= 0) or not Windows.SetupComm(com_port, inQueue, outQueue)or not
      Windows.GetCommState(com_port, dcb) then exit; //init error

  dcb.BaudRate := com_dcb.BaudRate;
  dcb.StopBits := com_dcb.StopBits;
  dcb.Parity := com_dcb.Parity;
  dcb.ByteSize := com_dcb.ByteSize;

  if not Windows.SetCommState(com_port, dcb)
  or not Windows.GetCommTimeouts(com_port, ct) then exit; //error

  ct.ReadTotalTimeoutConstant := com_CommTimeouts.ReadTotalTimeoutConstant;
  ct.ReadIntervalTimeout := com_CommTimeouts.ReadIntervalTimeout;
  ct.ReadTotalTimeoutMultiplier := com_CommTimeouts.ReadTotalTimeoutMultiplier;
  ct.WriteTotalTimeoutMultiplier := com_CommTimeouts.WriteTotalTimeoutMultiplier;
  ct.WriteTotalTimeoutConstant := com_CommTimeouts.WriteTotalTimeoutConstant;

  if not Windows.SetCommTimeouts(com_port, ct)
    then exit; //error
  _PortOpened := true;
  OpenPort := true;
end;

function TMyComPort.ReadData(var Buf; size: word): integer;
var
  i: cardinal;
  ovr: TOverlapped;
begin
  if not _PortOpened then exit;
  fillChar(buf, size, 0);
  fillChar(ovr, sizeOf(ovr), 0); i := 0; result := -1;
  if not windows.ReadFile(com_port, buf, size, i, @ovr) then exit;
  result := i;
  ReadData := result;
end;

function TMyComPort.Set_RTS: boolean;
begin
  if not _PortOpened then exit;
  EscapeCommFunction(com_port,SETRTS);
end;

function TMyComPort.WriteData(var Buf; size: word): integer;
var
  p: pointer;
  i: cardinal;
begin
  if not _PortOpened then exit;
  p := @Buf;
  result := 0;
  if not WriteFile(com_port, p^, size, i, nil) then exit;

  WriteData := result;
end;


procedure ReadComportList(AList: TStrings);
var
  I: Integer;
  H: THandle;
begin {опрос существующих портов}
  AList.Clear;
  for I := 0 to 255 do {цикл опроса}
  begin {пробуем получить дескриптор порта}
    H := CreateFile(PChar('COM' + IntToStr(i + 1)),
      GENERIC_READ or GENERIC_WRITE,
      0,
      nil,
      OPEN_EXISTING, FILE_FLAG_OVERLAPPED, 0);

    if (H <> INVALID_HANDLE_VALUE) or (GetLastError = 5) then {если порт есть то добавить в список}
      AList.Add('COM'+IntToStr(i + 1));
    if H <> 0 then
      CloseHandle(H); {закрыть дескриптор}
  end;
end;

end.
