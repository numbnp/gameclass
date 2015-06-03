//////////////////////////////////////////////////////////////////////////////
//
// Компонент TY2KCheckedPanel.
// Панель с заголовком и кнопкой закрытия.
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KCheckedPanel;

interface

uses
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
    FcbxEnableControls: TCheckBox;
    FOnEnableControlsClick: TNotifyEvent;
    procedure EnableControlsClick(Sender: TObject);
    procedure _EnableChildrens(const AbEnable: boolean);    
  protected
  public
    // construcor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    procedure Paint(); override;

  published
    property EnableControls: TCheckBox read FcbxEnableControls;
    property OnEnableControlsClick: TNotifyEvent read FOnEnableControlsClick
        write FOnEnableControlsClick;
  end; // TY2KCheckedPanel



implementation

uses
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
    Left := 9;
    Height := 17;
    Width := 30;
    OnClick := EnableControlsClick;
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

  if not (csDesigning in ComponentState) then
    _EnableChildrens(FcbxEnableControls.State = cbChecked);

end; // TY2KCheckedPanel.Paint


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TY2KCheckedPanel.EnableControlsClick(Sender: TObject);
begin
  if not (csDesigning in ComponentState) then
    _EnableChildrens(FcbxEnableControls.State = cbChecked);
  if Assigned(OnEnableControlsClick) then
    OnEnableControlsClick(Self);
end; // TY2KCheckedPanel.EnableControlsClick


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private methods

procedure TY2KCheckedPanel._EnableChildrens(const AbEnable: boolean);
var i: integer;
begin
  for i:= 0 to Self.ControlCount - 1 do
    if Self.Controls[i] <> (FcbxEnableControls as TControl) then
      Self.Controls[i].Enabled := AbEnable;
end; // TY2KCheckedPanel._EnableChildrens

end. /////////////////////////// end of file /////////////////////////////////
