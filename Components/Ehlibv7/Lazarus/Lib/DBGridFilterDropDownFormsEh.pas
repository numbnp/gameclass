{*******************************************************}
{                                                       }
{                       EhLib 7.0                       }
{           FilterDropDownFormsEh component             }
{                    (Build 7.0.01)                     }
{                                                       }
{     Copyright (c) 2014-2014 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridFilterDropDownFormsEh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF EH_LIB_7} Themes, UxTheme, Types, {$ENDIF}
  {$IFDEF FPC}
  EhLibLCL, DBGridsEh, LMessages, LCLType, Win32Extra,
  {$ELSE}
  EhLibVCL, DBGridEh,
  {$ENDIF}
  DropDownFormEh, Dialogs, DynVarsEh, ToolCtrlsEh, DBCtrlsEh, GridsEh,
  StdCtrls, ExtCtrls,
  DBGridEhGrouping,
  StrUtils, Buttons, FilterDropDownFormsEh;

type
  TDDFormFilterPopupListboxItemEh = class;

{ TDBGridMenuButtonEh }

  TDBGridMenuButtonEh = class(TMenuButtonEh)
    procedure Paint(const DrawItemStruct: TDrawItemStruct); override;
    procedure DrawSortMarket(ARect: TRect); virtual;
  public
    FSortState: TSortMarkerEh;
  end;

  TDBGridFilterDropDownForm = class(TFilterDropDownForm)
    procedure CustomDropDownFormEhCreate(Sender: TObject);
  private
    FColumn: TColumnEh;

    FSortButton1: TDBGridMenuButtonEh;
    FSortButton2: TDBGridMenuButtonEh;
    FLineMenuButton1: TDBGridMenuButtonEh;

    FClearFilterButton: TDBGridMenuButtonEh;
    FClearColumnFilterButton: TDBGridMenuButtonEh;
    FCustomFilterButton: TDBGridMenuButtonEh;
    FLineMenuButton2: TDBGridMenuButtonEh;
    FLineMenuButton3: TDBGridMenuButtonEh;
    FLineMenuButton4: TDBGridMenuButtonEh;

    procedure MenuButtonClick(Sender: TObject); virtual;

  public
    procedure RealignControls; override;

    property Column: TColumnEh read FColumn write FColumn;

    property SortButton1: TDBGridMenuButtonEh read FSortButton1;
    property SortButton2: TDBGridMenuButtonEh read FSortButton2;
    property LineMenuButton1: TDBGridMenuButtonEh read FLineMenuButton1;

    property ClearFilterButton: TDBGridMenuButtonEh read FClearFilterButton;
    property CustomFilterButton: TDBGridMenuButtonEh read FCustomFilterButton;
    property LineMenuButton2: TDBGridMenuButtonEh read FLineMenuButton2;
    property LineMenuButton3: TDBGridMenuButtonEh read FLineMenuButton3;
    property LineMenuButton4: TDBGridMenuButtonEh read FLineMenuButton4;
  end;

{ TDDFormFilterPopupListboxItemEh }

  TDDFormFilterPopupListboxItemEh = class(TCustomListboxItemEh)
  protected
    function GetColumn(Listbox: TCustomListboxEh): TColumnEh;
    function GetGroupLevel(Listbox: TCustomListboxEh): TGridDataGroupLevelEh;
    function FilterForm(Listbox: TCustomListboxEh): TFilterDropDownForm;
  end;

{ TDDFormListboxItemEhSort }

  TDDFormListboxItemEhSort = class(TDDFormFilterPopupListboxItemEh)
  protected
    FSortState: TSortMarkerEh;
  public
    constructor Create(ASortState: TSortMarkerEh);
    function IsDataItem: Boolean; override;
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

{ TDDFormListboxItemEhSpec }

  TPopupListboxItemEhSpecType = (ptFilterSpecItemClearFilter,
    ptFilterSpecItemClearColumnFilter, ptFilterSpecItemDialog, ptFilterApply);

  TDDFormListboxItemEhSpec = class(TDDFormFilterPopupListboxItemEh)
  protected
    FType: TPopupListboxItemEhSpecType;
  public
    constructor Create(AType: TPopupListboxItemEhSpecType);
    function IsDataItem: Boolean; override;
    procedure Execute(Sender: TCustomListboxEh; ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState); override;
  end;

var
  DBGridFilterDropDownForm: TDBGridFilterDropDownForm;

  ListboxItemEhSortAsc: TDDFormListboxItemEhSort;
  ListboxItemEhSortDes: TDDFormListboxItemEhSort;

  ListboxItemEhClearFilter: TDDFormListboxItemEhSpec;
  ListboxItemEhClearColumnFilter: TDDFormListboxItemEhSpec;
  ListboxItemEhDialog: TDDFormListboxItemEhSpec;
  ListboxItemEhApplyFilter: TDDFormListboxItemEhSpec;

  DBGridFilterDropDownFormProc: function : TDBGridFilterDropDownForm = nil;

