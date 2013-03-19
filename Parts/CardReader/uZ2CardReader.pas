unit uZ2CardReader;

interface

uses uCardReader, uComPort,ExtCtrls;

type
  TZ2CardReader = class (TPCardReader)
    private
      ComPort: TMyComPort;
      ReadTimer:TTimer;
      procedure OnReadTimer(Sender: TObject);
      function GetRuning():boolean;
    public
      property Runing: boolean
        read GetRuning;
      constructor Create();
      destructor Destroy; override;

      function Start():boolean; override; //Запустили считывание
      function Stop():boolean; override;//Остановка считывания

  end;

Var
  RxBuffer:string;
  CardReader:TZ2CardReader;

implementation

uses SysUtils,Math, StrUtils;

{ TPercoCardReader }

constructor TZ2CardReader.Create;
begin
  inherited;
  ComPort:= TMyComPort.Create;
  ReadTimer:= TTimer.Create(nil);
  ReadTimer.Interval := 100;
  ReadTimer.OnTimer := OnReadTimer;
  ReadTimer.Enabled :=False;

  RxBuffer := '';

  StopAfterReadCode :=true; //Останавливаемся после получения кода
  PortName := 'COM1';

  ComPort.com_dcb.BaudRate := 9600;
  ComPort.com_dcb.StopBits := 0;
  ComPort.com_dcb.Parity := 0;
  ComPort.com_dcb.ByteSize := 8;
  ComPort.com_CommTimeouts.ReadTotalTimeoutConstant := 100;
  ComPort.com_CommTimeouts.ReadIntervalTimeout := 0;
  ComPort.com_CommTimeouts.ReadTotalTimeoutMultiplier := 0;
  ComPort.com_CommTimeouts.WriteTotalTimeoutMultiplier := 0;
  ComPort.com_CommTimeouts.WriteTotalTimeoutConstant := 0;

end;

destructor TZ2CardReader.Destroy;
begin
  FreeAndNil(ComPort);
  FreeAndNil(ReadTimer);
  inherited;
end;

function TZ2CardReader.GetRuning: boolean;
begin
  result:= ComPort.PortOpened;
end;

procedure TZ2CardReader.OnReadTimer(Sender: TObject);
var
  Buffer: array [0..1024] of byte;
  ReadResult:integer;
  ResultStr :string;
  i:integer;
begin
  if not ComPort.PortOpened then exit;

  ReadResult := ComPort.ReadData(Buffer,80);

  if ReadResult>0 then
  begin
    for i:= 0 to ReadResult-1 do
    begin
      RxBuffer := RxBuffer + chr(Buffer[i]);
      if RightStr(RxBuffer,2)=#$D#$A then
      begin
        ResultStr := LeftStr(RxBuffer,length(RxBuffer)-2);
        RxBuffer := '';
        if ResultStr <> 'No card' then
        begin
          CallBackReadCodeProc(ResultStr);
          if StopAfterReadCode then
            Stop;
        end;
      end;
    end;
  end

{  if ByteArrRx[5]=$02 then                                        //Требуется повторная инициализация
  begin
    ComPort.FlushBuffer;
    ComPort.WriteData( InitBufer,Length(InitBufer) );
    Sleep(10);
    ComPort.ReadData( ByteArrRx,6);
  end;
  if ByteArrRx[5]=$80 then                                        //Получили признак ввода кода
  begin
    Sleep(10);
    ComPort.ReadData(ByteArrRx,11);
    Code:= ByteArrRx[3];
    Code:= Code + Trunc(IntPower($100,1))*ByteArrRx[4];
    Code:= Code + Trunc(IntPower($100,2))*ByteArrRx[5];
    Code:= Code + Trunc(IntPower($100,3))*ByteArrRx[6];
    Code:= Code + Trunc(IntPower($100,4))*ByteArrRx[7];
    CallBackReadCodeProc(IntToStr(Code));
    if StopAfterReadCode then
    begin
      Stop;
    end;
  end;}
end;

function TZ2CardReader.Start: boolean;
var
  ByteArrRx: array [1..6] of byte;
begin
  result:=false;
  if ComPort.PortOpened then raise Exception.Create('Port is already open');
  if not ComPort.OpenPort(PortName) then raise Exception.Create('Can not open port');

  ReadTimer.Enabled := True;
  OnReadTimer(nil);
  result:= True;
  start:= result;

end;

function TZ2CardReader.Stop: boolean;
begin
  ReadTimer.Enabled :=False;
  if ComPort.PortOpened then ComPort.ClosePort;
end;



end.
