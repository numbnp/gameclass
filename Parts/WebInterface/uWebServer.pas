unit uWebServer;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,winsock;

const
  RT_GET = 1;
  RT_POST = 2;

type
  TBuff = array of Byte;

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
    function ParseHttpRequest(recv:string): HttpRequest;
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
function UnpackKeyValue(const Str:string; var Key,Value:string):boolean;

function MySplit(Delimiter:String;DelimitedText:string):TStringList;


function ReplaceSlash(Str: string): string;
//function ReplaceStr(Str, X, Y: ansistring): ansistring;
function ReplaceWebCode(Str: string): string;


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
  if _listenThread.Suspended then _listenThread.Start;
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
    if _clientThread.Suspended then _clientThread.Start;
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
 _Arequest:AnsiString;
 _request:string;
 _path: String;
 _FileStream : TMemoryStream;
 _httpRequest : HttpRequest;
// _f:file of byte;
// _fileSize:integer;
begin
  inherited;
  Recv(_client, _buff, 1024, 0);
  _Arequest:=ansistring(_buff);
  _request := string(_Arequest);
 // _request:=TEncoding.UTF8.GetString(_buff);

  if _request='' then
  begin
    CloseSocket(_client);
    exit;
  end;

  AddToLog(_request);

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


function TClientThread.ParseHttpRequest(recv: String): HttpRequest;
var
  tmp_slist:TStringList;
  tmp_slist_fistHeader:TStringList;
  tmp_slist_split:TStringList;
  Res:HttpRequest;
  i:integer;
  parametrs:String;
  Key,Value:String;
  CurrentRequestLineNumber: integer;
  Content_Length:integer;
begin
  Content_Length := 0;
  // Разбиваем запрос на строки
  tmp_slist := MySplit(#13+#10,recv);
  parametrs := '';

  //Парсим первую строку
  tmp_slist_fistHeader := MySplit(' ',tmp_slist.Strings[0]);

  // Определяем тип запроса
  if 'GET'=tmp_slist_fistHeader.Strings[0] then Res.RequestType := RT_GET;
  if 'POST'=tmp_slist_fistHeader.Strings[0] then Res.RequestType := RT_POST;

  //Разбор запрашиваемого файла на имя файла и параметры
  tmp_slist_split := MySplit('?',tmp_slist_fistHeader.Strings[1]);
  Res.FilePath := tmp_slist_split.Strings[0];
  if tmp_slist_split.Count >1 then
  begin
    parametrs := tmp_slist_split.Strings[0];
  end;
  FreeAndNil(tmp_slist_split);

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
        parametrs := parametrs + '&' + Copy(tmp_slist.Strings[i],1,Content_Length)
      else
        parametrs := Copy(tmp_slist.Strings[i],1,Content_Length);

  if length(parametrs)>0 then
  begin
    tmp_slist_split := MySplit('&',parametrs);
    for i:= 0 to tmp_slist_split.Count -1 do
      if UnpackKeyValue(tmp_slist_split.Strings[i],Key,Value) then
        Res.Parametrs.Values[Key]:= ReplaceWebCode(Value);
    FreeAndNil(tmp_slist_split);
  end;

  tmp_slist.Free;

  Result := Res;

end;

function MySplit(Delimiter:String;DelimitedText:string):TStringList;
var
  split_sl:TStringList;
begin
  split_sl:= TStringList.Create;
  split_sl.LineBreak := Delimiter;
  split_sl.Text := DelimitedText;
  Result := split_sl;
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

function ReplaceWebCode(Str: String): String;
var
  _Result: string;
begin
  _Result:=dzurl.UrlDecode(Str);
  _Result:=StringReplace(_Result,'&lt;','<',[rfReplaceAll]);
  _Result:=StringReplace(_Result,'&gt;','>',[rfReplaceAll]);
  Result := _Result;
end;


function UnpackKeyValue(const Str:String; var Key,Value:String):boolean;
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
    Key := Copy(Str,1,DelimeterPos-1);
    Value := Copy(Str,DelimeterPos+1,Length(Str)-DelimeterPos);
    _Result := True;
  end;
  Result := _Result;
end;

end.
