unit uY2KNetTreeView;

interface

uses
  SysUtils,
  Windows,
  Classes,
  Controls,
  ComCtrls,
  NetUtils,
  uY2KTreeView;


type

  //
  // TY2KNetTreeView
  //

  TY2KNetTreeView = class(TY2KTreeView)
  private
    // fields
    FbCheckEnable: Boolean;

    // private helper methods
    procedure _RecursiveBuildNetTree(const Anode: TTreeNode;
        const AptrListRoot: PNetResource);

  public
    // piblic methods
    procedure LoadNet();

  published
    // properties
    property CheckEnable: Boolean
        read FbCheckEnable write FbCheckEnable default FALSE;

  end; // TY2KNetTreeView


implementation

uses
  WinSock;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// piblic methods

procedure TY2KNetTreeView.LoadNet();
var
  WSAData: TWSAData;

begin
 WSAStartup($0101, WSAData);

 Items.Clear();

 _RecursiveBuildNetTree(nil, nil);

 WSACleanup();

end; // TY2KNetTreeView.LoadNet


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TY2KNetTreeView._RecursiveBuildNetTree(
    const Anode: TTreeNode; const AptrListRoot: PNetResource);
var
  lstNet: TList;
  i: Integer;
  node: TTreeNode;
  strName: String;
  ptrHostEnt: PHostEnt;
begin
  lstNet := GetContainerList(AptrListRoot);
  if not Assigned(lstNet) then begin
    exit;
  end;

  for i := 0 to lstNet.Count - 1 do begin
    strName := PNetRes(lstNet[i])^.RemoteName;

    if PNetRes(lstNet[i])^.dwDisplayType = RESOURCEDISPLAYTYPE_SERVER then begin
      strName := Copy(strName, 3, Length(strName) - 2);
      ptrHostEnt := GetHostByName(PAnsiChar(strName));
      if Assigned(ptrHostEnt) then begin
        strName := inet_ntoa(PInAddr(ptrHostEnt.h_addr_list^)^);
      end else begin
        strName := PNetRes(lstNet[i])^.RemoteName;
      end;
    end;
    node := Items.AddChild(Anode, strName);
    if FbCheckEnable then begin
      node.StateIndex := 2;
    end else begin
      node.StateIndex := -1;
    end;
    _RecursiveBuildNetTree(node, lstNet[i]);
    
  end;

end; // TY2KNetTreeView._RecursiveBuildNetTree


end.
