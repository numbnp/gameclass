{*******************************************************}
{                                                       }
{                     EhLib v7.0                        }
{              TMemTreeListEh component                 }
{                   (Build 7.0.04)                      }
{                                                       }
{        Copyright (c) 2004-13 by EhLib Team and        }
{                Dmitry V. Bolshakov                    }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit MemTreeEh;

interface

uses SysUtils, Classes, ComCtrls, ToolCtrlsEh;

type

  TTreeListEh = class;
  TBaseTreeNodeEh = class;
  TNodeAttachModeEh = (naAddEh, naAddFirstEh, naAddChildEh, naAddChildFirstEh, naInsertEh, naAddAfterEh);
  TAddModeEh = (taAddFirstEh, taAddEh, taInsertEh);

  TCompareNodesEh = function (Node1, Node2: TBaseTreeNodeEh; ParamSort: TObject): Integer of object;
  TTreeNodeNotifyEvent = procedure (Sender: TBaseTreeNodeEh) of object;
  TTreeNodeNotifyResultEvent = function (Sender: TBaseTreeNodeEh): Boolean of object;
  TTreeNodeIterativeEvent = procedure (Sender: TBaseTreeNodeEh; Param: TObject) of object;

  TTreeListNotificationEh = (tlnNodeAddedEh, tlnNodeDeletedEh, tlnTreeListChangedEh);

{ TBaseTreeNodeEh }

//  TBaseTreeNodeEh = class(TComponent)
  TBaseTreeNodeEh = class(TPersistent)
  private
    FData: TObject;
    FExpanded: Boolean;
    FHasChildren: Boolean;
    FHasVisibleChildren: Boolean;
    FIndex: Integer;
    FItems: TList;
    FLevel: Integer;
    FOwner: TTreeListEh;
    FParent: TBaseTreeNodeEh;
    FText: string;
    FVisible: Boolean;
    FVisibleCount: Integer;
    FVisibleIndex: Integer;
    FVisibleItems: TList;
    FVisibleItemsObsolete: Boolean;
