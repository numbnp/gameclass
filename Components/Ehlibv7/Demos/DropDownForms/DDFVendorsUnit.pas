unit DDFVendorsUnit;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBGridEh, Buttons, Db, ExtCtrls, ComCtrls, GridsEh,
{$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  DBGridEhGrouping, ADODB, ToolCtrlsEh, DBGridEhToolCtrls, MemTableDataEh,
  MemTableEh, DBAxisGridsEh, StdCtrls, DropDownFormEh, DataDriverEh,
  ADODataDriverEh, DBVertGridsEh, DynVarsEh, DBCtrls;

type
  TDDFVendors = class(TCustomDropDownFormEh)
    DataSource1: TDataSource;
    Panel2: TPanel;
    Table1: TADOTable;
    MemTableEh1: TMemTableEh;
    Panel3: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    ADODataDriverEh2: TADODataDriverEh;
    DBVertGridEh1: TDBVertGridEh;
    Splitter1: TSplitter;
    MainGrid: TDBGridEh;
    Panel1: TPanel;
    sbOk: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Image1: TImage;
    procedure sbOkClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure MainGridDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure CustomDropDownFormEhInitForm(Sender: TCustomDropDownFormEh;
      DynParams: TDynVarsEh);
    procedure CustomDropDownFormEhReturnParams(
      Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
  public
    class function GetGlobalRef: TCustomDropDownFormEh; override;
  end;

var
  DDFVendors: TDDFVendors;

implementation

uses DBConsts, EditVendorUnit;

{$R *.DFM}

type
  TSpeedButtonCrack = class (TSpeedButton);
  
{ TForm2 }

procedure TDDFVendors.FormCreate(Sender: TObject);
begin
  fEditVendor := TfEditVendor.Create(Self);

  Panel3.DoubleBuffered := True;
  Panel3.ParentBackground := False;
  Panel1.DoubleBuffered := True;
  Panel1.ParentBackground := False;

  FormElements := [ddfeLeftGripEh, ddfeRightGripEh, ddfeCloseButtonEh];
end;

procedure TDDFVendors.sbOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
  Close;
end;

procedure TDDFVendors.SpeedButton2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TDDFVendors.MainGridDblClick(Sender: TObject);
begin
  if sbOk.Enabled then
    sbOkClick(Sender);
end;

procedure TDDFVendors.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
  begin
    if not MainGrid.SearchPanel.Active then
    begin
      ModalResult := mrCancel;
      Visible := False;
    end;  
  end else if Key = VK_RETURN then
  begin
    if not MainGrid.SearchPanel.Active then
    begin
      ModalResult := mrOk;
      Visible := False;
    end;  
  end;
end;

procedure TDDFVendors.SpeedButton5Click(Sender: TObject);
begin
  KeepFormVisible := True;
  try
    if MessageDlg(SDeleteRecordQuestion, mtConfirmation, mbOKCancel, 0) <> idCancel then
      MemTableEh1.Delete;
  finally
    KeepFormVisible := False;
  end;
end;

procedure TDDFVendors.SpeedButton4Click(Sender: TObject);
begin
  KeepFormVisible := True;
  try
    fEditVendor.Position := poDesigned;
    fEditVendor.Position := poOwnerFormCenter;
    if fEditVendor.ShowModal = mrOk then
    begin
      if dsEdit = MemTableEh1.State then
        MemTableEh1.Post
    end else
      MemTableEh1.Cancel;
  finally
    KeepFormVisible := False;
  end;
end;

procedure TDDFVendors.SpeedButton3Click(Sender: TObject);
begin
  KeepFormVisible := True;
  try
  MemTableEh1.Append;
  fEditVendor.Position := poDesigned;
  fEditVendor.Position := poOwnerFormCenter;
  if (fEditVendor.ShowModal = mrOk) and MemTableEh1.Modified then
  begin
    MemTableEh1.Post
  end else
    MemTableEh1.Cancel;
  finally
    KeepFormVisible := False;
  end;
end;

procedure TDDFVendors.Image1Click(Sender: TObject);
begin
  ModalResult := mrCancel;
  Close;
end;

procedure TDDFVendors.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  sbOk.Enabled := not MemTableEh1.IsEmpty;
end;

procedure TDDFVendors.FormShow(Sender: TObject);
begin
  if FDropLayout = dlUnderControlEh then
    Image1.Left := ClientWidth - Image1.Width - 3
  else
    Image1.Left := ClientWidth - Image1.Width - 14;
end;

procedure TDDFVendors.CustomDropDownFormEhInitForm(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
var
  VNo: String;
begin
  MainGrid.SearchPanel.CancelSearchFilter;
  MainGrid.SearchPanel.SearchingText := '';

  if DynParams = nil then Exit;
  VNo := DynParams['VendorNo'].AsString;
  if VNo <> '' then
    MemTableEh1.Locate('VendorNo', VNo, []);
end;

procedure TDDFVendors.CustomDropDownFormEhReturnParams(
  Sender: TCustomDropDownFormEh; DynParams: TDynVarsEh);
begin
  if DynParams = nil then Exit;
  DynParams['VendorNo'].AsString := MemTableEh1.FieldByName('VendorNo').AsString;
  DynParams['VendorName'].AsString := MemTableEh1.FieldByName('VendorName').AsString;
//  DynParams['Address1'].AsString := MemTableEh1.FieldByName('Address1').AsString;
end;

class function TDDFVendors.GetGlobalRef: TCustomDropDownFormEh;
begin
  if DDFVendors = nil then
    Application.CreateForm(TDDFVendors, DDFVendors);
  Result := DDFVendors;
end;

initialization
  RegisterClass(TDDFVendors);
end.
