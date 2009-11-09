//////////////////////////////////////////////////////////////////////////////
//
//
//
//////////////////////////////////////////////////////////////////////////////

unit ufrmOptions;

interface

uses
  // system units
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  Mask,
  ToolEdit,
  ExtCtrls,
  VirtualTrees,
  Contnrs,
  ActnList,
  uY2KHTMLHelp,
  // project units
  uLanguagesManager,
  uOptions,
  uNavigatorOptions,
  uFormList;


type

  //
  // TfrmOptions
  //

  TfrmOptions = class(TForm)
    btnOk: TButton;
    btnApply: TButton;
    btnDefault: TButton;
    tvNavigator: TVirtualStringTree;
    pnlMain: TPanel;
    actlstOptions: TActionList;
    actApply: TAction;
    actOk: TAction;
    actDefault: TAction;
    btnCancel: TButton;
    actCancel: TAction;
    procedure tvNavigatorGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure tvNavigatorClick(Sender: TObject);
    procedure actApplyExecute(Sender: TObject);
    procedure actOkExecute(Sender: TObject);
    procedure actDefaultExecute(Sender: TObject);
    procedure tvNavigatorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actCancelExecute(Sender: TObject);

  private
    // fields
    FOptionsLink: TOptionsLink;
    FLanguagesManagerLink: TLanguagesManagerLink;
    FlstFrames: TFormList;

    FHTMLHelp: TY2KHTMLHelp;

    // localized strings
    OPTIONS_CAPTION: String;

    OPTIONS_MANAGE: String;
    OPTIONS_DISPLAY: String;
    OPTIONS_STARTPAGE: String;
    OPTIONS_GRIDS: String;
    OPTIONS_COLORS: String;
//    OPTIONS_ICONS: String;
    OPTIONS_LANGUAGE: String;
    OPTIONS_DEBUG: String;


    // events handlers
    procedure _OptionsChange(ASender: TObject; const AbChanged: Boolean);
    procedure _OptionsSave(ASender: TObject);
    procedure _LanguageChange(ASender: TObject);

    // private helper methods
    procedure _CreateAndInitOptionsFrames();
    procedure _FinalAndDestroyOptionsFrames();
    procedure _InitOptionsNavigator();
    procedure _SubscribeToOptionsEvents();
    procedure _SubscribeToLanguagesManagerEvents();
    function _AddNavigatorNode(const AptrNode: PVirtualNode;
        const AnId: Integer; const AstrCaption: String): PVirtualNode;
    procedure _ShowOptionsFrame(const AnFrameId: Integer);
    procedure _SetNodeCaption(const AnId: Integer;
        const AstrCaption: String);
    procedure _SetAllNodesCaptions();

  protected
    // properties methods
    procedure SetHTMLHelp(const AHTMLHelp: TY2KHTMLHelp);

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // properties
    property HTMLHelp: TY2KHTMLHelp read FHTMLHelp write SetHTMLHelp;

  end; // TfrmOptions


implementation

uses
  // project units
  ufrmBaseOptionsFrame,
  ufrmGeneralOptionsFrame,
  ufrmDisplayOptionsFrame,
  ufrmGridsOptionsFrame,
  ufrmColorsOptionsFrame,
//  ufrmIconsOptionsFrame,
  ufrmLanguageOptionsFrame,
  ufrmManageOptionsFrame,
  ufrmDebugOptionsFrame,
  ufrmStartPageOptionsFrame;

{$R *.dfm}

const
  // используем константу, так как в конструкторе
  // поле ClassName еще не определено
  CLASS_NAME = 'TfrmOptions';

type

  // структура для дерева навигации настроек
  POptionsNavigatorData = ^TOptionsNavigatorData;
  TOptionsNavigatorData = record
    Id: Integer;
    Caption: String;
  end; // TOptionsNavigatorData


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TfrmOptions.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  OPTIONS_CAPTION := 'Options';

  OPTIONS_MANAGE := 'Manage';
  OPTIONS_DISPLAY := 'Display';
  OPTIONS_STARTPAGE := 'Start Page';
  OPTIONS_GRIDS := 'Grids';
  OPTIONS_COLORS := 'Colors';
//  OPTIONS_ICONS := 'Icons';
  OPTIONS_LANGUAGE := 'Language';
  OPTIONS_DEBUG := 'Debug';

  actApply.Enabled := Options.IsChanged();

  _SubscribeToLanguagesManagerEvents();
  _SubscribeToOptionsEvents();
  _InitOptionsNavigator();
  _CreateAndInitOptionsFrames();
  _ShowOptionsFrame(0);
  tvNavigator.FocusedNode := tvNavigator.GetFirst(); 

  _LanguageChange(Self);

