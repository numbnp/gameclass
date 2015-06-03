{*******************************************************}
{                                                       }
{                       EhLib v7.0                      }
{                                                       }
{            TLookupLinkFields form                     }
{                                                       }
{      Copyright (c) 2013-2013 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit LookupLinkDesignEh;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, Forms,
{$IFDEF DESIGNTIME}
  DesignIntf, DesignEditors,
{$ENDIF}
  StdCtrls, ExtCtrls, DB, Buttons, DBLookupUtilsEh;

type

{ TLookupLinkFields }

  TLookupLinkFields = class(TForm)
    KeyFieldList: TListBox;
    LookupKeyList: TListBox;
    BindList: TListBox;
    Label30: TLabel;
    Label31: TLabel;
    LookupDatasetList: TComboBox;
    IndexLabel: TLabel;
    Label2: TLabel;
    Bevel1: TBevel;
    AddButton: TButton;
    DeleteButton: TButton;
    ClearButton: TButton;
    Button1: TButton;
    Button2: TButton;
    ResultFieldLabel: TLabel;
    ResultFieldList: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure BindingListClick(Sender: TObject);
    procedure AddButtonClick(Sender: TObject);
    procedure DeleteButtonClick(Sender: TObject);
    procedure BindListClick(Sender: TObject);
    procedure ClearButtonClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure HelpClick(Sender: TObject);
    procedure LookupDatasetListChange(Sender: TObject);
  private
    FFullIndexName: string;
//    MasterFieldList: string;
//    IndexFieldList: string;
    OrderedLookupKeyList: TStringList;
    OrderedKeyFieldList: TStringList;
    procedure OrderFieldList(OrderedList, List: TStrings);
    procedure AddToBindList(const Str1, Str2: string);
    procedure Initialize;
    procedure LookupDatasetChanged;
    procedure TrySameFieldInLookupKeyList;

//    property FullIndexName: string read FFullIndexName;
//    procedure SetDataSet(Value: TDataSet);
  protected
    FComponent: TComponent;
{$IFDEF DESIGNTIME}
    FDesigner: IDesigner;
{$ENDIF}
    FDataSet: TDataSet;
    FKeyFieldNames: String;
    FLookupKeyFieldNames: String;
    FLookupResultField: String;
    FLookupDataSet: TDataSet;

  public
    property DataSet: TDataSet read FDataSet;
//    property DataSetProxy: TFieldLinkProperty read FDataSetProxy write FDataSetProxy;
    function Edit: Boolean;

    procedure InitDatasetList;
    procedure GetDataSetListRunTime(List: TStrings);
  end;

function EditLookupLink(Component: TComponent;
{$IFDEF DESIGNTIME}
  ADesigner: IDesigner;
{$ENDIF}
  ADataSet: TDataSet;
  var KeyFieldNames, LookupKeyFieldNames, LookupResultField: String;
  var LookupDataSet: TDataSet): Boolean;

implementation

{$R *.dfm}

uses Dialogs, DBConsts, TypInfo, DsnDBCst;

function StripFieldName(const Fields: string; var Pos: Integer): string;
var
  I: Integer;
begin
  I := Pos;
  while (I <= Length(Fields)) and (Fields[I] <> ';') do Inc(I);
  Result := Copy(Fields, Pos, I - Pos);
  if (I <= Length(Fields)) and (Fields[I] = ';') then Inc(I);
  Pos := I;
end;

function StripDetail(const Value: string): string;
var
  S: string;
  I: Integer;
begin
  S := Value;
  I := 0;
  while Pos('->', S) > 0 do
  begin
    I := Pos('->', S);
    S[I] := ' ';
  end;
  Result := Copy(Value, 0, I - 2);
end;

function StripMaster(const Value: string): string;
var
  S: string;
  I: Integer;
begin
  S := Value;
  I := 0;
  while Pos('->', S) > 0 do
  begin
    I := Pos('->', S);
    S[I] := ' ';
  end;
  Result := Copy(Value, I + 3, Length(Value));
end;

function EditLookupLink(Component: TComponent;
{$IFDEF DESIGNTIME}
  ADesigner: IDesigner;
{$ENDIF}
  ADataSet: TDataSet;
  var KeyFieldNames, LookupKeyFieldNames, LookupResultField: String;
  var LookupDataSet: TDataSet): Boolean;
begin
  with TLookupLinkFields.Create(nil) do
  try
//    DataSetProxy := ADataSetProxy;
    FComponent := Component;
{$IFDEF DESIGNTIME}
    FDesigner := ADesigner;
{$ENDIF}
    FDataSet := ADataSet;
    FKeyFieldNames := KeyFieldNames;
    FLookupKeyFieldNames := LookupKeyFieldNames;
    FLookupResultField := LookupResultField;
    FLookupDataSet := LookupDataSet;

    Result := Edit;
    if Result then
    begin
      KeyFieldNames := FKeyFieldNames;
      LookupKeyFieldNames := FLookupKeyFieldNames;
      LookupResultField := FLookupResultField;
      LookupDataSet := FLookupDataSet;
    end
  finally
    Free;
  end;
end;

{ TLinkFields }

procedure TLookupLinkFields.FormCreate(Sender: TObject);
begin
  OrderedLookupKeyList := TStringList.Create;
  OrderedKeyFieldList := TStringList.Create;
//  HelpContext := hcDFieldLinksDesign;
end;

procedure TLookupLinkFields.FormDestroy(Sender: TObject);
begin
  OrderedLookupKeyList.Free;
  OrderedKeyFieldList.Free;
end;

function TLookupLinkFields.Edit;
begin
  Initialize;
  
  if ShowModal = mrOK then
  begin
//    if FullIndexName <> '' then
//      DataSetProxy.IndexName := FullIndexName else
//      DataSetProxy.IndexFieldNames := IndexFieldList;
//    DataSetProxy.MasterFields := MasterFieldList;
    Result := True;
  end
  else
    Result := False;
end;

procedure TLookupLinkFields.Initialize;

  procedure SetUpLists(const MasterFieldList, DetailFieldList: string);
  var
    I, J: Integer;
    MasterFieldName, DetailFieldName: string;
  begin
    I := 1;
    J := 1;
    while (I <= Length(MasterFieldList)) and (J <= Length(DetailFieldList)) do
    begin
      MasterFieldName := StripFieldName(MasterFieldList, I);
      DetailFieldName := StripFieldName(DetailFieldList, J);
      if (KeyFieldList.Items.IndexOf(MasterFieldName) <> -1) and
        (OrderedLookupKeyList.IndexOf(DetailFieldName) <> -1) then
      begin
        with OrderedLookupKeyList do
          Objects[IndexOf(DetailFieldName)] := TObject(True);
        with LookupKeyList.Items do
          Delete(IndexOf(DetailFieldName));
        with KeyFieldList.Items do
          Delete(IndexOf(MasterFieldName));
        BindList.Items.Add(Format('%s -> %s',
          [DetailFieldName, MasterFieldName]));
        ClearButton.Enabled := True;
      end;
    end;
  end;

begin

//  FMasterDataSet.GetFieldNames(KeyFieldList.Items);
  InitDatasetList;

  LookupDatasetChanged;

  if FDataSet <> nil then
    FDataSet.GetFieldNames(KeyFieldList.Items);

  OrderedKeyFieldList.Assign(KeyFieldList.Items);

  SetUpLists(FKeyFieldNames, FLookupKeyFieldNames);
  ResultFieldList.Text := FLookupResultField;
end;

procedure TLookupLinkFields.LookupDatasetChanged;
var
  I: Integer;
//  IndexExp: string;
begin
  LookupKeyList.Items.Clear;
{  if DataSetProxy.IndexBased then
  begin
    I := DataSetProxy.IndexDefs.IndexOf(DataSetProxy.IndexName);
    if (I <> -1) then IndexExp := DataSetProxy.IndexDefs.Items[I].Expression;
    if IndexExp <> '' then
      LookupKeyList.Items.Add(IndexExp) else
      DataSetProxy.GetFieldNamesForIndex(LookupKeyList.Items);
  end else}

  if FLookupDataSet <> nil then
  begin
    FLookupDataSet.GetFieldNames(LookupKeyList.Items);
    FLookupDataSet.GetFieldNames(ResultFieldList.Items);
  end else
  begin
    ResultFieldList.Items.Clear;
  end;

{  DataSet.GetFieldNames(LookupKeyList.Items);
  KeyFieldList.Items.Assign(OrderedKeyFieldList);
}
  OrderedLookupKeyList.Assign(LookupKeyList.Items);

  for I := 0 to OrderedLookupKeyList.Count - 1 do
    OrderedLookupKeyList.Objects[I] := TObject(False);
  BindList.Clear;
  AddButton.Enabled := False;
  ClearButton.Enabled := False;
  DeleteButton.Enabled := False;
  KeyFieldList.ItemIndex := -1;

end;

procedure TLookupLinkFields.LookupDatasetListChange(Sender: TObject);
begin
{$IFDEF DESIGNTIME}
  FLookupDataSet := FDesigner.GetComponent(LookupDatasetList.Text) as TDataSet;
{$ELSE}
  FLookupDataSet := TDataSet(FComponent.Owner.FindComponent(LookupDatasetList.Text));
{$ENDIF}
  LookupDatasetChanged;
end;

procedure TLookupLinkFields.OrderFieldList(OrderedList, List: TStrings);
var
  I, J: Integer;
  MinIndex, Index, FieldIndex: Integer;
begin
  for J := 0 to List.Count - 1 do
  begin
    MinIndex := $7FFF;
    FieldIndex := -1;
    for I := J to List.Count - 1 do
    begin
      Index := OrderedList.IndexOf(List[I]);
      if Index < MinIndex then
      begin
        MinIndex := Index;
        FieldIndex := I;
      end;
    end;
    List.Move(FieldIndex, J);
  end;
end;

procedure TLookupLinkFields.AddToBindList(const Str1, Str2: string);
var
  I: Integer;
  NewField: string;
  NewIndex: Integer;
begin
  NewIndex := OrderedLookupKeyList.IndexOf(Str1);
  NewField := Format('%s -> %s', [Str1, Str2]);
  with BindList.Items do
  begin
    for I := 0 to Count - 1 do
    begin
      if OrderedLookupKeyList.IndexOf(StripDetail(Strings[I])) > NewIndex then
      begin
        Insert(I, NewField);
        Exit;
      end;
    end;
    Add(NewField);
  end;
end;

procedure TLookupLinkFields.BindingListClick(Sender: TObject);
begin
  TrySameFieldInLookupKeyList;
  AddButton.Enabled := (LookupKeyList.ItemIndex <> LB_ERR) and
    (KeyFieldList.ItemIndex <> LB_ERR);
end;

procedure TLookupLinkFields.AddButtonClick(Sender: TObject);
var
  LookupKeyIndex: Integer;
  KeyFieldIndex: Integer;
begin
  LookupKeyIndex := LookupKeyList.ItemIndex;
  KeyFieldIndex := KeyFieldList.ItemIndex;
  AddToBindList(LookupKeyList.Items[LookupKeyIndex], KeyFieldList.Items[KeyFieldIndex]);
  with OrderedLookupKeyList do
    Objects[IndexOf(LookupKeyList.Items[LookupKeyIndex])] := TObject(True);
  LookupKeyList.Items.Delete(LookupKeyIndex);
  KeyFieldList.Items.Delete(KeyFieldIndex);
  ClearButton.Enabled := True;
  AddButton.Enabled := False;
end;

procedure TLookupLinkFields.ClearButtonClick(Sender: TObject);
var
  I: Integer;
  BindValue: string;
begin
  for I := 0 to BindList.Items.Count - 1 do
  begin
    BindValue := BindList.Items[I];
    LookupKeyList.Items.Add(StripDetail(BindValue));
    KeyFieldList.Items.Add(StripMaster(BindValue));
  end;
  BindList.Clear;
  ClearButton.Enabled := False;
  DeleteButton.Enabled := False;
  OrderFieldList(OrderedLookupKeyList, LookupKeyList.Items);
  LookupKeyList.ItemIndex := -1;
  KeyFieldList.Items.Assign(OrderedKeyFieldList);
  for I := 0 to OrderedLookupKeyList.Count - 1 do
    OrderedLookupKeyList.Objects[I] := TObject(False);
  AddButton.Enabled := False;
end;

procedure TLookupLinkFields.DeleteButtonClick(Sender: TObject);
var
  I: Integer;
begin
  with BindList do
  begin
    for I := Items.Count - 1 downto 0 do
    begin
      if Selected[I] then
      begin
        LookupKeyList.Items.Add(StripDetail(Items[I]));
        KeyFieldList.Items.Add(StripMaster(Items[I]));
        with OrderedLookupKeyList do
          Objects[IndexOf(StripDetail(Items[I]))] := TObject(False);
        Items.Delete(I);
      end;
    end;
    if Items.Count > 0 then
      Selected[0] := True;
    DeleteButton.Enabled := Items.Count > 0;
    ClearButton.Enabled := Items.Count > 0;
    OrderFieldList(OrderedLookupKeyList, LookupKeyList.Items);
    LookupKeyList.ItemIndex := -1;
    OrderFieldList(OrderedKeyFieldList, KeyFieldList.Items);
    KeyFieldList.ItemIndex := -1;
    AddButton.Enabled := False;
  end;
end;

procedure TLookupLinkFields.BindListClick(Sender: TObject);
begin
  DeleteButton.Enabled := BindList.ItemIndex <> LB_ERR;
end;

procedure TLookupLinkFields.BitBtn1Click(Sender: TObject);
var
//  Gap: Boolean;
  I: Integer;
//  FirstIndex: Integer;
begin
//  FirstIndex := -1;
  FKeyFieldNames := '';
  FLookupKeyFieldNames := '';
//  IndexFieldList := '';
  FFullIndexName := '';

  with BindList do
  begin
    for I := 0 to Items.Count - 1 do
    begin
      FKeyFieldNames := Format('%s%s;', [FKeyFieldNames, StripMaster(Items[I])]);
      FLookupKeyFieldNames := Format('%s%s;', [FLookupKeyFieldNames, StripDetail(Items[I])]);
    end;
    if FKeyFieldNames <> '' then
      SetLength(FKeyFieldNames, Length(FKeyFieldNames) - 1);
    if FLookupKeyFieldNames <> '' then
      SetLength(FLookupKeyFieldNames, Length(FLookupKeyFieldNames) - 1);
  end;
  FLookupResultField := ResultFieldList.Text;
end;

procedure TLookupLinkFields.HelpClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TLookupLinkFields.InitDatasetList;
var
  CompName: string;
begin
  LookupDatasetList.Clear;
{$IFDEF DESIGNTIME}
  FDesigner.GetComponentNames(GetTypeData(TDataset.ClassInfo), LookupDatasetList.Items.Append);
{$ELSE}
  GetDataSetListRunTime(LookupDatasetList.Items);
{$ENDIF}
  if FLookupDataSet <> nil then
  begin
    if FLookupDataSet.Owner = FComponent.Owner then
      CompName := FLookupDataSet.Name
    else
      CompName := FLookupDataSet.Owner.Name + '.' + FLookupDataSet.Name;
    LookupDatasetList.ItemIndex := LookupDatasetList.Items.IndexOf(CompName);
  end;  
end;

procedure TLookupLinkFields.GetDataSetListRunTime(List: TStrings);
var
  AnOwner: TComponent;
  i: Integer;
begin
  List.BeginUpdate;
  try
  AnOwner := FComponent.Owner;
  for i := 0 to AnOwner.ComponentCount-1 do
  begin
    if AnOwner.Components[i] is TDataSet then
      List.Add(AnOwner.Components[i].Name);
  end;
  finally
    List.EndUpdate;
  end;
end;

procedure TLookupLinkFields.TrySameFieldInLookupKeyList;
var
  Idx: Integer;
begin
  if KeyFieldList.ItemIndex >= 0 then
  begin
    Idx := LookupKeyList.Items.IndexOf(KeyFieldList.Items[KeyFieldList.ItemIndex]);
    if Idx >= 0 then
      LookupKeyList.ItemIndex := Idx;
  end;
end;

end.
