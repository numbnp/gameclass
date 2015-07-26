//////////////////////////////////////////////////////////////////////////////
//
// TGetHardwareRemoteCommand
//
//////////////////////////////////////////////////////////////////////////////

unit uGetHardwareRemoteCommand;

interface

uses
  // project units
  uRemoteCommand,
  Types;

type

  //
  // TGetHardwareRemoteCommand
  //

  TGetHardwareRemoteCommand = class(TRemoteCommand)
    // fields

  public
    // constructor / destructror
    constructor Create(const AstrHostForSend: String);

    // public methods
    procedure Execute(); override;

  end; // TGetHardwareRemoteCommand


implementation

uses
  // system units
  SysUtils,
  Classes,
  // project units
{$IFDEF MSWINDOWS}
//  uHardwareManager,
  ComObj,
  ActiveX,
  Windows,
{$ENDIF}
{$IFDEF LINUX}
{$ENDIF}
  uProtocol,
  uCommandSender,
  uDebugLog;

var
  FstrHostForSend: String;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TGetHardwareRemoteCommand.Create(const AstrHostForSend: String);
begin
  inherited Create();

  FstrHostForSend := AstrHostForSend;

end; // TGetHardwareRemoteCommand.Create

// по идее это должна быть метод класса, но при попытке запустить
// метод класса в отдельном потоке приложение подвисает
// в варианте с глобальной функцией все работате нормально
{$IFDEF MSWINDOWS}
function DoGetHardware: DWORD;
var
  strSendData: String;
begin
//  CoInitialize(Nil);
  strSendData :=  STR_CMD_RET_GETHARDWARE + '=';
//      + THardwareManager.Instance().GetHardwareAsString;
  SendDataTo(FstrHostForSend, strSendData);
//  CoUninitialize;
  Result := 0;
end; // DoGetHardware
{$ENDIF}
{$IFDEF LINUX}
function DoGetHardware: DWORD;
var
  strSendData: String;
begin
//  CoInitialize(Nil);
  strSendData :=  STR_CMD_RET_GETHARDWARE + '=';
//      + THardwareManager.Instance().GetHardwareAsString;
  SendDataTo(FstrHostForSend, strSendData);
//  CoUninitialize;
  Result := 0;
end; // DoGetHardware
{$ENDIF}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TGetHardwareRemoteCommand.Execute();
var
  nThreadId: Cardinal;
begin
{$IFDEF MSWINDOWS}
  nThreadId := BeginThread(
      nil, 0, @DoGetHardware, Pointer(Self), 0, nThreadId);
  ASSERT(nThreadId <> INVALID_HANDLE_VALUE);
{$ENDIF}
{$IFDEF LINUX}
  nThreadId := BeginThread(
      nil, @DoGetHardware, Pointer(Self), nThreadId);
{$ENDIF}
end; // TGetHardwareRemoteCommand.Execute


end.
