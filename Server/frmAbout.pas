unit frmAbout;

interface

uses
  GClangutils, GCCommon, GCConst, GCFunctions, GCComputers,
  frmAddKey,
  registry, ShellAPI,
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls,
  ComCtrls;

type
  TformAbout = class(TForm)
    OKButton: TButton;
    Image1: TImage;
    lblVersion: TLabel;
    Copyright: TLabel;
    lblWWW: TLabel;
    lblRegisteredTo: TLabel;
    editRegs: TEdit;
    Shape1: TShape;
    butKey: TButton;
    butHelp: TButton;
    lvModules: TListView;
    lblLicensedComps: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure butKeyClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lblWWWClick(Sender: TObject);
    procedure lblEmailClick(Sender: TObject);
    procedure butHelpClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formAbout: TformAbout;

implementation

uses
  frmGCMessageBox;

{$R *.dfm}

procedure TformAbout.FormActivate(Sender: TObject);
var
  li: TListItem;
begin
  li := lvModules.Items.Add;
  li.Caption := 'GCLinuxClientCount';
  li.SubItems.Insert(0, IntToStr(MAX_COMPUTERS));

  li := lvModules.Items.Add;
  li.Caption := 'GCHardwareControl';
  li.SubItems.Insert(0, 'Да');

  li := lvModules.Items.Add;
  li.Caption := 'GCPrinterControl';
  li.SubItems.Insert(0, 'Да');

  li := lvModules.Items.Add;
  li.Caption := 'GCInternetControl for Windows';

  li.SubItems.Insert(0, 'Да');

  li := lvModules.Items.Add;
  li.Caption := 'GCInternetControl for Linux/FreeBSD';

  li.SubItems.Insert(0, 'Да');

  li := lvModules.Items.Add;
  li.Caption := 'GCKKMControl';
  li.SubItems.Insert(0, 'Да');

  li := lvModules.Items.Add;
  li.Caption := 'GCViewer';
  li.SubItems.Insert(0, 'Да');

  li := lvModules.Items.Add;
  li.Caption := 'GCSync';
  li.SubItems.Insert(0, 'Да');

  editRegs.Text := STR_UNREGISTERED_VERSION;
  lblLicensedComps.Caption := '';
  editRegs.Text := 'Free';
  lblLicensedComps.Caption := 'Лицензия на '
        + IntToStr(MAX_COMPUTERS)
        + ' компьютеров';

end;

procedure TformAbout.butKeyClick(Sender: TObject);
var
  str: string;
  Reg: TRegistry;
  bTryFail: boolean;
  strTry : string;

begin
  if not isManager then begin
    MessageBox(HWND_TOP, PChar(translate('NoRegistrationAccess')),
        PChar('GameClass'),MB_OK or MB_ICONINFORMATION);
    exit;
  end;
 if GetKeyState(VK_CONTROL) < 0  then begin
    formGCMessageBox.memoInfo.Text := translate('GetHardwareIdInfo')
        + 'Free';
    formGCMessageBox.SetDontShowAgain(False);
    formGCMessageBox.ShowModal;
    exit;
  end;

  Application.CreateForm(TformAddKey, formAddKey);
  if (formAddKey.ShowModal = mrOK) then
  begin
    //MessageBox(HWND_TOP,PChar(Registration.LocalHardwareID),'',MB_OK);
    str := XorCodeString(formAddKey.memoKey.Text, 'Free');
    Reg := TRegistry.Create;
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    bTryFail := false;
    strTry := '';
    if Reg.OpenKey('\Software\GameClass3',True) then
    begin
      Reg.WriteString('Key',str);
      formGCMessageBox.memoInfo.Text := translate('ThankYouForRegs');
      formGCMessageBox.SetDontShowAgain(false);
      formGCMessageBox.ShowModal;
      strTry := Reg.ReadString('Key');
      Reg.CloseKey;
    end
    else 
      bTryFail := true;
    
    if (bTryFail) or ((not bTryFail) and (strTry <> str)) then
    begin
      formGCMessageBox.memoInfo.Text := translate('ThankYouForRegsDenyPermissions');
      formGCMessageBox.SetDontShowAgain(false);
      formGCMessageBox.ShowModal;
    end;
    Reg.Free;
  end;
  formAddKey.Destroy;
end;

procedure TformAbout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then ModalResult := mrCancel;
end;

procedure TformAbout.lblWWWClick(Sender: TObject);
begin
  ShellExecute(0,'open',pChar('http:// www.nodasoft.com/products/gc'),
      NIL, NIL, SW_SHOWNORMAL);
end;

procedure TformAbout.lblEmailClick(Sender: TObject);
begin
  ShellExecute(0,'open',
      pChar('mailto:support@nodasoft.com?subject=GameClass3&body=Version = '
      + APP_VERSION + ';  Registered to '
      + 'Free'), NIL, NIL, SW_SHOWNORMAL);
end;

procedure TformAbout.butHelpClick(Sender: TObject);
begin
  GCHelp(HELP_REGISTRATION);
end;


end.

