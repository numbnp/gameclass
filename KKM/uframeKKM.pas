unit uframeKKM;

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
  ExtCtrls, Mask, ToolEdit;

type
  TKKMProperty = class (TObject)
  private
    FstrPath: String;
    FstrNotes: String;
  public
    property Path: String
      read FstrPath write FstrPath;
    property Notes: String
      read FstrNotes write FstrNotes;
  end;

  TframeKKM = class(TFrame)
    gbTabs: TGroupBox;
    Panel1: TPanel;
    gbUnixPro: TGroupBox;
    cbxKKM: TCheckBox;
    cboKKMPlugin: TComboBox;
    gbKKMPlugin: TGroupBox;
    btnKKMConfig: TButton;
    memKKMNotes: TMemo;
    lblKKMNotes: TLabel;
    cbxDisconnectBlock: TCheckBox;
    cbxPrintNonFiscal: TCheckBox;
    cbxZOrderByCloseShift: TCheckBox;
    cbxCustomOperatorName: TCheckBox;
    edtOperatorName: TEdit;
    cbxUseCashInForPrepay: TCheckBox;
    cbxOnlyForOperator: TCheckBox;
    procedure cbxKKMClick(Sender: TObject);
    procedure cbxDisconnectBlockClick(Sender: TObject);
    procedure cboKKMPluginChange(Sender: TObject);
    procedure cbxZOrderByCloseShiftClick(Sender: TObject);
    procedure cbxPrintNonFiscalClick(Sender: TObject);
    procedure cbxCustomOperatorNameClick(Sender: TObject);
    procedure edtOperatorNameChange(Sender: TObject);
    procedure btnKKMConfigClick(Sender: TObject);
    procedure cbxUseCashInForPrepayClick(Sender: TObject);
    procedure cbxOnlyForOperatorClick(Sender: TObject);
  private
    { Private declarations }
    procedure ResetFrame;
    // private helper methods
    procedure _AfterControlDataChange(const AbDoDesign: Boolean = False);


  public
    function GetID: integer;
    procedure Activate(ID: integer);
    { Public declarations }
    procedure DoDesign;
  end;

  procedure ScanDir(const AstrStartDir: String; const AstrMask: String;
    var AlstFiles: TStrings);

implementation
{$R *.dfm}
uses
  gcconst,
  uRegistry,
  uRegistryKKM,
  uKKMPlugin,
  ufrmKKMConfig,
  gccomputers;

var
   GbframeKKMLock: Boolean = False;

function TframeKKM.GetID: integer;
begin
  GetID := FRAME_KKM;
end;

procedure TframeKKM.DoDesign;
var
  i: Integer;
begin
  GbframeKKMLock := True;
  cbxKKM.Checked := GRegistry.Modules.KKM.Active;
  cbxKKM.Enabled := Registration.KKMControl;
  cboKKMPlugin.Enabled := cbxKKM.Checked;
  cbxDisconnectBlock.Enabled := cbxKKM.Checked;
  cbxZOrderByCloseShift.Enabled := cbxKKM.Checked;
  cbxPrintNonFiscal.Enabled := cbxKKM.Checked;
  cbxCustomOperatorName.Enabled := cbxKKM.Checked;
  edtOperatorName.Enabled := cbxKKM.Checked
      and GRegistry.Modules.KKM.CustomOperatorName;
  cbxUseCashInForPrepay.Enabled := cbxKKM.Checked;
  cbxOnlyForOperator.Enabled := cbxKKM.Checked;
  if cbxKKM.Checked then begin
    for i := 0 to cboKKMPlugin.Items.Count - 1 do
      if GRegistry.Modules.KKM.PluginPath =
          TKKMProperty(cboKKMPlugin.Items.Objects[i]).Path then begin
        cboKKMPlugin.ItemIndex := i;
        memKKMNotes.Text := TKKMProperty(
            cboKKMPlugin.Items.Objects[i]).Notes;
      end;
    cbxDisconnectBlock.Checked := GRegistry.Modules.KKM.DisconnectBlock;
    cbxZOrderByCloseShift.Checked := GRegistry.Modules.KKM.ZOrderByCloseShift;
    cbxPrintNonFiscal.Checked := GRegistry.Modules.KKM.PrintNonFiscal;
    cbxCustomOperatorName.Checked := GRegistry.Modules.KKM.CustomOperatorName;
    edtOperatorName.Text := GRegistry.Modules.KKM.OperatorName;
    cbxUseCashInForPrepay.Checked := GRegistry.Modules.KKM.UseCashInForPrepay;
    cbxOnlyForOperator.Checked := GRegistry.Modules.KKM.OnlyForOperator;
  end;
  btnKKMConfig.Enabled := cbxKKM.Checked
      and (cboKKMPlugin.ItemIndex <> -1);
  GbframeKKMLock := False;
end;

// процедура ставит все контролы в исходные позиции
procedure TframeKKM.ResetFrame;
var
  lstFiles: TStrings;
  i: Integer;
  kkm: TKKMPlugin;
  kkmProperty: TKKMProperty;
begin
  //Смотрим что лежит в KKM
  kkm := TKKMPlugin.Create;
  lstFiles := TStringList.Create;
  ScanDir(ExtractFilePath(Application.ExeName) + KKM_FOLDER, '*.dll', lstFiles);
  for i := 0 to lstFiles.Count - 1 do begin
    if kkm.LoadDll(lstFiles[i]) then begin
      if kkm.IsKKMPlugin then begin
        kkmProperty := TKKMProperty.Create;
        kkmProperty.Path := lstFiles[i];
        kkmProperty.Notes := kkm.GetNotes;
        cboKKMPlugin.AddItem(kkm.GetName
            + ' (' + ExtractFileName(kkmProperty.Path)
            + ', ' + kkm.GetVersion + ')', kkmProperty);
      end;
      kkm.Final;
    end;
  end;
  DoDesign;
