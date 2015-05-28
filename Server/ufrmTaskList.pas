unit ufrmTaskList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ImgList, GCLangutils, GCCommon, GCConst,
  ExtCtrls;

type
  TfrmTaskList = class(TForm)
    lvTasks: TListView;
    lbTasksTemplate: TListBox;
    lblTaskList: TLabel;
    lblTaskTemplate: TLabel;
    butAddToTemplate: TButton;
    ilTasks: TImageList;
    butRemoveFromTemplate: TButton;
    butAddToTemplateFromEdit: TButton;
    edtTask: TEdit;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure butAddToTemplateClick(Sender: TObject);
    procedure butRemoveFromTemplateClick(Sender: TObject);
    procedure butHelpClick(Sender: TObject);
    procedure butAddToTemplateFromEditClick(Sender: TObject);
  private
  public
    constructor Create(const AOwner: TComponent;
        const AstrTaskList: String); reintroduce;
    destructor Destroy; override;
    procedure UpdateTemplateList;
    { Public declarations }
  end;

var
  frmTaskList: TfrmTaskList;

implementation

uses
  gccomputers,
  gcfunctions,
  uRegistry,
  frmMain,
  uProtocol;

{$R *.dfm}

constructor TfrmTaskList.Create(const AOwner: TComponent;
    const AstrTaskList: String);
var
  lstTasks: TStringList;
  i: Integer;
begin
  inherited Create(AOwner);
  lstTasks := TStringList.Create;
  lstTasks.Text := AstrTaskList;
  for i := 0 to lstTasks.Count - 1 do
    lvTasks.Items.Add.Caption := lstTasks.Strings[i];
  FreeAndNil(lstTasks);
  lblTaskList.Caption := translate('lblTasksList');
  lblTaskTemplate.Caption := translate('lblTaskTemplate');
  UpdateTemplateList;
  butRemoveFromTemplate.Enabled := FunctionAmIRight('fnRemoveFromTasksTemplate');
end;

destructor TfrmTaskList.Destroy;
begin
  inherited Destroy;
end;


procedure TfrmTaskList.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (key=27) then ModalResult := mrCancel;
end;

procedure TfrmTaskList.butAddToTemplateClick(Sender: TObject);
var
  i: integer;
  lstTasks: TStringList;
begin
  lstTasks := GRegistry.TaskKill.Template;
  for i:=0 to (lvTasks.Items.Count-1) do
    if (lvTasks.Items[i].Selected) then
      if lstTasks.IndexOf(lvTasks.Items[i].Caption) = -1 then
        lstTasks.Add(lvTasks.Items[i].Caption);
  GRegistry.TaskKill.Template := lstTasks;
  UpdateTemplateList;
  FreeAndNil(lstTasks);
end;

procedure TfrmTaskList.UpdateTemplateList;
var
  i: Integer;
  tmpStringList:TStringList;
begin

  lbTasksTemplate.Clear;
  tmpStringList := GRegistry.TaskKill.Template;
  for i:=0 to ( tmpStringList.Count-1) do
    lbTasksTemplate.Items.Add( tmpStringList.Strings[i] );
  FreeAndNil(tmpStringList);
end;

procedure TfrmTaskList.butRemoveFromTemplateClick(Sender: TObject);
var
  i: integer;
  lstTasks: TStringList;
begin
  lstTasks := GRegistry.TaskKill.Template;
  for i:=0 to (lbTasksTemplate.Items.Count-1) do
    if (lbTasksTemplate.Selected[i]) then
       lstTasks.Delete(
        lstTasks.IndexOf(lbTasksTemplate.Items.Strings[i]));
  GRegistry.TaskKill.Template := lstTasks;
  UpdateTemplateList;
end;

procedure TfrmTaskList.butHelpClick(Sender: TObject);
begin
  GCHelp(HELP_KILL_TASKS);
end;

procedure TfrmTaskList.butAddToTemplateFromEditClick(Sender: TObject);
var
  lstTasks: TStringList;
begin
  lstTasks := GRegistry.TaskKill.Template;
  if Length(edtTask.Text) > 0 then
    if lstTasks.IndexOf(edtTask.Text) = -1 then
      lstTasks.Add(edtTask.Text);
  GRegistry.TaskKill.Template := lstTasks;
  UpdateTemplateList;
  FreeAndNil(lstTasks);
end;

end.
