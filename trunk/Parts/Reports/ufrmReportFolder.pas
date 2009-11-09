unit ufrmReportFolder;

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
  VirtualTrees,
  //GIFImage,
  StdCtrls,
  ExtCtrls,
//  uLanguagesManager,
  ufrmReport,
  uReport,
  uReportCommon;


type

  // events types
  TChangeReportNode = procedure(
      const ASender: TObject; const AnReportId: Integer) of object;


  //
  // TfrmReportFolder
  //

  TfrmReportFolder = class(TfrmReport)
    tvReportFolder: TVirtualStringTree;
    edtFolderName: TEdit;
    pnlFolderName: TPanel;
    lblFolder: TLabel;
    procedure tvReportFolderInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure tvReportFolderFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure tvReportFolderGetText(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure tvReportFolderSaveNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Stream: TStream);
    procedure tvReportFolderLoadNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Stream: TStream);
    procedure tvReportFolderGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure tvReportFolderDblClick(Sender: TObject);
    procedure edtFolderNameChange(Sender: TObject);

  private
    // fields
    FReport: TReport;

    FbInit: Boolean;

    FbEditMode: Boolean;

    FOnChangeReportNode: TChangeReportNode;
    FOnModifyReport: TModifyReport;

//    FLanguagesManagerLink: TLanguagesManagerLink;

    // events handlers
//    procedure _LanguageChange(ASender: TObject);

    // private helper methods
    procedure _ExpandAllNodes();
    procedure _TuneForm();
//    procedure _SubscribeToLanguagesManagerEvents();

    // fire methods
    procedure _FireChangeReportNode(const AnReportId: Integer);
    procedure _FireModifyReport();

  protected
    // properties methods
    procedure SetEditMode(const AbEditMode: Boolean);

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // public methods
    procedure SetReport(const AReport: TReport); override;
    procedure Storage(); override;
    procedure SetFolder(const AtvSource: TVirtualStringTree;
        const AptrNode: PVirtualNode);

    // properties
    property EditMode: Boolean read FbEditMode write SetEditMode;
    property OnChangeReportNode: TChangeReportNode
        read FOnChangeReportNode write FOnChangeReportNode;
    property OnModifyReport: TModifyReport
        read FOnModifyReport write FOnModifyReport;

  end; // TfrmReportFolder


implementation

{$R *.dfm}

const
  CLASS_NAME = 'TfrmReportFolder';

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TfrmReportFolder.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FbInit := FALSE;
  FbEditMode := FALSE;

  tvReportFolder.NodeDataSize := SizeOf(TReportData);

//  _SubscribeToLanguagesManagerEvents();
//  _LanguageChange(Self);

  _TuneForm();

end; // TfrmReportFolder.Create


destructor TfrmReportFolder.Destroy();
begin
//  FreeAndNil(FLanguagesManagerLink);

  inherited Destroy();

end; // TfrmReportFolder.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TfrmReportFolder.SetReport(const AReport: TReport);
begin
  FReport := AReport;

  if Assigned(FReport) then begin
    FbInit := TRUE;
    edtFolderName.Text := FReport.ReportName;
    FbInit := FALSE;
  end;

end; // TfrmReportFolder.SetReport


procedure TfrmReportFolder.Storage();
begin
// do nothing
end; // TfrmReportFolder.Storage


procedure TfrmReportFolder.SetFolder(
    const AtvSource: TVirtualStringTree; const AptrNode: PVirtualNode);
begin
  tvReportFolder.Clear();
  tvReportFolder.Images := AtvSource.Images;
  AtvSource.CopyTo(AptrNode, tvReportFolder, amInsertAfter, TRUE);
  _ExpandAllNodes();
end; // TfrmReportFolder.SetFolder


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TfrmReportFolder.SetEditMode(const AbEditMode: Boolean);
begin
  FbEditMode := AbEditMode;
  _TuneForm();
end; // TfrmReportFolder.SetEditMode


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmReportFolder.tvReportFolderInitNode(Sender: TBaseVirtualTree;
  ParentNode, Node: PVirtualNode;
  var InitialStates: TVirtualNodeInitStates);
var
  ptrData: PReportData;
begin
  ptrData := Sender.GetNodeData(Node);
  ptrData.Caption := '';
end; // TfrmReportFolder.tvReportFolderInitNode


