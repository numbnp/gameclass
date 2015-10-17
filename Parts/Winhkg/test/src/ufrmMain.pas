unit ufrmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  uWinhkg;

type
  TfrmMain = class(TForm)
    btnMouseHook: TButton;
    btnMouseUnhook: TButton;
    btnLoadHookDll: TButton;
    btnUnloadHookDll: TButton;
    btnKeyboardHook: TButton;
    btnKeyboardUnhook: TButton;
    btnTestKeyboard: TButton;
    btnTestMouse: TButton;
    Button1: TButton;
    Edit1: TEdit;
    Button2: TButton;
    procedure btnLoadHookDllClick(Sender: TObject);
    procedure btnMouseHookClick(Sender: TObject);
    procedure btnMouseUnhookClick(Sender: TObject);
    procedure btnUnloadHookDllClick(Sender: TObject);
    procedure btnKeyboardHookClick(Sender: TObject);
    procedure btnKeyboardUnhookClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnTestMouseClick(Sender: TObject);
    procedure btnTestKeyboardClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    FWinhkg: TWinhkg;

  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation




{$R *.dfm}


//------------------------------------------------------------------------------
// Константы и глобальные переменные
//------------------------------------------------------------------------------
var

  nXPos,
  nYPos:         Integer;




//------------------------------------------------------------------------------
// Имя:      InitDirectInput()
// Описание: Производит инициализацию объектов DirectInput в программе
//------------------------------------------------------------------------------
function InitDirectInput( hWnd: HWND ): Boolean;
{var
  lpdf: TDIDataFormat;
begin
  Result := FALSE;

  // Создаём главный объект DirectInput
  if FAILED( DirectInput8Create( GetModuleHandle( nil ), DIRECTINPUT_VERSION,
                                 IID_IDirectInput8, lpDI8, nil ) ) then
     Exit;
  lpDI8._AddRef();

  // Создаём объект для работы с клавиатурой
  if FAILED( lpDI8.CreateDevice( GUID_SysKeyboard, lpDIKeyboard, nil ) ) then
     Exit;
  lpDIKeyboard._AddRef();

  // Устанавливаем предопределённый формат для "простогй клавиатуры". В боль-
  // шинстве случаев можно удовлетвориться и установками, заданными в структуре
  // c_dfDIKeyboard по умолчанию, но в особых случаях нужно заполнить её самому
  lpdf := c_dfDIKeyboard;
  if FAILED( lpDIKeyboard.SetDataFormat( lpdf ) ) then
     Exit;

  // Устанавливаем уровень кооперации. Подробности о флагах смотри в DirectX SDK
//  DISCL_FOREGROUND
  if FAILED( lpDIKeyboard.SetCooperativeLevel( hWnd, DISCL_BACKGROUND or
                                                     DISCL_NONEXCLUSIVE ) ) then
     Exit;

  // Захвытываем клавиатуру
  lpDIKeyboard.Acquire();

  Result := TRUE;
end;}
begin
  Result := False;
end;




//------------------------------------------------------------------------------
// Имя:      ReleaseDirectInput()
// Описание: Производит удаление объектов DirectInput
//------------------------------------------------------------------------------
procedure ReleaseDirectInput();
begin
{  // Удаляем объект для работы с клавиатурой
  if lpDIKeyboard <> nil then // Можно проверить if Assigned( DIKeyboard )
  begin
    lpDIKeyboard.Unacquire(); // Освобождаем устройство
    lpDIKeyboard._Release();
    lpDIKeyboard := nil;
  end;

  // Последним удаляем главный объект DirectInput
  if lpDI8 <> nil then
  begin
    lpDI8._Release();
    lpDI8 := nil;
  end;}
end;


procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FWinhkg := TWinhkg.Create('winhkg.dll');
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FWinhkg);
end;

procedure TfrmMain.btnLoadHookDllClick(Sender: TObject);
begin
  FWinhkg.Init();
end;

procedure TfrmMain.btnMouseHookClick(Sender: TObject);
begin
  FWinhkg.SetClientHandle(frmMain.Handle);
  FWinhkg.LockMouse();
end;

procedure TfrmMain.btnMouseUnhookClick(Sender: TObject);
begin
  FWinhkg.UnlockMouse();
end;

procedure TfrmMain.btnUnloadHookDllClick(Sender: TObject);
begin
  FWinhkg.Final();
end;

procedure TfrmMain.btnKeyboardHookClick(Sender: TObject);
begin
 !!!!   FWinhkg.SetClientHandle(frmMain.Handle);
  FWinhkg.LockKeyboard();
end;

procedure TfrmMain.btnKeyboardUnhookClick(Sender: TObject);
begin
  FWinhkg.UnlockKeyboard();
end;


procedure TfrmMain.btnTestMouseClick(Sender: TObject);
begin
  if FWinhkg.IsLockMouse() then
    MessageDlg('Mouse locked', mtInformation, [mbOK], 0)
  else
    MessageDlg('Mouse unlocked', mtInformation, [mbOK], 0);
end;

procedure TfrmMain.btnTestKeyboardClick(Sender: TObject);
begin
  if FWinhkg.IsLockKeyboard() then
    MessageDlg('Keyboard locked', mtInformation, [mbOK], 0)
  else
    MessageDlg('Keyboard unlocked', mtInformation, [mbOK], 0);
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  Sleep(40000);
  if not InitDirectInput( frmMain.Handle ) then
  begin
    MessageBox( frmMain.Handle, 'Ошибка при инициализации DirectInput!',
                'Ошибка!', MB_ICONHAND );
    ReleaseDirectInput();
    Halt;
  end;
  FWinhkg.LockKeyboard();
  Sleep(40000);
  FWinhkg.UnlockKeyboard();
  ReleaseDirectInput();
end;

procedure TfrmMain.FormClick(Sender: TObject);
begin
frmMain.SetFocus;
end;
procedure TfrmMain.Button2Click(Sender: TObject);
begin
  FWinhkg.SetClientHandle(frmMain.Handle);
end;

end.
