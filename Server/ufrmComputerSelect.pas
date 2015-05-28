unit ufrmComputerSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RXCtrls,
  StdCtrls,
  gccomputers;

type
  TfrmComputerSelect = class(TForm)
    lbxComputers: TRxCheckListBox;
    procedure FormDeactivate(Sender: TObject);
    procedure lbxComputersClick(Sender: TObject);
  private
    FNotifyEvent: TNotifyEvent;
    function _GetCount: Integer;
    function _GetSelectedAsText: String;
    function _GetSelected(const AnIndex: Integer): TComputer;
  public
    constructor Create(const AOwner: TComponent;
        const ANotifyEvent: TNotifyEvent = Nil); reintroduce;
    destructor Destroy; override;
    procedure Init(const AAction: TComputerAction);
    procedure FillListAndShow(const APoint: TPoint;
        const AAction: TComputerAction);
    property Count: Integer
        read _GetCount;
    property SelectedAsText: String
        read _GetSelectedAsText;
    property Selected[const AnIndex: Integer]: TComputer
        read _GetSelected;
  end;

implementation

{$R *.dfm}
constructor TfrmComputerSelect.Create(const AOwner: TComponent;
    const ANotifyEvent: TNotifyEvent);
//var
//  i: Integer;
begin
  inherited Create(AOwner);
  FNotifyEvent := ANotifyEvent;
end;

destructor TfrmComputerSelect.Destroy;
begin
  inherited Destroy;
end;

function TfrmComputerSelect._GetCount: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i:=0 to lbxComputers.Items.Count-1 do
    if lbxComputers.Checked[i] then
      Inc(Result);
end; // TformComputerSelect._GetCount:

function TfrmComputerSelect._GetSelectedAsText: String;
var
  i: Integer;
begin
  Result := '';
  for i:=0 to lbxComputers.Items.Count-1 do
    if lbxComputers.Checked[i] then
        Result := Result + lbxComputers.Items[i] + ', ';
  if Length(Result)>0 then
    SetLength(Result, Length(Result)-2);
end; // TformComputerSelect._GetSelectedText:

function TfrmComputerSelect._GetSelected(const AnIndex: Integer): TComputer;
begin
  Result := TComputer(lbxComputers.Items.Objects[AnIndex]);
end; // TformComputerSelect._GetSelected:

procedure TfrmComputerSelect.FormDeactivate(Sender: TObject);
begin
  Hide;
end;

procedure TfrmComputerSelect.lbxComputersClick(Sender: TObject);
var
  i, j: Integer;
begin
  //Обновляем CompsSel
  j := 0;
  for i := 0 to lbxComputers.Items.Count - 1 do
    if lbxComputers.Checked[i] then begin
      CompsSel[j] := Tcomputer(lbxComputers.Items.Objects[i]).id;
      Inc(j);
    end;
  CompsSelCount := j;
  if Assigned(FNotifyEvent) then
    FNotifyEvent(Self);
end;

procedure TfrmComputerSelect.Init(const AAction: TComputerAction);
var
  i: Integer;
begin
  lbxComputers.Items.Clear;
  for i:=0 to CompsCount-1 do begin
    lbxComputers.Items.AddObject(Comps[i].GetStrNumber, Comps[i]);
    lbxComputers.EnabledItem[i] := Comps[i].IsLikely(AAction);
  end;
  for i:=0 to CompsSelCount-1 do
    if lbxComputers.EnabledItem[ComputersGetIndex(CompsSel[i])] then
      lbxComputers.Checked[ComputersGetIndex(CompsSel[i])] := True;
end;

procedure TfrmComputerSelect.FillListAndShow(const APoint: TPoint;
    const AAction: TComputerAction);
var
  nColumns: Integer;
begin
  Init(AAction);
  nColumns := (lbxComputers.Items.Count + 9) div 10 ;
  if (nColumns < 1) then
    nColumns := 1;
  lbxComputers.Columns := nColumns + 1;
  if lbxComputers.Items.Count < 10 then
    Height := lbxComputers.Items.Count*13 + 5
  else
    Height := 164;
  Width := 50*nColumns;
  lbxComputers.AutoScroll := False;
  Left := APoint.X;
  Top := APoint.Y;
  inherited Show;
  if Assigned(FNotifyEvent) then
    FNotifyEvent(Self);
end;


end.
