//////////////////////////////////////////////////////////////////////////////
//
// Модуль содержит описание и реализацию класса TBlocking.
// Класс Управляет блокировками
// программы GCClient.
//
// Класс реализован по шаблону Singleton.
// Для доступа к свойствам и методам класса используйте вызовы
// TBlocking.Instance."MethodName" или вспомогательную переменную Blocking.
//
//////////////////////////////////////////////////////////////////////////////

unit uBlocking;

interface

uses
  // project units
    uY2KCommon,
    uClientInfo,
    uClientOptions,
    ExtCtrls,
    uLockComp;
//const

type
  //
  // TBlocking
  //

  TBlocking = class(TObject)
  private
    // fields
    FbWindowsMinimized: Boolean;
    FbDisplayBlocked: Boolean;
    FtmrMain: TTimer;
    // private helper methods
    procedure _OnTimer(Sender: TObject);

  protected
    // constructor / destructor
    constructor CreateInstance();

    // class methods
    class function AccessInstance(
        const ARequest: TSingletonOperation): TBlocking;

    // properties methods

  public
    // constructor / destructor
    constructor Create();
    destructor Destroy(); override;

    // class methods
    class function Instance(): TBlocking;
    class procedure ReleaseInstance();

    // public methods
    procedure Init();


    // properties
    // окна свернуты
    property WindowsMinimized: Boolean
        read FbWindowsMinimized write FbWindowsMinimized;
    // дисплей отключен
    property DisplayBlocked: Boolean
        read FbDisplayBlocked write FbDisplayBlocked;
  end; // TBlocking


var
  GBlocking: TBlocking;


implementation

uses
  // system units
{$IFOPT D+}
  ufrmMain,
{$ENDIF}
  SysUtils,
  Windows,
  Messages,
  Forms, Math;
  // project units
//  uY2KCommon;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

// Exceptions: EAssertionFailed
constructor TBlocking.Create();
begin
  inherited Create();
  ASSERT(FALSE, Format('Access class %s through Instance only', [ClassName]));

end; // TBlocking.Create


constructor TBlocking.CreateInstance();
begin
  inherited Create();
  FtmrMain := TTimer.Create(Nil);
  FtmrMain.OnTimer := _OnTimer;
  FtmrMain.Interval := 1000;
  FtmrMain.Enabled := True;
  FbWindowsMinimized := False;
  FbDisplayBlocked := False;
end; // TBlocking.CreateInstance


destructor TBlocking.Destroy();
begin
  if AccessInstance(SinglOper_Access) = Self then begin
    AccessInstance(SinglOper_Destroy);
  end;
  FtmrMain.Free;
  inherited Destroy();
end; // TBlocking.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// class methods

class function TBlocking.AccessInstance(
    const ARequest: TSingletonOperation): TBlocking;
// Константа используется для хранения ссылки на единственный
// экземпляр класса. Такая реализация обусловлена отсутсвием
// в классах Delphi статических полей.
// ВНИМАНИЕ! Для корректной работы необходимо включить {$WRITEABLECONST ON}!
{$WRITEABLECONST ON}
const
  FInstance: TBlocking = nil;
begin
  case ARequest of
    SinglOper_Access: begin
      // do nothing
    end;

    SinglOper_Create: begin
      if not Assigned(FInstance) then begin
        FInstance := CreateInstance();
      end;
    end;

    SinglOper_Destroy: begin
      FInstance := nil;
    end;

    else begin
      ASSERT(FALSE,
          Format('Illegal request %d in AccessInstance', [Ord(ARequest)]));
    end;
  end;

  Result := FInstance;

{$WRITEABLECONST OFF}
end; // TBlocking.AccessInstance


class function TBlocking.Instance(): TBlocking;
const
  FInstance: TBlocking = nil;
begin
  Result := AccessInstance(SinglOper_Create);
end; // TBlocking.Instance


class procedure TBlocking.ReleaseInstance();
begin
  AccessInstance(SinglOper_Access).Free();
end; // TBlocking.ReleaseInstance


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods
procedure TBlocking._OnTimer(Sender: TObject);
begin
  If (GClientInfo.Stop < Time) then
    GClientInfo.Blocked := True;
  if GClientInfo.Blocked then
    frmMain.Show;
{$IFOPT D+}
  frmMain.pnlBlocked.Visible := True;
  if GClientInfo.Blocked then begin
    frmMain.pnlBlocked.Caption := 'BLOCKED'
  end else
    frmMain.pnlBlocked.Caption := 'Unblocked';
{$ELSE}
  if GClientInfo.Blocked then begin
    if GClientOptions.BlockKeyboard then
      LockKeyboard();
    if GClientOptions.BlockMouse then
      LockMouse();
    if GClientOptions.BlockTasks then begin
{$WARNINGS OFF}
      EnumWindows(@EnumWinProc, CMD_MINIMIZE);
{$WARNINGS ON}
      PostMessage(FindWindow('_RunpadClass',nil),WM_USER+20,0,0);
      FbWindowsMinimized := True;
    end;
    if GClientOptions.BlockDisplay
        and not GClientOptions.AllowCardsSupport then begin
      SendMessage(Application.Handle, wm_SysCommand, SC_MonitorPower, 1);
      FbDisplayBlocked := True;
    end;
  end else begin
    if GClientOptions.BlockKeyboard then
      UnlockKeyboard();
    if GClientOptions.BlockMouse then
      UnlockMouse();
    if GClientOptions.BlockTasks and FbWindowsMinimized then begin
{$WARNINGS OFF}
      EnumWindows (@EnumWinProc, CMD_RESTORE);
{$WARNINGS ON}
      FbWindowsMinimized := False;
    end;
    if GClientOptions.BlockDisplay and FbDisplayBlocked then begin
      SendMessage(Application.Handle, wm_SysCommand, SC_MonitorPower,-1);
      FbDisplayBlocked := True;
    end;
  end;
{$ENDIF}
end; // TBlocking.Save

procedure TBlocking.Init();
begin
end;


initialization

  GBlocking := TBlocking.Instance();

finalization

  TBlocking.ReleaseInstance();

end.
