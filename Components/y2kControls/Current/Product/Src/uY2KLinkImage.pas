//////////////////////////////////////////////////////////////////////////////
//
// Компонент - наследник TImage. Позволяет по клику открывать URL,
// программу редактирования почты или запускать exe-файл.
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KLinkImage;

interface

uses
  SysUtils,
  Classes,
  Controls,
  ExtCtrls,
  Graphics,
  Messages;

type

  // перечисление возможных типов ссылок
  TY2KLinkImageType = (Normal, URL, EMail, Exe);

  // events methods types
  TOnMouseOverY2KLinkImageEvent = procedure(Sender: TObject) of object;
  TOnMouseOutY2KLinkImageEvent = procedure(Sender: TObject) of object;


  //
  // TY2KLinkImage
  //

  TY2KLinkImage = class(TImage)
  private
    // fields
    FLinkType     : TY2KLinkImageType;
    FstrCommand   : string;
    FbOnePicture  : boolean;
    FbMouseInPos  : boolean;
    FbIsPictureIn : boolean;
    FpictIn       : TPicture;
    FpictTemp     : TPicture;
    FOnMouseOver  : TOnMouseOverY2KLinkImageEvent;
    FOnMouseOut   : TOnMouseOutY2KLinkImageEvent;

    // events handlers
    procedure CMMouseEnter(var AMsg: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var AMsg: TMessage); message CM_MOUSELEAVE;

  protected
    // overrided methods
    procedure Paint; override;

    // properties methods
    procedure SetLinkType(Value: TY2KLinkImageType);
    procedure SetPictureIn(Value: TPicture);

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // overrided methods
    procedure Click; override;

  published
    // properties
    property PictureIn: TPicture read FpictIn write SetPictureIn;
    property LinkType: TY2KLinkImageType read FLinkType write SetLinkType;
    property OnePicture: boolean read FbOnePicture write FbOnePicture;
    property CommandString: string read FstrCommand write FstrCommand;
    property OnMouseOver: TOnMouseOverY2KLinkImageEvent
        read FOnMouseOver write FOnMouseOver;
    property OnMouseOut: TOnMouseOutY2KLinkImageEvent
        read FOnMouseOut  write FOnMouseOut;

  end; // TY2KLinkImage


implementation

uses
  ShellApi,
  Windows;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KLinkImage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FbIsPictureIn := FALSE;
  OnePicture := TRUE;
  Cursor     := crHandPoint;
  FpictIn    := TPicture.Create();
  FpictTemp  := TPicture.Create();
end; // TY2KLinkImage.Create

destructor TY2KLinkImage.Destroy();
begin
  FpictIn.Free();
  FpictTemp.Free();
  inherited Destroy();
end; // TY2KLinkImage.Destroy

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// overrided methods

procedure TY2KLinkImage.Click();
begin
  inherited Click();
  if length(Trim(CommandString)) > 0 then
    case LinkType of
      Exe:  ShellExecute(0, 'open', PChar(CommandString),
          '', '', SW_SHOWNORMAL);
      EMail: ShellExecute(0, 'open', PChar('mailto:' + CommandString),
          '', '', SW_SHOWNORMAL);
      URL:  ShellExecute(0, 'open', PChar('http://' + CommandString),
          '', '', SW_SHOWNORMAL);
    end;
end; // TY2KLinkImage.Click

procedure TY2KLinkImage.Paint();
begin
  if not (csDesigning in ComponentState) then
    if FbMouseInPos then
      if not FbIsPictureIn then begin
        FbIsPictureIn := TRUE;
        if not OnePicture then
          Picture.Assign(FpictIn);
      end;
  inherited Paint();
end; // TY2KLinkImage.Paint


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TY2KLinkImage.CMMouseEnter(var AMsg: TMessage);
begin
  FbMouseInPos := TRUE;
  if not OnePicture then
    FpictTemp.Assign(Picture);
  Paint();
  if Assigned(FOnMouseOver) then
    FOnMouseOver(Self);
end; // TY2KLinkImage.CMMouseEnter

procedure TY2KLinkImage.CMMouseLeave(var AMsg: TMessage);
begin
  FbMouseInPos := FALSE;
  FbIsPictureIn := FALSE;
  if not OnePicture then
    Picture.Assign(FpictTemp);
  Paint();
  if Assigned(FOnMouseOut) then
    FOnMouseOut(Self);
end; // TY2KLinkImage.CMMouseLeave

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TY2KLinkImage.SetLinkType(Value: TY2KLinkImageType);
begin
  FLinkType := Value;
end; // TY2KLinkImage.SetLinkType

procedure TY2KLinkImage.SetPictureIn(Value: TPicture);
begin
  FpictIn.Assign(Value);
end; // TY2KLinkImage.SetPictureIn


end. ////////////////////////// end of file //////////////////////////////////
