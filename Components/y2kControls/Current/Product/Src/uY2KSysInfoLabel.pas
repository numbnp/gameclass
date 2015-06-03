//////////////////////////////////////////////////////////////////////////////
//
// TY2KSysInfoLabel.
// Компонент отображения информации, предоставляемой невизуальным
// компонентом TY2KSysInfo.
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KSysInfoLabel;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  StdCtrls;

type
  TLabelType = (OS, OSBuildNumber, UserName, ComputerName,
                WindowsDir, SystemDir, TempDir, AvailMem,
                TotalMem, AvailPageFile, TotalPageFile,
                AvailVirtual, TotalVirtual);

  //
  // TY2KSysInfoLabel
  //

  TY2KSysInfoLabel = class(TLabel)
  private
    // attributes
    FLabelType      : TLabelType;
    FstrDescription : string;

    // private methods
    procedure _SetCaption();
  public
    // constructor / destructor
    constructor Create(AOwner:TComponent); override;

    // properties methods
    procedure SetLabelType(ALabelType:TLabelType);
    procedure SetDescription(AstrDescription:string);

  published
    // properties
    property LabelType: TLabelType read FLabelType write SetLabelType;
    property Description: string read FstrDescription write SetDescription;
  end; // TY2KSysInfoLabel


implementation

uses
  uY2KSysInfo;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TY2KSysInfoLabel

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KSysInfoLabel.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  _SetCaption();
end; // TY2KSysInfoLabel.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TY2KSysInfoLabel.SetDescription(AstrDescription:string);
begin
  FstrDescription := AstrDescription;
  _SetCaption();
end; // TY2KSysInfoLabel.SetDescription

procedure TY2KSysInfoLabel.SetLabelType(ALabelType:TLabelType);
begin
  FLabelType := ALabelType;
  _SetCaption();
end; // TY2KSysInfoLabel.SetLabelType


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private methods

procedure TY2KSysInfoLabel._SetCaption();
var strTempCaption:string;
begin
  case FLabelType of
    OS: strTempCaption := SIGetOS;
    OSBuildNumber: strTempCaption := SIGetOSBuildNumber;
    UserName: strTempCaption := SIGetUserName;
    ComputerName: strTempCaption := SIGetComputerName;
    WindowsDir: strTempCaption := SIGetWindowsDir;
    SystemDir: strTempCaption := SIGetSystemDir;
    TempDir: strTempCaption := SIGetTempDir;
    AvailMem: strTempCaption := SIGetTotalMemory;
    TotalMem: strTempCaption := SIGetAvailMemory;
    AvailPageFile: strTempCaption := SIGetTotalPageFile;
    TotalPageFile: strTempCaption := SIGetAvailPageFile;
    AvailVirtual: strTempCaption := SIGetTotalVirtual;
    TotalVirtual: strTempCaption := SIGetAvailVirtual;
  end;
  Caption := FstrDescription + strTempCaption;
end; // TY2KSysInfoLabel.SetCaption

end. /////////////////////////// end of file /////////////////////////////////

