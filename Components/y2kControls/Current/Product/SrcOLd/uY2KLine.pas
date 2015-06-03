//////////////////////////////////////////////////////////////////////////////
//
// Визуальный компонент - TY2KLine (линия).
//
//////////////////////////////////////////////////////////////////////////////
unit uY2KLine;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  Graphics;

type

  TDirection = (ldHorizontal, ldVertical, ldLRDiagonal, ldRLDiagonal);

  //
  // TY2KLine
  //

  TY2KLine = class(TGraphicControl)
  private
    // attributes
    FPen: TPen;
    FDirection: TDirection;
    // private methods
    procedure SetPen(Value: TPen);
    procedure SetDirection(Value: TDirection);

  protected
    // protected methods
    procedure Paint; override;

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    // public methods
    procedure StyleChanged(Sender: TObject);

  published
    // properties
    property Align;
    property Anchors;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Direction:TDirection read FDirection write SetDirection;
    property Enabled;
    property Constraints;
    property ParentShowHint;
    property Pen: TPen read FPen write SetPen;
    property ShowHint;
    property Visible;
    property OnContextPopup;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDock;
    property OnStartDrag;
  end; // TY2KLine


implementation

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csReplicatable];
  Width := 65;
  Height := 1;
  FPen := TPen.Create();
  FPen.OnChange := StyleChanged;
end; // TY2KLine.Create

destructor TY2KLine.Destroy();
begin
  FPen.Free;
  inherited Destroy();
end; // TY2KLine.Destroy

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

procedure TY2KLine.Paint;
var  X, Y, W, H: Integer;
begin
  with Canvas do
    begin
      Pen := FPen;
      X := Pen.Width div 2;
      Y := X;
      W := Width - Pen.Width + 1;
      H := Height - Pen.Width + 1;
      if Pen.Width = 0 then begin
          Dec(W);
          Dec(H);
        end;
      if FDirection = ldLRDiagonal then begin
          MoveTo(X, Y);
          LineTo(X + W, Y + H - 1);
        end
      else if FDirection = ldRLDiagonal then begin
          MoveTo(X + W, Y);
          LineTo(X, Y + H - 1);
        end
      else if FDirection = ldHorizontal then begin
          Height := Pen.Width;
          MoveTo(X, Y);
          LineTo(X + W, Y);
        end
      else if FDirection = ldVertical then begin
          Width := Pen.Width;
          MoveTo(X, Y);
          LineTo(X, Y + H - 1);
        end
    end;
end; // TY2KLine.Paint

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TY2KLine.StyleChanged(Sender: TObject);
begin
  Invalidate();
end; // TY2KLine.StyleChanged


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TY2KLine.SetPen(Value: TPen);
begin
  FPen.Assign(Value);
end; // TY2KLine.SetPen

procedure TY2KLine.SetDirection(Value: TDirection);
begin
  FDirection := Value;
  if (FDirection = ldHorizontal) and (Width <= 2) then
    Width := 65
  else if (FDirection = ldVertical) and (Height <= 2) then
    Height := 65;
  Invalidate;
end; // TY2KLine.SetDirection

end. /////////////////////////// end of file /////////////////////////////////
