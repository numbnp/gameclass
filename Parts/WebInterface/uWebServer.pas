unit uWebServer;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,winsock;

const
  RT_GET = 1;
  RT_POST = 2;

type
  HttpRequest = record
    FilePath:string;
    RequestType:integer;
    Parametrs:TStringList;
    Headers:TStringList;
    end;

  TExecuteClientEvent = function (Sender: TObject; Request:HttpRequest):boolean of object;
  TPrepareFileEvent = function (Sender: TObject; FilePath:String): TMemoryStream of object;

  TClientThread = class(TThread)
  private
    FExecuteClientEvent :TExecuteClientEvent;
    FPrepareFileEvent :TPrepareFileEvent;

    procedure SendStr(s:TSocket;str:ansiString);
    procedure SendFile(s:TSocket;FileStream:TMemoryStream);
    Function PrepareFile(FilePath:String): TMemoryStream;
    function GetTypeContent(FilePath:ansistring):ansistring;
    function ParseHttpRequest(recv:ansistring): HttpRequest;
  public
    _Client :TSocket;
    DocumentRoot :String;
    DirectoryIndex :String;
    AddLog:procedure (str:string); stdcall;
    property ExecuteClientEvent : TExecuteClientEvent read FExecuteClientEvent write FExecuteClientEvent;
    property PrepareFileEvent : TPrepareFileEvent read FPrepareFileEvent write FPrepareFileEvent;

  protected
    procedure AddToLog(str:string);
    procedure Execute; override;
  end;


  TListerningThread = class(TThread)
  private
    FExecuteClientEvent :TExecuteClientEvent;
    FPrepareFileEvent :TPrepareFileEvent;
  public
    ListenPort:integer;
    DocumentRoot:String;
    DirectoryIndex:String;
    AddLog:procedure (str:string); stdcall;
    property ExecuteClientEvent : TExecuteClientEvent read FExecuteClientEvent write FExecuteClientEvent;
    property PrepareFileEvent : TPrepareFileEvent read FPrepareFileEvent write FPrepareFileEvent;
  protected
      procedure Execute; override;
  end;


  TMyWebServer = class
  private
    _listenThread:TListerningThread;
    FExecuteClientEvent :TExecuteClientEvent;
    FPrepareFileEvent :TPrepareFileEvent;
  public
    RootFolder: string;
    Port: integer;
    IndexPageName: string;

    AddLog:procedure (str:string);  stdcall;
    property ExecuteClientEvent : TExecuteClientEvent read FExecuteClientEvent write FExecuteClientEvent;
    property PrepareFileEvent : TPrepareFileEvent read FPrepareFileEvent write FPrepareFileEvent;

    constructor Create();
    procedure start();
    procedure stop();
  end;

Var
  MyWebServer: TMyWebServer;

//function HexToInt(HexStr : string) : Int64;
procedure StrBreakApart(const Source, Delimeter: ansistring; Parts: TStrings);
function UnpackKeyValue(const Str:ansistring; var Key,Value:ansistring):boolean;



function ReplaceSlash(Str: string): string;
//function ReplaceStr(Str, X, Y: ansistring): ansistring;
function ReplaceWebCode(Str: ansistring): ansistring;


implementation

uses StrUtils, DzURL;

constructor TMyWebServer.Create();
var
  d:TWSAData;
begin
  inherited Create;
  RootFolder := 'c:\';
  Port := 80;
  IndexPageName := 'index.html';
  WSAStartup($101,d);
end;

procedure TMyWebServer.start();
begin
  _listenThread := TListerningThread.Create(true);
  _listenThread.ListenPort := Port;
  _listenThread.DocumentRoot := RootFolder;
  _listenThread.DirectoryIndex := IndexPageName;
  _listenThread.AddLog := AddLog;
  if Assigned(FPrepareFileEvent) then
    _listenThread.PrepareFileEvent := FPrepareFileEvent;
  if Assigned(FExecuteClientEvent) then
    _listenThread.ExecuteClientEvent := FExecuteClientEvent;
  _listenThread.Resume;
end;

procedure TMyWebServer.stop;
begin
  _listenThread.Terminate;
end;

{ TListerningThread }

procedure TListerningThread.Execute;

var
  _listenSocket, _clientSocket:TSocket;
  _listenAddr, _clientAddr: sockaddr_in;
  _clientThread:TClientThread;
  _size:integer;
