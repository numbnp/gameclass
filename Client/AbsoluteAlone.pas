unit AbsoluteAlone;

interface

implementation

uses
  Windows;

const
  STR_PROG_MUTEX = 'gameclass_client_D4B8E495-1C01-4B0D-8F70-9A74B0E6494C';

var
  hMutex: THandle;
  strMutexName: String;

function StopLoading(): Boolean;
begin
  strMutexName := STR_PROG_MUTEX;
  hMutex := CreateMutex(nil, FALSE, PChar(strMutexName));
  Result := (hMutex = 0) or (GetLastError = ERROR_ALREADY_EXISTS);
end; // StopLoading


initialization
  if StopLoading then begin
    halt;
  end;

finalization
  if hMutex <> 0 then begin
    CloseHandle(hMutex);
  end;

end.
