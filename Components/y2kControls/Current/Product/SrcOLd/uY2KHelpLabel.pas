unit uY2KHelpLabel;

interface

uses
  SysUtils,
  Classes,
  Controls,
  StdCtrls,
  uY2KHTMLHelp,
  uY2KLinkLabel;

type

  //
  // TY2KHelpLabel
  //

  TY2KHelpLabel = class(TY2KLinkLabel)
  private
    // attributes
    FY2KHTMLHelp: TY2KHTMLHelp;
    FY2KHTMLHelpLink: TY2KHTMLHelpLink;
  protected

  public
    // constructor / destructor
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;

    // properties methods
    procedure SetHTMLHelp(AY2KHTMLHelp: TY2KHTMLHelp);
  published
    // properties
    property HTMLHelp: TY2KHTMLHelp read FY2KHTMLHelp
        write SetHTMLHelp;
  end; // TY2KHelpLabel

implementation

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KHelpLabel.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FY2KHTMLHelpLink := FY2KHTMLHelpLink.Create;
end; // TY2KHelpLabel.Create

destructor TY2KHelpLabel.Destroy();
begin
  if Assigned(FY2KHTMLHelpLink) then begin
    FY2KHTMLHelpLink.Free;
    FY2KHTMLHelpLink := nil;
  end;
  inherited Destroy();
end; // TY2KHelpLabel.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

procedure TY2KHelpLabel.SetHTMLHelp(AY2KHTMLHelp: TY2KHTMLHelp);
begin
  ASSERT(Assigned(AY2KHTMLHelp));

  if Assigned(FY2KHTMLHelp)then
    FY2KHTMLHelp.UnRegisterChanges(FY2KHTMLHelpLink);

  FY2KHTMLHelp := AY2KHTMLHelp;
  if Assigned(FY2KHTMLHelp) then begin
      FY2KHTMLHelp.RegisterChanges(FY2KHTMLHelpLink);
      FY2KHTMLHelp.FreeNotification(Self);
    end;
end; // TY2KHelpLabel.SetHTMLHelp

end.
