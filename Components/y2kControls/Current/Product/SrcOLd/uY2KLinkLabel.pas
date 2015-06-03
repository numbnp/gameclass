//////////////////////////////////////////////////////////////////////////////
//
// Визуальный компонент TY2KLinkLabel.
// Умеет менять шрифт при наведении курсора мыши, запускать приложения,
// открывать страницы в браузере по умолчанию, запускать почтовый клиент.
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KLinkLabel;

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
  ShellApi;

type
  TY2KLinkLabelType = (Normal, URL, EMail, Exe);

  // events methods types
  TOnMouseOverY2KLinkLabelEvent = procedure(Sender: TObject) of object;
  TOnMouseOutY2KLinkLabelEvent = procedure(Sender: TObject) of object;

  //
  // TY2KLinkLabel
  //

  TY2KLinkLabel = class(TLabel)
  private
    // attributes
    FLabelType    : TY2KLinkLabelType;
    FfntIn        : TFont;
    FfntTemp      : TFont;
    FbMouseInPos  : boolean;
    FOnMouseOver  : TOnMouseOverY2KLinkLabelEvent;
    FOnMouseOut   : TOnMouseOutY2KLinkLabelEvent;

    // events handlers
    procedure CMMouseEnter(var AMsg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var AMsg: TMessage); message CM_MOUSELEAVE;

  protected
    // protected methods
    procedure Paint; override;

    // properties methods
    procedure SetLabelType(Value: TY2KLinkLabelType);
    procedure SetFontIn(Value: TFont);

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;

    // public methods
    procedure Click; override;

  published
    // properties
    property FontIn: TFont read FfntIn write SetFontIn;
    property LabelType: TY2KLinkLabelType read FLabelType write SetLabelType;
    property OnMouseOver: TOnMouseOverY2KLinkLabelEvent read FOnMouseOver
        write FOnMouseOver;
    property OnMouseOut: TOnMouseOutY2KLinkLabelEvent read FOnMouseOut
        write FOnMouseOut;
  end; // TY2KLinkLabel


implementation


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TY2KLinkLabel

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KLinkLabel.Create(AOwner: TComponent);  // override
begin
  inherited Create(AOwner);
  FfntIn := TFont.Create();
  with FfntIn do begin
    Color := clBlue;
    Style := Style + [fsUnderline];
  end;
  Cursor:= crHandPoint;
  FfntTemp := TFont.Create();
end; // TY2KLinkLabel.Create


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TY2KLinkLabel.Click();
begin
  inherited Click();
//  case FLabelType of
//    Exe:  ShellExecute(0, 'open', PChar(Caption), '', '', SW_SHOWNORMAL);
//    EMail: ShellExecute(0, 'open', PChar('mailto:' + Caption), '', '', SW_SHOWNORMAL);
//    URL:  ShellExecute(0, 'open', PChar('http://' + Caption), '', '', SW_SHOWNORMAL);
//  end;
end; // TY2KLinkLabel.Click

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TY2KLinkLabel.CMMouseEnter(var AMsg: TMessage);
begin
  FbMouseInPos := TRUE;
  FfntTemp.Assign(Font);
  Paint();
  if Assigned(FOnMouseOver) then
    FOnMouseOver(Self);
end; // TY2KLinkLabel.CMMouseEnter

procedure TY2KLinkLabel.CMMouseLeave(var AMsg: TMessage);
begin
  FbMouseInPos := FALSE;
  Font := FfntTemp;
  Paint();
  if Assigned(FOnMouseOut) then
    FOnMouseOut(Self);
end; // TY2KLinkLabel.CMMouseLeave

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

procedure TY2KLinkLabel.Paint(); // override
begin
  if not (csDesigning in ComponentState) then
    if FbMouseInPos then
      Font := FfntIn;
  inherited Paint();
end; // TY2KLinkLabel.Paint()


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TY2KLinkLabel.SetLabelType(Value: TY2KLinkLabelType);
begin
  FLabelType := Value;
//  case FLabelType of
//    Normal: Font.Style:= [];
//    Exe, EMail, URL: Font.Style:= [fsUnderline];
//  end;
end; // TY2KLinkLabel.SetLabelType

procedure TY2KLinkLabel.SetFontIn(Value: TFont);
begin
  FfntIn := Value;
end; // TY2KLinkLabel.SetFontIn


end. /////////////////////////// end of file /////////////////////////////////
