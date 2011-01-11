unit uRegistration;

interface

const
  UNREGISTERED_VERSION = 'Unregistered trial version';
  GC_LINUX_CLIENT_COUNT = 'GCLinuxClientCount';
  GC_HARDWARE_CONTROL = 'GCHardwareControl';
  GC_PRINTER_CONTROL = 'GCPrinterControl';
  GC_INTERNET_CONTROL = 'GCInternetControl';
  GC_INTERNET_CONTROL_COM_LINUX ='GCInternetControlComLinux';
  GC_KKM_CONTROL = 'GCKKMControl';
  GC_VIEWER ='GCViewer';
  GC_SYNC ='GCSync';

type
  TRegistration = class
  public
    constructor Create;
  private
    FstrUserName  : PChar;
    FnTrialDaysTotal : Integer;
    FnTrialDaysLeft  : Integer;
    FnTrialExTotal : Integer;
    FnTrialExLeft   : Integer;
    FstrHardwareID: PChar;
    FpKey : Pointer;
    FnCompsRegs: Integer;
    FbHardwareControl: Boolean;
    FbInternetControl: Boolean;
    FbPrinterControl: Boolean;
    FbInternetControlLinux: Boolean;
    FbInternetControlComLinux: Boolean;
    FbKKMControl: Boolean;
    FbViewer: Boolean;
    FbSync: Boolean;
    FnLinuxClientCount: Integer;
  public
    property UserName: PChar
      read FstrUserName write FstrUserName;
    property TrialDaysTotal: Integer
      read FnTrialDaysTotal write FnTrialDaysTotal;
    property TrialDaysLeft: Integer
      read FnTrialDaysLeft write FnTrialDaysLeft;
    property TrialExTotal: Integer
      read FnTrialExTotal write FnTrialExTotal;
    property TrialExLeft: Integer
      read FnTrialExLeft write FnTrialExLeft;
    property HardwareID: PChar
      read FstrHardwareID write FstrHardwareID;
    property Key: Pointer
      read FpKey write FpKey;
    property CompsRegs: Integer
      read FnCompsRegs write FnCompsRegs;
    property HardwareControl: Boolean
      read FbHardwareControl write FbHardwareControl;
    property InternetControl: Boolean
      read FbInternetControl write FbInternetControl;
    property PrinterControl: Boolean
      read FbPrinterControl write FbPrinterControl;
    property InternetControlLinux: Boolean
      read FbInternetControlLinux write FbInternetControlLinux;
    property InternetControlComLinux: Boolean
      read FbInternetControlComLinux write FbInternetControlComLinux;
    property KKMControl: Boolean
      read FbKKMControl write FbKKMControl;
    property Viewer: Boolean
      read FbViewer write FbViewer;
    property Sync: Boolean
      read FbSync write FbSync;
    property LinuxClientCount: Integer
      read FnLinuxClientCount write FnLinuxClientCount;
  end;


var
  Registration: TRegistration;


implementation

uses
  Classes,
  Types,
  Registry,
  Windows,
  SysUtils,
  StrUtils;

constructor TRegistration.Create;
var
  Total,Left    : DWORD;
begin
  UserName := '';
  TrialDaysTotal := -1;
  TrialDaysLeft := -1;
  TrialExTotal := -1;
  TrialExLeft := -1;
  CompsRegs := 100;
  HardwareControl := False;
  InternetControl := False;
  PrinterControl := False;
  InternetControlLinux := False;
  InternetControlComLinux := False;
  KKMControl := False;
  Viewer := True;
  Sync := False;
  LinuxClientCount := 0;
end;
 
initialization
  Registration := TRegistration.Create;
  with Registration do begin
    PrinterControl := True;
    HardwareControl := True;
    InternetControl := True;
    PrinterControl := True;
    InternetControlLinux := True;
    InternetControlComLinux := True;
    KKMControl := True;
    Viewer := True;
    Sync := True;
    UserName := 'Free user';
    CompsRegs := 300;
    LinuxClientCount := 300;
    HardwareID := 'Free';
  end;

end.
