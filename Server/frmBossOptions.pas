unit frmBossOptions;

interface

uses
  GCLangUtils, GCConst, GCCommon,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, frameComputers, ExtCtrls, frameUsers,
  frameTarifs, StdCtrls, frameRights, frameCustomers,
  frameSideline, frameGC3Client, frameHardware, frameSound, frameTraffic,
  framePrinter, uframeRunPad, uframeScripts, uframeOptions, uframeInterface,
  uframeKKM, uframeTaskKill, uframeClientInterface, uframeDiscounts,frameMail;

type
  TformBossOptions = class(TForm)
    tvBossOptions: TTreeView;
    ilBossOptions: TImageList;
    framComputers1: TframComputers;
    framUsers1: TframUsers;
    framRights1: TframRights;
    butOk: TButton;
    butHelp: TButton;
    GroupBox1: TGroupBox;
    framSideline1: TframSideline;
    framHardware1: TframHardware;
    frameSound1: TframeSound;
    pnlBottom: TPanel;
    pnlClient: TPanel;
    Panel1: TPanel;
    frameRunPad1: TframeRunPad;
    frameScripts1: TframeScripts;
    frameTraffic1: TframeTraffic;
    frameKKM1: TframeKKM;
    frameTaskKill1: TframeTaskKill;
    frameClientInterface1: TframeClientInterface;
    frameDiscounts1: TframeDiscounts;
    frameInterface1: TframeInterface;
    frameOptions1: TframeOptions;
    framCustomers1: TframCustomers;
    framTarifs1: TframTarifs;
    framGC3Client1: TframGC3Client;
    framePrinter1: TframePrinter;
    framMail1: TframMail;
    procedure FormActivate(Sender: TObject);
    procedure tvBossOptionsChange(Sender: TObject; Node: TTreeNode);
    procedure butOkClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure butHelpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    curFrame: integer;
    procedure UpdateInformation;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formBossOptions: TformBossOptions;

implementation

uses
  GCFunctions,
  uKKMTools;

{$R *.dfm}

procedure TformBossOptions.FormActivate(Sender: TObject);
begin
  ModalResult := mrCancel;
  Caption := translate('mnuBossOptions');
  butOk.Caption := translate('butClose');
  butHelp.Caption := translate('subHelp');
  curFrame := FRAME_COMPUTERS;
  UpdateInformation;
end;

// процедура скрывает ненужные фреймы и открывает нужные
procedure TformBossOptions.UpdateInformation;
begin
  framComputers1.Activate(curFrame);
  framUsers1.Activate(curFrame);
  framTarifs1.Activate(curFrame);
  framSideline1.Activate(curFrame);
  framRights1.Activate(curFrame);
  frameOptions1.Activate(curFrame);
  framCustomers1.Activate(curFrame);
  frameSound1.Activate(curFrame);
  framePrinter1.Activate(curFrame);
  frameTraffic1.Activate(curFrame);
  framHardware1.Activate(curFrame);
  framGC3Client1.Activate(curFrame);
  frameRunPad1.Activate(curFrame);
  frameScripts1.Activate(curFrame);
  frameKKM1.Activate(curFrame);
  frameInterface1.Activate(curFrame);
  frameTaskKill1.Activate(curFrame);
  frameClientInterface1.Activate(curFrame);
  frameDiscounts1.Activate(curFrame);
  framMail1.Activate(curFrame);
end;

procedure TformBossOptions.tvBossOptionsChange(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.Selected then
  begin
    if (curFrame = FRAME_GC3CLIENT) then framGC3Client1.Save;
    if (curFrame = FRAME_CLIENT_INTERFACE) then frameClientInterface1.Save;
    curFrame := Node.SelectedIndex;
    UpdateInformation;
  end;
end;

procedure TformBossOptions.butOkClick(Sender: TObject);
begin
  framGC3Client1.Save;
  frameClientInterface1.Save;
end;

procedure TformBossOptions.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then ModalResult := mrCancel;
end;

procedure TformBossOptions.butHelpClick(Sender: TObject);
begin
  if (curFrame = FRAME_TARIFS) then GCHelp(HELP_SETTINGS_TARIFS);
  //----
  if (curFrame = FRAME_COMPUTERS) then GCHelp(HELP_BOSSOPTIONS_COMPUTERS);
  if (curFrame = FRAME_USERS) then GCHelp(HELP_BOSSOPTIONS_USERS);
  if (curFrame = FRAME_SIDELINE) then GCHelp(HELP_BOSSOPTIONS_SIDELINE);
  if (curFrame = FRAME_OPTIONS) then GCHelp(HELP_BOSSOPTIONS_OPTIONS);
  if (curFrame = FRAME_RIGHTS) then GCHelp(HELP_BOSSOPTIONS_RIGHTS);
  //if (curFrame = FRAME_) then GCHelp(HELP_BOSSOPTIONS_);
end;

procedure TformBossOptions.FormCreate(Sender: TObject);
begin
  KKMPluginStop;
end;

procedure TformBossOptions.FormDestroy(Sender: TObject);
begin
  KKMPluginStart;
end;

end.
