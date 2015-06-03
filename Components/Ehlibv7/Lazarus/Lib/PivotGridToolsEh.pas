{*******************************************************}
{                                                       }
{                        EhLib v7.0                     }
{                                                       }
{              Tool controls for PivotGridEh            }
{                      Build 7.0.002                    }
{                                                       }
{   Copyright (c) 2014-2014 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PivotGridToolsEh;

interface

uses
{$IFDEF EH_LIB_17} System.Generics.Collections, {$ENDIF}
  Windows, SysUtils, Messages, Classes, Controls, Forms, StdCtrls,
{$IFDEF EH_LIB_5} Contnrs, {$ENDIF}
{$IFDEF EH_LIB_6} Variants, Types, {$ENDIF}
{$IFDEF EH_LIB_7} Themes, UxTheme, {$ENDIF}
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  WinUtils,
{$ELSE}
  {$IFDEF FPC}
  EhLibLCL, DBGridsEh, LMessages, LCLType, Win32Extra,
  {$ELSE}
  EhLibVCL, DBGridEh,
  {$ENDIF}
{$ENDIF}
  PivotGridsEh,
  MemTableEh, MemTableDataEh, TypInfo,
  GridsEh, DBCtrlsEh, ToolCtrlsEh,
  DBUtilsEh, GridToolCtrlsEh,
  DBCtrls, Db, Menus, Registry, Graphics, IniFiles, ImgList, StdActns,
  ActnList, ExtCtrls, DynVarsEh, ToolWin, Comctrls, CommCtrl;

type
  TCustomPivotGridFieldsEh = class;
  TCustomPivotGridToolBoxEh = class;

  TPivotGridFieldsTypeEh = (sgftFieldsListEh, sgftColFieldsEh, sgftRowFieldsEh,
    sgftValueFieldsEh);

{ TCustomPivotGridFieldsEh }

  TCustomPivotGridFieldsEh = class(TCustomDBGridEh)
  private
    FListType: TPivotGridFieldsTypeEh;
    FDataTable: TMemTableEh;
    FDataSource: TDataSource;
    FDragPivotField: TPivotFieldEh;
    FDragPivotFieldName: String;
    FPivotFieldValueInfo: TPivotFieldValueInfoEh;
//    function GetPivotGrid: TCustomPivotGridEh;
    function GetPivotDataSourceEh: TPivotDataSourceEh;
  protected
    function DragDropHitTestInfo(X, Y: Integer; var LinePos: TPoint; var LineSize: Integer; var DropToPos: Integer): Boolean;
    function IsAutoFitColWidthsActiveMode: Boolean; override;

    procedure CellMouseDown(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;
    procedure CellMouseClick(const Cell: TGridCoord; Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect; const GridMousePos, CellMousePos: TPoint); override;

    procedure DoStartDrag(var DragObject: TDragObject); override;
    procedure DoEndDrag(Target: TObject; X, Y: Integer); override;
    procedure DragOver(Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean); override;
    procedure CreateWnd; override;
  public
//    FPivotGrid: TCustomPivotGridEh;
    FPivotDataSource: TPivotDataSourceEh;
    FToolBox: TCustomPivotGridToolBoxEh;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DragDrop(Source: TObject; X, Y: Integer); override;
    procedure PivotFieldGridDefinitionChanged;
    procedure GetColCellParamsEvent(Sender: TObject; EditMode: Boolean; Params: TColCellParamsEh);

    property ListType: TPivotGridFieldsTypeEh read FListType write FListType;
    property DataTable: TMemTableEh read FDataTable;
    property DataSource: TDataSource read FDataSource;
//    property PivotGrid: TCustomPivotGridEh read GetPivotGrid;
    property PivotDataSource: TPivotDataSourceEh read GetPivotDataSourceEh;

  end;

{ TCustomPivotGridToolBoxEh }

  TCustomPivotGridToolBoxEh = class(TCustomPanel, IPivotDataSourceNotificationEh)
  private
//    FValueFields: TStringList;
///    FColumnFields: TStringList;
//    FRowFields: TStringList;
//    FValueFieldsInfo: TValueFieldsCollectionEh;

    FFieldStructChanging: Boolean;
    FInternalPivotGridAssigning: Boolean;
    FPivotDataSource: TPivotDataSourceEh;

//    procedure SetPivotGrid(const Value: TCustomPivotGridEh);
///    procedure SetValueFieldsInfo(const Value: TValueFieldsCollectionEh);
    function GetColumnFields: TStringList;
    function GetRowFields: TStringList;
    function GetValueFieldsInfo: TValueFieldsCollectionEh;
    procedure SetPivotDataSource(const Value: TPivotDataSourceEh);
  protected
    FPivotGrid: TCustomPivotGridEh;

    FFieldListGrid: TCustomPivotGridFieldsEh;
    FRowsLabel: TLabel;
    FRowsListGrid: TCustomPivotGridFieldsEh;
    FColsLabel: TLabel;
    FColsListGrid: TCustomPivotGridFieldsEh;
    FValsLabel: TLabel;
    FValsListGrid: TCustomPivotGridFieldsEh;

    FFieldListPanel: TPanel;
    FPivotDataPanel: TPanel;
    FSplitter: TSplitter;

    procedure FieldStructChanged(Sender: TObject);
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PivotDataPanelResize(Sender: TObject);
    procedure PivotGridDefinitionChanged(Sender: TCustomPivotGridEh);
    procedure ValueFieldsInfoChangeEvent(Sender: TCollection; Item: TCollectionItem; Action: TCollectionNotification);

//    procedure PivotDataSourceChange(Sender: TObject);

    procedure PivotFieldsChanged(Sender: TObject);
    procedure PivotStructureChanged(Sender: TObject);
    procedure PivotDataChanged(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ApplyDefinitionToGrid;

//    property PivotGrid: TCustomPivotGridEh read FPivotGrid write SetPivotGrid;
    property PivotDataSource: TPivotDataSourceEh read FPivotDataSource write SetPivotDataSource;
    property ColumnFields: TStringList read GetColumnFields;
    property RowFields: TStringList read GetRowFields;
    property ValueFieldsInfo: TValueFieldsCollectionEh read GetValueFieldsInfo;// write SetValueFieldsInfo;
//    property ValueFields: TStringList read FValueFields;
  end;

{ TPivotGridToolBoxEh }

  TPivotGridToolBoxEh = class(TCustomPivotGridToolBoxEh)
  published
    property PivotDataSource;

    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;

    {$IFDEF FPC}
    {$ELSE}
    property BevelEdges;
    property BevelInner;
    property BevelKind;
    property BevelOuter;
    property BevelWidth;
    {$ENDIF}
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
    {$IFDEF FPC}
    {$ELSE}
    property Ctl3D;
    {$ENDIF}
    property UseDockManager default True;
    property DockSite;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    {$IFDEF FPC}
    {$ELSE}
    property Locked;
    {$ENDIF}
{$IFDEF EH_LIB_16}
    property Padding;
{$ENDIF}
    property ParentBiDiMode;
    {$IFDEF FPC}
    {$ELSE}
    property ParentBackground;
    property ParentCtl3D;
    {$ENDIF}
    property ParentColor;
{$IFDEF EH_LIB_16}
    property ParentDoubleBuffered;
{$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
{$IFDEF EH_LIB_16}
    property ShowCaption;
{$ENDIF}
    property ShowHint;
{$IFDEF EH_LIB_17}
    property StyleElements;
{$ENDIF}
    property TabOrder;
    property TabStop;
{$IFDEF EH_LIB_13}
    property Touch;
    property VerticalAlignment;
{$ENDIF}
    property Visible;

{$IFDEF EH_LIB_13}
    property OnAlignInsertBefore;
    property OnAlignPosition;
{$ENDIF}
    {$IFDEF FPC}
    {$ELSE}
    property OnCanResize;
    {$ENDIF}
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
{$IFDEF EH_LIB_13}
    property OnGesture;
    property OnMouseActivate;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
{$ENDIF}
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

implementation

uses DBAxisGridsEh, EditPivotFieldFormEh;

{ TCustomPivotGridFieldsEh }

constructor TCustomPivotGridFieldsEh.Create(AOwner: TComponent);
var
  Struct: TMTDataStructEh;
  bf: TMTDataFieldEh;
begin
  inherited Create(AOwner);
  FDataSource := TDataSource.Create(Self);
  inherited DataSource := FDataSource;
  FDataTable := TMemTableEh.Create(Self);
  Struct := FDataTable.RecordsView.MemTableData.DataStruct;

  bf := Struct.CreateField(TMTStringDataFieldEh);
  bf.FieldName := 'StringField';
  bf.Size := 255;

  bf := Struct.CreateField(TMTRefObjectFieldEh);
  bf.FieldName := 'RefObjectField';

  FDataTable.Open;
  FDataSource.DataSet := FDataTable;

  AutoFitColWidths := True;
  Flat := True;
  ReadOnly := True;
  Options := [dgRowSelect, dgAlwaysShowSelection];

  Columns.Add;
  Columns[0].FieldName := 'StringField';
  Columns[0].OnGetCellParams := GetColCellParamsEvent;
  VertScrollBar.SmoothStep := True;
end;

procedure TCustomPivotGridFieldsEh.CreateWnd;
begin
  inherited CreateWnd;
  UpdateAllDataRowHeights;
end;

destructor TCustomPivotGridFieldsEh.Destroy;
begin
  FDataTable.Close;
  FreeAndNil(FDataTable);
  FreeAndNil(FDataSource);
  inherited Destroy;
end;

procedure TCustomPivotGridFieldsEh.CellMouseDown(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseDown(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if Button = mbLeft then
  begin
    if ListType = sgftValueFieldsEh
      then FPivotFieldValueInfo := TPivotFieldValueInfoEh(TRefObjectField(FDataTable.Fields[1]).Value)
      else FDragPivotField := TPivotFieldEh(TRefObjectField(FDataTable.Fields[1]).Value);
    FDragPivotFieldName := FDataTable.Fields[0].AsString;
    BeginDrag(False);
  end;
end;

procedure TCustomPivotGridFieldsEh.CellMouseClick(const Cell: TGridCoord;
  Button: TMouseButton; Shift: TShiftState; const ACellRect: TRect;
  const GridMousePos, CellMousePos: TPoint);
begin
  inherited CellMouseClick(Cell, Button, Shift, ACellRect, GridMousePos, CellMousePos);
  if not DataTable.IsEmpty and (ssDouble in Shift) and (ListType = sgftValueFieldsEh) then
  begin
    EditPivotField(TPivotFieldValueInfoEh(TRefObjectField(FDataTable.Fields[1]).Value));
  end;
end;

procedure TCustomPivotGridFieldsEh.DoStartDrag(var DragObject: TDragObject);
begin
  inherited DoStartDrag(DragObject);
  DragObject := TPivotGridDrabObj.Create(Self);
  TPivotGridDrabObj(DragObject).FPivotField := FDragPivotField;
  TPivotGridDrabObj(DragObject).FPivotFieldValueInfo := FPivotFieldValueInfo;
  TPivotGridDrabObj(DragObject).FPivotFieldName := FDragPivotFieldName;
end;

procedure TCustomPivotGridFieldsEh.DragDrop(Source: TObject; X, Y: Integer);
var
  ADragCell: TPivotCellEh;
  GridDrabObj: TPivotGridDrabObj;
  SourceFieldsGrid: TCustomPivotGridFieldsEh;
  LineSize: Integer;
  DropToPos: Integer;
  SizeLinePos: TPoint;
  InRowsPos: Integer;
  InColsPos: Integer;
  PivotFieldName: String;
begin
  inherited DragDrop(Source, X, Y);

  if (Source is TPivotGridDrabObj)
    then GridDrabObj := TPivotGridDrabObj(Source)
    else Exit;
  if GridDrabObj.FDragCell <> nil then
  begin
    ADragCell := GridDrabObj.FDragCell;
    if ADragCell.CelType = sctFieldNameForRowEh then
    begin
      PivotDataSource.RowFields.Delete(FToolBox.RowFields.IndexOf(ADragCell.PivotField.FieldName));
    end else
    begin
      PivotDataSource.ColumnFields.Delete(FToolBox.ColumnFields.IndexOf(ADragCell.PivotField.FieldName));
    end;

    StartWait;
    PivotDataSource.BuildPivotData;
    StopWait;
  end else
  begin
    SourceFieldsGrid := (GridDrabObj.Control as TCustomPivotGridFieldsEh);
    if ListType = sgftFieldsListEh then
    begin
      if GridDrabObj.FPivotField <> nil
        then PivotFieldName := GridDrabObj.FPivotField.FieldName
        else PivotFieldName := GridDrabObj.FPivotFieldName;
      if SourceFieldsGrid.ListType = sgftColFieldsEh then
        FToolBox.ColumnFields.Delete(FToolBox.ColumnFields.IndexOf(PivotFieldName))
      else if SourceFieldsGrid.ListType = sgftRowFieldsEh then
        FToolBox.RowFields.Delete(FToolBox.RowFields.IndexOf(PivotFieldName))
      else if SourceFieldsGrid.ListType = sgftValueFieldsEh then
        if FToolBox.ValueFieldsInfo.Count > 0 then
        begin
          if GridDrabObj.FPivotFieldValueInfo <> nil then
            FToolBox.ValueFieldsInfo.Delete(FToolBox.ValueFieldsInfo.IndexOf(GridDrabObj.FPivotFieldValueInfo))
          else
            FToolBox.ValueFieldsInfo.Delete(FToolBox.ValueFieldsInfo.IndexByPivotFieldName(GridDrabObj.FPivotFieldName))
        end;
    end else if ListType = sgftColFieldsEh then
    begin
      if DragDropHitTestInfo(X, Y, SizeLinePos, LineSize, DropToPos) then
      begin
        if SourceFieldsGrid = Self then
        begin
          InColsPos := FToolBox.ColumnFields.IndexOfObject(GridDrabObj.FPivotField);
          if InColsPos < DropToPos then
            Dec(DropToPos);
          FToolBox.ColumnFields.Move(InColsPos, DropToPos);
          DataTable.RecNo := DropToPos + 1;
        end else
        begin
          InColsPos := FToolBox.ColumnFields.IndexOfObject(GridDrabObj.FPivotField);
          if InColsPos >= 0 then
            Exit;
          InRowsPos := FToolBox.RowFields.IndexOfObject(GridDrabObj.FPivotField);
          if InRowsPos >= 0 then
            FToolBox.RowFields.Delete(InRowsPos);
          FToolBox.ColumnFields.InsertObject(DropToPos, GridDrabObj.FPivotField.FieldName, GridDrabObj.FPivotField);
        end
      end
    end else if ListType = sgftRowFieldsEh then
    begin
      if DragDropHitTestInfo(X, Y, SizeLinePos, LineSize, DropToPos) then
      begin
        if SourceFieldsGrid = Self then
        begin
          InRowsPos := FToolBox.RowFields.IndexOfObject(GridDrabObj.FPivotField);
          if InRowsPos < DropToPos then
            Dec(DropToPos);
          FToolBox.RowFields.Move(InRowsPos, DropToPos);
        end else
        begin
          InRowsPos := FToolBox.RowFields.IndexOfObject(GridDrabObj.FPivotField);
          if InRowsPos >= 0 then
            Exit;
          InColsPos := FToolBox.ColumnFields.IndexOfObject(GridDrabObj.FPivotField);
          if InColsPos >= 0 then
            FToolBox.ColumnFields.Delete(InColsPos);
          FToolBox.RowFields.InsertObject(DropToPos, GridDrabObj.FPivotField.FieldName, GridDrabObj.FPivotField);
        end
      end
    end else if ListType = sgftValueFieldsEh then
    begin
      if DragDropHitTestInfo(X, Y, SizeLinePos, LineSize, DropToPos) then
      begin
        if SourceFieldsGrid = Self then
        begin
          InRowsPos := FToolBox.ValueFieldsInfo.IndexOf(GridDrabObj.FPivotFieldValueInfo);
          if InRowsPos < DropToPos then
            Dec(DropToPos);
          FToolBox.ValueFieldsInfo.Move(InRowsPos, DropToPos);
        end else
        begin
          FToolBox.ValueFieldsInfo.AddForPivotField(GridDrabObj.FPivotField, DropToPos);
        end
      end
    end;
  end;
end;

procedure TCustomPivotGridFieldsEh.DragOver(Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  ADragCell: TPivotCellEh;
  AxisStringList: TStringList;
  GridDrabObj: TPivotGridDrabObj;
  SizeLinePos: TPoint;
  LineSize: Integer;
  DropToPos: Integer;
begin
  inherited DragOver(Source, X, Y, State, Accept);
  if Source is TPivotGridDrabObj then
  begin
    GridDrabObj := TPivotGridDrabObj(Source);
    ADragCell := GridDrabObj.FDragCell;
    if ADragCell = nil then
    begin
      if ListType = sgftFieldsListEh then
      begin
        Accept := True;
      end else if ListType = sgftColFieldsEh then
      begin
        Accept := True;
        DragDropHitTestInfo(X, Y, SizeLinePos, LineSize, DropToPos);
        if DropToPos >= 0 then
          if GetMoveLineEh.Visible
            then GetMoveLineEh.MoveToFor(Self, SizeLinePos)
            else GetMoveLineEh.StartShow(Self, SizeLinePos, False, LineSize, Self);
      end else if ListType = sgftRowFieldsEh then
      begin
        Accept := True;
        DragDropHitTestInfo(X, Y, SizeLinePos, LineSize, DropToPos);
        if DropToPos >= 0 then
          if GetMoveLineEh.Visible
            then GetMoveLineEh.MoveToFor(Self, SizeLinePos)
            else GetMoveLineEh.StartShow(Self, SizeLinePos, False, LineSize, Self);
      end else if ListType = sgftValueFieldsEh then
      begin
        Accept := True;
        DragDropHitTestInfo(X, Y, SizeLinePos, LineSize, DropToPos);
        if DropToPos >= 0 then
          if GetMoveLineEh.Visible
            then GetMoveLineEh.MoveToFor(Self, SizeLinePos)
            else GetMoveLineEh.StartShow(Self, SizeLinePos, False, LineSize, Self);
      end;
    end else
    begin
      if ADragCell.CelType = sctFieldNameForRowEh
        then AxisStringList := FToolBox.ColumnFields
        else AxisStringList := FToolBox.RowFields;

      if (AxisStringList <> nil) and (AxisStringList.Count = 0)
        then Accept := False
        else Accept := True;
    end
  end;
  if State = dsDragLeave then
    GetMoveLineEh.Hide;
end;

procedure TCustomPivotGridFieldsEh.DoEndDrag(Target: TObject; X,
  Y: Integer);
begin
  inherited DoEndDrag(Target, X, Y);
  if Target is TPivotGridEh then
    TPivotGridEh(Target).FinishDragFrom(Self);
end;

function TCustomPivotGridFieldsEh.DragDropHitTestInfo(X, Y: Integer;
  var LinePos: TPoint; var LineSize, DropToPos: Integer): Boolean;
var
//  DrawInfo: TGridDrawInfoEh;
  ARect: TRect;
//  CellMousePos: TPoint;
  OverCell: TGridCoord;
begin
//  CalcDrawInfo(DrawInfo);
  OverCell := CalcCoordFromPoint(X, Y);
  Result := False;
  DropToPos := -1;
  if OverCell.X >= 0 then
  begin
    if (OverCell.Y = -1) and (Y > 0) then
      OverCell.Y := RowCount-1;

    ARect := CellRect(OverCell.X, OverCell.Y);
    LinePos.X := ARect.Left;
    if (Y > (ARect.Bottom + ARect.Top) div 2) and not DataTable.IsEmpty then
    begin
      LinePos.Y := ARect.Bottom;
      DropToPos := OverCell.Y + 1;
    end else
    begin
      LinePos.Y := ARect.Top;
      DropToPos := OverCell.Y;
    end;

    LineSize := ARect.Right - ARect.Left;
    Result := True;
  end;
end;

function TCustomPivotGridFieldsEh.GetPivotDataSourceEh: TPivotDataSourceEh;
begin
  Result := FPivotDataSource;
end;

function TCustomPivotGridFieldsEh.IsAutoFitColWidthsActiveMode: Boolean;
begin
  Result := AutoFitColWidths;
end;

procedure TCustomPivotGridFieldsEh.PivotFieldGridDefinitionChanged;
var
  i: Integer;
  sf: TPivotFieldEh;
  spi: TPivotFieldValueInfoEh;
begin
  FDataTable.DisableControls;
  try
  FDataTable.EmptyTable;

  if (PivotDataSource <> nil) and (PivotDataSource.PivotFields <> nil) then
  begin

    if ListType = sgftFieldsListEh then
    begin

      for i := 0 to PivotDataSource.PivotFields.Count-1 do
      begin
        sf := PivotDataSource.PivotFields[i];

        FDataTable.Append;
        FDataTable.Fields[0].AsString := sf.DisplayName;
        TRefObjectField(FDataTable.Fields[1]).Value := sf;

        FDataTable.Post;
      end;

    end else if ListType = sgftColFieldsEh then
    begin

      for i := 0 to FToolBox.ColumnFields.Count-1 do
      begin
        sf := TPivotFieldEh(FToolBox.ColumnFields.Objects[i]);

        FDataTable.Append;
        if sf <> nil then
        begin
          FDataTable.Fields[0].AsString := sf.DisplayName;
          TRefObjectField(FDataTable.Fields[1]).Value := sf;
        end else
          FDataTable.Fields[0].AsString := FToolBox.ColumnFields[i];

        FDataTable.Post;
      end;

    end else if ListType = sgftRowFieldsEh then
    begin

      for i := 0 to FToolBox.RowFields.Count-1 do
      begin
        sf := TPivotFieldEh(FToolBox.RowFields.Objects[i]);

        FDataTable.Append;
        if sf <> nil then
        begin
          FDataTable.Fields[0].AsString := sf.DisplayName;
          TRefObjectField(FDataTable.Fields[1]).Value := sf;
        end else
          FDataTable.Fields[0].AsString := FToolBox.RowFields[i];

        FDataTable.Post;
      end;

    end else if ListType = sgftValueFieldsEh then
    begin

      for i := 0 to FToolBox.ValueFieldsInfo.Count-1 do
      begin
        spi := FToolBox.ValueFieldsInfo[i];

        FDataTable.Append;
        if spi.PivotField = nil
          then FDataTable.Fields[0].AsString := spi.PivotFieldName
          else FDataTable.Fields[0].AsString := spi.PivotField.DisplayName;
        TRefObjectField(FDataTable.Fields[1]).Value := spi;

        FDataTable.Post;
      end;
    end;
  end;

  finally
    FDataTable.First;
    FDataTable.EnableControls;
  end;
end;

procedure TCustomPivotGridFieldsEh.GetColCellParamsEvent(Sender: TObject;
  EditMode: Boolean; Params: TColCellParamsEh);
var
  spi: TPivotFieldValueInfoEh;
begin
  if PivotDataSource = nil then Exit;

  if not DataTable.IsEmpty and (TRefObjectField(FDataTable.Fields[1]).Value = nil) then
    Params.Font.Color := clGrayText;
  if not DataTable.IsEmpty and (ListType = sgftValueFieldsEh) then
  begin
    spi := TPivotFieldValueInfoEh(TRefObjectField(FDataTable.Fields[1]).Value);
    Params.Text := Params.Text + ' (' + PivotAggrValueTypes[spi.SumFunction] + ')';
  end;
end;

{ TPivotGridToolBoxEh }

constructor TCustomPivotGridToolBoxEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  BevelOuter := bvNone;
  Width := 100;
  Height := 200;
{$IFDEF EH_LIB_16}
  ShowCaption := False;
{$ENDIF}

  FFieldListPanel := TPanel.Create(Self);
  FFieldListPanel.Parent := Self;
  FFieldListPanel.SetBounds(0,0,100,50);
  FFieldListPanel.Name := 'FFieldListPanel';
  FFieldListPanel.BevelOuter := bvNone;

  FSplitter := TSplitter.Create(Self);
  FSplitter.Parent := Self;
  FSplitter.Cursor := crVSplit;
  FSplitter.ResizeStyle := rsUpdate;
  FSplitter.SetBounds(0,10,10,8);

  FPivotDataPanel := TPanel.Create(Self);
  FPivotDataPanel.Parent := Self;
  FPivotDataPanel.SetBounds(0,18,100,200);
  FPivotDataPanel.Name := 'FPivotDataPanel';
  FPivotDataPanel.BevelOuter := bvNone;
  FPivotDataPanel.OnResize := PivotDataPanelResize;

  FPivotDataPanel.Align := alBottom;
  FSplitter.Align := alBottom;
  FFieldListPanel.Align := alClient;

  FFieldListGrid := TCustomPivotGridFieldsEh.Create(Self);
  FFieldListGrid.Parent := FFieldListPanel;
  FFieldListGrid.SetBounds(10, 10, FFieldListPanel.Width-20, FFieldListPanel.Height-20);
//  FFieldListGrid.FPivotGrid := PivotGrid;
  FFieldListGrid.Anchors := [akLeft, akTop, akRight, akBottom];
  FFieldListGrid.Border.Ctl3D := False;
  {$IFDEF FPC}
  {$ELSE}
  FFieldListGrid.Ctl3D := False;
  FFieldListGrid.ParentCtl3D := False;
  {$ENDIF}
  FFieldListGrid.FToolBox := Self;

  FRowsLabel := TLabel.Create(Self);
  FRowsLabel.Parent := FPivotDataPanel;
  FRowsLabel.SetBounds(10, 10, FPivotDataPanel.Width-20, 30);
  FRowsLabel.Caption := 'Rows';

  FRowsListGrid := TCustomPivotGridFieldsEh.Create(Self);
  FRowsListGrid.Parent := FPivotDataPanel;
  FRowsListGrid.SetBounds(10, 25, FPivotDataPanel.Width-20, 30);
  FRowsListGrid.Anchors := [akLeft, akTop, akRight];
  FRowsListGrid.ListType := sgftRowFieldsEh;
  FRowsListGrid.Border.Ctl3D := False;
  {$IFDEF FPC}
  {$ELSE}
  FRowsListGrid.Ctl3D := False;
  FRowsListGrid.ParentCtl3D := False;
  {$ENDIF}
  FRowsListGrid.FToolBox := Self;

  FColsLabel := TLabel.Create(Self);
  FColsLabel.Parent := FPivotDataPanel;
  FColsLabel.SetBounds(10, FRowsListGrid.Top+FRowsListGrid.Height+10,
                       FPivotDataPanel.Width-20, 30);
  FColsLabel.Caption := 'Columns';

  FColsListGrid := TCustomPivotGridFieldsEh.Create(Self);
  FColsListGrid.Parent := FPivotDataPanel;
  FColsListGrid.SetBounds(10, FColsLabel.Top+15, FPivotDataPanel.Width-20, 30);
  FColsListGrid.Anchors := [akLeft, akTop, akRight];
  FColsListGrid.ListType := sgftColFieldsEh;
  FColsListGrid.Border.Ctl3D := False;
  {$IFDEF FPC}
  {$ELSE}
  FColsListGrid.Ctl3D := False;
  FColsListGrid.ParentCtl3D := False;
  {$ENDIF}
  FColsListGrid.FToolBox := Self;

  FValsLabel := TLabel.Create(Self);
  FValsLabel.Parent := FPivotDataPanel;
  FValsLabel.SetBounds(10, FColsListGrid.Top+FColsListGrid.Height+10,
                       FPivotDataPanel.Width-20, 30);
  FValsLabel.Caption := 'Values';

  FValsListGrid := TCustomPivotGridFieldsEh.Create(Self);
  FValsListGrid.Parent := FPivotDataPanel;
  FValsListGrid.SetBounds(10, FValsLabel.Top+15, FPivotDataPanel.Width-20, 30);
//  FValsListGrid.FPivotGrid := PivotGrid;
  FValsListGrid.Anchors := [akLeft, akTop, akRight];
  FValsListGrid.ListType := sgftValueFieldsEh;
  FValsListGrid.Border.Ctl3D := False;
  {$IFDEF FPC}
  {$ELSE}
  FValsListGrid.Ctl3D := False;
  FValsListGrid.ParentCtl3D := False;
  {$ENDIF}
  FValsListGrid.FToolBox := Self;

end;

destructor TCustomPivotGridToolBoxEh.Destroy;
begin
  PivotDataSource := nil;
  inherited Destroy;
end;

procedure TCustomPivotGridToolBoxEh.SetPivotDataSource(
  const Value: TPivotDataSourceEh);
begin
  if FPivotDataSource <> Value then
  begin
    if FPivotDataSource <> nil then
      FPivotDataSource.UnRegisterChanges(Self);
    FPivotDataSource := Value;
    if FPivotDataSource <> nil then
    begin
      FPivotDataSource.RegisterChanges(Self);
      FreeNotification(FPivotDataSource);
    end;
    PivotGridDefinitionChanged(nil);
  end;
end;

procedure TCustomPivotGridToolBoxEh.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) then
  begin
    if AComponent = FPivotGrid then
      PivotDataSource := nil;
  end;
end;

procedure TCustomPivotGridToolBoxEh.ApplyDefinitionToGrid;
begin
  FInternalPivotGridAssigning := True;
  try
{    PivotGrid.RowFields.Assign(RowFields);
    PivotGrid.ColumnFields.Assign(ColumnFields);
//    PivotGrid.ValueFields.Assign(ValueFields);
    PivotGrid.ValueFieldDefs.Assign(ValueFieldsInfo);
}

  finally
    FInternalPivotGridAssigning := False;
  end;
end;

procedure TCustomPivotGridToolBoxEh.FieldStructChanged(Sender: TObject);
begin
  if FFieldStructChanging then Exit;

  FRowsListGrid.PivotFieldGridDefinitionChanged;
  FColsListGrid.PivotFieldGridDefinitionChanged;
  FValsListGrid.PivotFieldGridDefinitionChanged;
end;

function TCustomPivotGridToolBoxEh.GetColumnFields: TStringList;
begin
  if Assigned(PivotDataSource)
    then Result := PivotDataSource.ColumnFields
    else Result := nil;
end;

function TCustomPivotGridToolBoxEh.GetRowFields: TStringList;
begin
  if Assigned(PivotDataSource)
    then Result := PivotDataSource.RowFields
    else Result := nil;
end;

function TCustomPivotGridToolBoxEh.GetValueFieldsInfo: TValueFieldsCollectionEh;
begin
  if Assigned(PivotDataSource)
    then Result := PivotDataSource.ValueFieldDefs
    else Result := nil;
end;

procedure TCustomPivotGridToolBoxEh.ValueFieldsInfoChangeEvent(Sender: TCollection;
  Item: TCollectionItem; Action: TCollectionNotification);
begin
  FieldStructChanged(Sender);
end;

procedure TCustomPivotGridToolBoxEh.PivotFieldsChanged(Sender: TObject);
begin
  PivotGridDefinitionChanged(nil);
end;

procedure TCustomPivotGridToolBoxEh.PivotStructureChanged(Sender: TObject);
begin
  PivotGridDefinitionChanged(nil);
end;

procedure TCustomPivotGridToolBoxEh.PivotDataChanged(Sender: TObject);
begin
// Nothing to do
end;

procedure TCustomPivotGridToolBoxEh.PivotGridDefinitionChanged(
  Sender: TCustomPivotGridEh);
begin
  if FInternalPivotGridAssigning then Exit;

  FFieldListGrid.FPivotDataSource := PivotDataSource;
  FFieldListGrid.PivotFieldGridDefinitionChanged;

  FFieldStructChanging := True;

  try
    FRowsListGrid.FPivotDataSource := PivotDataSource;
    FRowsListGrid.PivotFieldGridDefinitionChanged;

    FColsListGrid.FPivotDataSource := PivotDataSource;
    FColsListGrid.PivotFieldGridDefinitionChanged;

    FValsListGrid.FPivotDataSource := PivotDataSource;
    FValsListGrid.PivotFieldGridDefinitionChanged;

  finally
    FFieldStructChanging := False;
  end;
end;

procedure TCustomPivotGridToolBoxEh.PivotDataPanelResize(Sender: TObject);
var
  LabelsAreaSize: Integer;
  ForGridsSize: Integer;
  Delta: Integer;
  Add2, Add3: Integer;
  OneGridHeight: Integer;
begin
  if not HandleAllocated then Exit;

  LabelsAreaSize := 5 + FRowsLabel.Height + 3 +
                    5 + FColsLabel.Height + 3 +
                    5 + FValsLabel.Height + 3 +
                    5;

  ForGridsSize := FPivotDataPanel.ClientHeight - LabelsAreaSize;
  if ForGridsSize < 9 then
    ForGridsSize := 9;
  Delta := ForGridsSize mod 3;
  OneGridHeight := ForGridsSize div 3;

  if Delta > 0
    then Add2 := 1
    else Add2 := 0;

  if Delta > 1
    then Add3 := 1
    else Add3 := 0;

  FRowsLabel.SetBounds(10, 5, FPivotDataPanel.Width-20, FRowsLabel.Height);
  FRowsListGrid.SetBounds(10, FRowsLabel.Top + FRowsLabel.Height + 3,
                          FPivotDataPanel.Width-20, OneGridHeight);

  FColsLabel.SetBounds(10, FRowsListGrid.Top + FRowsListGrid.Height + 5,
                       FPivotDataPanel.Width-20, FColsLabel.Height);
  FColsListGrid.SetBounds(10, FColsLabel.Top + FColsLabel.Height + 3,
                          FPivotDataPanel.Width-20, OneGridHeight+Add2);

  FValsLabel.SetBounds(10, FColsListGrid.Top+FColsListGrid.Height + 5,
                       FPivotDataPanel.Width-20, FValsLabel.Height);
  FValsListGrid.SetBounds(10, FValsLabel.Top + FValsLabel.Height + 3,
                          FPivotDataPanel.Width-20, OneGridHeight+Add3);
end;

end.
