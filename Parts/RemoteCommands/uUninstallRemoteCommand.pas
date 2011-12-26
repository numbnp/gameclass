//////////////////////////////////////////////////////////////////////////////
//
// TUninstallRemoteCommand
// Команда ре/деинсталляции клиента, поступающая от управляющего сервера.
//
// Карамани Юрий - 05.2005
//
//////////////////////////////////////////////////////////////////////////////

unit uUninstallRemoteCommand;

interface

uses
  // project units
  uRemoteCommand;

type

  //
  // TUninstallRemoteCommand
  //

  TUninstallRemoteCommand = class(TRemoteCommand)
  protected
    // fields
    FbReinstall: Boolean;
  public
    // constructor / destructror
    constructor Create(const AbReinstall: Boolean);

    // public methods
    procedure Execute(); override;

    // properties
    property Reinstall: Boolean read FbReinstall write FbReinstall;

  end; // TUninstallRemoteCommand


implementation

uses
  Types,
{$IFDEF MSWINDOWS}
  Windows,
  ShellAPI,
{$ENDIF}
  SysUtils,
  uDebugLog,
  uFilesSynchronizeConst;

const
  UNINSTALL_FILENAME = 'unins000.exe';

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TUninstallRemoteCommand.Create(const AbReinstall: Boolean);
begin
  inherited Create();

  FbReinstall := AbReinstall;

end; // TUninstallRemoteCommand.Create

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TUninstallRemoteCommand.Execute();
var
  strCommand: String;
  strParameters: String;
begin
  strCommand := ExtractFilePath(ParamStr(0));
  strParameters := '/S';
  if Reinstall then begin
    strCommand := strCommand + FILE_RECEIVE_DIR_DEF + '\'
        + FILE_INSTALL_FILENAME_DEF;
  end else begin
    strCommand := strCommand + '..\' + UNINSTALL_FILENAME;
  end;
{$IFDEF MSWINDOWS}
  ShellExecute(0, Nil, PChar(strCommand), PCHar(strParameters), Nil, SW_NORMAL);
{$ENDIF}
{$IFDEF LINUX}
//  ShellExecute(0, Nil, PChar(strCommand), PCHar(strParameters), Nil, SW_NORMAL);
{$ENDIF}
end; // TUninstallRemoteCommand.Execute


end. ////////////////////////// end of file //////////////////////////////////