function GetDefaultDBGridFilterDropDownForm: TDBGridFilterDropDownForm;

implementation

uses Menus, DBGridEhToolCtrls, DBGridEhSimpleFilterDlg, EhLibConsts;

{$R *.dfm}

function GetDefaultDBGridFilterDropDownForm: TDBGridFilterDropDownForm;
begin
  if DBGridFilterDropDownForm = nil then
    DBGridFilterDropDownForm := TDBGridFilterDropDownForm.Create(Application);
  Result := DBGridFilterDropDownForm;
end;

type
//  TCustomListboxEhCrack = class(TCustomListboxEh);
  TCustomDBGridEhCrack = class(TCustomDBGridEh);
  TSTColumnFilterEhCrack = class(TSTColumnFilterEh);

{ TDBGridFilterDropDownForm }

procedure TDBGridFilterDropDownForm.CustomDropDownFormEhCreate(Sender: TObject);
begin
  inherited CustomDropDownFormEhCreate(Sender);

  FSortButton1 := TDBGridMenuButtonEh.Create(Self);
  FSortButton1.Parent := Self;
  FSortButton1.Caption := SSTFilterListItem_SortingByAscend;
//  FSortButton1.Style := ebsGlyphEh;
//  FSortButton1.Flat := True;
  FSortButton1.ActionItem := ListboxItemEhSortAsc;
  FSortButton1.OnClick := MenuButtonClick;
  FSortButton1.Height := FMenuItemHeight;
  FSortButton1.FCaptionMargin := FLeftMargin;
  FSortButton1.FSortState := smUpEh;
  FSortButton1.FDropDownForm := Self;

  FSortButton2 := TDBGridMenuButtonEh.Create(Self);
  FSortButton2.Parent := Self;
  FSortButton2.Caption := SSTFilterListItem_SortingByDescend;
//  FSortButton2.Style := ebsGlyphEh;
//  FSortButton2.Flat := True;
  FSortButton2.ActionItem := ListboxItemEhSortDes;
  FSortButton2.OnClick := MenuButtonClick;
  FSortButton2.Height := FMenuItemHeight;
  FSortButton2.FCaptionMargin := FLeftMargin;
  FSortButton2.FSortState := smDownEh;
  FSortButton2.FDropDownForm := Self;

  FLineMenuButton1 := TDBGridMenuButtonEh.Create(Self);
  FLineMenuButton1.Parent := Self;
  FLineMenuButton1.Caption := cLineCaption;
//  FLineMenuButton1.Style := ebsGlyphEh;
  FLineMenuButton1.Enabled := False;
  FLineMenuButton1.Height := 5;
  FLineMenuButton1.FCaptionMargin := FLeftMargin;
  FLineMenuButton1.FDropDownForm := Self;

  FClearFilterButton := TDBGridMenuButtonEh.Create(Self);
  FClearFilterButton.Parent := Self;
  FClearFilterButton.Caption := SSTFilterListItem_ClearFilter;
  FClearFilterButton.ActionItem := ListboxItemEhClearFilter;
  FClearFilterButton.OnClick := MenuButtonClick;
  FClearFilterButton.Height := FMenuItemHeight;
  FClearFilterButton.FCaptionMargin := FLeftMargin;
  FClearFilterButton.FDropDownForm := Self;

  FClearColumnFilterButton := TDBGridMenuButtonEh.Create(Self);
  FClearColumnFilterButton.Parent := Self;
  FClearColumnFilterButton.Caption := SSTFilterListItem_ClearFilterInColumn;
  FClearColumnFilterButton.ActionItem := ListboxItemEhClearColumnFilter;
  FClearColumnFilterButton.OnClick := MenuButtonClick;
  FClearColumnFilterButton.Height := FMenuItemHeight;
  FClearColumnFilterButton.FCaptionMargin := FLeftMargin;
  FClearColumnFilterButton.FDropDownForm := Self;

  FCustomFilterButton := TDBGridMenuButtonEh.Create(Self);
  FCustomFilterButton.Parent := Self;
  FCustomFilterButton.Caption := SSTFilterListItem_CustomFilter;
//  FCustomFilterButton.Style := ebsGlyphEh;
//  FCustomFilterButton.Flat := True;
  FCustomFilterButton.ActionItem := ListboxItemEhDialog;
  FCustomFilterButton.OnClick := MenuButtonClick;
  FCustomFilterButton.Height := FMenuItemHeight;
  FCustomFilterButton.FCaptionMargin := FLeftMargin;
  FCustomFilterButton.FDropDownForm := Self;

  FLineMenuButton2 := TDBGridMenuButtonEh.Create(Self);
  FLineMenuButton2.Parent := Self;
  FLineMenuButton2.Caption := cLineCaption;
