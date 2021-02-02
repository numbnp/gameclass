{$I EhLib.Inc}

unit CustomPlannerItemDialog;

interface

uses
{$IFDEF CIL}
  EhLibVCLNET,
  WinUtils,
{$ELSE}
  {$IFDEF FPC}
  EhLibLCL, LMessages, LCLType, Win32Extra,
  {$ELSE}
  EhLibVCL, DBConsts, RTLConsts,
  {$ENDIF}
{$ENDIF}
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls, Mask,
  DBCtrlsEh, PlannersEh, PlannerDataEh,
  DateUtils, Db,
  ComCtrls, ExtCtrls;

type
  TCustomPlannerItemForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    StartDateEdit: TDateTimePicker;
    EndDateEdit: TDateTimePicker;
    AllDayCheck: TCheckBox;
    OKButton: TButton;
    CancelButton: TButton;
    eTitle: TDBEditEh;
    cbStartTimeEdit: TDBComboBoxEh;
    cbFinishTimeEdit: TDBComboBoxEh;
    eBody: TDBMemoEh;
    Bevel3: TBevel;
    cbxRecource: TDBComboBoxEh;
    Bevel4: TBevel;
    cmbCategory: TDBComboBoxEh;
    Label4: TLabel;
    procedure cbStartTimeEditEnter(Sender: TObject);
    procedure cbStartTimeEditChange(Sender: TObject);
    procedure StartDateEditEnter(Sender: TObject);
    procedure StartDateEditChange(Sender: TObject);
  private
    FDeltaTime: TDateTime;
    FDeltaDate: TDateTime;
//    FExtraDataSet: TDataSet;
  public
    procedure InitForm(Item: TPlannerDataItemEh; ExtraDataSet: TDataSet);
    function FormStarDate: TDateTime;
    function FormEndDate: TDateTime;
  end;

var
  CustomPlannerItemForm: TCustomPlannerItemForm;

function CustomEditPlanItem(Item: TPlannerDataItemEh; ExtraDataSet: TDataSet): Boolean;
procedure CustomEditNewItem(Planner: TPlannerControlEh; ExtraDataSet: TDataSet);

implementation

{$R *.dfm}

function CustomEditPlanItem(Item: TPlannerDataItemEh; ExtraDataSet: TDataSet): Boolean;
var
  AForm: TCustomPlannerItemForm;
  InsertMode: Boolean;
begin
  Result := False;
  AForm := TCustomPlannerItemForm.Create(Application);
  try
    AForm.InitForm(Item, ExtraDataSet);
    if AForm.ShowModal = mrOK then
    begin
      Item.BeginEdit;

      Item.Title := AForm.eTitle.Text;
      Item.Body := AForm.eBody.Text;
      Item.StartTime := AForm.FormStarDate;
      Item.EndTime := AForm.FormEndDate;
      Item.AllDay := AForm.AllDayCheck.Checked;
      if AForm.cbxRecource.ItemIndex >= 0 then
        Item.ResourceID := AForm.cbxRecource.KeyItems[AForm.cbxRecource.ItemIndex];

      InsertMode := False;
      if ExtraDataSet.State = dsInsert then
        InsertMode := True
      else if ExtraDataSet.Locate('Id', Item.ItemID, []) then
        ExtraDataSet.Edit
      else raise Exception.Create('Can''t locate ItemID = "' + VarToStr(Item.ItemID) + '"');

//        mtPlannerData['Id'] := PlanItem.ItemID;
      ExtraDataSet['StartTime'] := AForm.FormStarDate;
      ExtraDataSet['EndTime'] := AForm.FormEndDate;
      ExtraDataSet['Title'] := AForm.eTitle.Text;
      ExtraDataSet['Body'] := AForm.eBody.Text;
      ExtraDataSet.FieldByName('AllDay').AsBoolean := AForm.AllDayCheck.Checked;
      if AForm.cbxRecource.ItemIndex >= 0 then
        ExtraDataSet['ResourceID'] := AForm.cbxRecource.KeyItems[AForm.cbxRecource.ItemIndex]
      else
        ExtraDataSet['ResourceID'] := Null;
      ExtraDataSet['Category'] := AForm.cmbCategory.Value;
      ExtraDataSet.Post;

      if InsertMode then
        Item.ItemID := ExtraDataSet['Id'];

      Item.EndEdit(True);
      Result := True;
    end;
  finally
    AForm.Free;
  end;

end;

procedure CustomEditNewItem(Planner: TPlannerControlEh; ExtraDataSet: TDataSet);
var
  StartTime, EndTime: TDateTime;
  PlanItem: TPlannerDataItemEh;
  AResource: TPlannerResourceEh;
