{*******************************************************}
{                                                       }
{                     EhLib 10.0                        }
{          Registers object that sort data in           }
{                  TCustomMemTableEh                    }
{                                                       }
{    Copyright (c) 2003-2020 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{*******************************************************}
{ Add this unit to 'uses' clause of any unit of your    }
{ project to allow TDBGridEh to sort data in            }
{ TMemTableEh automatically after sorting markers       }
{ will be changed.                                      }
{ TMTEDatasetFeaturesEh determine if                    }
{ TDBGridEh.SortLocal = True then it will sort data     }
{ in memory using procedure SortByFields                }
{ else if SortLocal = False and MemTable connected to   }
{ other  DataSet via ProviderDataSet, it will try to    }
{ sord data in this DataSet using                       }
{ GetDatasetFeaturesForDataSet function                 }
{*******************************************************}

unit EhLibMTE;

{$I EhLib.Inc}

interface

uses
{$IFDEF EH_LIB_17} System.Contnrs, {$ENDIF}
  Variants, Types,
{$IFDEF CIL}
  EhLibVCLNET,
{$ELSE}
  {$IFDEF FPC}
  EhLibLCL, LCLType, DBGridsEh,
  {$ELSE}
  EhLibVCL, DBGridEh,
  {$ENDIF}
{$ENDIF}
  DBUtilsEh,
  Db, MemTableEh, MemTableDataEh, DataDriverEh,
  SysUtils, ToolCtrlsEh, Classes;

type

  TMTEDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  protected
    FBaseNode: TMemRecViewEh;
  public
    constructor Create; override;
    function GetLikeWildcardForSeveralCharacters: String; override;
    function LocateText(AGrid: TCustomDBGridEh; const FieldName: string; const Text: String; AOptions: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh; TimeOut: System.LongWord = 0; CheckValueEvent: TCheckColumnValueAcceptEventEh = nil): Boolean; override;
    function IsInOperatorSupported(Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): Boolean; override;
    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ExecuteFindDialog(Sender: TObject; const Text, FieldName: String; Modal: Boolean); override;
    procedure FillSTFilterListCommandValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings); override;
    procedure FillSTFilterListDataValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings); override;
    procedure FillFieldUniqueValues(Field: TField; Items: TStrings); override;
  end;

  function WrapFieldName(const FieldName: String): String;

var
  SortInView: Boolean;

implementation

uses DBGridEhGrouping;

type
  TDataDriverEhCrack = class(TDataDriverEh) end;

function WrapFieldName(const FieldName: String): String;
var
  i: Integer;
