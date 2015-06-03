unit uY2KTitledLine;

interface

uses
  SysUtils,
  Classes,
  Controls,
  uY2KLine,
  StdCtrls;

type

  //
  // TY2KTitledLine
  //

  TY2KTitledLine = class(TLabel)
  private
    { Private declarations }
    FLine : TY2KLine;
  protected
    { Protected declarations }
    procedure SetParent(AParent: TWinControl); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer); override;
  published
    { Published declarations }
    property Line : TY2KLine read FLine;
  end; // TY2KTitledLine


implementation

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KTitledLine.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  AutoSize := TRUE;
  FLine := TY2KLine.Create(Self);
  with FLine do begin
    SetSubComponent(TRUE);
    Width := 20;
    Height := 1;
    Show();
  end;
end;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TY2KTitledLine.SetBounds(ALeft: Integer; ATop: Integer; AWidth: Integer; AHeight: Integer);
begin
  inherited SetBounds(ALeft, ATop, AWidth, AHeight);
  if Assigned(FLine) then
    FLine.SetBounds(Left + Width + 2,
                    Top + Round(Height/2),
                    FLine.Width,
                    FLine.Height);
end; // TY2KTitledLine.SetBounds


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

procedure TY2KTitledLine.SetParent(AParent: TWinControl);
begin
  inherited SetParent(AParent);
  if Assigned(FLine) then begin
    if Assigned(AParent) then
      FLine.Parent := AParent;
    FLine.Visible := True;
  end
end; // TY2KTitledLine.SetParent


end.
