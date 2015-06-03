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
  StdCtrls;

type

  // перечисление возможных типов ссылок
  TY2KLinkLabelType = (Normal, URL, EMail, Exe);

  // events methods types
  TOnMouseOverY2KLinkLabelEvent = procedure(Sender: TObject) of object;
  TOnMouseOutY2KLinkLabelEvent = procedure(Sender: TObject) of object;

  //
  // TY2KLinkLabel
  //

  TY2KLinkLabel = class(TLabel)
  private
    // fields
    FLabelType: TY2KLinkLabelType;
    FstrCommand: String;
    FfntIn: TFont;
    FfntOut: TFont;
//    FfntTemp: TFont;
    FbMouseInPos: Boolean;
    FOnMouseOver: TOnMouseOverY2KLinkLabelEvent;
    FOnMouseOut: TOnMouseOutY2KLinkLabelEvent;

    // events handlers
    procedure CMMouseEnter(var AMsg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var AMsg: TMessage); message CM_MOUSELEAVE;

  protected
    // overrided methods
    procedure Paint; override;

    // properties methods
    procedure SetLabelType(Value: TY2KLinkLabelType);
    procedure SetFontIn(Value: TFont);
    procedure SetFontOut(Value: TFont);

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // overrided methods
    procedure Click; override;

  published
    // properties
    property FontIn: TFont read FfntIn write SetFontIn;
    property FontOut: TFont read FfntOut write SetFontOut;
    property LabelType: TY2KLinkLabelType
        read FLabelType write SetLabelType;
    property CommandString: string read FstrCommand write FstrCommand;
    property OnMouseOver: TOnMouseOverY2KLinkLabelEvent
        read FOnMouseOver write FOnMouseOver;
    property OnMouseOut: TOnMouseOutY2KLinkLabelEvent
        read FOnMouseOut  write FOnMouseOut;

  end; // TY2KLinkLabel


implementation

uses
  ShellApi;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KLinkLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FfntIn := TFont.Create();
  with FfntIn do begin
    Color := clBlue;
    Style := Style + [fsUnderline];
  end;

  FfntOut := TFont.Create();
  with FfntOut do begin
    Color := clBtnText;
  end;

  Cursor:= crHandPoint;

//  FfntTemp := TFont.Create();

end; // TY2KLinkLabel.Create


destructor TY2KLinkLabel.Destroy();
begin
  FreeAndNil(FfntIn);
  FreeAndNil(FfntOut);

  inherited Destroy();

end; // TY2KLinkLabel.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// overrided methods

procedure TY2KLinkLabel.Click();
begin
  inherited Click();
  if length(Trim(CommandString)) > 0 then
    case LabelType of
      Exe: begin
        ShellExecute(0, 'open', PChar(CommandString),
            '', '', SW_SHOWNORMAL);
      end;
      EMail: begin
        ShellExecute(0, 'open', PChar('mailto:' + CommandString),
            '', '', SW_SHOWNORMAL);
      end;
      URL: begin
        ShellExecute(0, 'open', PChar('http://' + CommandString),
            '', '', SW_SHOWNORMAL);
      end;
    end;
end; // TY2KLinkLabel.Click


procedure TY2KLinkLabel.Paint();
begin
  if not (csDesigning in ComponentState) then begin
    if FbMouseInPos then begin
      Font.Assign(FfntIn);
//      Font := FfntIn;
    end else begin
      Font.Assign(FfntOut);
//      Font := FfntOut;
    end;
  end;
  inherited Paint();
end; // TY2KLinkLabel.Paint


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TY2KLinkLabel.CMMouseEnter(var AMsg: TMessage);
begin
  FbMouseInPos := TRUE;
//  FfntTemp.Assign(Font);
  Paint();
  if Assigned(FOnMouseOver) then begin
    FOnMouseOver(Self);
  end;
end; // TY2KLinkLabel.CMMouseEnter

procedure TY2KLinkLabel.CMMouseLeave(var AMsg: TMessage);
begin
  FbMouseInPos := FALSE;
//  Font := FfntTemp;
  Paint();
  if Assigned(FOnMouseOut) then begin
    FOnMouseOut(Self);
  end;
end; // TY2KLinkLabel.CMMouseLeave


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TY2KLinkLabel.SetLabelType(Value: TY2KLinkLabelType);
begin
  FLabelType := Value;
end; // TY2KLinkLabel.SetLabelType


procedure TY2KLinkLabel.SetFontIn(Value: TFont);
begin
  FfntIn := Value;
end; // TY2KLinkLabel.SetFontIn


procedure TY2KLinkLabel.SetFontOut(Value: TFont);
begin
  FfntOut := Value;
end; // TY2KLinkLabel.SetFontOut


end.