begin
  for i := 1 to Length(FieldName) do
  begin
    if CharInSetEh(FieldName[i], [' ', ',', ';', '''']) then
    begin
      Result := '[' + FieldName + ']';
      Exit;
    end;
  end;
  Result := FieldName;
end;

procedure ApplySortingForSQLDataDriver(Grid: TCustomDBGridEh;
  SQLDriver: TCustomSQLDataDriverEh; UseFieldName: Boolean);
var
  i, OrderLine: Integer;
  s: String;
  SQL: TStrings;
  SortOrder: TSortOrderEh;
begin

  SQL := TStringList.Create;
  try
    SQL.Text := SQLDriver.SelectSQL.Text;

    s := '';
    for i := 0 to Grid.SortMarkedColumns.Count - 1 do
    begin
      if UseFieldName
        then s := s + Grid.SortMarkedColumns[i].FieldName
        else s := s + IntToStr(Grid.SortMarkedColumns[i].Field.FieldNo);

      SortOrder := Grid.Center.GetSortOrderForSortMarker(Grid,
        Grid.SortMarkedColumns[i], Grid.SortMarkedColumns[i].Title.SortMarker);
      if SortOrder = soDescEh
        then s := s + ' DESC, '
        else s := s + ', ';
    end;

    s := Copy(s, 1, Length(s) - 2);
    if SQLDriver.OrderByTextSupported then
      SQLDriver.ApplyOrderByText(s)
    else
    begin
      if s <> '' then
        s := 'ORDER BY ' + s;

      OrderLine := -1;
      for i := 0 to SQL.Count - 1 do
        if UpperCase(Copy(SQL[i], 1, Length('ORDER BY'))) = 'ORDER BY' then
        begin
          OrderLine := i;
          Break;
        end;
      if OrderLine = -1 then
      begin
        SQL.Add('');
        OrderLine := SQL.Count-1;
      end;

      SQL.Strings[OrderLine] := s;

      SQLDriver.SelectSQL := SQL;
     end;
  finally
    SQL.Free;
  end;
end;

procedure ApplyFilterForSQLDataDriver(Grid: TCustomDBGridEh; SQLDriver: TCustomSQLDataDriverEh;
  DateValueToSQLString: TDateValueToSQLStringProcEh);
var
  i, OrderLine: Integer;
  s: String;
  SQL: TStrings;
begin
  SQL := TStringList.Create;
  try
    SQL.Text := SQLDriver.SelectSQL.Text;

    OrderLine := -1;
    for i := 0 to SQL.Count - 1 do
      if UpperCase(Copy(SQL[i], 1, Length(SQLFilterMarker))) = UpperCase(SQLFilterMarker) then
      begin
        OrderLine := i;
        Break;
      end;
    s := GetExpressionAsFilterString(Grid, GetOneExpressionAsSQLWhereString, DateValueToSQLString, True);

    if SQLDriver.FilterTextSupported then
      SQLDriver.ApplyFilterText(s)
    else
    begin
      if s = '' then
        s := '1=1';
      if OrderLine = -1 then
        Exit;

      SQL.Strings[OrderLine] := SQLFilterMarker + ' and (' + s + ')';
      SQLDriver.SelectSQL := SQL;
    end;

  finally
    SQL.Free;
  end;
end;

function LocateTextInTree(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh; BaseNode: TMemRecViewEh;
  CheckValueProc: TCheckColumnValueAcceptEventEh = nil): Boolean;
var
  FCurInListColIndex: Integer;
  TreeListPos: Integer;
  MemTable: TCustomMemTableEh;
  TreeList: TMemoryTreeListEh;
  RootNode, NextNode: TMemRecViewEh;

  function CheckEofBof: Boolean;
  begin
    if (Direction = ltdUpEh)
      then Result := (NextNode = nil)
      else Result := (NextNode = nil);
  end;

  procedure First;
  begin
    TreeListPos := 0;
    MemTable.InstantReadLeave;
    if TreeFindRange = lttInCurrentLevelEh then
    begin
      RootNode := BaseNode.NodeParent.VisibleNodeItems[0];
      NextNode := RootNode;
    end else if TreeFindRange = lttInCurrentNodeEh then
    begin
      RootNode := BaseNode;
      NextNode := RootNode;
    end else
      NextNode := TreeList.AccountableItem[TreeListPos];
    MemTable.InstantReadEnter(NextNode, -1);
  end;

  procedure Next;
  begin
    Inc(TreeListPos);
    if TreeFindRange = lttInCurrentLevelEh then
    begin
      if (NextNode.NodeParent.VisibleNodesCount-1 = NextNode.VisibleNodeIndex)
      then
        NextNode := nil
      else
        NextNode := NextNode.NodeParent.VisibleNodeItems[NextNode.VisibleNodeIndex + 1];
    end else if TreeFindRange = lttInCurrentNodeEh then
    begin
      if NextNode.VisibleNodesCount > 0 then
        NextNode := NextNode.VisibleNodeItems[0]
      else if (NextNode <> BaseNode) and
              (NextNode.NodeParent.VisibleNodesCount-1 > NextNode.VisibleNodeIndex) then
        NextNode := NextNode.NodeParent.VisibleNodeItems[NextNode.VisibleNodeIndex + 1]
      else
      begin
        while (NextNode <> BaseNode) and (NextNode.NodeParent.VisibleNodesCount-1 = NextNode.VisibleNodeIndex)  do
          NextNode := NextNode.NodeParent;
        if NextNode = BaseNode
          then NextNode := nil
          else NextNode := NextNode.NodeParent.VisibleNodeItems[NextNode.VisibleNodeIndex + 1];
      end;
    end else
    begin
      if TreeListPos <= TreeList.AccountableCount-1 then
        NextNode := TreeList.AccountableItem[TreeListPos]
      else
        NextNode := nil;
    end;
    if NextNode <> nil then
    begin
      MemTable.InstantReadLeave;
      MemTable.InstantReadEnter(NextNode, -1);
    end;
  end;

  procedure Prior;
  begin
    Dec(TreeListPos);
    if TreeFindRange = lttInCurrentLevelEh then
    begin
      if NextNode.VisibleNodeIndex = 0
      then
        NextNode := nil
      else
        NextNode := NextNode.NodeParent.VisibleNodeItems[NextNode.VisibleNodeIndex - 1];
    end else if TreeFindRange = lttInCurrentNodeEh then
    begin
      if (TreeListPos >= 0) and
       ((TreeList.AccountableItem[TreeListPos].NodeLevel > BaseNode.NodeLevel) or
        (TreeList.AccountableItem[TreeListPos] = BaseNode)) then
        NextNode := TreeList.AccountableItem[TreeListPos]
      else
        NextNode := nil;
    end else
    begin
      if TreeListPos >= 0 then
        NextNode := TreeList.AccountableItem[TreeListPos]
      else
        NextNode := nil;
    end;
    if NextNode <> nil then
    begin
      MemTable.InstantReadLeave;
      MemTable.InstantReadEnter(NextNode, -1);
    end;
  end;

  procedure ToNextRec;
  begin
    if ltoAllFieldsEh in AOptions then
      if (Direction = ltdUpEh) then
      begin
        if FCurInListColIndex > 0 then
          Dec(FCurInListColIndex)
        else
        begin
          Prior;
          FCurInListColIndex := AGrid.VisibleColumns.Count-1;
        end;
      end else
      begin
        if FCurInListColIndex < AGrid.VisibleColumns.Count-1 then
          Inc(FCurInListColIndex)
        else
        begin
          Next;
          FCurInListColIndex := 0;
        end;
      end
    else if (Direction = ltdUpEh) then
      Prior
    else
      Next;
  end;

  function ColText(Col: TColumnEh): String;
  begin
    if ltoMatchFormatEh in AOptions then
      Result := Col.DisplayText
    else if Col.Field <> nil then
      Result := Col.Field.AsString
    else
      Result := '';
  end;

  function AnsiContainsText(const AText, ASubText: string): Boolean;
  begin
    Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
  end;

  function AnsiContainsStr(const AText, ASubText: string): Boolean;
  begin
    Result := AnsiPos(ASubText, AText) > 0;
  end;

var
  DataText: String;
  i: Integer;
  RecView, RecViewFound: TMemRecViewEh;
begin
  Result := False;
  MemTable := (AGrid.DataSource.DataSet as TCustomMemTableEh);
  MemTable.CheckBrowseMode;
  if MemTable.BOF and MemTable.EOF then Exit;
  TreeList := MemTable.RecordsView.MemoryTreeList;
  RecView := MemTable.TreeNode;
  if FieldName <> '' then
    FCurInListColIndex := AGrid.VisibleColumns.IndexOf(AGrid.FieldColumns[FieldName])
  else
    FCurInListColIndex := AGrid.VisibleColumns.IndexOf(AGrid.Columns[AGrid.SelectedIndex]);
  if(FCurInListColIndex = -1) then
    FCurInListColIndex := 0;
  if (AGrid.VisibleColumns.Count = 0) then Exit;
  MemTable.InstantReadEnter(0);
  AGrid.DataSource.DataSet.DisableControls;
  try
    if (Direction = ltdAllEh) then
    begin
      First;
    end else
    begin
      TreeListPos := 0;
      for i := 0 to TreeList.AccountableCount-1 do
        if TreeList.AccountableItem[i] = RecView then
        begin
          TreeListPos := i;
          NextNode := RecView;
          MemTable.InstantReadLeave;
          MemTable.InstantReadEnter(NextNode, -1);
          Break;
        end;
      ToNextRec;
    end;
    while not CheckEofBof do
    begin

      if @CheckValueProc <> nil then
      begin
        Result := False;
        CheckValueProc(AGrid.VisibleColumns[FCurInListColIndex], Result, Text);
        if Result then
        begin
          AGrid.SelectedIndex := AGrid.VisibleColumns[FCurInListColIndex].Index;
          Break;
        end;
      end else
      begin
        DataText := ColText(AGrid.VisibleColumns[FCurInListColIndex]);
        
        if not (ltoCaseInsensitiveEh in AOptions) then
        begin
          
          if ( (Matching = ltmAnyPartEh) and (
              AnsiContainsStr(DataText, Text) )
             ) or (
          
            (Matching = ltmWholeEh) and (DataText = Text)
            ) or ((Matching = ltmFromBegingEh) and
          
            (Copy(DataText, 1, Length(Text)) = Text) )
          then
          begin
            Result := True;
            AGrid.SelectedIndex := AGrid.VisibleColumns[FCurInListColIndex].Index;
            Break;
          end
        end else
        
        if ( (Matching = ltmAnyPartEh) and (
            AnsiContainsText(DataText, Text) )
           ) or (
        
          (Matching = ltmWholeEh) and (
          AnsiUpperCase(DataText) =
          AnsiUpperCase(Text))
          ) or ((Matching = ltmFromBegingEh) and
        
          (AnsiUpperCase(Copy(DataText, 1, Length(Text))) =
          AnsiUpperCase(Text)) ) then
        begin
          Result := True;
          AGrid.SelectedIndex := AGrid.VisibleColumns[FCurInListColIndex].Index;
          Break;
        end;
      end;
      ToNextRec;
    end;
  finally
    MemTable.InstantReadLeave;
    AGrid.DataSource.DataSet.EnableControls;
  end;

  if Result then
  begin
    RecViewFound := NextNode;
    RecView := RecViewFound;
    while RecView.Rec <> nil do
    begin
      RecView.NodeExpanded := True;
      RecView := RecView.NodeParent;
    end;
    MemTable.GotoRec(RecViewFound.Rec);
  end;
end;

{ TMTEDatasetFeaturesEh }

constructor TMTEDatasetFeaturesEh.Create;
begin
  inherited Create;
  SupportsLocalLike := True;
end;

procedure TMTEDatasetFeaturesEh.ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var
  DataDriver: TDataDriverEh;
  DS: TDataSet;
  DatasetFeatures: TDatasetFeaturesEh;
begin
  if TDBGridEh(Sender).STFilter.Local then
  begin
    ApplyGridLocalFilter(TDBGridEh(Sender), DataSet, IsReopen);
  end
  else if (DataSet is TCustomMemTableEh) then
  begin
    if not (DataSet is TCustomMemTableEh) then Exit;
    DataDriver := TCustomMemTableEh(DataSet).DataDriver;
    if DataDriver = nil then
      raise Exception.Create('MemTableEh.DataDriver is empty');
    DS := TDataDriverEhCrack(DataDriver).ProviderDataSet;
    if DS <> nil then
    begin
      DatasetFeatures := GetDatasetFeaturesForDataSet(DS);
      if DatasetFeatures <> nil then
        DatasetFeatures.ApplyFilter(Sender, DS, False);
      DataSet.Close;
      DataSet.Open;
    end else if (DataDriver is TCustomSQLDataDriverEh) then
    begin
      ApplyFilterForSQLDataDriver(TCustomDBGridEh(Sender),
        TCustomSQLDataDriverEh(DataDriver), DateValueToSQLString);
      DataSet.Close;
      DataSet.Open;
    end;
  end;
end;

procedure TMTEDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var
  DS: TDataSet;
  MTE: TCustomMemTableEh;
  DatasetFeatures: TDatasetFeaturesEh;
  i: Integer;
  OrderByStr: String;
  DataDriver: TDataDriverEh;
  SortOrder: TSortOrderEh;
  DBGridEh: TCustomDBGridEh;
  OrderValueProc: TGetOrderVarValueProcEh;
  SortDataArr: TExternalSortDataArrEh;
begin
  if Sender is TCustomDBGridEh then
  begin
    DBGridEh := TCustomDBGridEh(Sender);
    MTE := TCustomMemTableEh(DataSet);
    if DBGridEh.SortLocal then
    begin
      if DBGridEh.RequireExternalSorting then
      begin
        OrderValueProc := DBGridEh.GetSortValue;
        SetLength(SortDataArr, DBGridEh.SortMarkedColumns.Count);
        for i := 0 to DBGridEh.SortMarkedColumns.Count - 1 do
        begin
          SortDataArr[i].Desc := DBGridEh.Center.GetSortOrderForSortMarker(DBGridEh,
            DBGridEh.SortMarkedColumns[i], DBGridEh.SortMarkedColumns[i].Title.SortMarker) = soDescEh;
          if DBGridEh.SortMarkedColumns[i].LookupParams.LookupActive then
            SortDataArr[i].DataType :=
              DBGridEh.SortMarkedColumns[i].LookupParams.LookupDisplayField.DataType
          else if DBGridEh.SortMarkedColumns[i].Field <> nil  then
            SortDataArr[i].DataType := DBGridEh.SortMarkedColumns[i].Field.DataType
          else
            SortDataArr[i].DataType := ftUnknown;
        end;
        MTE.SortOrder := '';
        MTE.SortWithExternalProc(OrderValueProc, SortDataArr);
      end else
      begin
        OrderByStr := '';
        if DBGridEh.DataGrouping.Active then
        begin
          for i := 0 to DBGridEh.DataGrouping.ActiveGroupLevelsCount - 1 do
          begin
            OrderByStr := OrderByStr + WrapFieldName(TColumnEh(DBGridEh.DataGrouping.ActiveGroupLevels[i].Column).FieldName) + ' ';
            if DBGridEh.DataGrouping.ActiveGroupLevels[i].SortOrder = soDescEh then
              OrderByStr := OrderByStr + ' DESC';
            OrderByStr := OrderByStr + ',';
          end;
        end;
        for i := 0 to DBGridEh.SortMarkedColumns.Count - 1 do
        begin
          OrderByStr := OrderByStr + WrapFieldName(DBGridEh.SortMarkedColumns[i].FieldName) + ' ';
          SortOrder := DBGridEh.Center.GetSortOrderForSortMarker(TCustomDBGridEh(Sender),
            DBGridEh.SortMarkedColumns[i], DBGridEh.SortMarkedColumns[i].Title.SortMarker);
          if SortOrder = soDescEh then
            OrderByStr := OrderByStr + ' DESC';
          OrderByStr := OrderByStr + ',';
        end;
        Delete(OrderByStr, Length(OrderByStr), 1);
        if (DataSet is TCustomMemTableEh) then
        begin
          MTE := TCustomMemTableEh(DataSet);
          if SortInView
            then MTE.SortOrder := OrderByStr
            else MTE.SortByFields(OrderByStr);
        end;
      end;
    end else
    begin
      if not (DataSet is TCustomMemTableEh) then Exit;
      DataDriver := TCustomMemTableEh(DataSet).DataDriver;
      if DataDriver = nil then
        raise Exception.Create('MemTableEh.DataDriver is empty');
      DS := TDataDriverEhCrack(DataDriver).ProviderDataSet;
      if DS <> nil then
      begin
        DatasetFeatures := GetDatasetFeaturesForDataSet(DS);
        if DatasetFeatures <> nil then
          DatasetFeatures.ApplySorting(Sender, DS, False);
        DataSet.Close;
        DataSet.Open;
      end else if (DataDriver is TCustomSQLDataDriverEh) then
      begin
        ApplySortingForSQLDataDriver(TCustomDBGridEh(Sender),
          TCustomSQLDataDriverEh(DataDriver), SortUsingFieldName);
        DataSet.Close;
        DataSet.Open;
      end;
    end;
  end;
end;

function TMTEDatasetFeaturesEh.LocateText(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh; TimeOut: LongWord = 0;
  CheckValueEvent: TCheckColumnValueAcceptEventEh = nil): Boolean;
var
  mt: TCustomMemTableEh;
begin
  mt := nil;
  Result := False;
  if not ( (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil) and
            AGrid.DataSource.DataSet.Active )
  then
    Exit;
  if (AGrid.DataSource.DataSet is TCustomMemTableEh) then
    mt := (AGrid.DataSource.DataSet as TCustomMemTableEh);
  if (mt <> nil) and mt.TreeList.Active and (TreeFindRange <> lttInExpandedNodesEh)  then
  begin
    Result := LocateTextInTree(AGrid, FieldName, Text, AOptions,
      Direction, Matching, TreeFindRange, FBaseNode, CheckValueEvent);
  end else
    Result := inherited LocateText(AGrid, FieldName, Text, AOptions,
      Direction, Matching, TreeFindRange, TimeOut, CheckValueEvent);
end;

procedure TMTEDatasetFeaturesEh.ExecuteFindDialog(Sender: TObject;
  const Text, FieldName: String; Modal: Boolean);
var
  mt: TCustomMemTableEh;
  Grid: TCustomDBGridEh;
begin
  if Sender is TCustomDBGridEh then
    Grid := TCustomDBGridEh(Sender)
  else
    Exit;
  if not ( (Grid.DataSource <> nil) and (Grid.DataSource.DataSet <> nil) and
            Grid.DataSource.DataSet.Active )
  then
    Exit;
  FBaseNode := nil;
  if (Grid.DataSource.DataSet is TCustomMemTableEh) then
  begin
    mt := (Grid.DataSource.DataSet as TCustomMemTableEh);
    if mt.TreeList.Active then
      FBaseNode := mt.TreeNode;
  end;
  inherited ExecuteFindDialog(Sender, Text, FieldName, Modal);
end;

procedure TMTEDatasetFeaturesEh.FillSTFilterListCommandValues(
  AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
begin
  if Assigned(AGrid.Center) then
     AGrid.Center.StandardFillSTFilterListCommandValues(AGrid, Column, Items, False, True);
end;

procedure TMTEDatasetFeaturesEh.FillSTFilterListDataValues(
  AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
begin
  if Assigned(AGrid.Center) then
    AGrid.Center.StandardFillSTFilterListDataValues(AGrid, Column, Items);
end;

procedure TMTEDatasetFeaturesEh.FillFieldUniqueValues(Field: TField; Items: TStrings);
var
  mt: TCustomMemTableEh;
  mtfli: IMemTableDataFieldValueListEh;
begin
  if (Field <> nil) and
     (Field.DataSet <> nil) and
     Field.DataSet.Active and
     (Field.DataSet is TCustomMemTableEh)
     then
  begin
    mt := TCustomMemTableEh(Field.DataSet);
    mtfli := (mt as IMemTableEh).GetFieldValueList(Field.FieldName);
    Items.Clear;
    Items.AddStrings(mtfli.GetValues);
  end;
end;


function TMTEDatasetFeaturesEh.GetLikeWildcardForSeveralCharacters: String;
begin
  Result := '%';
end;

function TMTEDatasetFeaturesEh.IsInOperatorSupported(Grid: TCustomDBGridEh;
  DataSet: TDataSet; IsLocalFilter: Boolean): Boolean;
begin
  {$IFDEF FPC}
  Result := False;
  {$ELSE}
  Result := True;
  {$ENDIF} 
end;

initialization
  RegisterDatasetFeaturesEh(TMTEDatasetFeaturesEh, TCustomMemTableEh);
end.
