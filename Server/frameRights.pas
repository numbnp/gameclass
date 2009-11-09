unit frameRights;

interface

uses 
  GCConst, ADODB, GCCommon, GCLangUtils,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, StdCtrls;

type
  TRight = class
  public
    constructor Create;
  public
    id: integer;
    namesystem: string;
    name: string;
    info: string;
    rOperators: integer;
    rAdmins: integer;
    rBosses: integer;
  end;

  TframRights = class(TFrame)
    lvRights: TListView;
    memoInfoFunction: TMemo;
    cbOperators: TCheckBox;
    cbAdmins: TCheckBox;
    cbBosses: TCheckBox;
    lblDescription: TLabel;
    procedure lvRightsClick(Sender: TObject);
    procedure cbOperatorsClick(Sender: TObject);
    procedure cbAdminsClick(Sender: TObject);
    procedure cbBossesClick(Sender: TObject);
    procedure lvRightsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lvRightsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    lock: boolean;
    procedure ResetFrame;
    procedure UpdateRightsList;    
    procedure UpdateRight;
  public
    function GetID: integer;
    procedure Activate(ID: integer); 
    { Public declarations }
  end;

implementation

{$R *.dfm}

constructor TRight.Create;
begin
  Name := 'name';
  info := '';
  rOperators := 0;
  rAdmins := 0;
  rBosses := 0;
end;

function TframRights.GetID: integer;
begin
  GetID := FRAME_RIGHTS;
end;

// процедура ставит все контролы в исходные позиции
procedure TframRights.ResetFrame;
begin
  UpdateRightsList;
end;

procedure TframRights.Activate(ID: integer);
begin
  Visible := (GetID = ID);
  if (not Visible) then exit;
  ResetFrame;
  lvRights.Column[0].Caption := translate('Function');
  lblDescription.Caption := translate('Description');
end;

procedure TframRights.UpdateRightsList;
var
  i: integer;
  li: TListItem;
  Right: TRight;
  dts: TADODataSet;
  str: string;
  ItemIndexOld: integer;
begin
  lock := true;
  ItemIndexOld := lvRights.ItemIndex;
  if lvRights.Items.Count>0 then
    for i:=0 to (lvRights.Items.Count-1) do
    begin
      Right := lvRights.Items[i].Data;
      Right.Destroy;
    end;  
  lvRights.Clear;


  if (dsConnected) then
  begin
    dts := TADODataSet.Create(nil);
    dsDoQuery(DS_RIGHTS_SELECT, @dts);
    while (dts.Recordset.RecordCount > 0) and (not dts.Recordset.EOF) do
    begin
      if (dts.Recordset.Fields.Item['name'].Value <> 'fnManagerRights') then begin
        Right := TRight.Create;
        Right.id := dts.Recordset.Fields.Item['id'].Value;
        Right.namesystem := dts.Recordset.Fields.Item['name'].Value;
        Right.name := translate(dts.Recordset.Fields.Item['name'].Value+'Name');
        Right.info := translate(dts.Recordset.Fields.Item['name'].Value+'Info');
        Right.rOperators := dts.Recordset.Fields.Item['rOperators'].Value;
        Right.rAdmins := dts.Recordset.Fields.Item['rAdmins'].Value;
        Right.rBosses := dts.Recordset.Fields.Item['rBosses'].Value;
        li := lvRights.Items.Add;
        li.Caption := Right.Name;
        if (Right.rOperators = 1) then str := '+' else str:='';
        li.SubItems.Insert(0, str);
        if (Right.rAdmins = 1) then str :='+' else str:='';
        li.SubItems.Insert(1, str);
        if (Right.rBosses = 1) then str :='+' else str:='';
        li.SubItems.Insert(2, str);

        li.Data := Right;
      end;

      dts.Recordset.MoveNext;
    end;  
    dts.Close;    
    dts.Destroy;    
  end;
  if (ItemIndexOld = -1) then
  begin
    cbOperators.Checked := false;
    cbAdmins.Checked := false;
    cbBosses.Checked := false;
  end
  else
    lvRights.ItemIndex := ItemIndexOld;
  lock := false;
end;

procedure TframRights.lvRightsClick(Sender: TObject);
var
  Right: TRight;
begin
 lock := true;
 if (lvRights.ItemIndex <> -1) then
 begin
   Right := lvRights.Items[lvRights.ItemIndex].Data;
   cbOperators.Checked := (Right.rOperators = 1);
   cbAdmins.Checked := (Right.rAdmins = 1);
   cbBosses.Checked := (Right.rBosses = 1);
   cbAdmins.Enabled := true;
   cbOperators.Enabled := true;
   if ((Right.namesystem = FN_CLEAR_STATISTICS) or
      (Right.namesystem = FN_BOSS_OPTIONS) or
      (Right.namesystem = FN_REMOTE_CONTROL)) then begin
      cbAdmins.Enabled := false;
      cbOperators.Enabled := false;
   end;
   memoInfoFunction.Text := Right.info;
 end;
 lock := false;
end;

procedure TframRights.UpdateRight;
var
  Right: TRight;
  strBosses, strOperators, strAdmins: string;
begin
  if (lvRights.ItemIndex = -1) or (lock) then exit;
  Right := lvRights.Items[lvRights.ItemIndex].Data;
  strBosses := '0';
  strOperators := '0';
  strAdmins := '0';
  if (cbBosses.Checked) then strBosses := '1';
  if (cbAdmins.Checked) then strAdmins := '1';
  if (cbOperators.Checked) then strOperators := '1';
  dsDoCommand(DS_RIGHTS_UPDATE + ' @idFunctions=' + IntToStr(Right.id) +', @rOperators=' + strOperators + ', @rAdmins=' + strAdmins +', @rBosses=' + strBosses);
  UpdateRightsList;
end;

procedure TframRights.cbOperatorsClick(Sender: TObject);
begin
  UpdateRight;
end;

procedure TframRights.cbAdminsClick(Sender: TObject);
begin
  UpdateRight;
end;

procedure TframRights.cbBossesClick(Sender: TObject);
begin
  UpdateRight;
end;

procedure TframRights.lvRightsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  lvRightsClick(Sender);
end;

procedure TframRights.lvRightsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  lvRightsClick(Sender);
end;

end.
