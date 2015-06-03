//////////////////////////////////////////////////////////////////////////////
//
// Невизуальный компонент TY2KHTMLHelp. Предоставляет подписчикам доступ к
// определенному файлу - справке. Работа организована по принципу шаблона
// observer.
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KHTMLHelp;

interface

uses
  SysUtils,
  Classes;

type

  // forward declarations
  TY2KHTMLHelp = class;

  // procedure-type for external function
  THtmlHelpA = function(hwndCaller: THandle; pszFile: PChar; uCommand: Cardinal;
      dwData: Longint): THandle; stdcall;


  //
  // TY2KHTMLHelpLink
  //

  TY2KHTMLHelpLink = class(TObject)
  private
    FSender: TY2KHTMLHelp;
    FOnChange: TNotifyEvent;
  public
    destructor Destroy(); override;
    procedure Change(); dynamic;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property Sender: TY2KHTMLHelp read FSender write FSender;
  end; // TY2KHTMLHelpLink


  //
  // TY2KHTMLHelp
  //

  TY2KHTMLHelp = class(TComponent)
  private
    // attributes
    FHtmlHelp       : THtmlHelpA;   // функция из внешней библиотеки работы
                                    // с HTML-справкой
    FhHelpLib       : THandle;      // хэндл библиотеки работы с HTML-справкой
    FstrHelpFileName: string;       // имя файла - справки
    FlstClients     : TList;        // список, в котором хранятся
                                    // "подписчики на файл-справку"
    FOnChange       : TNotifyEvent; // событие "изменения данных"

    // private methods
    function _LoadHtmlHelpLibrary(): boolean;
    procedure _UnloadHtmlHelpLibrary();
  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;
    // public methods
    function OpenHelp(): boolean;
    function Article(const AstrArticlePath: string): boolean;
    procedure RegisterChanges(AHTMLHelpLink: TY2KHTMLHelpLink);
    procedure UnregisterChanges(AHTMLHelpLink: TY2KHTMLHelpLink);
  published
    // properties
    property HelpFileName: string read FstrHelpFileName write FstrHelpFileName;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end; // TY2KHTMLHelp


implementation

uses
  Windows;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TY2KHTMLHelpLink

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

destructor TY2KHTMLHelpLink.Destroy();
begin
  if Sender <> nil then
    Sender.UnRegisterChanges(Self);
  inherited Destroy();
end; // TY2KHTMLHelpLink.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TY2KHTMLHelpLink.Change();
begin
  if Assigned(OnChange) then
    OnChange(Sender);
end;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TY2KHTMLHelp

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KHTMLHelp.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if not _LoadHtmlHelpLibrary() then
    raise Exception.Create('HtmlHelp library not loaded');
  FlstClients := TList.Create;
end; // TY2KHTMLHelp.Create

destructor TY2KHTMLHelp.Destroy();
begin
  // очищаем список клиентов
  if Assigned(FlstClients) then begin
    FlstClients.Clear();
    FlstClients.Free();
    FlstClients := nil;
  end;
  _UnloadHtmlHelpLibrary();
  inherited Destroy();
end; // TY2KHTMLHelp.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

function TY2KHTMLHelp.OpenHelp(): boolean;
begin
  Result := FALSE;
  if FhHelpLib <> 0 then
    Result := boolean(FHtmlHelp(GetDesktopWindow(),
      PChar(FstrHelpFileName), 0, 0));
end; // TY2KHTMLHelp.OpenHelp

function TY2KHTMLHelp.Article(const AstrArticlePath: string): boolean;
begin
  Result := FALSE;
  if FhHelpLib <> 0 then
    Result := boolean(FHtmlHelp(GetDesktopWindow(),
      PChar(FstrHelpFileName + '::\' + AstrArticlePath), 0, 0));
end; // TY2KHTMLHelp.Article

procedure TY2KHTMLHelp.RegisterChanges(AHTMLHelpLink: TY2KHTMLHelpLink);
begin
  ASSERT(Assigned(AHTMLHelpLink));

  AHTMLHelpLink.Sender := Self;
  if Assigned(FlstClients) then
    FlstClients.Add(AHTMLHelpLink);
end; // TY2KHTMLHelp.RegisterChanges

procedure TY2KHTMLHelp.UnregisterChanges(AHTMLHelpLink: TY2KHTMLHelpLink);
var i: integer;
begin
  ASSERT(Assigned(AHTMLHelpLink));

  if Assigned(FlstClients) then
    for i := 0 to FlstClients.Count - 1 do
      if FlstClients[i] = AHTMLHelpLink then begin
        AHTMLHelpLink.Sender := nil;
        FlstClients.Delete(i);
        Break;
      end;
end; // TY2KHTMLHelp.UnregisterChanges

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private methods

function TY2KHTMLHelp._LoadHtmlHelpLibrary(): boolean;
begin
  if FhHelpLib = 0 then
    try
      FHtmlHelp := nil;
      FhHelpLib := LoadLibrary('HHCTRL.OCX');
      if (FhHelpLib <> 0) then
        FHtmlHelp := GetProcAddress(FhHelpLib, 'HtmlHelpA');
    except
      //нет ошибки, HTML HELP не полностью установлен
      FhHelpLib := 0;
    end;
  Result := FhHelpLib <> 0;
end;

procedure TY2KHTMLHelp._UnloadHtmlHelpLibrary();
begin
  if FhHelpLib <> 0 then begin
    FreeLibrary(FhHelpLib);
    FhHelpLib := 0;
  end;
end; // TY2KHTMLHelp._UnloadHtmlHelpLibrary

end. //////////////////// end of file //////////////////////////////


