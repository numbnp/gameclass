unit uY2KTitledPanel;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ExtCtrls;

type

  //
  // TY2KTitledPanel
  //

  TY2KTitledPanel = class(TPanel)
  private
    FbShowCloseButton : boolean;
    FlblTitle : TLabel;
    FbtnClose : TButton;
    FOnBtnCloseClick : TNotifyEvent;
    procedure CloseButtonClick(Sender: TObject);
    procedure ResizePanel(Sender: TObject);
  protected
    procedure SetShowCloseButton(AbShowCloseButton : boolean);
  public
    constructor Create(AOwner: TComponent); override;
  published
    property ShowCloseButton : boolean read FbShowCloseButton
        write SetShowCloseButton;
    property Title : TLabel read FlblTitle;
    property OnBtnCloseClick : TNotifyEvent read FOnBtnCloseClick
        write FOnBtnCloseClick;
  end; // TY2KTitledPanel


implementation

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KTitledPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Caption := '';
  if not (csDesigning in ComponentState) then
    Parent := (AOwner as TWinControl);
  FbShowCloseButton := TRUE;
  FlblTitle := TLabel.Create(Self);
  OnResize := ResizePanel;
  with FlblTitle do begin
    Parent := Self;
    SetSubComponent(TRUE);
    Color := clGray;
    Align := alTop;
    AutoSize := FALSE;
    Layout := tlCenter;
    Height := 17;
    Font.Color := clWhite;
    Font.Style := [fsBold];
    Font.Size := 9;
    Show();
  end;

  FbtnClose := TButton.Create(Self);
  with FbtnClose do begin
    Parent := Self;
    if not (csDesigning in ComponentState) then
      Left := Self.GetClientRect.Right - 19
    else
      Left := Self.Width - 19;
    Top := 1;
    Width := 18;
    Height := 17;
    Anchors := [akTop, akRight];
    Caption := 'X';
    OnClick := CloseButtonClick;
    TabStop := FALSE;
  end;
  Resize();
end;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

procedure TY2KTitledPanel.SetShowCloseButton(AbShowCloseButton : boolean);
begin
  FbShowCloseButton := AbShowCloseButton;
  if ShowCloseButton then
    FbtnClose.Show()
  else
    FbtnClose.Hide();
  Invalidate;
end; // TY2KTitledPanel.SetShowCloseButton

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private methods

procedure TY2KTitledPanel.CloseButtonClick(Sender: TObject);
begin
  if Assigned(OnBtnCloseClick) then
    OnBtnCloseClick(Self);
end; // TY2KTitledPanel.CloseButtonClick

procedure TY2KTitledPanel.ResizePanel(Sender: TObject);
begin
  FbtnClose.Left := Self.Width - 19;
  Invalidate();
end; // TY2KTitledPanel.ResizePanel

end.
