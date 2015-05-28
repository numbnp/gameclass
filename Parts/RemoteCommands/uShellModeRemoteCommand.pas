//////////////////////////////////////////////////////////////////////////////
//
// TShellModeRemoteCommand
// Обработка режима шелла
//
//////////////////////////////////////////////////////////////////////////////
unit uShellModeRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TShellModeRemoteCommand
  //

  TShellModeRemoteCommand = class(TRemoteCommand)
  private
    // fields
    FstrShellMode: String;

  public
    // constructor / destructor
    constructor Create(); overload;
    constructor Create(const AstrShellMode: String); overload;

    // public methods
    procedure Execute(); override;

  end; // TShellModeRemoteCommand


implementation

uses
  // project units
  uY2KCommon,
  uY2KString,
  uClientConst,
  Windows,
  Registry,
  Messages;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TShellModeRemoteCommand.Create();
begin
  ASSERT(FALSE,
      'TShellModeRemoteCommand.Create need AstrShellMode parameter');
end; // TShellModeRemoteCommand.Create


constructor TShellModeRemoteCommand.Create(const AstrShellMode: String);
begin
  inherited Create();
  FstrShellMode := AstrShellMode;
end; // TShellModeRemoteCommand.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TShellModeRemoteCommand.Execute();
var
  reg: TRegistry;
  strDir: String;
begin
  if (FstrShellMode = 'RunPad1') then begin
    reg := TRegistry.Create;
    try
      reg.RootKey := HKEY_CURRENT_USER;
      if reg.OpenKey('SOFTWARE\RunpadShell', FALSE) then begin
        strDir := reg.ReadString('Install_Dir');
        if (strDir <> '') then begin
          strDir := strDir + '\rshell.exe 0';
          WinExec(PAnsiChar(Ansistring(strDir)), SW_HIDE);
        end;
        reg.CloseKey;
      end;
    except
    end;
    reg.Free;
  end else if (FstrShellMode = 'RunPad0') then begin
    PostMessage(FindWindow('_RunpadClass',nil), WM_USER + 12, 0, 0);
  end;
end; // TShellModeRemoteCommand.Execute


end.