begin
  inherited;
  _listenSocket := socket (AF_INET, SOCK_STREAM, 0);

  if (_listenSocket = INVALID_SOCKET) then
  begin
    MessageBox (0, 'Socket create Error',
    'warning!', 0);
    Exit;
  end;

  _listenAddr.sin_family := AF_INET;
  _listenAddr.sin_port := htons(ListenPort);
  _listenAddr.sin_addr.S_addr := htonl(INADDR_ANY);

  if (Bind(_listenSocket, _listenAddr,
   sizeof(_listenAddr)))=SOCKET_ERROR then
  begin
    MessageBox (0, 'BIND Erorr', 'warning!', 0);
    Exit;
  end;

  if Listen(_listenSocket, 4) = SOCKET_ERROR then
  begin
    MessageBox (0, 'Listen Error', 'warning', 0);
    Exit;
  end;

  while not self.Terminated do
  begin
    _size := sizeof(_clientAddr);

    _clientSocket := accept(_listenSocket, @_clientAddr, @_size);

    if (_clientSocket = INVALID_SOCKET) then
      Continue;

    _clientThread := TClientThread.Create(true);
    _clientThread._Client := _ClientSocket;
    _clientThread.DocumentRoot := DocumentRoot;
    _clientThread.DirectoryIndex := DirectoryIndex;
    _clientThread.AddLog := AddLog;
    if Assigned(FPrepareFileEvent) then
      _clientThread.PrepareFileEvent := FPrepareFileEvent;
    if Assigned(FExecuteClientEvent) then
      _clientThread.ExecuteClientEvent := FExecuteClientEvent;
    _clientThread.Resume;
  end;
end;

{ TClientThread }

procedure TClientThread.AddToLog(str: string);
begin
  if @AddLog <> nil then
    AddLog(str);
end;

procedure TClientThread.Execute;
var
 _buff: array [0..1024] of AnsiChar;
 _request:AnsiString;
 _path: String;
 _FileStream : TMemoryStream;
 _httpRequest : HttpRequest;
