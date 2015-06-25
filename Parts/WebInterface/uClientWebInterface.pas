unit uClientWebInterface;

interface

uses
  Classes,
  cefvcl,
  ceflib,
  Forms,
  StrUtils,
  Vcl.Controls,
  System.Rtti,
  windows,
  uMyWebBrowser,
  uWebServer;

type
  TParceAndReplaceLine = procedure (Sender: TObject; FilePath:AnsiString) of object;
  TWebInterface = class
    private
      _MyWebBrowser :TMyWebBrowser;
      _MyWebServer:TMyWebServer;
      _Parent:TWinControl;
    public
      Port:Integer;
      IndexFile:string;
      SkinPath:string;
      ParceAndReplaceLine : TParceAndReplaceLine;
      constructor Create (Parent:TWinControl);
      procedure ShowDevTools;
      procedure ReloadSkin();
      procedure ShowUnblock();
      procedure Start;
      procedure DoJsCommand(Command:string);

      function ExecuteClientEvent (Sender: TObject; Request:HttpRequest):boolean;
      function PrepareFile (Sender: TObject; FilePath:String): TMemoryStream;
    end;

implementation

uses
  SysUtils;

procedure TWebInterface.DoJsCommand(Command: string);
begin
  _MyWebBrowser.ExecuteJavaScript(Command);
end;

function TWebInterface.ExecuteClientEvent(Sender: TObject;
  Request: HttpRequest): boolean;
begin
  Result := True;
end;

function TWebInterface.PrepareFile(Sender: TObject;
  FilePath: String): TMemoryStream;
var
  msResultFile: TMemoryStream;
  sFileType: AnsiString;
  fFile: TextFile;
  sBuf:AnsiString;
  _Out_buff:array [0..5000] of ansichar;
  iBufSize:integer;
begin
  msResultFile := TMemoryStream.Create;
  sFileType := AnsiString(UpperCase(ExtractFileExt(FilePath)));
  if (sFileType='.HTM') or (sFileType='.HTML') or (sFileType='.CSS') then
  begin
    AssignFile (fFile,FilePath);
    Reset(fFile);
    While not EOF(fFile)do
    begin
      readln(fFile,sBuf);
      if Assigned(ParceAndReplaceLine) then
        ParceAndReplaceLine(Self,sBuf);
      StrPCopy(_Out_buff, sBuf);
      iBufSize := Length(sBuf);
      _Out_buff[iBufSize] := #10;
      msResultFile.WriteBuffer(_Out_buff,iBufSize + 1);
    end;
    CloseFile(fFile);
    msResultFile.Seek(0,soBeginning);
  end else begin
    msResultFile.LoadFromFile(FilePath);
  end;
  Result := msResultFile;
end;

procedure TWebInterface.ReloadSkin;
begin
  _MyWebBrowser.Reload;
end;

constructor TWebInterface.Create(Parent: TWinControl);
begin
  inherited Create();
  _Parent := Parent;
  IndexFile := 'main.html';
  Port := 5068;
  SkinPath := ExtractFilePath(Application.ExeName) +  'Skins\new';
end;


procedure TWebInterface.ShowDevTools;
begin
  _MyWebBrowser.ShowDevTools;
end;

procedure TWebInterface.ShowUnblock;
begin
  _MyWebBrowser.ExecuteJavaScript('show_unblock_window();');
end;

procedure TWebInterface.Start;
begin
  _MyWebServer := TMyWebServer.Create;
  _MyWebServer.RootFolder := SkinPath;
  _MyWebServer.Port := Port;
  _MyWebServer.ExecuteClientEvent := ExecuteClientEvent;
  _MyWebServer.PrepareFileEvent := PrepareFile;
  _MyWebServer.start;
  _MyWebBrowser := TMyWebBrowser.Create(_Parent,'http://127.0.0.1:'
                                        + IntToStr(Port)
                                        + '/' + IndexFile );
end;

end.