begin
  if Planner.NewItemParams(StartTime, EndTime, AResource) then
  begin
    PlanItem := Planner.PlannerDataSource.NewItem;
    PlanItem.Title := 'New Item';
    PlanItem.Body := '';
    PlanItem.AllDay := False;
    PlanItem.StartTime := StartTime;
    PlanItem.EndTime := EndTime;
    PlanItem.Resource := AResource;
    ExtraDataSet.Append;
    if CustomEditPlanItem(PlanItem, ExtraDataSet) then
      PlanItem.EndEdit(True)
    else
      PlanItem.EndEdit(False);
  end;
end;

{ TPlannerItemForm }

procedure TCustomPlannerItemForm.StartDateEditEnter(Sender: TObject);
begin
  if (StartDateEdit.DateTime <> 0) and (EndDateEdit.DateTime <> 0) then
    try
      FDeltaDate := EndDateEdit.DateTime - StartDateEdit.DateTime;
    except
      on EConvertError do FDeltaTime := 0;
    end;
end;

procedure TCustomPlannerItemForm.StartDateEditChange(Sender: TObject);
begin
 if FDeltaDate <> 0 then
   EndDateEdit.DateTime := StartDateEdit.DateTime + FDeltaDate;
end;

procedure TCustomPlannerItemForm.cbStartTimeEditEnter(Sender: TObject);
begin
  if (cbStartTimeEdit.Text <> '') and (cbFinishTimeEdit.Text <> '') then
    try
      FDeltaTime := StrToTime(cbFinishTimeEdit.Text) - StrToTime(cbStartTimeEdit.Text)
    except
      on EConvertError do FDeltaTime := 0;
    end;
end;

function TCustomPlannerItemForm.FormStarDate: TDateTime;
begin
  Result := Trunc(StartDateEdit.DateTime) + Frac(StrToTime(cbStartTimeEdit.Text));
end;

function TCustomPlannerItemForm.FormEndDate: TDateTime;
begin
  Result := Trunc(EndDateEdit.DateTime) + Frac(StrToTime(cbFinishTimeEdit.Text));
end;

procedure TCustomPlannerItemForm.cbStartTimeEditChange(Sender: TObject);
var
  s: String;
  ATime: TDateTime;

  function IsDigit(c: Char): Boolean;
  begin
    Result := CharInSetEh(c, ['0','1','2','3','4','5','6','7','8','9',' '])
  end;

begin
  s := cbStartTimeEdit.Text;
  if (Length(s) = 5) and
     IsDigit(s[1]) and
     IsDigit(s[2]) and
     (s[3] = ':') and
     IsDigit(s[4]) and
     IsDigit(s[5])
  then
   if FDeltaTime <> 0 then
   begin
     ATime := StrToTime(cbStartTimeEdit.Text);
     cbFinishTimeEdit.Text := FormatDateTime('HH:MM', ATime + FDeltaTime);
   end;
end;

procedure TCustomPlannerItemForm.InitForm(Item: TPlannerDataItemEh; ExtraDataSet: TDataSet);
var
  i: Integer;
begin
  eTitle.Text := Item.Title;
  eBody.Text := Item.Body;

  StartDateEdit.OnChange := nil;
  StartDateEdit.DateTime := Item.StartTime;
  StartDateEdit.OnChange := StartDateEditChange;

  EndDateEdit.DateTime := Item.EndTime;
  AllDayCheck.Checked := Item.AllDay;

  cbStartTimeEdit.OnChange := nil;
  cbStartTimeEdit.Text := FormatDateTime('HH:MM', Item.StartTime);
  cbStartTimeEdit.OnChange := cbStartTimeEditChange;

  cbFinishTimeEdit.Text := FormatDateTime('HH:MM', Item.EndTime);

  if (Item.Source.Resources.Count > 0) then
  begin
    for i := 0 to Item.Source.Resources.Count-1 do
    begin
      cbxRecource.Items.Add(Item.Source.Resources[i].Name);
      cbxRecource.KeyItems.Add(VarToStr(Item.Source.Resources[i].ResourceID));
    end;
  end;

  cbxRecource.ItemIndex := cbxRecource.KeyItems.IndexOf(VarToStr(Item.ResourceID));

  if ExtraDataSet.State = dsInsert then
// Ok
  else if ExtraDataSet.Locate('Id', Item.ItemID, []) then
  begin
    cmbCategory.Value := ExtraDataSet['Category'];
  end;
end;

end.