end; // TfrmOptions.Create


destructor TfrmOptions.Destroy();
begin
  FreeAndNil(FLanguagesManagerLink);
  FreeAndNil(FOptionsLink);
//  if Assigned(FOptionsLink) then begin
//    Options.UnregisterChanges(FOptionsLink);
//  end;
  _FinalAndDestroyOptionsFrames();
  inherited Destroy();
end; // TfrmOptions.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TfrmOptions.SetHTMLHelp(const AHTMLHelp: TY2KHTMLHelp);
var
  i: Integer;
begin
  FHTMLHelp := AHTMLHelp;
  for i := 0 to FlstFrames.Count - 1 do begin
    (FlstFrames[i] as TfrmBaseOptionsFrame).HTMLHelp := AHTMLHelp;
  end;
end; // TfrmOptions.SetHTMLHelp


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmOptions.actApplyExecute(Sender: TObject);
begin
  if Options.Language.LngIndex.IsChanged then begin
    LanguagesManager.SetLanguage(Options.Language.LngIndex.Value);
  end;
  Options.Save();
end; // TfrmOptions.actApplyExecute


procedure TfrmOptions.actOkExecute(Sender: TObject);
begin
  if Options.Language.LngIndex.IsChanged then begin
    LanguagesManager.SetLanguage(Options.Language.LngIndex.Value);
  end;
  Options.Save();

  Close();
  
end; // TfrmOptions.actCloseExecute


procedure TfrmOptions.actCancelExecute(Sender: TObject);
begin
  Options.Cancel();
  Close();
end; // TfrmOptions.actCancelExecute


procedure TfrmOptions.actDefaultExecute(Sender: TObject);
begin
  with Options do begin
    General.Default();
    Manage.Default();
    Display.Default();
    Database.Default();
    Debug.Default();
  end;
  // Options.Default();
end; // TfrmOptions.actDefaultExecute


procedure TfrmOptions.tvNavigatorGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  Data: POptionsNavigatorData;
begin
  Data := Sender.GetNodeData(Node);
  if Assigned(Data) then begin
    CellText := Data.Caption;
  end;
end; // TfrmOptions.tvNavigatorGetText


procedure TfrmOptions.tvNavigatorClick(Sender: TObject);
var
  ptrNavigatorData: POptionsNavigatorData;
begin
  if Assigned(tvNavigator.FocusedNode) then begin
    ptrNavigatorData := tvNavigator.GetNodeData(tvNavigator.FocusedNode);
    _ShowOptionsFrame(ptrNavigatorData^.Id);
  end;
end; // TfrmOptions.tvNavigatorClick


procedure TfrmOptions.tvNavigatorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  ptrNavigatorData: POptionsNavigatorData;
begin
  if Key = VK_RETURN then begin
    if Assigned(tvNavigator.FocusedNode) then begin
      ptrNavigatorData := tvNavigator.GetNodeData(tvNavigator.FocusedNode);
      _ShowOptionsFrame(ptrNavigatorData^.Id);
    end;
  end;
end; // TfrmOptions.tvNavigatorKeyDown


procedure TfrmOptions._OptionsSave(ASender: TObject);
begin
//
end; // TfrmOptions._OptionsSave


procedure TfrmOptions._OptionsChange(
    ASender: TObject; const AbChanged: Boolean);
begin
  actApply.Enabled := AbChanged;
//  actCancel.Enabled := AbChanged;
end; // TfrmOptions._OptionsChange


procedure TfrmOptions._LanguageChange(ASender: TObject);
var
  ptrNodeData: POptionsNavigatorData;
begin
  LanguagesManager.GetString(CLASS_NAME, actApply);
  LanguagesManager.GetString(CLASS_NAME, actOk);
  LanguagesManager.GetString(CLASS_NAME, actCancel);  
  LanguagesManager.GetString(CLASS_NAME, actDefault);

  LanguagesManager.GetString(
      CLASS_NAME, 'OPTIONS_MANAGE', '', OPTIONS_MANAGE);
  LanguagesManager.GetString(
      CLASS_NAME, 'OPTIONS_DISPLAY', '', OPTIONS_DISPLAY);
  LanguagesManager.GetString(
      CLASS_NAME, 'OPTIONS_STARTPAGE', '', OPTIONS_STARTPAGE);
  LanguagesManager.GetString(
      CLASS_NAME, 'OPTIONS_GRIDS', '', OPTIONS_GRIDS);
  LanguagesManager.GetString(
      CLASS_NAME, 'OPTIONS_COLORS', '', OPTIONS_COLORS);