//  FLineMenuButton2.Style := ebsGlyphEh;
  FLineMenuButton2.Enabled := False;
  FLineMenuButton2.Height := 5;
  FLineMenuButton2.FCaptionMargin := FLeftMargin;
  FLineMenuButton2.FDropDownForm := Self;

  FLineMenuButton2.Align := alTop;
  FCustomFilterButton.Align := alTop;
  FClearColumnFilterButton.Align := alTop;
  FClearFilterButton.Align := alTop;
  FLineMenuButton1.Align := alTop;
  FSortButton2.Align := alTop;
  FSortButton1.Align := alTop;

end;

procedure TDBGridFilterDropDownForm.RealignControls;
var
  FLTop: Integer;
begin
  inherited RealignControls;

  FSortButton1.Top := 0;
  FSortButton2.Top := FSortButton1.Top + FSortButton1.Height;
  FLineMenuButton1.Top := FSortButton2.Top + FSortButton2.Height;
  FClearFilterButton.Top := FLineMenuButton1.Top + FLineMenuButton1.Height;
  FClearColumnFilterButton.Top := FClearFilterButton.Top + FClearFilterButton.Height;
  FCustomFilterButton.Top := FClearColumnFilterButton.Top + FClearColumnFilterButton.Height;
  FLineMenuButton2.Top := FCustomFilterButton.Top + FCustomFilterButton.Height;

  if UseRightToLeftAlignment then
  begin
    SearchEdit.SetBounds(
      5, FLineMenuButton2.Top + FLineMenuButton2.Height + 5,
      ClientWidth - FLeftMargin - 5, SearchEdit.Height);

    FLTop := SearchEdit.Top + SearchEdit.Height + 5;
    FilterList.SetBounds(
      5, FLTop,
      ClientWidth - FLeftMargin - SearchEdit.Left, Panel1.Top - FLTop);
  end else
  begin
    SearchEdit.SetBounds(
      FLeftMargin, FLineMenuButton2.Top + FLineMenuButton2.Height + 5,
      ClientWidth - 5 - SearchEdit.Left, SearchEdit.Height);

    FLTop := SearchEdit.Top + SearchEdit.Height + 5;
    FilterList.SetBounds(
      FLeftMargin, FLTop,
      ClientWidth - 5 - SearchEdit.Left, Panel1.Top - FLTop);
  end;
end;

procedure TDBGridFilterDropDownForm.MenuButtonClick(Sender: TObject);
var
  MenuButton: TMenuButtonEh;
begin
  MenuButton := TMenuButtonEh(Sender);
  if MenuButton.ActionItem <> nil then
  begin
    MenuButton.ActionItem.Execute(FilterList, -1, Point(0,0), []);
    ModalResult := mrCancel;
    Close;
  end;
end;

{ TDDFormFilterPopupListboxItemEh }

function TDDFormFilterPopupListboxItemEh.FilterForm(Listbox: TCustomListboxEh): TFilterDropDownForm;
begin
  Result := TFilterDropDownForm(Listbox.Owner);
end;

function TDDFormFilterPopupListboxItemEh.GetColumn(Listbox: TCustomListboxEh): TColumnEh;
begin
  Result := TDBGridFilterDropDownForm(Listbox.Owner).Column;
end;

function TDDFormFilterPopupListboxItemEh.GetGroupLevel(
  Listbox: TCustomListboxEh): TGridDataGroupLevelEh;
begin
  Result := nil;
end;

{ TDDFormListboxItemEhSort }

constructor TDDFormListboxItemEhSort.Create(ASortState: TSortMarkerEh);
begin
  inherited Create;
  FSortState := ASortState;
end;

procedure TDDFormListboxItemEhSort.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
begin
  if GetGroupLevel(Sender) <> nil then
  begin
    if FSortState = smDownEh then
      GetGroupLevel(Sender).SortOrder := soAscEh
    else if FSortState = smUpEh then
      GetGroupLevel(Sender).SortOrder := soDescEh;
  end else
  begin
    GetColumn(Sender).Title.SortMarker := FSortState;
    TCustomDBGridEhCrack(GetColumn(Sender).Grid).DoSortMarkingChanged;
  end;
end;

function TDDFormListboxItemEhSort.IsDataItem: Boolean;
begin
  Result := False;
end;

{ TDDFormListboxItemEhSpec }

constructor TDDFormListboxItemEhSpec.Create(AType: TPopupListboxItemEhSpecType);
begin
  inherited Create;
  FType := AType;
end;

