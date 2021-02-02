unit UnitFrame2;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Forms,
  Graphics, Controls, Dialogs, ExtCtrls, EhLibVCL,
  StrUtils, Types, TypInfo, Contnrs,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  GridsEh, PivotGridsEh, PivotGridToolsEh, DBCtrlsEh, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, DBAxisGridsEh, DBGridEh,
  ComCtrls, DataDriverEh, ADODataDriverEh, MemTableEh, MemTableDataEh, Db,
  ADODB, StdCtrls, Mask, Buttons, Menus;

type
  TFrame2 = class(TFrame)
    Panel1: TPanel;
    Panel4: TPanel;
    lReportName: TLabel;
    bRebuildPivotData: TButton;
    panPivotGridToolBox: TPanel;
    Panel8: TPanel;
    Panel6: TPanel;
    neDefColWidth: TDBNumberEditEh;
    PivotGridToolBoxEh1: TPivotGridToolBoxEh;
    Splitter1: TSplitter;
    SpeedButton1: TSpeedButton;
    mtMasterData: TMemTableEh;
    ddrMasterData: TADODataDriverEh;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PivotGridEh1: TPivotGridEh;
    DBGridEh1: TDBGridEh;
    dsMasterData: TDataSource;
    ConProvMaster: TADOConnectionProviderEh;
    PivotDataSourceEh1: TPivotDataSourceEh;
    sbSave: TSpeedButton;
    ppmSourceDataGrid: TPopupMenu;
    Savetofile1: TMenuItem;
    LoadFromFile1: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    procedure SpeedButton1Click(Sender: TObject);
    procedure bRebuildPivotDataClick(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure PivotGridEh1GridDefinitionChanged(Sender: TObject);
    procedure PivotGridEh1GridLayoutChanged(Sender: TObject);
    procedure Savetofile1Click(Sender: TObject);
    procedure LoadFromFile1Click(Sender: TObject);

  private
    FPivotLayoutChanged: Boolean;
    FDataBuiling: Boolean;
    function GetPivotReportLayoutAsXml: String;
    procedure InitPivotReportLayoutFromXml(XmlText: String);

  public
    ReportParamsDataSet: TDataSet;

    function CloseQuery: Boolean;
    procedure SelectReport(ReportParamsDataSet: TDataSet);
    procedure FillPivotStruct(ReportParamsDataSet: TDataSet; SourceDataSet: TDataSet);
    procedure SaveReportLayout;
    procedure UpdateButtonsState;
    procedure RebuildPivotData;
  end;

implementation

uses XMLIntf, XMLDoc, Unit1;

{$R *.dfm}

procedure TFrame2.bRebuildPivotDataClick(Sender: TObject);
begin
  FDataBuiling := True;
  try
    RebuildPivotData;
  finally
    FDataBuiling := False;
//    FPivotLayoutChanged := False;
    UpdateButtonsState;
  end;
end;

procedure TFrame2.RebuildPivotData;
begin
  PivotGridEh1.DefaultColWidth := neDefColWidth.Value;
  PivotDataSourceEh1.CreateAndFillSourceTable;
  PivotDataSourceEh1.BuildPivotData;
  TabSheet1.PageControl.ActivePageIndex := TabSheet1.TabIndex;
end;

function VarDynArrayItemCompare(List: Pointer; ItemIndex1, ItemIndex2: Integer): Integer;
var
  Res: TVariantRelationship;
begin
  Result := 0;
  Res := DBVarCompareValue(TPivotKeyValueStateEh(TObjectList(List)[ItemIndex1]).KeyValue, TPivotKeyValueStateEh(TObjectList(List)[ItemIndex2]).KeyValue);
  case Res of
    //vrEqual: Result := 0;
    vrLessThan: Result := -1;
    vrGreaterThan: Result := 1;
    vrNotEqual: raise Exception.Create('Compare error in TPivotKeyValueStatesEh.UpdateData');
  end;
end;

procedure VarDynArrayItemExchange(List: Pointer; ItemIndex1, ItemIndex2: Integer);
var
  vTmp: TObject;
begin
  vTmp := TObjectList(List)[ItemIndex2];
  TObjectList(List)[ItemIndex2] := TObjectList(List)[ItemIndex1];
  TObjectList(List)[ItemIndex1] := vTmp;
end;

procedure TFrame2.InitPivotReportLayoutFromXml(XmlText: String);
var
  XMLDoc: IXMLDocument;
  RootNode, Node: IXMLNode;
  i: Integer;

  procedure ReadColsList(Node: IXMLNode);
  var
    CNode: IXMLNode;
    i: Integer;
    PivotField: TPivotFieldEh;
  begin
    if Node.NodeName <> 'ColsList' then
      raise Exception.Create('XML Read Error: Node.NodeName <> ''ColsList''');
    PivotDataSourceEh1.ColumnFields.Clear;
    for i := 0 to Node.ChildNodes.Count-1 do
    begin
      CNode := Node.ChildNodes[i];
      PivotField := PivotGridEh1.PivotFields.FindFieldByName(VarToStr(CNode.NodeValue));
//      if PivotField <> nil then
      PivotDataSourceEh1.ColumnFields.AddObject(VarToStr(CNode.NodeValue), PivotField);
    end;
  end;

  procedure ReadRowsList(Node: IXMLNode);
  var
    CNode: IXMLNode;
    i: Integer;
    PivotField: TPivotFieldEh;
  begin
    if Node.NodeName <> 'RowsList' then
      raise Exception.Create('XML Read Error: Node.NodeName <> ''RowsList''');
    PivotDataSourceEh1.RowFields.Clear;
    for i := 0 to Node.ChildNodes.Count-1 do
    begin
      CNode := Node.ChildNodes[i];
      PivotField := PivotGridEh1.PivotFields.FindFieldByName(VarToStr(CNode.NodeValue));
//      if PivotField <> nil then
      PivotDataSourceEh1.RowFields.AddObject(VarToStr(CNode.NodeValue), PivotField);
    end;
  end;

  procedure ReadValsList(Node: IXMLNode);
  var
    CNode: IXMLNode;
    i: Integer;
    SFValInfo: TPivotFieldValueInfoEh;
  begin
    if Node.NodeName <> 'ValsList' then
      raise Exception.Create('XML Read Error: Node.NodeName <> ''ValsList''');
    PivotDataSourceEh1.ValueFieldDefs.Clear;
    for i := 0 to Node.ChildNodes.Count-1 do
    begin
      CNode := Node.ChildNodes[i];
      SFValInfo := PivotDataSourceEh1.ValueFieldDefs.Add;
      SFValInfo.PivotFieldName := VarToStr(CNode.NodeValue);
      SFValInfo.SumFunction :=
        TPivotValueTypeEh(GetEnumValue(TypeInfo(TPivotValueTypeEh), VarToStr(CNode.Attributes['SumFunction'])));
      SFValInfo.DisplayFormat := VarToStr(CNode.Attributes['DisplayFormat']);
    end;
  end;

  procedure ReadProperties(Node: IXMLNode);
  var
    CNode: IXMLNode;
    i: Integer;
  begin
    if Node.NodeName <> 'Properties' then
      raise Exception.Create('XML Read Error: Node.NodeName <> ''Properties''');
    for i := 0 to Node.ChildNodes.Count-1 do
    begin
      CNode := Node.ChildNodes[i];
      if CNode.NodeName = 'DefaultColWidth' then
        neDefColWidth.Value := StrToInt(CNode.NodeValue);
    end;
  end;

  procedure ReadPivotFieldsList(Node: IXMLNode);
  begin
    raise Exception.Create('ReadPivotFieldsList is not implemented');
  end;

  procedure ReadKeyValueState(Node: IXMLNode; PivotField: TPivotFieldEh);
  var
    RowNode, DataNode, ExpandedNode, VisibleNode: IXMLNode;
    KeyValue: Variant;
    i: Integer;
//    ExpandedState: Boolean;
    KeyValueStates: TObjectList;
    kvs: TPivotKeyValueStateEh;
  begin
    KeyValueStates := TObjectList.Create(False);

    for i := 0 to Node.ChildNodes.Count-1 do
    begin
      KeyValue := Unassigned;
      RowNode := Node.ChildNodes[i];
      if (RowNode.ChildNodes.Count > 0) and (RowNode.ChildNodes[0].ChildNodes.Count > 0) then
      begin
        KeyValue := RowNode.ChildNodes[0].ChildNodes[0].Text;
        KeyValue := PivotField.SysStringToDataValue(KeyValue);
      end;
//-      else
//-        raise Exception.Create('ReadKeyValueState: Invalid data format');

      if not VarIsClear(KeyValue) then
      begin
        kvs := TPivotKeyValueStateEh.CreateApart(KeyValue);
        KeyValueStates.Add(kvs);
        DataNode := RowNode.ChildNodes.FindNode('Data');
        if DataNode <> nil then
        begin
          ExpandedNode := DataNode.ChildNodes.FindNode('Expanded');
          if ExpandedNode <> nil then
            kvs.Expanded := StrToBool(ExpandedNode.Text);
          VisibleNode := DataNode.ChildNodes.FindNode('Visible');
          if VisibleNode <> nil then
            kvs.Visible := StrToBool(VisibleNode.Text);
        end;
      end;
    end;

//-    DBMemoEh1.Clear;
//-    DBMemoEh1.Lines.BeginUpdate;
//-    for i := 0 to KeyValueStates.Count-1 do
//-    begin
//-      DBMemoEh1.Lines.Add(i.ToString + ' - ' + SysVarToStr(TPivotKeyValueStateEh(KeyValueStates[i]).KeyValue));
//-    end;
//-   DBMemoEh1.Lines.EndUpdate;


    AbstractQuickSort(KeyValueStates, 0, KeyValueStates.Count-1, VarDynArrayItemCompare, VarDynArrayItemExchange);
    //KeyValueStates.SortData;

    PivotField.KeyValueStates.UpdateStateFromSortedList(KeyValueStates);

    KeyValueStates.OwnsObjects := True;
    KeyValueStates.Free;
  end;

  procedure ReadPivotFieldProps(Node: IXMLNode);
  var
    CNode: IXMLNode;
    i: Integer;
    PivotFieldName: String;
    PivotField: TPivotFieldEh;
  begin
    PivotFieldName := '';
    for i := 0 to Node.ChildNodes.Count-1 do
    begin
      CNode := Node.ChildNodes[i];
      if CNode.NodeName = 'PivotFieldName' then
      begin
        PivotFieldName := VarToStr(CNode.NodeValue);
        Break;
      end;
    end;
    if PivotFieldName = '' then
      raise Exception.Create('ReadPivotFieldProps  PivotFieldName = ''''');

    PivotField := PivotDataSourceEh1.PivotFields.FindFieldByName(PivotFieldName);

    if PivotField <> nil then
    begin
      for i := 0 to Node.ChildNodes.Count-1 do
      begin
        CNode := Node.ChildNodes[i];
        if CNode.NodeName = 'DisplayWidth' then
        begin
          PivotField.DisplayWidth := StrToInt(CNode.NodeValue)
        end else if CNode.NodeName = 'KeyValueState' then
          ReadKeyValueState(CNode, PivotField);
      end;
    end;

    PivotFieldName := '';
  end;

  procedure ReadPivotFieldsProps(Node: IXMLNode);
  var
    CNode: IXMLNode;
    i: Integer;
  begin
    if Node.NodeName <> 'PivotFieldsProps' then
      raise Exception.Create('XML Read Error: Node.NodeName <> ''PivotFieldsProps''');
    for i := 0 to Node.ChildNodes.Count-1 do
    begin
      CNode := Node.ChildNodes[i];
      if CNode.NodeName = 'PivotFieldProps' then
        ReadPivotFieldProps(CNode);
    end;
  end;

  procedure ReadPivotDataStructure(Node: IXMLNode);
  var
    CNode: IXMLNode;
    i: Integer;
  begin
    if Node.NodeName <> 'PivotDataStructure' then
      raise Exception.Create('XML Read Error: Node.NodeName <> ''PivotDataStructure''');

    for i := 0 to Node.ChildNodes.Count-1 do
    begin
      CNode := Node.ChildNodes[i];
      if CNode.NodeName = 'ColsList' then
        ReadColsList(CNode)
      else if CNode.NodeName = 'RowsList' then
        ReadRowsList(CNode)
      else if CNode.NodeName = 'ValsList' then
       ReadValsList(CNode);
    end;
  end;

  procedure ReadHorzAxisKeyValueState(Node: IXMLNode);
  begin
    raise Exception.Create('ReadHorzAxisKeyValueState is not implemented');
  end;

begin
  XMLDoc := NewXMLDocument;
  XMLDoc.XML.Text := XmlText;
  XMLDoc.Active := True;
//  if XMLDoc.ChildNodes.Count < 2 then
//    raise Exception.Create('XML Read Error: XMLDoc.ChildNodes.Count < 2');
  RootNode := nil;
  for i := 0 to XMLDoc.ChildNodes.Count-1 do
  begin
    if XMLDoc.ChildNodes[i].NodeName = 'PivotReportLayout' then
    begin
      RootNode := XMLDoc.ChildNodes[1];
      Break;
    end;
  end;
  if (RootNode = nil) then Exit;

  if RootNode.NodeName <> 'PivotReportLayout' then
    raise Exception.Create('XML Read Error: RootNode.NodeName <> ''PivotReportLayout''');
  for i := 0 to RootNode.ChildNodes.Count-1 do
  begin
    Node := RootNode.ChildNodes[i];
    if Node.NodeName = 'Properties' then
      ReadProperties(Node)
    else if Node.NodeName = 'PivotFielsList' then
      ReadPivotFieldsList(Node)
    else if Node.NodeName = 'PivotFieldsProps' then
      ReadPivotFieldsProps(Node)
    else if Node.NodeName = 'PivotDataStructure' then
      ReadPivotDataStructure(Node)
    else if Node.NodeName = 'HorzAxisKeyValueState' then
      ReadHorzAxisKeyValueState(Node);
  end;
end;

procedure TFrame2.PivotGridEh1GridDefinitionChanged(Sender: TObject);
begin
  if FDataBuiling then Exit;
  FPivotLayoutChanged := True;
  UpdateButtonsState;
end;

procedure TFrame2.PivotGridEh1GridLayoutChanged(Sender: TObject);
begin
  if FDataBuiling then Exit;
  FPivotLayoutChanged := True;
  UpdateButtonsState;
end;

function TFrame2.CloseQuery: Boolean;
var
  ModRes: Integer;
begin
  Result := True;
  if FPivotLayoutChanged then
  begin
    ModRes := MessageDlg('The Layout has been changed.' + sLineBreak + 'Do you want to save the Layout?',
      mtConfirmation, mbYesNoCancel, 0);
    if ModRes = mrCancel then
      Result := False
    else if ModRes = mrYes then
      sbSaveClick(nil);
  end;
end;

procedure TFrame2.FillPivotStruct(ReportParamsDataSet, SourceDataSet: TDataSet);
begin
  PivotDataSourceEh1.ColumnFields.Clear;
  PivotDataSourceEh1.RowFields.Clear;
  PivotDataSourceEh1.ValueFieldDefs.Clear;

  try
    InitPivotReportLayoutFromXml(ReportParamsDataSet.FieldByName('LayoutAsXML').AsString);
  except
    on E: Exception do
      Application.HandleException(E);
  end;
end;

function TFrame2.GetPivotReportLayoutAsXml: String;
var
  XMLDoc: IXMLDocument;
  RootNode, Node: IXMLNode;

  procedure AddProperties(Node: IXMLNode);
  var
    CNode: IXMLNode;
  begin
    CNode := Node.AddChild('DefaultColWidth');
    CNode.Text := IntToStr(neDefColWidth.Value);
  end;

  procedure AddKeyValueState(Node: IXMLNode; PivotField: TPivotFieldEh);
  var
    i, j: Integer;
    CNodeRow, CNodeKey, CNodeVi, CNodeData, CNodeDataVi: IXMLNode;
    kvs: TPivotKeyValueStateEh;
  begin
    for i := 0 to PivotField.KeyValueStates.Count-1 do
    begin
      kvs := PivotField.KeyValueStates[i];
      CNodeRow := Node.AddChild('Row');

      CNodeKey := CNodeRow.AddChild('Key');

      for j := 0 to 0 do
      begin
        CNodeVi := CNodeKey.AddChild('v1');
        CNodeVi.Text := SysVarToStr(kvs.KeyValue);
      end;

      CNodeData := CNodeRow.AddChild('Data');

      CNodeDataVi := CNodeData.AddChild('Expanded');
      CNodeDataVi.Text := BoolToStr(kvs.Expanded, True);

      CNodeDataVi := CNodeData.AddChild('Visible');
      CNodeDataVi.Text := BoolToStr(kvs.Visible, True);
    end;
  end;

  procedure AddPivotFieldsProps(Node: IXMLNode);
  var
    i: Integer;
    CNode,C1Node: IXMLNode;
    pf: TPivotFieldEh;
  begin
    for i := 0 to PivotDataSourceEh1.PivotFields.Count-1 do
    begin
      CNode := Node.AddChild('PivotFieldProps');

      pf := PivotDataSourceEh1.PivotFields[i];
      C1Node := CNode.AddChild('PivotFieldName');
      C1Node.Text := pf.FieldName;

      if pf.DisplayWidth > 0 then
      begin
        C1Node := CNode.AddChild('DisplayWidth');
        C1Node.Text := IntToStr(pf.DisplayWidth);
      end;

      if (PivotDataSourceEh1.ColumnFields.IndexOfObject(pf) >= 0) or
         (PivotDataSourceEh1.RowFields.IndexOfObject(pf) >= 0)
      then
      begin
        C1Node := CNode.AddChild('KeyValueState');
        AddKeyValueState(C1Node, pf);
      end;
    end;
  end;

  procedure AddPivotDataStructure(StructNode: IXMLNode);
  var
    i: Integer;
    Node, CNode: IXMLNode;
  begin
    Node := StructNode.AddChild('ColsList');
    for i := 0 to PivotDataSourceEh1.ColumnFields.Count-1 do
    begin
      CNode := Node.AddChild('Col'+IntToStr(i));
      CNode.Text := PivotDataSourceEh1.ColumnFields[i];
    end;

    Node := StructNode.AddChild('RowsList');
    for i := 0 to PivotDataSourceEh1.RowFields.Count-1 do
    begin
      CNode := Node.AddChild('Row'+IntToStr(i));
      CNode.Text := PivotDataSourceEh1.RowFields[i];
    end;

    Node := StructNode.AddChild('ValsList');
    for i := 0 to PivotDataSourceEh1.ValueFieldDefs.Count-1 do
    begin
      CNode := Node.AddChild('Val'+IntToStr(i));
      CNode.Text := PivotDataSourceEh1.ValueFieldDefs[i].PivotField.FieldName;
      CNode.Attributes['SumFunction'] :=
        GetEnumName(TypeInfo(TPivotValueTypeEh), Ord(PivotDataSourceEh1.ValueFieldDefs[i].SumFunction));
      CNode.Attributes['DisplayFormat'] := PivotDataSourceEh1.ValueFieldDefs[i].DisplayFormat;
    end;
  end;

begin
  XMLDoc := NewXMLDocument;
  XMLDoc.Options := [doNodeAutoIndent];

  RootNode := XMLDoc.AddChild('PivotReportLayout');

  Node := RootNode.AddChild('Properties');
  AddProperties(Node);

  Node := RootNode.AddChild('PivotFieldsProps');
  AddPivotFieldsProps(Node);

  Node := RootNode.AddChild('PivotDataStructure');
  AddPivotDataStructure(Node);

  Result := XMLDoc.XML.Text;
end;

procedure TFrame2.SaveReportLayout;
begin
  if (ReportParamsDataSet = nil) or not ReportParamsDataSet.Locate('RepName', lReportName.Caption, []) then
    Exit;

  ReportParamsDataSet.Edit;

  ReportParamsDataSet.FieldByName('LayoutAsXML').AsString := GetPivotReportLayoutAsXml;

  ReportParamsDataSet.Post;
end;

procedure TFrame2.Savetofile1Click(Sender: TObject);
begin
  SaveDialog1.InitialDir := ExtractFileDir(ParamStr(0));
  SaveDialog1.FileName := 'PivotSourceData.dfm';
  if SaveDialog1.Execute then
  begin
    mtMasterData.SaveToFile(SaveDialog1.FileName);
  end;
end;

procedure TFrame2.LoadFromFile1Click(Sender: TObject);
var
  ModRes: Integer;
begin
  OpenDialog1.InitialDir := ExtractFileDir(ParamStr(0));
  OpenDialog1.FileName := 'PivotSourceData.dfm';
  if OpenDialog1.Execute then
  begin
    mtMasterData.DataDriver := nil;
    mtMasterData.LoadFromFile(OpenDialog1.FileName);
  end;

  ModRes := MessageDlg('Do you want to recreate pivot fields?', mtConfirmation, [mbYes, mbNo], 0);
  if ModRes = mrYes then
  begin
    lReportName.Caption := '<Tmp>';
    PivotDataSourceEh1.PivotFields.Clear;
    PivotDataSourceEh1.PivotFields.RebuildPivotFields;
    PivotDataSourceEh1.ColumnFields.Clear;
    PivotDataSourceEh1.RowFields.Clear;
    PivotDataSourceEh1.ValueFieldDefs.Clear;
  end;
end;

procedure TFrame2.SelectReport(ReportParamsDataSet: TDataSet);
var
  connString: String;
  connParams: TStringList;
  FileName, s: String;
  FilesList: TStringList;
  i: Integer;
  AppDir: String;
begin
  if (ReportParamsDataSet.FieldByName('ConnectionParameters').AsString = '') and
     (ReportParamsDataSet.FieldByName('FilePaths').AsString = '')
  then
    raise Exception.Create('ConnectionParameters and FilePaths are Empty');

  AppDir := ExcludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));

  lReportName.Caption := ReportParamsDataSet.FieldByName('RepName').AsString;

  FilesList := TStringList.Create;
  FilesList.Text := ReportParamsDataSet.FieldByName('FilePaths').AsString;
  if FilesList.Count > 0 then
  begin
    FileName := '';
    for i := 0 to FilesList.Count-1 do
    begin
      s := FilesList[i];
      s := StringReplace(s, '%APPDIR%', AppDir, [rfIgnoreCase]);
      if FileExists(s) then
      begin
        FileName := s;
        Break;
      end;
    end;
    if FileName = '' then
      raise Exception.Create('Can''t find file name specified by "FilePaths" field value');
  end;
  FilesList.Free;

  connParams := TStringList.Create;
  connParams.Text := ReportParamsDataSet.FieldByName('ConnectionParameters').AsString;
  for i := 0 to connParams.Count-1 do
  begin
    if Copy(connParams[i], 1, Length('Data Source')) = 'Data Source' then
    begin
      s := StringReplace(connParams[i], '%FilePath%', FileName, [rfIgnoreCase]);
      connParams[i] := s;
    end;
  end;
  connString := Form1.GetDelimitedTextFromStrings(connParams, ';');
  ConProvMaster.InlineConnection.ConnectionString := connString;
  if connString <> '' then
    ConProvMaster.InlineConnection.Connected := True;
  connParams.Free;

  ddrMasterData.SelectSQL.Text := ReportParamsDataSet.FieldByName('SQLText').AsString;

  FDataBuiling := True;
  try
    mtMasterData.Close;
    if connString = '' then
    begin
      mtMasterData.DataDriver := nil;
      mtMasterData.LoadFromFile(ReportParamsDataSet.FieldByName('FilePaths').AsString);
    end else
    begin
      mtMasterData.DataDriver := ddrMasterData;
    end;
    mtMasterData.Open;

    PivotDataSourceEh1.PivotFields.Clear;
    PivotDataSourceEh1.PivotFields.RebuildPivotFields;
    PivotDataSourceEh1.CreateAndFillSourceTable;

    FillPivotStruct(ReportParamsDataSet, mtMasterData);

    //TabSheet2.PageControl.ActivePageIndex := TabSheet2.TabIndex;

    Self.ReportParamsDataSet := ReportParamsDataSet;
    RebuildPivotData;
  finally
    FDataBuiling := False;
    FPivotLayoutChanged := False;
    UpdateButtonsState;
  end;
end;

procedure TFrame2.SpeedButton1Click(Sender: TObject);
var
  ModRes: Integer;
begin
  if FPivotLayoutChanged = True then
  begin
    ModRes := MessageDlg('The Layout has been changed.' + sLineBreak + 'Do you want to save the Layout?',
      mtConfirmation, [mbYes, mbNo], 0);
    if ModRes = mrYes then
      sbSaveClick(nil);
  end;
  TForm1(Parent).SwitchToSelectReport;
end;

procedure TFrame2.UpdateButtonsState;
begin
  sbSave.Enabled := (FPivotLayoutChanged = True);
end;

procedure TFrame2.sbSaveClick(Sender: TObject);
begin
  SaveReportLayout;
  FPivotLayoutChanged := False;
  UpdateButtonsState;
end;

end.