procedure TfrmReportFolder.tvReportFolderFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  ptrData: PReportData;
begin
  ptrData := Sender.GetNodeData(Node);
  if Assigned(ptrData) then begin
    ptrData.Caption := '';
  end;
end; // TfrmReportFolder.tvReportFolderFreeNode


procedure TfrmReportFolder.tvReportFolderGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: WideString);
var
  ptrData: PReportData;
begin
  ptrData := Sender.GetNodeData(Node);
  if Assigned(ptrData) then begin
    CellText := ptrData.Caption;
  end;
end; // TfrmReportFolder.tvReportFolderGetText


procedure TfrmReportFolder.tvReportFolderGetImageIndex(
  Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind;
  Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  ptrData: PReportData;
begin
  if (Kind in [ikNormal, ikSelected ]) then begin
    ptrData := Sender.GetNodeData(Node);
    if Assigned(ptrData) then begin
      if ptrData^.IsFolder then begin
        ImageIndex := 0;
      end else begin
        ImageIndex := 1;
      end;
    end;
    Ghosted := FALSE;
  end;
end; // TfrmReportFolder.tvReportFolderGetImageIndex


procedure TfrmReportFolder.tvReportFolderSaveNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Stream: TStream);
var
  ptrNodeData: PReportData;
begin
  ptrNodeData := Sender.GetNodeData(Node);
  if Assigned(ptrNodeData) then begin
    Stream.Write(ptrNodeData^, SizeOf(TReportData));
  end;
end; // TfrmReportFolder.tvReportFolderSaveNode


procedure TfrmReportFolder.tvReportFolderLoadNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Stream: TStream);
var
  ptrNodeData: PReportData;
begin
  ptrNodeData := Sender.GetNodeData(Node);
  if Assigned(ptrNodeData) then begin
    Stream.Read(ptrNodeData^, SizeOf(TReportData));
  end;
end; // TfrmReportFolder.tvReportFolderLoadNode


procedure TfrmReportFolder.tvReportFolderDblClick(Sender: TObject);
var
  ptrNodeData: PReportData;
begin
  if Assigned(tvReportFolder.FocusedNode) then begin
    ptrNodeData := tvReportFolder.GetNodeData(tvReportFolder.FocusedNode);
    _FireChangeReportNode(ptrNodeData^.id);
  end;
end; // TfrmReportFolder.tvReportFolderDblClick


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmReportFolder.edtFolderNameChange(Sender: TObject);
begin
  if Assigned(FReport) and not FbInit then begin
    FReport.ReportName := edtFolderName.Text;
    _FireModifyReport();
  end;
end; // TfrmReportFolder.edtFolderNameChange


{procedure TfrmReportFolder._LanguageChange(ASender: TObject);
begin
  with LanguagesManager do begin
    GetString(CLASS_NAME, TLabel(lblFolder));
  end;
end; // TfrmReportFolder._LanguageChange
}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmReportFolder._ExpandAllNodes();
var
  ptrNode: PVirtualNode;
begin
  ptrNode := tvReportFolder.GetFirst();
  while Assigned(ptrNode) do begin
    tvReportFolder.Expanded[ptrNode] := TRUE;
    ptrNode := tvReportFolder.GetNext(ptrNode);
  end;
end; // TfrmReportFolder._ExpandAllNodes


procedure TfrmReportFolder._TuneForm();
begin
  pnlFolderName.Visible := FbEditMode;
end; // TfrmReportFolder._TuneForm


{procedure TfrmReportFolder._SubscribeToLanguagesManagerEvents();
begin
  ASSERT(Assigned(LanguagesManager),
      'TfrmReportFolder._SubscribeToLanguagesManagerEvents error! '
      + 'LanguagesManager not created!');

  FLanguagesManagerLink := TLanguagesManagerLink.Create(LanguagesManager);
  FLanguagesManagerLink.OnLanguageChange := _LanguageChange;

end; // TfrmReportFolder._SubscribeToLanguagesManagerEvents
}

//////////////////////////////////////////////////////////////////////////////
// fire methods

procedure TfrmReportFolder._FireChangeReportNode(const AnReportId: Integer);
begin
  if Assigned(OnChangeReportNode) then begin
    OnChangeReportNode(Self, AnReportId);
  end;
end; // TfrmReportFolder._FireChangeReportNode


procedure TfrmReportFolder._FireModifyReport();
begin
  if Assigned(OnModifyReport) then begin
    OnModifyReport(Self);
  end;
end; // TfrmReportFolder._FireModifyReport


end.