//    FVisibleIndex: Integer;
    function GetHasVisibleChildren: Boolean;
    function GetVisibleItem(const Index: Integer): TBaseTreeNodeEh;
    procedure InternalBuildVisibleItems;
    procedure SetExpanded(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
  protected
    function Add(Item: TBaseTreeNodeEh): Integer;
    function ExpandedChanging: Boolean; virtual;
    function GetCount: Integer;
    function GetItem(const Index: Integer): TBaseTreeNodeEh; {$IFDEF EH_LIB_9} inline; {virtual;} {$ENDIF}
    function GetVisibleCount: Integer;
    function HasParentOf(Node: TBaseTreeNodeEh): Boolean;
    function VisibleChanging: Boolean; virtual;
    function VisibleItems: TList;
    procedure BuildVisibleItems; virtual;
    procedure ChildVisibleChanged(ChildNode: TBaseTreeNodeEh); virtual;
    procedure Clear; virtual;
    procedure Delete(Index: Integer);
    procedure Exchange(Index1, Index2: Integer);
    procedure ExpandedChanged; virtual;
    procedure Insert(Index: Integer; Item: TBaseTreeNodeEh);
    procedure QuickSort(L, R: Integer; Compare: TCompareNodesEh; ParamSort: TObject);
    procedure SetLevel(ALevel: Integer);
    procedure SortData(CompareProg: TCompareNodesEh; ParamSort: TObject; ARecurse: Boolean = True); virtual;
    procedure VisibleChanged; virtual;
    
    property Count: Integer read GetCount;
    property Data: TObject read FData write FData;
    property Expanded: Boolean read FExpanded write SetExpanded;
    property HasChildren: Boolean read FHasChildren write FHasChildren;
    property HasVisibleChildren: Boolean read GetHasVisibleChildren write FHasVisibleChildren;
    property Index: Integer read FIndex;
    property Items[const Index: Integer]: TBaseTreeNodeEh read GetItem; default;
    property Level: Integer read FLevel;
    property Owner: TTreeListEh read FOwner;
    property Parent: TBaseTreeNodeEh read FParent write FParent;
    property Text: string read FText write FText;
    property Visible: Boolean read FVisible write SetVisible default True;
    property VisibleCount: Integer read GetVisibleCount;
    property VisibleIndex: Integer read FVisibleIndex;
    property VisibleItem[const Index: Integer]: TBaseTreeNodeEh read GetVisibleItem;
  public
//    constructor Create(AOwner: TComponent); override;
    constructor Create; virtual;
    destructor Destroy; override;
  end;

  TTreeNodeClassEh = class of TBaseTreeNodeEh;

{ TTreeListEh }

  TTreeListEh = class(TComponent)
  private
    FItemClass: TTreeNodeClassEh;
    FMaxLevel: Integer;
    FOnExpandedChanged: TTreeNodeNotifyEvent;
    FOnExpandedChanging: TTreeNodeNotifyResultEvent;
    FRoot: TBaseTreeNodeEh;
  protected
    function ExpandedChanging(Node: TBaseTreeNodeEh): Boolean; virtual;
    function IsHasChildren(Node: TBaseTreeNodeEh = nil): Boolean; // if Node is nil then Node = RootNode
    procedure ExpandedChanged(Node: TBaseTreeNodeEh); virtual;
    procedure QuickSort(L, R: Integer; Compare: TCompareNodesEh);
    property MaxLevel: Integer read FMaxLevel write FMaxLevel default 1000;

    function AddChild(const Text: string; Parent: TBaseTreeNodeEh; Data: TObject): TBaseTreeNodeEh; // if Parent is nil then Parent = RootNode
    function CompareTreeNodes(Rec1, Rec2: TBaseTreeNodeEh; ParamSort: TObject): Integer; virtual;
    function CountChildren(Node: TBaseTreeNodeEh = nil): Integer; // if Node is nil then Node = RootNode
    function CreateNodeApart(const Text: string; Data: TObject): TBaseTreeNodeEh;
    function GetFirst: TBaseTreeNodeEh;
    function GetFirstChild(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
    function GetFirstVisible: TBaseTreeNodeEh;
    function GetLast(Node: TBaseTreeNodeEh = nil): TBaseTreeNodeEh; // if Node is nil then Node = RootNode
    function GetLastChild(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
    function GetNext(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
    function GetNextSibling(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
    function GetNextVisible(Node: TBaseTreeNodeEh; ConsiderCollapsed: Boolean): TBaseTreeNodeEh;
    function GetNextVisibleSibling(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
    function GetNode(StartNode: TBaseTreeNodeEh; Data: TObject): TBaseTreeNodeEh;
    function GetParentAtLevel(Node: TBaseTreeNodeEh; ParentLevel: Integer): TBaseTreeNodeEh;   //
    function GetParentVisible(Node: TBaseTreeNodeEh; ConsiderCollapsed: Boolean): TBaseTreeNodeEh;
    function GetPathVisible(Node: TBaseTreeNodeEh; ConsiderCollapsed: Boolean): Boolean;
    function GetPrevious(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
    function GetPrevSibling(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
    function GetPrevVisibleSibling(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
    procedure AddNode(Node: TBaseTreeNodeEh; Destination: TBaseTreeNodeEh; Mode: TNodeAttachModeEh; ReIndex: Boolean);
    procedure BuildChildrenIndex(Node: TBaseTreeNodeEh = nil; Recurse: Boolean = True; FromIndex: Integer = -1; ToIndex: Integer = -1);
    procedure Clear;
    procedure Collapse(Node: TBaseTreeNodeEh; Recurse: Boolean);
    procedure DeleteChildren(Node: TBaseTreeNodeEh);
    procedure DeleteNode(Node: TBaseTreeNodeEh; ReIndex: Boolean);
    procedure Expand(Node: TBaseTreeNodeEh; Recurse: Boolean);
    procedure ExportToTreeView(TreeView: TTreeView; Node: TBaseTreeNodeEh; NodeTree: TTreeNode; AddChild: Boolean);
    procedure ExtractNode(Node: TBaseTreeNodeEh; ReIndex: Boolean);
    procedure MoveTo(Node: TBaseTreeNodeEh; Destination: TBaseTreeNodeEh; Mode: TNodeAttachModeEh; ReIndex: Boolean); virtual;
    procedure SortData(CompareProg: TCompareNodesEh; ParamSort: TObject; ARecurse: Boolean = True); virtual;
    procedure TreeChanged(Node: TBaseTreeNodeEh; Operation: TTreeListNotificationEh; OldIndex: Integer; OldParentNode: TBaseTreeNodeEh); virtual;

    property Root: TBaseTreeNodeEh read FRoot write FRoot;
    property OnExpandedChanged: TTreeNodeNotifyEvent read FOnExpandedChanged write FOnExpandedChanged;
    property OnExpandedChanging: TTreeNodeNotifyResultEvent read FOnExpandedChanging write FOnExpandedChanging;
  public
    constructor Create(ItemClass: TTreeNodeClassEh); reintroduce;
    destructor Destroy; override;
  end;

implementation

{ TBaseTreeNodeEh }

//constructor TBaseTreeNodeEh.Create(AOwner: TComponent);
constructor TBaseTreeNodeEh.Create;
begin
//  inherited Create(AOwner);
  inherited Create;
  FItems := TList.Create;
  FVisibleItems := TList.Create;
  FVisible := True;
end;

destructor TBaseTreeNodeEh.Destroy;
var
  I: Integer;
begin
  for I := 0  to FItems.Count - 1  do
    TBaseTreeNodeEh(FItems[I]).Free;
  FreeAndNil(FItems);
  FreeAndNil(FVisibleItems);
  inherited Destroy;
end;

procedure TBaseTreeNodeEh.Exchange(Index1, Index2: Integer);
begin
  if Index1 = Index2 then Exit;
  FItems.Exchange(Index1, Index2);
  Items[Index2].FIndex := Index2;
  Items[Index1].FIndex := Index1;
  //Visible Index now invalid.
end;

function TBaseTreeNodeEh.GetCount;
begin
  Result := FItems.Count;
end;

function TBaseTreeNodeEh.GetVisibleCount: Integer;
begin
  if FVisibleItemsObsolete then
    InternalBuildVisibleItems;
  if FVisibleCount = Count
    then Result := Count
    else Result := FVisibleItems.Count;
end;

function TBaseTreeNodeEh.GetVisibleItem(const Index: Integer): TBaseTreeNodeEh;
begin
  if FVisibleItemsObsolete then
    InternalBuildVisibleItems;
  Result := TBaseTreeNodeEh(VisibleItems[Index]);
end;

function TBaseTreeNodeEh.VisibleItems: TList;
begin
  if FVisibleItemsObsolete then
    InternalBuildVisibleItems;
  if Count = VisibleCount
    then Result := FItems
    else Result := FVisibleItems;
end;

procedure TBaseTreeNodeEh.BuildVisibleItems;
begin
  FVisibleItemsObsolete := True;
//  InternalBuildVisibleItems;
end;

procedure TBaseTreeNodeEh.InternalBuildVisibleItems;
var
  i: Integer;
begin
  FVisibleItems.Clear;
  for i := 0 to Count-1 do
    if Items[i].Visible then
      Items[i].FVisibleIndex := FVisibleItems.Add(Items[i]);
  FVisibleCount := FVisibleItems.Count;
  FVisibleItemsObsolete := False;
//  if (Count > 0) {and HasChildren} then
  HasVisibleChildren := (VisibleCount > 0);
end;

function TBaseTreeNodeEh.GetItem(const Index: Integer): TBaseTreeNodeEh;
begin
{  if (Index < 0) or (Index > FItems.Count-1) then
    begin
      Result := nil;
      Exit;
    end;}
  Result := TBaseTreeNodeEh(FItems.Items[Index]);
end;

function TBaseTreeNodeEh.GetHasVisibleChildren: Boolean;
begin
  if FVisibleItemsObsolete then
    InternalBuildVisibleItems;
  Result := FHasVisibleChildren;
end;

procedure TBaseTreeNodeEh.QuickSort(L, R: Integer; Compare: TCompareNodesEh; ParamSort: TObject);
var
  I, J: Integer;
  P: TBaseTreeNodeEh;
begin
  repeat
    I := L;
    J := R;
    P := Items[(L + R) shr 1];
    repeat
      while Compare(Items[I], P, ParamSort) < 0 do
        Inc(I);
      while Compare(Items[J], P, ParamSort) > 0 do
        Dec(J);
      if I <= J then
      begin
        Exchange(I, J);
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(L, J, Compare, ParamSort);
    L := I;
  until I >= R;

  if FVisibleCount <> Count then
    BuildVisibleItems();
//  Owner.BuildChildrenIndex(Self, False); // To reset visible index.
end;

procedure TBaseTreeNodeEh.SetExpanded(const Value: Boolean);
begin
  if FExpanded = Value then Exit;
  if ExpandedChanging then
  begin
    FExpanded := Value;
    ExpandedChanged;
  end;
end;

procedure TBaseTreeNodeEh.SetVisible(const Value: Boolean);
begin
  if FVisible = Value then Exit;
  if VisibleChanging then
  begin
    FVisible := Value;
    VisibleChanged;
  end;
end;

procedure TBaseTreeNodeEh.SortData(CompareProg: TCompareNodesEh; ParamSort: TObject; ARecurse: Boolean);
var
  i: Integer;
begin
  if Count = 0 then Exit;
  QuickSort(0, Count-1, CompareProg, ParamSort);
  if ARecurse then
    for i := 0 to Count-1  do
      Items[i].SortData(CompareProg, ParamSort, ARecurse);
//  Owner.BuildChildrenIndex(Self, False);
end;

procedure TBaseTreeNodeEh.ExpandedChanged;
begin
  if Owner <> nil then
    Owner.ExpandedChanged(Self);
end;

function TBaseTreeNodeEh.ExpandedChanging: Boolean;
begin
  if Owner <> nil
    then Result := Owner.ExpandedChanging(Self)
    else Result := True;
end;

procedure TBaseTreeNodeEh.VisibleChanged;
begin
//  if Visible then
  FParent.ChildVisibleChanged(Self);
end;

procedure TBaseTreeNodeEh.ChildVisibleChanged(ChildNode: TBaseTreeNodeEh);
//var
//  i{, j}: Integer;
begin
  BuildVisibleItems();
{  if Visible then
  begin
    for i := 0 to Count-1 do
      if Items[i].Index > ChildNode.Index then
      begin
        FVisibleItems.Insert(i, ChildNode);
        ChildNode.FVisibleIndex := i;
        for j := i+1 to FVisibleItems.Count-1 do
          Inc(TBaseTreeNodeEh(FVisibleItems[i]).FVisibleIndex);
        Exit;
      end;
    ChildNode.FVisibleIndex := FVisibleItems.Add(ChildNode);
  end else
    for i := 0 to Count-1 do
      if Items[i].Index = ChildNode.Index then
      begin
        FVisibleItems.Delete(i);
        for j := i to FVisibleItems.Count-1 do
          Dec(TBaseTreeNodeEh(FVisibleItems[i]).FVisibleIndex);
        Exit;
      end;}
end;

function TBaseTreeNodeEh.VisibleChanging: Boolean;
begin
  Result := True;
end;

procedure TBaseTreeNodeEh.SetLevel(ALevel: Integer);
var
  i: Integer;
begin
  if FLevel <> ALevel then
  begin
    if ALevel > Owner.MaxLevel then
      raise Exception.Create('TBaseTreeNodeEh.SetLevel: Max level exceed - ' + IntToStr(Owner.MaxLevel));
    FLevel := ALevel;
    for i := 0 to Count-1  do
      Items[i].SetLevel(FLevel+1);
  end;
end;

function TBaseTreeNodeEh.Add(Item: TBaseTreeNodeEh): Integer;
begin
  if Item.Owner <> Owner then
    raise Exception.Create('TBaseTreeNodeEh.Add: Tree nodes can not has different Owners');
  if (FVisibleCount = Count) and Item.Visible then
  begin
    Result := FItems.Add(Item);
    Item.FVisibleIndex := Result;
    Inc(FVisibleCount);
    BuildVisibleItems();
  end else
  begin
    Result := FItems.Add(Item);
    BuildVisibleItems();
  end;
end;

procedure TBaseTreeNodeEh.Clear;
begin
  FItems.Clear;
  FVisibleItems.Clear;
end;

procedure TBaseTreeNodeEh.Delete(Index: Integer);
begin
  FItems.Delete(Index);
  BuildVisibleItems();
{  if FVisibleCount = Count then
  begin
    FItems.Delete(Index);
    Dec(FVisibleCount);
  end else
  begin
    FItems.Delete(Index);
    BuildVisibleItems();
  end;}
end;

procedure TBaseTreeNodeEh.Insert(Index: Integer; Item: TBaseTreeNodeEh);
begin
  if Item.Owner <> Owner then
    raise Exception.Create('TBaseTreeNodeEh.Add: Tree nodes can not has different Owners');
  if (FVisibleCount = Count) and Item.Visible then
  begin
    FItems.Insert(Index, Item);
    Inc(FVisibleCount);
  end else
  begin
    FItems.Insert(Index, Item);
    BuildVisibleItems();
  end;
end;

function TBaseTreeNodeEh.HasParentOf(Node: TBaseTreeNodeEh): Boolean;
var
  ANode: TBaseTreeNodeEh;
begin
  Result := False;
  ANode := Self;
  while ANode <> Owner.Root do
  begin
    if ANode = Node then
    begin
      Result := True;
      Exit;
    end;
    ANode := ANode.Parent;
  end;
end;

{ TTreeListEh }

constructor TTreeListEh.Create(ItemClass: TTreeNodeClassEh);
begin
  inherited Create(nil);
  FItemClass := ItemClass;
//  FRoot := FItemClass.Create(Self);
  FRoot := FItemClass.Create;
  Root.Parent := nil;
  Root.FLevel := 0;
  Root.FOwner := Self;
  FMaxLevel := 1000;
end;

destructor TTreeListEh.Destroy;
begin
  FreeAndNil(FRoot);
  inherited Destroy;
end;

function TTreeListEh.AddChild(const Text: string; Parent: TBaseTreeNodeEh; Data: TObject): TBaseTreeNodeEh;
var
  ParentNode: TBaseTreeNodeEh;
//  NewNode: TBaseTreeNodeEh;
//  ChildIndex: Integer;
begin
  if Parent = nil
    then ParentNode := FRoot
    else ParentNode := Parent;
  Result := CreateNodeApart(Text, Data);
  AddNode(Result, ParentNode, naAddChildEh, True);
  
{
  if Parent = nil
    then ParentNode := FRoot
    else ParentNode := Parent;
  NewNode := FItemClass.Create;

  NewNode.Parent := ParentNode;
  ParentNode.HasChildren := True;

  NewNode.FOwner := Self;
  NewNode.Data := Data;
  ChildIndex := ParentNode.Add(NewNode);
  NewNode.Text := Text;
  NewNode.SetLevel(ParentNode.Level + 1);
  NewNode.FIndex := ChildIndex;
  Result := NewNode;
}
end;

procedure TTreeListEh.DeleteChildren(Node: TBaseTreeNodeEh);
var
  I: Integer;
begin
 for I := 0  to Node.Count - 1  do
   Node.Items[I].Free;
 Node.Clear;
end;

procedure TTreeListEh.DeleteNode(Node: TBaseTreeNodeEh; ReIndex: Boolean);
begin
  DeleteChildren(Node);
  ExtractNode(Node, ReIndex);
  FreeAndNil(Node);
end;

procedure TTreeListEh.ExtractNode(Node: TBaseTreeNodeEh; ReIndex: Boolean);
var
  BuildChildrenIndexRequired: Boolean;
  DeletedIndex: Integer;
  OldParentNode: TBaseTreeNodeEh;
begin
  if Node.Parent = nil then
    Exit;
  BuildChildrenIndexRequired := (Node.Index < Node.Parent.Count-1);
  DeletedIndex := Node.Index;
  OldParentNode := Node.Parent;
  Node.Parent.Delete(Node.Index);
  Node.Parent.HasChildren := (Node.Parent.Count > 0);
  if ReIndex then
  begin
    if BuildChildrenIndexRequired then
      BuildChildrenIndex(Node.Parent, False);
//    Node.Parent.FItemsIndexesObsolete := True;
  end;
  TreeChanged(Node, tlnNodeDeletedEh, DeletedIndex, OldParentNode);
end;

procedure TTreeListEh.Expand(Node: TBaseTreeNodeEh; Recurse: Boolean);
var
  I: Integer;
begin
  if Node = nil then Node := FRoot;
  if Node.Count > 0 then
  begin
    if Node <> FRoot then
      Node.Expanded := True;
    if Recurse then
      for I := 0 to Node.Count-1 do
        Expand(Node.Items[I], True);
  end;
end;

procedure TTreeListEh.Collapse(Node: TBaseTreeNodeEh; Recurse: Boolean);
var
  I: Integer;
begin
  if Node = nil then Node := FRoot;
  Node.Expanded := False;
  if Recurse then
    for I := 0 to Node.Count-1 do
      Collapse(Node.Items[I], True);
end;


procedure TTreeListEh.AddNode(Node: TBaseTreeNodeEh; Destination: TBaseTreeNodeEh; Mode: TNodeAttachModeEh; ReIndex: Boolean);
begin
  if (Node = nil) or (Node = FRoot) then
    Exit;
  if Destination = nil then
    Destination := FRoot;
  if (Destination = FRoot) and
     (Mode <> naAddChildEh) and
     (Mode <> naAddChildFirstEh)
  then
    Exit;

  case Mode of
    naAddChildEh:
      begin
        Node.Parent := Destination;
        Destination.HasChildren := True;
        Node.FIndex := Destination.Add(Node);
        Node.SetLevel(Destination.Level + 1);
      end;
    naAddChildFirstEh:
      begin
        Node.Parent := Destination;
        Destination.HasChildren := True;
        Destination.Insert(0, Node);
        Node.FIndex := 0;
        Node.SetLevel(Destination.Level + 1);
        if ReIndex then BuildChildrenIndex(Node.Parent, False);
      end;
    naAddEh:
      begin
        AddNode(Node, Destination.Parent, naAddChildEh, False);
      end;
    naAddFirstEh:
      begin
        AddNode(Node, Destination.Parent, naAddChildFirstEh, ReIndex);
      end;
    naInsertEh:
      begin
        Node.Parent := Destination.Parent;
        Destination.Parent.HasChildren := True;
        Destination.Parent.Insert(Destination.Index, Node);
        Node.FIndex := Destination.Index;
        Node.SetLevel(Destination.Parent.Level + 1);
        if ReIndex then BuildChildrenIndex(Destination.Parent, False, Node.Index);
      end;
    naAddAfterEh:
      begin
        if Destination.Parent[Destination.Parent.Count-1] = Destination then
          AddNode(Node, Destination, naAddEh, ReIndex)
        else
          AddNode(Node, Destination.Parent[Destination.Index+1], naInsertEh, ReIndex);
      end;
  end;

  TreeChanged(Node, tlnNodeAddedEh, -1, nil);
end;

procedure TTreeListEh.MoveTo(Node: TBaseTreeNodeEh; Destination: TBaseTreeNodeEh;
  Mode: TNodeAttachModeEh; ReIndex: Boolean);
begin
  if {(Destination = nil) or} (Node = nil) or (Node = FRoot) then Exit;
  if (Destination = FRoot) and (Mode <> naAddChildEh) and (Mode <> naAddChildFirstEh) then
    Exit;

  if Destination.HasParentOf(Node) then
    raise Exception.Create('Reference-loop found');

  Node.Parent.Delete(Node.Index);
  Node.Parent.HasChildren := (Node.Parent.Count > 0);
//
  if ReIndex then BuildChildrenIndex(Node.Parent, False);
  AddNode(Node, Destination, Mode, ReIndex);
end;

function TTreeListEh.GetNode(StartNode: TBaseTreeNodeEh; Data: TObject): TBaseTreeNodeEh;
var
  I: Integer;
  CurNode: TBaseTreeNodeEh;
begin
  Result := nil;
  if StartNode = nil then StartNode := FRoot;
  for I := 0 to StartNode.Count - 1 do
  begin
    CurNode := StartNode.Items[I];
    if CurNode.Data = Data then
    begin
      Result := CurNode;
      Break;
    end
    else
    begin
      Result := GetNode(CurNode, Data);
      if result <> nil then
        Break;
    end;
  end
end;

function TTreeListEh.GetPrevSibling(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
begin
  if (Node = nil) or (Node.Index = 0) or (Node.Parent = nil) then
  begin
    Result := nil;
    exit;
  end;
  Result := TBaseTreeNodeEh(Node.Parent.Items[Node.Index - 1]);
end;

function TTreeListEh.GetNextSibling(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
begin
  if (Node = nil) or (Node.Parent = nil) or (Node.Index = Node.Parent.Count - 1) then
  begin
    Result := nil;
    Exit;
  end;
  Result := Node.Parent.Items[Node.Index + 1];
end;

function TTreeListEh.GetFirstChild(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
begin
  if (Node = nil) or (Node.Count = 0) then
  begin
    Result := nil;
    Exit;
  end;
  Result := Node.Items[0];
end;

function TTreeListEh.GetLastChild(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
begin
  if (Node = nil) or (Node.Count = 0) then
  begin
    result := nil;
    Exit;
  end;
  Result := Node.Items[Node.Count - 1];
end;


function TTreeListEh.GetFirst: TBaseTreeNodeEh;
begin
  Result := GetFirstChild(FRoot);
end;


function TTreeListEh.GetPrevious(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
var
  PrevSiblingNode: TBaseTreeNodeEh;
begin
  Result := Node;
  if (Result = nil) or (Result = FRoot) then exit;
  PrevSiblingNode := GetPrevSibling(Result);
  if PrevSiblingNode <> nil then
  begin
    Result := GetLast(PrevSiblingNode);
    if Result = nil then
      Result := PrevSiblingNode;
  end
  else
    if Node.Parent <> FRoot then
      Result := Node.Parent
    else
      Result := nil;
end;

function TTreeListEh.GetNext(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
var
  FirstChild, NextSibling: TBaseTreeNodeEh;
begin
  Result := Node;
  if (Result = nil) or (Result = FRoot) then
    Exit;
  FirstChild := GetFirstChild(Result);
  if FirstChild <> nil then
  begin
    Result := FirstChild;
    Exit;
  end;
  repeat
    NextSibling := GetNextSibling(Result);
    if NextSibling <> nil then
    begin
      Result := NextSibling;
      Break;
    end
    else
    begin
      if Result.Parent <> FRoot then
        Result := Result.Parent
      else
      begin
        Result := nil;
        Break;
      end;
    end;
  until False;
end;


function TTreeListEh.GetLast(Node: TBaseTreeNodeEh = nil): TBaseTreeNodeEh;
var
  Next: TBaseTreeNodeEh;
begin
  if Node = nil then
    Node := FRoot;
  Result := GetLastChild(Node);
  while Result <> nil do
  begin
    Next := GetLastChild(Result);
    if Next = nil then
      Break;
    Result := Next;
  end;
end;

function TTreeListEh.IsHasChildren(Node: TBaseTreeNodeEh = nil): Boolean;
begin
  if Node = nil then
    Node := FRoot;
  Result := Node.Count > 0;
end;

function TTreeListEh.CountChildren(Node: TBaseTreeNodeEh = nil): Integer;
begin
  if Node = nil then
    Node := FRoot;
  Result := Node.Count;
end;

function TTreeListEh.GetParentAtLevel(Node: TBaseTreeNodeEh; ParentLevel: Integer): TBaseTreeNodeEh;
begin
  Result := nil;
  if (Node = nil) or (Node = FRoot) then
    Exit;
  if (ParentLevel >= Node.Level) or (ParentLevel < 0) then
    Exit;
  if ParentLevel = 0 then
  begin
    Result := FRoot;
    Exit;
  end;
  Result := Node;
  while Result <> nil do
  begin
    Result := Result.Parent;
    if Result <> nil then
      if Result.Level = ParentLevel then
        Break;
  end;
end;

function TTreeListEh.GetFirstVisible: TBaseTreeNodeEh;
var
  CurNode: TBaseTreeNodeEh;
begin
  Result := nil;
  if not IsHasChildren then
    Exit;
  CurNode := GetFirstChild(FRoot);
  if CurNode = nil then
    Exit;
  Result := CurNode;
  if not Result.Visible then
  begin
    repeat
      CurNode := GetNextSibling(Result);
      if CurNode <> nil then
      begin
        Result := CurNode;
        if Result.Visible then
          Break;
      end else
      begin
        if Result.Parent <> FRoot then
          Result := Result.Parent
        else
        begin
          Result := nil;
          Break;
        end;
      end;
    until False;
  end;
end;

function TTreeListEh.GetPathVisible(Node: TBaseTreeNodeEh; ConsiderCollapsed: Boolean): Boolean;
begin
  Result := False;
  if (Node = nil) or (Node = FRoot) then exit;
  repeat
    Node := Node.Parent;
  until (Node = FRoot) or not (Node.Expanded or not ConsiderCollapsed) or not (Node.Visible);
  Result := (Node = FRoot);
end;

function TTreeListEh.GetParentVisible(Node: TBaseTreeNodeEh; ConsiderCollapsed: Boolean): TBaseTreeNodeEh;
begin
  Result := Node;
  while Result <> FRoot do
  begin
    repeat
      Result := Result.Parent;
    until (Result.Expanded or not ConsiderCollapsed);
    if (Result = FRoot) or (Result.Visible and GetPathVisible(Result, ConsiderCollapsed)) then
      Break;
    while (Result <> FRoot) and (Result.Parent.Expanded or not ConsiderCollapsed) do
      Result := Result.Parent;
  end;
end;

function TTreeListEh.GetNextVisible(Node: TBaseTreeNodeEh; ConsiderCollapsed: Boolean): TBaseTreeNodeEh;
var
  ForceSearch: Boolean;
  FirstChild, NextSibling: TBaseTreeNodeEh;
begin
  Result := Node;
  if Result <> nil then
  begin
    if Result = FRoot then
    begin
      Result := nil;
      Exit;
    end;
    if not (Result.Visible) or not (GetPathVisible(Result, ConsiderCollapsed))  then
      Result := GetParentVisible(Result, ConsiderCollapsed);

    FirstChild := GetFirstChild(Result);
    if (Result.Expanded or not ConsiderCollapsed) and (FirstChild <> nil)  then
    begin
      Result := FirstChild;
      ForceSearch := False;
    end
    else
      ForceSearch := True;

    if (Result <> nil) and (ForceSearch or not (Result.Visible)) then
    begin
      repeat
        NextSibling := GetNextSibling(Result);
        if NextSibling <> nil then
        begin
          Result := NextSibling;
          if Result.Visible then
            Break;
        end
        else
        begin
          if Result.Parent <> FRoot then
            Result := Result.Parent
          else
          begin
            Result := nil;
            Break;
          end;
        end;
      until False;
    end;
  end;
end;

procedure TTreeListEh.Clear;
begin
  DeleteChildren(FRoot);
end;

procedure TTreeListEh.BuildChildrenIndex(Node: TBaseTreeNodeEh = nil; Recurse: Boolean = True; FromIndex: Integer = -1; ToIndex: Integer = -1);
var
  I: Integer;
  CurNode: TBaseTreeNodeEh;
  AFromIndex, AToIndex: Integer;
begin
  if Node = nil then
    Node := FRoot;
  Node.FVisibleItems.Clear;
  if FromIndex = -1
    then AFromIndex := 0
    else AFromIndex := FromIndex;
  if ToIndex = -1
    then AToIndex := Node.Count - 1
    else AToIndex := ToIndex;
  for I := AFromIndex to AToIndex do
  begin
    CurNode := Node.Items[I];
    CurNode.FIndex := I;
{    if CurNode.Visible
      then CurNode.FVisibleIndex := Node.FVisibleItems.Add(CurNode)
      else CurNode.FVisibleIndex := -1;}
    if Recurse then
      BuildChildrenIndex(CurNode, True);
  end;
  Node.BuildVisibleItems;
end;

procedure TTreeListEh.ExportToTreeView(TreeView:TTreeView; Node: TBaseTreeNodeEh; NodeTree: TTreeNode;AddChild:Boolean);
var
  CurNode:TBaseTreeNodeEh;
  TreeNode:TTreeNode;
begin
  CurNode := Node;
  while CurNode <> nil do
  begin
    if AddChild then
      TreeNode:=TreeView.Items.AddChildObject(NodeTree, CurNode.Text, CurNode.Data)
    else
      TreeNode:=TreeView.Items.AddObject(NodeTree, CurNode.Text, CurNode.Data);
      TreeNode.Expanded := CurNode.Expanded;
      ExportToTreeView(TreeView, GetFirstChild(CurNode), TreeNode,True);
      CurNode:=GetNextSibling(CurNode);
  end;
end;

procedure TTreeListEh.QuickSort(L, R: Integer; Compare: TCompareNodesEh);
begin
end;

procedure TTreeListEh.SortData(CompareProg: TCompareNodesEh; ParamSort: TObject;  ARecurse: Boolean);
begin
  FRoot.SortData(CompareProg, ParamSort, ARecurse);
end;

function TTreeListEh.CompareTreeNodes(Rec1, Rec2: TBaseTreeNodeEh; ParamSort: TObject): Integer;
begin
  Result := 0;
end;

function TTreeListEh.GetNextVisibleSibling(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
begin
  if Node.Parent.Count = Node.Parent.VisibleCount then
    Result := GetNextSibling(Node)
  else
  begin
    if (Node = nil) or (Node.Parent = nil) or (Node.VisibleIndex = Node.Parent.VisibleCount - 1) then
    begin
      Result := nil;
      Exit;
    end;
    Result := Node.Parent.VisibleItem[Node.VisibleIndex + 1];
  end;
end;

function TTreeListEh.GetPrevVisibleSibling(Node: TBaseTreeNodeEh): TBaseTreeNodeEh;
begin
  if Node.Parent.Count = Node.Parent.VisibleCount then
    Result := GetPrevSibling(Node)
  else
  begin
    if (Node = nil) or (Node.Parent = nil) or (Node.VisibleIndex = 0) then
    begin
      Result := nil;
      Exit;
    end;
    Result := Node.Parent.VisibleItem[Node.VisibleIndex - 1];
  end;
end;

procedure TTreeListEh.ExpandedChanged(Node: TBaseTreeNodeEh);
begin
  if Assigned(OnExpandedChanged) then
    OnExpandedChanged(Node);
end;

procedure TTreeListEh.TreeChanged(Node: TBaseTreeNodeEh;
  Operation: TTreeListNotificationEh; OldIndex: Integer;
  OldParentNode: TBaseTreeNodeEh);
begin

end;

function TTreeListEh.ExpandedChanging(Node: TBaseTreeNodeEh): Boolean;
begin
  Result := True;
  if Assigned(OnExpandedChanging) then
    Result := OnExpandedChanging(Node);
end;

function TTreeListEh.CreateNodeApart(const Text: string; Data: TObject): TBaseTreeNodeEh;
var
  NewNode: TBaseTreeNodeEh;
begin
//  NewNode := FItemClass.Create(Self);
  NewNode := FItemClass.Create;
  NewNode.Parent := nil;
  NewNode.FOwner := Self;
  NewNode.Data := Data;
  NewNode.Text := Text;
  NewNode.FLevel := 0;
  NewNode.FIndex := -1;
  Result := NewNode;
end;

end.

