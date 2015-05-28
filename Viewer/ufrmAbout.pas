unit ufrmAbout;

interface

uses
  Registry,
  Windows,
  SysUtils,
  Classes,
  Graphics,
  Forms,
  Controls,
  StdCtrls,
  Buttons,
  ExtCtrls,
  ComCtrls,
  uY2KFileVersionInfoLabel,
  uY2KFileVersionInfo;

type
  TfrmAbout = class(TForm)
    OKButton: TButton;
    Image1: TImage;
    lblVersion: TLabel;
    Copyright: TLabel;
    lblWWW: TLabel;
    lblEmail: TLabel;
    ProductName: TLabel;
    lblRegisteredTo: TLabel;
    editRegs: TEdit;
    Shape1: TShape;
    lvModules: TListView;
    lblLicensedComps: TLabel;
    Y2KFileVersionInfo: TY2KFileVersionInfo;
    lblProductVersion: TY2KFileVersionInfoLabel;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lblWWWClick(Sender: TObject);
    procedure lblEmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation


uses
  ShellAPI;

resourcestring
  STR_UNREGISTERED_VERSION = 'Незаригистрированная демо-версия';

{$R *.dfm}

procedure TfrmAbout.FormActivate(Sender: TObject);
var
  li: TListItem;
begin
  li := lvModules.Items.Add;
  li.Caption := 'GCHardwareControl';
  if Registration.HardwareControl then
    li.SubItems.Insert(0, 'Да')
  else
    li.SubItems.Insert(0, 'Нет');

  li := lvModules.Items.Add;
  li.Caption := 'GCPrinterControl';
  if Registration.PrinterControl then
    li.SubItems.Insert(0, 'Да')
  else
    li.SubItems.Insert(0, 'Нет');

  li := lvModules.Items.Add;
  li.Caption := 'GCInternetControl for Windows';
  if Registration.InternetControl then
    li.SubItems.Insert(0, 'Да')
  else
    li.SubItems.Insert(0, 'Нет');

  li := lvModules.Items.Add;
  li.Caption := 'GCInternetControl for Linux/FreeBSD';
  if Registration.InternetControlComLinux then
    li.SubItems.Insert(0, 'Да')
  else
    li.SubItems.Insert(0, 'Нет');

  li := lvModules.Items.Add;
  li.Caption := 'GCKKMControl';
  if Registration.KKMControl then
    li.SubItems.Insert(0, 'Да')
  else
    li.SubItems.Insert(0, 'Нет');

  li := lvModules.Items.Add;
  li.Caption := 'GCViewer';
  if Registration.Viewer then
    li.SubItems.Insert(0, 'Да')
  else
    li.SubItems.Insert(0, 'Нет');

  li := lvModules.Items.Add;
  li.Caption := 'GCSync';
  if Registration.Sync then
    li.SubItems.Insert(0, 'Да')
  else
    li.SubItems.Insert(0, 'Нет');

  editRegs.Text := STR_UNREGISTERED_VERSION;
  lblLicensedComps.Caption := '';
  if StrLen(Registration.UserName) > 0 then
  begin
    editRegs.Text := Registration.UserName;
    lblLicensedComps.Caption := 'Лицензия на '
        + IntToStr(Registration.CompsRegs)
        + ' компьютеров';
  end;
end;

procedure TfrmAbout.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then ModalResult := mrCancel;
end;

procedure TfrmAbout.lblWWWClick(Sender: TObject);
begin
  ShellExecute(0,'open',pChar('http:// www.nodasoft.com/products/gc'),
      NIL, NIL, SW_SHOWNORMAL);
end;

procedure TfrmAbout.lblEmailClick(Sender: TObject);
begin
  ShellExecute(0,'open',
      pChar('mailto:support@nodasoft.com?subject=GCViewer&body=Version = '
      + lblProductVersion.Caption + ';  Registered to '
      + Registration.UserName), NIL, NIL, SW_SHOWNORMAL);
end;

end.