//  LanguagesManager.GetString(
//      CLASS_NAME, 'OPTIONS_ICONS', '', OPTIONS_ICONS);
  LanguagesManager.GetString(
      CLASS_NAME, 'OPTIONS_LANGUAGE', '', OPTIONS_LANGUAGE);
  LanguagesManager.GetString(
      CLASS_NAME, 'OPTIONS_DEBUG', '', OPTIONS_DEBUG);

  _SetAllNodesCaptions();

  LanguagesManager.GetString(
      CLASS_NAME, '', 'Caption', OPTIONS_CAPTION);
  Caption := OPTIONS_CAPTION;

  if Assigned(tvNavigator.FocusedNode) then begin
    ptrNodeData := tvNavigator.GetNodeData(tvNavigator.FocusedNode);
    if Assigned(ptrNodeData) then begin
      Caption := Caption + ' - ' + ptrNodeData^.Caption;
    end;
  end;

end; // TfrmOptions._LanguageChange


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmOptions._SubscribeToOptionsEvents();
begin
  ASSERT(Assigned(Options),
      'TfrmOptions._SubscribeToOptionsEvents error! Options not created!');
  FOptionsLink := TOptionsLink.Create(Options);
  FOptionsLink.OnSave := _OptionsSave;
  FOptionsLink.OnChange := _OptionsChange;
end; // TfrmOptions._SubscribeToOptionsEvents


procedure TfrmOptions._SubscribeToLanguagesManagerEvents();
begin
  ASSERT(Assigned(LanguagesManager),
      'TfrmOptions._SubscribeToLanguagesManagerEvents error! '
      + 'LanguagesManager not created!');
  FLanguagesManagerLink := TLanguagesManagerLink.Create(LanguagesManager);
  FLanguagesManagerLink.OnLanguageChange := _LanguageChange;
end; // TfrmOptions._SubscribeToLanguagesManagerEvents


procedure TfrmOptions._CreateAndInitOptionsFrames();
var
  frmOptionsFrame: TForm;
begin
  FlstFrames := TFormList.Create(TRUE);

//  frmOptionsFrame := TfrmGeneralOptionsFrame.Create(pnlMain);
//  frmOptionsFrame.Parent := pnlMain;
//  frmOptionsFrame.Align := alClient;
//  frmOptionsFrame.Hide();
//  FlstFrames.Add(frmOptionsFrame);

  frmOptionsFrame := TfrmManageOptionsFrame.Create(pnlMain);
  frmOptionsFrame.Parent := pnlMain;
  frmOptionsFrame.Align := alClient;
  frmOptionsFrame.Hide();
  FlstFrames.Add(frmOptionsFrame);

  frmOptionsFrame := TfrmDisplayOptionsFrame.Create(pnlMain);
  frmOptionsFrame.Parent := pnlMain;
  frmOptionsFrame.Align := alClient;
  frmOptionsFrame.Hide();
  FlstFrames.Add(frmOptionsFrame);

  frmOptionsFrame := TfrmStartPageOptionsFrame.Create(pnlMain);
  frmOptionsFrame.Parent := pnlMain;
  frmOptionsFrame.Align := alClient;
  frmOptionsFrame.Hide();
  FlstFrames.Add(frmOptionsFrame);

  frmOptionsFrame := TfrmGridsOptionsFrame.Create(pnlMain);
  frmOptionsFrame.Parent := pnlMain;
  frmOptionsFrame.Align := alClient;
  frmOptionsFrame.Hide();
  FlstFrames.Add(frmOptionsFrame);

  frmOptionsFrame := TfrmColorsOptionsFrame.Create(pnlMain);
  frmOptionsFrame.Parent := pnlMain;
  frmOptionsFrame.Align := alClient;
  frmOptionsFrame.Hide();
  FlstFrames.Add(frmOptionsFrame);

//  frmOptionsFrame := TfrmIconsOptionsFrame.Create(pnlMain);
//  frmOptionsFrame.Parent := pnlMain;
//  frmOptionsFrame.Align := alClient;
//  frmOptionsFrame.Hide();
//  FlstFrames.Add(frmOptionsFrame);

  frmOptionsFrame := TfrmLanguageOptionsFrame.Create(pnlMain);
  frmOptionsFrame.Parent := pnlMain;
  frmOptionsFrame.Align := alClient;
  frmOptionsFrame.Hide();
  FlstFrames.Add(frmOptionsFrame);

{$IFOPT D+}
  frmOptionsFrame := TfrmDebugOptionsFrame.Create(pnlMain);
  frmOptionsFrame.Parent := pnlMain;
  frmOptionsFrame.Align := alClient;
  frmOptionsFrame.Hide();
  FlstFrames.Add(frmOptionsFrame);
{$ENDIF}