procedure TDDFormListboxItemEhSpec.Execute(Sender: TCustomListboxEh;
  ItemIndex: Integer; InItemPos: TPoint; Shift: TShiftState);
var
  Grid: TCustomDBGridEhCrack;
  ColumnFilter: TSTColumnFilterEhCrack;
begin
  Grid := TCustomDBGridEhCrack(GetColumn(Sender).Grid);
  case FType of
    ptFilterSpecItemClearFilter:
      begin
        Grid.ClearFilter;
        Grid.SetDataFilter;
      end;
    ptFilterSpecItemClearColumnFilter:
      begin
        GetColumn(Sender).STFilter.ExpressionStr := '';
        Grid.SetDataFilter;
      end;
    ptFilterSpecItemDialog:
      begin
        if StartDBGridEhColumnFilterDialog(GetColumn(Sender)) then
        begin
          if GetColumn(Sender).Grid.STFilter.InstantApply then
            Grid.SetDataFilter;
        end;
        Exit;
      end;
    ptFilterApply:
      begin
        ColumnFilter := TSTColumnFilterEhCrack(GetColumn(Sender).STFilter);
        ColumnFilter.UpdateFilterFromValuesCheckingState(
          FilterForm(Sender).BaseList, FilterForm(Sender).ListValuesCheckingState);
        Grid.SetDataFilter;
      end;
  end;
end;

function TDDFormListboxItemEhSpec.IsDataItem: Boolean;
begin
  Result := False;
end;

{ TDBGridMenuButtonEh }

procedure TDBGridMenuButtonEh.DrawSortMarket(ARect: TRect);
var
  SortMarkerIdx: Integer;
  Grid: TCustomDBGridEh;
  smSize: TSize;
  SMRect: TRect;
//  SMFillRect: TRect;
begin
  case FSortState of
    smDownEh: SortMarkerIdx := 0;
    smUpEh: SortMarkerIdx := 1;
  else SortMarkerIdx := -1;
  end;
  if (SortMarkerIdx >= 0) {and (ColorToRGB(Sender.Color) = ColorToRGB(clWindow))} then
    SortMarkerIdx := SortMarkerIdx + 3;
  if SortMarkerIdx <> -1 then
  begin
    Grid := TDBGridFilterDropDownForm(FDropDownForm).FColumn.Grid;
    smSize := Grid.Style.GetSortMarkerSize(FCanvas, Grid.TitleParams.SortMarkerStyle);
//    SMFillRect := ARect;
//    SMFillRect.Right := SMFillRect.Left + DefaultCheckBoxWidth + 2;
    SMRect := Rect((ARect.Left + ARect.Right - smSize.cx) div 2,
                   (ARect.Bottom + ARect.Top - smSize.cy) div 2,
                   0, 0);
    SMRect.Right := SMRect.Left + smSize.cx - 1;
    SMRect.Bottom := SMRect.Top + smSize.cy - 1;
//    Canvas.Brush.Color := Color;
//    Canvas.FillRect(SMFillRect);
    Grid.Style.DrawSortMarker(FCanvas, Grid.TitleParams.SortMarkerStyle,
      TDBGridFilterDropDownForm(FDropDownForm).FColumn, FSortState, False, SMRect);
  end;
end;

procedure TDBGridMenuButtonEh.Paint(const DrawItemStruct: TDrawItemStruct);
begin
  inherited Paint(DrawItemStruct);
  if FSortState <> smNoneEh then
    if Parent.UseRightToLeftAlignment
      then DrawSortMarket(Rect(Width-Height, 0, Width, Height))
      else DrawSortMarket(Rect(0, 0, Height, Height));
end;

initialization
  ListboxItemEhSortAsc := TDDFormListboxItemEhSort.Create(smUpEh);
  ListboxItemEhSortDes := TDDFormListboxItemEhSort.Create(smDownEh);

  ListboxItemEhClearFilter := TDDFormListboxItemEhSpec.Create(ptFilterSpecItemClearFilter);
  ListboxItemEhClearColumnFilter := TDDFormListboxItemEhSpec.Create(ptFilterSpecItemClearColumnFilter);
  ListboxItemEhDialog := TDDFormListboxItemEhSpec.Create(ptFilterSpecItemDialog);
//???  ListboxItemEhApplyFilter := TDDFormListboxItemEhSpec.Create(ptFilterApply);

  DBGridFilterDropDownFormProc := @GetDefaultDBGridFilterDropDownForm;
finalization
  FreeAndNil(ListboxItemEhSortAsc);
  FreeAndNil(ListboxItemEhSortDes);
  FreeAndNil(ListboxItemEhClearFilter);
  FreeAndNil(ListboxItemEhClearColumnFilter);
  FreeAndNil(ListboxItemEhDialog);
//???  FreeAndNil(ListboxItemEhApplyFilter);
end.
