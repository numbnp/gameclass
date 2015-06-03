//////////////////////////////////////////////////////////////////////////////
//
// Компонент TY2KCheckedPanel.
// Панель с заголовком и переключателем доступности элементов
// (enable / disable всем компонентам на панели).
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KCheckedPanel;

interface

uses
  // system units
  SysUtils,
  Classes,
  Controls,
  StdCtrls,
  ExtCtrls,
  Types;

type

  //
  // TY2KCheckedPanel
  //

  TY2KCheckedPanel = class(TPanel)
  private
    // fields
    FbInverseCheck         : boolean;
    FcbxEnableControls     : TCheckBox;
    FOnEnableControlsClick : TNotifyEvent;

    // events handlers
    procedure _EnableControlsClick(Sender: TObject);

    // private helper methods
    procedure _EnableChildrens(const AbEnable: boolean);
    procedure _EnableControls();

  protected
    // properties methods
    // InverseCheck
    procedure SetInverseCheck(const AbValue: boolean);

  public
    // construcor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // overrided methods
    procedure Paint(); override;
    procedure Loaded(); override;

  published
    // properties
    // CheckBox - переключатель доступности компонентов на панели
    property EnableControls: TCheckBox read FcbxEnableControls;

    // если InverseCheck = TRUE, то контролы включаются
    // при выключеном флажке EnableControls
    property InverseCheck: boolean read FbInverseCheck
        write SetInverseCheck; // stored True default True;

    // обработчик события клика на переключателе панели
    property OnEnableControlsClick: TNotifyEvent read FOnEnableControlsClick
        write FOnEnableControlsClick;

  end; // TY2KCheckedPanel



implementation

uses
  // system units
  Graphics,
  Windows,
  Themes;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KCheckedPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if not (csDesigning in ComponentState) then
    Parent := (AOwner as TWinControl);

  BevelInner := bvRaised;
  BevelOuter := bvLowered;

  FcbxEnableControls := TCheckBox.Create(Self);
  with FcbxEnableControls do begin
    Parent := Self;
    SetSubComponent(TRUE);
    Left   := 9;
    Height := 17;
    Width  := 30;
    ParentColor := FALSE;
    OnClick := _EnableControlsClick;
    Show();
  end;

end; // TY2KCheckedPanel.Create

destructor TY2KCheckedPanel.Destroy();
begin
  inherited Destroy();
end; // TY2KCheckedPanel.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// override methods

procedure TY2KCheckedPanel.Loaded();
begin
  inherited Loaded();
//  _EnableControls();
end; // TY2KCheckedPanel.Loaded

// см. исходники VCL для TPanel.Paint
// разница очень небольшая
procedure TY2KCheckedPanel.Paint();
const
  Alignments: array[TAlignment] of Longint = (DT_LEFT, DT_RIGHT, DT_CENTER);
var
  Rect: TRect;
  TopColor, BottomColor: TColor;
  FontHeight: Integer;
  Flags: Longint;

  procedure AdjustColors(Bevel: TPanelBevel);
  begin
    TopColor := clBtnHighlight;
    if Bevel = bvLowered then
      TopColor := clBtnShadow;
    BottomColor := clBtnShadow;
    if Bevel = bvLowered then
      BottomColor := clBtnHighlight;
  end;

begin
  Rect := GetClientRect;
  Rect.Top := Rect.Top + 7;

  if BevelOuter <> bvNone then begin
    AdjustColors(BevelOuter);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  Frame3D(Canvas, Rect, Color, Color, BorderWidth);
  if BevelInner <> bvNone then begin
    AdjustColors(BevelInner);
    Frame3D(Canvas, Rect, TopColor, BottomColor, BevelWidth);
  end;
  with Canvas do begin
    if not ThemeServices.ThemesEnabled or not ParentBackground then begin
      Brush.Color := Color;
      FillRect(Rect);
    end;
    Brush.Style := bsClear;
    Font := Self.Font;
    FontHeight := TextHeight('W');
    with Rect do begin
      Top := ((Bottom + Top) - FontHeight) div 2;
      Bottom := Top + FontHeight;
    end;
    Flags := DT_EXPANDTABS or DT_VCENTER or Alignments[Alignment];
    Flags := DrawTextBiDiModeFlags(Flags);
    DrawText(Handle, PChar(Caption), -1, Rect, Flags);
  end;

//  if not (csDesigning in ComponentState) then
//    _EnableChildrens(FcbxEnableControls.State = cbChecked);

end; // TY2KCheckedPanel.Paint


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

// InverseCheck
procedure TY2KCheckedPanel.SetInverseCheck(const AbValue: boolean);
begin
  FbInverseCheck := AbValue;
  _EnableControls();
end; // TY2KCheckedPanel.SetInverseCheck


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TY2KCheckedPanel._EnableControlsClick(Sender: TObject);
begin
  _EnableControls();
  if Assigned(OnEnableControlsClick) then
    OnEnableControlsClick(Self);
end; // TY2KCheckedPanel.EnableControlsClick


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TY2KCheckedPanel._EnableControls();
begin
  if not (csDesigning in ComponentState) then
    _EnableChildrens(
        ((FcbxEnableControls.State = cbChecked) and not InverseCheck)
        or (not (FcbxEnableControls.State = cbChecked) and InverseCheck));
end; // TY2KCheckedPanel._EnableControls

procedure TY2KCheckedPanel._EnableChildrens(const AbEnable: boolean);
var i: integer;
begin
  for i:= 0 to Self.ControlCount - 1 do
    if Self.Controls[i] <> (FcbxEnableControls as TControl) then
      Self.Controls[i].Enabled := AbEnable;
end; // TY2KCheckedPanel._EnableChildrens


end. /////////////////////////// end of file /////////////////////////////////
