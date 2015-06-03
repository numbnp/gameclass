//////////////////////////////////////////////////////////////////////////////
//
// Компонент TY2KSysInfoButton. При нажатии выдает информацию о системе и
// об установленном оборудовании (запускает утилиту из стандартного
// комплекта Windows.
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KSysInfoButton;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  StdCtrls;

type

  //
  // TY2KSysInfoButton
  //

  TY2KSysInfoButton = class(TButton)
  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;

    // public methods
    procedure Click(); override;
  end; // TY2KSysInfoButton



implementation

uses
  Dialogs,
  Registry,
  ShellApi,
  resstrings;

const

  REGKEYSYSINFOLOC = 'SOFTWARE\Microsoft\Shared Tools Location';
  REGVALSYSINFOLOC = 'MSINFO';
  REGKEYSYSINFO = 'SOFTWARE\Microsoft\Shared Tools\MSINFO';
  REGVALSYSINFO = 'PATH';

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KSysInfoButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := 'SystemInfo';
end; // TY2KSysInfoButton.Create

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TY2KSysInfoButton.Click;
var strSysInfoPath: string;
    reg: TRegistry;
begin
  inherited Click();
  Reg := TRegistry.Create;
  strSysInfoPath := '';
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey(REGKEYSYSINFO,True) then begin
        strSysInfoPath:=Reg.ReadString(REGVALSYSINFO);
        Reg.CloseKey;
      end
    else if Reg.OpenKey(REGKEYSYSINFOLOC,True) then begin
        strSysInfoPath:=Reg.ReadString(REGVALSYSINFOLOC);
        Reg.CloseKey;
      end;
    // из реестра считали информацию о пути к файлу с информацией о системе
    // теперь проверим существование этого файла
    if FileExists(strSysInfoPath) then
      ShellExecute(0, 'open', PChar(strSysInfoPath), '', '', SW_SHOWNORMAL)
    else
      MessageDlg(STR_ERROR_MSINFO32 + ' ' + strSysInfoPath, mtError, [mbOK], 0);
  finally
    Reg.Free;
  end;
end; // TY2KSysInfoButton.Click


end. /////////////////////////// end of file /////////////////////////////////