end;

procedure TframeKKM.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
//  gb.Caption := translate('gbNotofocation');
end;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TframeKKM._AfterControlDataChange(const AbDoDesign: Boolean = False);
begin
  if AbDoDesign then
    DoDesign;
  GbframeKKMLock := False;
end;

{procedure TframeKKM.cbxServerScriptClick(Sender: TObject);
begin
  if GbframeKKMLock then exit;  GbframeKKMLock := True;;
  GRegistry.Scripts.OnServer := cbxServerScript.Checked;
  _AfterControlDataChange(True);
end;
}
procedure ScanDir(const AstrStartDir: String; const AstrMask: String;
    var AlstFiles: TStrings);
var
  search : TSearchRec;
  strMask, strStartDir: String;
begin
  strMask := AstrMask;
  strStartDir := AstrStartDir;
  if strMask = '' then
    strMask := '*.*';
  if strStartDir[Length(strStartDir)] <>  '\' then
    strStartDir := strStartDir + '\';
  if FindFirst(strStartDir + strMask, faAnyFile, search) = 0 then begin
    repeat
      Application.ProcessMessages;
      if (search.Attr and faDirectory) <>  faDirectory then
        AlstFiles.Add(strStartDir + search.Name)
      else if (search.Name <>  '..') and (search.Name <>  '.') then begin
//        AlstFiles.Add(strStartDir + search.Name + '\');
        ScanDir(strStartDir + search.Name + '\', strMask, AlstFiles);
      end;
    until FindNext(search) <>  0;
    FindClose(search);
  end;
end;

procedure TframeKKM.cbxKKMClick(Sender: TObject);
begin
  if GbframeKKMLock then exit;  GbframeKKMLock := True;;
  GRegistry.Modules.KKM.Active := cbxKKM.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeKKM.cbxDisconnectBlockClick(Sender: TObject);
begin
  if GbframeKKMLock then exit;  GbframeKKMLock := True;;
  GRegistry.Modules.KKM.DisconnectBlock := cbxDisconnectBlock.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeKKM.cboKKMPluginChange(Sender: TObject);
begin
  if GbframeKKMLock then exit;  GbframeKKMLock := True;;
  if cboKKMPlugin.ItemIndex <> -1 then
    with cboKKMPlugin do begin
      GRegistry.Modules.KKM.PluginPath :=
          TKKMProperty(Items.Objects[ItemIndex]).Path;
      memKKMNotes.Text := TKKMProperty(Items.Objects[ItemIndex]).Notes;
    end;
  _AfterControlDataChange(True);
end;

procedure TframeKKM.cbxZOrderByCloseShiftClick(Sender: TObject);
begin
  if GbframeKKMLock then exit;  GbframeKKMLock := True;;
  GRegistry.Modules.KKM.ZOrderByCloseShift := cbxZOrderByCloseShift.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeKKM.cbxPrintNonFiscalClick(Sender: TObject);
begin
  if GbframeKKMLock then exit;  GbframeKKMLock := True;;
  GRegistry.Modules.KKM.PrintNonFiscal := cbxPrintNonFiscal.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeKKM.cbxCustomOperatorNameClick(Sender: TObject);
begin
  if GbframeKKMLock then exit;  GbframeKKMLock := True;;
  GRegistry.Modules.KKM.CustomOperatorName := cbxCustomOperatorName.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeKKM.edtOperatorNameChange(Sender: TObject);
begin
  if GbframeKKMLock then exit;  GbframeKKMLock := True;;
  GRegistry.Modules.KKM.OperatorName := edtOperatorName.Text;
  _AfterControlDataChange(True);
end;

procedure TframeKKM.btnKKMConfigClick(Sender: TObject);
var
  frmKKMConfig: TfrmKKMConfig;
  kkm: TKKMPlugin;
//  str: String;
begin
  with cboKKMPlugin do
    if ItemIndex <> -1 then begin
      kkm := TKKMPlugin.Create(TKKMProperty(Items.Objects[ItemIndex]).Path,
          GRegistry.Modules.KKM.Config);
      if kkm.GetConfigTypes = 'INTERNAL' then
        kkm.InternalConfig(Application.Handle)
      else begin
        frmKKMConfig := TfrmKKMConfig.Create(Self, kkm);
        if frmKKMConfig.ShowModal = mrOk then
          GRegistry.Modules.KKM.Config := frmKKMConfig.Config;
        FreeAndNil(frmKKMConfig);
      end;
      FreeAndNil(kkm);
    end;
end;

procedure TframeKKM.cbxUseCashInForPrepayClick(Sender: TObject);
begin
  if GbframeKKMLock then exit;  GbframeKKMLock := True;;
  GRegistry.Modules.KKM.UseCashInForPrepay := cbxUseCashInForPrepay.Checked;
  _AfterControlDataChange(True);
end;

procedure TframeKKM.cbxOnlyForOperatorClick(Sender: TObject);
begin
  if GbframeKKMLock then exit;  GbframeKKMLock := True;;
  GRegistry.Modules.KKM.OnlyForOperator := cbxOnlyForOperator.Checked;
  _AfterControlDataChange(True);
end;

end.
