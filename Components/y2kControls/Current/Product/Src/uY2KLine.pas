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

  // направление рисования линии
  TDirection = (ldHorizontal,
                ldVertical,
                ldLRDiagonal,
                ldRLDiagonal);

  //
  // TY2KLine
  //

  TY2KLine = class(TGraphicControl)
  private
    // fields
    FPen: TPen;
    FDirection: TDirection;

    // properties methods
    procedure SetPen(Value: TPen);
    procedure SetDirection(Value: TDirection);

    // event handlers
    procedure StyleChanged(Sender: TObject);

  protected
    // overrided methods
    procedure Paint; override;

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

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

const
  // значения по умолчанию
  WIDTH_DEF  = 65;
  HEIGHT_DEF = 65;


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
// overrided methods

procedure TY2KLine.Paint();
var
  X, Y, W, H: Integer;
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
// event handlers

// обработчик события Pen.OnChange
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
    Width := WIDTH_DEF
  else if (FDirection = ldVertical) and (Height <= 2) then
    Height := HEIGHT_DEF;
  Invalidate();
end; // TY2KLine.SetDirection


end. /////////////////////////// end of file /////////////////////////////////