// _f:file of byte;
// _fileSize:integer;
begin
  inherited;

  Recv(_client, _buff, 1024, 0);
  _request:=ansistring(_buff);

  if _request='' then
  begin
    CloseSocket(_client);
    exit;
  end;

  AddToLog(string(_request));

  AddToLog('-----------------------------------------------');
  _httpRequest := ParseHttpRequest(_request);

  if Assigned(FExecuteClientEvent) then
    if not FExecuteClientEvent(Self,_httpRequest) then
    begin
      CloseSocket(_client);
      exit;
    end;

  AddToLog('-----------------------------------------------');

  _path := _httpRequest.FilePath;

  _path := ReplaceSlash(_path);

  if ((_path = '') or (_path = '\')) Then
    _path := DocumentRoot +'\' + DirectoryIndex
  else
    _path := DocumentRoot + _path;

  if (FileExists(_Path)) Then
  begin
    if Assigned(FPrepareFileEvent) then
      _FileStream := FPrepareFileEvent(Self,_path)
    else
      _FileStream := PrepareFile(_path);

    SendStr(_Client, 'HTTP/1.0 200 OK');
    SendStr(_Client, 'Server: GameClassClient');
    SendStr(_Client, ansistring('Content-Length: ' + IntToStr(_FileStream.Size)));
    SendStr(_Client, ansistring('Content-Type: ' + GetTypeContent(AnsiString(_Path))));
    SendStr(_Client, 'Cache-Control: no-store');
    SendStr(_Client, 'Expires: Sat, 26 Jan 2008 20:31:55 +0300');
    SendStr(_Client, 'Connection: close');
    SendStr(_Client, '');

    SendFile(_Client, _FileStream);

    _FileStream.Free;
  end
  else
  begin
    // Нет запрашиваемого файла, отправляем 404
    SendStr(_Client, 'HTTP/1.0 404 Not Found');
    SendStr(_Client, 'Server: GameClassClient');
    SendStr(_Client, 'Content-Length: 0');
    SendStr(_Client, 'Content-Type: text/html');
    SendStr(_Client, 'Connection: close');
    SendStr(_Client, '');
  end;

  AddToLog('-----------------------------------------------');
  closesocket(_client);
  Terminate();
end;

procedure TClientThread.SendFile(s: TSocket; FileStream: TMemoryStream);
var
  _buff:array [0..500000] of ansichar;
  _ret:integer;
begin
  while true do
  begin
    _ret := FileStream.Read(_buff, sizeOf(_buff));
    if (_ret = 0) Then
      Break;
    Send(s, _buff, _ret, 0);
  end;
end;

procedure TClientThread.SendStr(s: TSocket; str: ansiString);
var
  _buff: array [0..255] of char;
  _temp: AnsiString;
begin
  AddToLog(string(str));
  _temp :=str+#13+#10;
  CopyMemory(@_buff, PAnsiChar(_temp), Length(_temp));
  send(s, _buff, Length(_temp), 0);
end;


function TClientThread.GetTypeContent(FilePath: AnsiString): ansistring;
var
  ex:AnsiString;
begin
  ex:=AnsiString(UpperCase(ExtractFileExt(string(FilePath))));
  if (ex='.HTM') or (ex='.HTML') then Result := 'text/html';
  if (ex='.CSS') then Result := 'text/css';
end;


function TClientThread.ParseHttpRequest(recv: AnsiString): HttpRequest;
var
  tmp_slist,tmp_slist1:TStringList;
  tmp_str:AnsiString;
  Res:HttpRequest;
  i:integer;
  parametrs:AnsiString;
  Key,Value:AnsiString;
  CurrentRequestLineNumber: integer;
  Content_Length:integer;
begin
  Content_Length := 0;
  // Разбиваем запрос на строки
  tmp_slist := TStringList.Create;
  StrBreakApart(recv,#13+#10,tmp_slist);
  parametrs := '';

  //Парсим первую строку

  // Определяем тип запроса
  if pos('GET',tmp_slist.Strings[0])>0 then Res.RequestType := RT_GET;
  if pos('POST',tmp_slist.Strings[0])>0 then Res.RequestType := RT_POST;

  //Разбор запрашиваемого файла на имя файла и параметры
  tmp_str:= Copy(tmp_slist.Strings[0],
                  Pos(' ',tmp_slist.Strings[0])+1,
                  length(tmp_slist.Strings[0])-Pos(' ',tmp_slist.Strings[0])
                );
  tmp_str := LeftStr(tmp_str,ansiPos(' ',tmp_str)-1);
  if AnsiPos('?',tmp_str)>0 then
  begin
    parametrs := RightStr(tmp_str,length(tmp_str) - AnsiPos('?',tmp_str));
    tmp_str := LeftStr(tmp_str,AnsiPos('?',tmp_str)-1);
  end;
  Res.FilePath := string(tmp_str);

  // Вытаскиваем все Http заголовки
  Res.Headers := TStringList.Create;
  CurrentRequestLineNumber :=1;
  While (CurrentRequestLineNumber <= tmp_slist.Count) and (tmp_slist.Strings[CurrentRequestLineNumber]<>'') do
  begin
    Res.Headers.Add(tmp_slist.Strings[CurrentRequestLineNumber]);
    if pos('Content-Length:',tmp_slist.Strings[CurrentRequestLineNumber])>0 then
      Content_Length := strtoint(copy(tmp_slist.Strings[CurrentRequestLineNumber],17,length(tmp_slist.Strings[CurrentRequestLineNumber])-16));
    inc(CurrentRequestLineNumber);
  end;

  inc(CurrentRequestLineNumber);

  // Разбор параметров POST запроса
  Res.Parametrs := TStringList.Create;
  if Res.RequestType = RT_POST then
    for i:=CurrentRequestLineNumber to tmp_slist.Count -1 do
    if pos('=', tmp_slist.Strings[i])>0 then
      if length(parametrs)>0 then
        parametrs := parametrs + '&' + AnsiString(LeftStr(tmp_slist.Strings[i],Content_Length))
      else
        parametrs := AnsiString(LeftStr(tmp_slist.Strings[i],Content_Length));

  tmp_slist1 := TStringList.Create;
  if length(parametrs)>0 then
  begin
    StrBreakApart(parametrs,'&',tmp_slist1);
    for i:= 0 to tmp_slist1.Count -1 do
      if UnpackKeyValue(AnsiString(tmp_slist1.Strings[i]),Key,Value) then
        Res.Parametrs.Values[string(Key)]:= string(ReplaceWebCode(Value));
  end;

  tmp_slist1.Free;
  tmp_slist.Free;

  Result := Res;

end;

Function TClientThread.PrepareFile(FilePath:String): TMemoryStream;
var
  msResultFile: TMemoryStream;
begin
  msResultFile := TMemoryStream.Create;
  msResultFile.LoadFromFile(FilePath);
  Result := msResultFile;
end;


function ReplaceSlash(Str: string): string;
begin
  Result := ReplaceStr(str,'/','\');
end;

function ReplaceWebCode(Str: AnsiString): AnsiString;
var
  ss: string;
  _Result: string;
begin
  ss:= string(Str);
  _Result:=Utf8ToAnsi(dzurl.UrlDecode(ss));
  _Result:=StringReplace(_Result,'&lt;','<',[rfReplaceAll]);
  _Result:=StringReplace(_Result,'&gt;','>',[rfReplaceAll]);
  Result := AnsiString(_Result);
end;


function UnpackKeyValue(const Str:AnsiString; var Key,Value:AnsiString):boolean;
var
  DelimeterPos:integer;
  _Result:Boolean;
begin
  _Result:=false;
  Key :='';
  Value :='';
  DelimeterPos := Pos('=',Str);
  if (DelimeterPos > 1) and (DelimeterPos < length(Str)) then
  begin
    Key := LeftStr(Str,DelimeterPos-1);
    Value := RightStr(Str, Length(Str)-DelimeterPos);
    _Result := True;
  end;
  Result := _Result;
end;

procedure StrBreakApart(const Source, Delimeter: AnsiString; Parts: TStrings);
var
 curPos: Integer;
 curStr: AnsiString;
begin
 Parts.Clear;
 if Length(Source) = 0 then
   Exit;
 Parts.BeginUpdate;
 try
   CurStr:= Source;
   repeat
     CurPos:= Pos(Delimeter, CurStr);
     if CurPos > 0 then begin
       Parts.Add(String(Copy(CurStr, 1, Pred(CurPos))));
       CurStr:= Copy(CurStr, CurPos+Length(Delimeter),
         Length(CurStr)-CurPos-Length(Delimeter)+1);
     end else
       Parts.Add(String(CurStr));
   until CurPos=0;
 finally
   Parts.EndUpdate;
 end;
end;



end.
