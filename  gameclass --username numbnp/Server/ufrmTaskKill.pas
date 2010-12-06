unit ufrmTaskKill;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList, GCLangutils, GCCommon, GCConst,
  ExtCtrls,
  ufrmTaskList;

type
  TfrmTaskKill = class(TForm)
    butKillSelTasks: TButton;
    butKillSet: TButton;
    butHelp: TButton;
    pnlButtons: TPanel;
    pnlTaskList: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure butHelpClick(Sender: TObject);
    procedure butKillSelTasksClick(Sender: TObject);
    procedure butKillSetClick(Sender: TObject);
  private
    FstrIPAddress: String;
    FfrmTaskList: TfrmTaskList;
  public
    constructor Create(const AOwner: TComponent;
        const AstrTaskList: String;
        const AbOnlyLists: Boolean = True;
        const AstrComputerName: String = '';
        const AstrIPAddress: String = ''); reintroduce;
    destructor Destroy; override;
  end;

var
  frmTaskKill: TfrmTaskKill;

implementation

uses
  gccomputers,
  gcfunctions,
  uRegistry,
  frmMain,
  uProtocol;

{$R *.dfm}

constructor TfrmTaskKill.Create(const AOwner: TComponent;
    const AstrTaskList: String;
    const AbOnlyLists: Boolean = True;
    const AstrComputerName: String = '';
    const AstrIPAddress: String = '');
begin
  inherited Create(AOwner);
  FfrmTaskList := TfrmTaskList.Create(pnlTaskList, AstrTaskList);
  FfrmTaskList.Parent := pnlTaskList;
  FfrmTaskList.Align := alClient;
  FfrmTaskList.Show;
  FstrIPAddress := AstrIPAddress;
  Caption := translate('Computer') + ' '
      + AstrComputerName;
  butKillSelTasks.Caption := translate('butKillSelectedProcesses');
  butHelp.Caption := translate('subHelp');
  butKillSet.Caption := translate('mnuKillTask');
end;

destructor TfrmTaskKill.Destroy;
begin
  FreeAndNil(FfrmTaskList);
  inherited Destroy;
end;

procedure TfrmTaskKill.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then ModalResult := mrCancel;
end;

procedure TfrmTaskKill.butHelpClick(Sender: TObject);
begin
  GCHelp(HELP_KILL_TASKS);
end;

procedure TfrmTaskKill.butKillSelTasksClick(Sender: TObject);
var
  i: Integer;
begin
  for i:=0 to (FfrmTaskList.lvTasks.Items.Count-1) do
    if FfrmTaskList.lvTasks.Items[i].Selected then
      UDPSend(FstrIPAddress,
          STR_CMD_KILLTASK + '='
          + FfrmTaskList.lvTasks.Items[i].Caption);
end;

procedure TfrmTaskKill.butKillSetClick(Sender: TObject);
var
  i: Integer;
begin
  for i:=0 to (GRegistry.TaskKill.Template.Count-1) do
     UDPSend(FstrIPAddress,
        STR_CMD_KILLTASK + '='
        + GRegistry.TaskKill.Template.Strings[i]);
end;

end.