end; // TfrmOptions._CreateAndInitOptionsFrames


procedure TfrmOptions._FinalAndDestroyOptionsFrames();
begin
  FreeAndNil(FlstFrames);
end; // TfrmOptions._FinalAndDestroyOptionsFrames


function TfrmOptions._AddNavigatorNode(const AptrNode: PVirtualNode;
    const AnId: Integer; const AstrCaption: String): PVirtualNode;
var
  node: PVirtualNode;
  ptrNavigatorData: POptionsNavigatorData;
begin
  if Assigned(AptrNode) then begin
    tvNavigator.ChildCount[AptrNode] := tvNavigator.ChildCount[AptrNode] + 1;
    node := tvNavigator.GetLast(AptrNode);
  end else begin
    tvNavigator.RootNodeCount := tvNavigator.RootNodeCount + 1;
    node := tvNavigator.GetLast();
  end;
  ptrNavigatorData := tvNavigator.GetNodeData(node);
  ptrNavigatorData^.Id := AnId;
  ptrNavigatorData^.Caption := AstrCaption;
  Result := node;
end; // TfrmOptions._AddNavigatorNode


procedure TfrmOptions._InitOptionsNavigator();
var
  node: PVirtualNode;
begin
  tvNavigator.NodeDataSize := SizeOf(TOptionsNavigatorData);
//  _AddNavigatorNode(nil, 0, 'General');
  _AddNavigatorNode(nil, 0, OPTIONS_MANAGE);
  node := _AddNavigatorNode(nil, 1, OPTIONS_DISPLAY);
  _AddNavigatorNode(node, 2, OPTIONS_STARTPAGE);
  _AddNavigatorNode(node, 3, OPTIONS_GRIDS);
  _AddNavigatorNode(node, 4, OPTIONS_COLORS);
//  _AddNavigatorNode(node, 5, OPTIONS_ICONS);
  _AddNavigatorNode(nil, 5, OPTIONS_LANGUAGE);
{$IFOPT D+}
  _AddNavigatorNode(nil, 6, OPTIONS_DEBUG);
{$ENDIF}
  tvNavigator.FullExpand(nil);
end; // TfrmOptions._InitOptionsNavigator


procedure TfrmOptions._ShowOptionsFrame(const AnFrameId: Integer);
var
  ptrNodeData: POptionsNavigatorData;
begin
  ASSERT((0 <= AnFrameId) and (AnFrameId < FlstFrames.Count),
      'TfrmOptions._ShowOptionsFrame error! Out of list bounds!');

  FlstFrames.ShowOneForm(AnFrameId);

  Caption := OPTIONS_CAPTION;

  if Assigned(tvNavigator.FocusedNode) then begin
    ptrNodeData := tvNavigator.GetNodeData(tvNavigator.FocusedNode);
    if Assigned(ptrNodeData) then begin
      Caption := Caption + ' - ' + ptrNodeData^.Caption;
    end;
  end;

end; // TfrmOptions._ShowOptionsFrame


procedure TfrmOptions._SetAllNodesCaptions();
begin
  _SetNodeCaption(0, OPTIONS_MANAGE);
  _SetNodeCaption(1, OPTIONS_DISPLAY);
  _SetNodeCaption(2, OPTIONS_STARTPAGE);
  _SetNodeCaption(3, OPTIONS_GRIDS);
  _SetNodeCaption(4, OPTIONS_COLORS);
//  _SetNodeCaption(5, OPTIONS_ICONS);
  _SetNodeCaption(5, OPTIONS_LANGUAGE);
{$IFOPT D+}
  _SetNodeCaption(6, OPTIONS_DEBUG);
{$ENDIF}
end; // TfrmOptions._SetAllNodesCaptions


procedure TfrmOptions._SetNodeCaption(const AnId: Integer;
    const AstrCaption: String);
var
  ptrNode: PVirtualNode;
  ptrNodeData: POptionsNavigatorData;
begin
  ptrNode := tvNavigator.GetFirst();
  while Assigned(ptrNode) do begin
    ptrNodeData := tvNavigator.GetNodeData(ptrNode);
    if Assigned(ptrNodeData) then begin
      if ptrNodeData^.Id = AnId then begin
        ptrNodeData^.Caption := AstrCaption;
        tvNavigator.InvalidateNode(ptrNode);
        break;
      end;
    end;
    ptrNode := tvNavigator.GetNext(ptrNode);
  end;
end; // TfrmOptions._SetNodeCaption


end.
