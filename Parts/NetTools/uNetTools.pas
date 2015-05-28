unit uNetTools;

interface
  function GetIPByName(AstrHostName: String): String;

implementation

uses
  WinSock,
  SysUtils;

function GetIPByName(AstrHostName: String): String;
var
  wsdata : TWSAData;
//  hostName : array [0..255] of ansichar;
  hostEnt : PHostEnt;
  addr : PAnsiChar;
  ip: string;
begin
  WSAStartup ($0101, wsdata);
  Result := '';
  // вырежим два слеша из начала, если они есть
  if (length(AstrHostName)>2) then
  if ((AstrHostName[1]='\') and (AstrHostName[2]='\')) then AstrHostName := Copy(AstrHostName,3,1000);
  try
//    gethostname (hostName, sizeof (hostName));
//    StrPCopy(hostName, AstrHostName);
    hostEnt := gethostbyname (PAnsichar(Ansistring(AstrHostName)));
    if Assigned (hostEnt) then
      if Assigned (hostEnt^.h_addr_list) then begin
        addr := hostEnt^.h_addr_list^;
        if Assigned (addr) then begin
          IP := Format ('%d.%d.%d.%d', [byte (addr [0]),
          byte (addr [1]), byte (addr [2]), byte (addr [3])]);
          GetIPByName := ip;
        end
      end
  finally
    WSACleanup;
  end
end;

end.
