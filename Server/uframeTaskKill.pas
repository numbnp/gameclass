unit uframeTaskKill;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ComCtrls,
  StdCtrls,
  ExtCtrls,
  Mask,
  RxToolEdit,
  ufrmTaskList;

type
  TframeTaskKill = class(TFrame)
    gbCommon: TGroupBox;
    pnlTemplate: TGroupBox;
    pnlTaskList: TPanel;
    rbtnInclude: TRadioButton;
    rbtnExclude: TRadioButton;
    rbtnRunPad: TRadioButton;
    rbtnNothing: TRadioButton;
    procedure rbtnIncludeClick(Sender: TObject);
  private
    FbControlsEnabled: Boolean;
    FfrmTaskList: TfrmTaskList;
    procedure ResetFrame;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
    procedure DoDesign;
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  end;

implementation
{$R *.dfm}
uses
  gcconst,
  uRegistry,
  uRegistryTaskKill,
  uTaskKillConst,
  uClientOptions,
  uClientOptionsConst,
  uSQLTools,
  udmMain,
  ADODB;

constructor TframeTaskKill.Create(AOwner: TComponent);
var
  dstList: TADODataSet;
  lstTasks, lstExcludedTasks: TStringList;
begin
  inherited Create(AOwner);

  lstTasks := TstringList.Create;
  lstExcludedTasks := TStringList.Create;
  lstExcludedTasks.Text := EXCLUDED_TASK_LIST;
  try
    dstList := TADODataSet.Create(Self);
    dsDoQuery(dmMain.cnnMain, dstList,
        'select distinct ExeFile from process');
    with dstList do begin
      while not Eof do begin
        if lstExcludedTasks.IndexOf(dstList.FieldValues['ExeFile']) = -1 then
          lstTasks.Add(dstList.FieldValues['ExeFile']);
        Next;
      end;
      dstList.Close;
    end;
    FreeAndNil(dstList);
  except
  end;
  FreeAndNil(lstExcludedTasks);
  FfrmTaskList := TfrmTaskList.Create(pnlTemplate, lstTasks.Text);
  FreeAndNil(lstTasks);
  FfrmTaskList.Parent := pnlTemplate;
  FfrmTaskList.Align := alClient;
  FfrmTaskList.Show;
end;

destructor TframeTaskKill.Destroy;
begin
  FreeAndNil(FfrmTaskList);
  inherited Destroy;
end;


function TframeTaskKill.GetID: integer;
begin
  GetID := FRAME_TASKKILL;
end;

procedure TframeTaskKill.DoDesign;
begin
  FbControlsEnabled := False;
  rbtnRunPad.Enabled := (GClientOptions.ShellMode = ShellMode_Runpad);
  case GRegistry.TaskKill.Mode of
    Include: rbtnInclude.Checked := True;
    Exclude: rbtnExclude.Checked := True;
    RunPad: begin
      if GClientOptions.ShellMode = ShellMode_Runpad then
        rbtnRunPad.Checked := True
      else
        rbtnInclude.Checked := True;
    end;
    Nothing: rbtnNothing.Checked := True;
  else
    rbtnInclude.Checked := True;
  end;
  FbControlsEnabled := True;
end;

// процедура ставит все контролы в исходные позиции
procedure TframeTaskKill.ResetFrame;
begin
  DoDesign;
end;

procedure TframeTaskKill.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
//  gb.Caption := translate('gbNotofocation');
end;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods
procedure TframeTaskKill.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TframeTaskKill.DisableControls;
begin
  FbControlsEnabled := False;
end;

procedure TframeTaskKill.rbtnIncludeClick(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  if rbtnInclude.Checked then
    GRegistry.TaskKill.Mode := Include
  else if rbtnExclude.Checked then
    GRegistry.TaskKill.Mode := Exclude
  else if rbtnRunPad.Checked then
    GRegistry.TaskKill.Mode := RunPad
  else if rbtnNothing.Checked then
    GRegistry.TaskKill.Mode := Nothing
  else
    GRegistry.TaskKill.Mode := Include;
end;

end.
