//////////////////////////////////////////////////////////////////////////////
//
//
//
//////////////////////////////////////////////////////////////////////////////

unit ufrmBaseOptionsFrame;

interface

uses
  // system units
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  ExtCtrls,
  StdCtrls,
  Contnrs,
  uY2KLinkLabel,
  uY2KHTMLHelp,
  uY2KHelpLabel,
  uOption,
  uOptions;


type

  //
  // TfrmBaseOptionsFrame
  //

  TfrmBaseOptionsFrame = class(TForm)
    pnlHelp: TPanel;
    lblHelp: TY2KHelpLabel;
    imgHelp: TImage;

  private
    // fields
    FlstOptionLinks: TObjectList;

  protected
    // protected methods
    function SubscribeToChanges(AOption: TOption): TOptionLink;
    procedure InitValues(); virtual; abstract;

    // properties methods
    function GetHTMLHelp(): TY2KHTMLHelp;
    procedure SetHTMLHelp(const AHTMLHelp: TY2KHTMLHelp);

  public
    // constructor / destructor
    constructor Create(AOwner: TComponent); override;
    destructor Destroy(); override;

    // properties
    property HTMLHelp: TY2KHTMLHelp read GetHTMLHelp write SetHTMLHelp;

  end; // TfrmBaseOptionsFrame


implementation

{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TfrmBaseOptionsFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FlstOptionLinks := TObjectList.Create(TRUE);
  InitValues();
end; // TfrmBaseOptionsFrame.Create


destructor TfrmBaseOptionsFrame.Destroy();
begin
  FreeAndNil(FlstOptionLinks);
  inherited Destroy();
end; // TfrmBaseOptionsFrame.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// properties methods

function TfrmBaseOptionsFrame.GetHTMLHelp(): TY2KHTMLHelp;
begin
  Result := lblHelp.HTMLHelp;
end; // TfrmBaseOptionsFrame.GetHTMLHelp


procedure TfrmBaseOptionsFrame.SetHTMLHelp(const AHTMLHelp: TY2KHTMLHelp);
begin
  lblHelp.HTMLHelp := AHTMLHelp;
end; // TfrmBaseOptionsFrame.SetHTMLHelp


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// protected methods

function TfrmBaseOptionsFrame.SubscribeToChanges(
    AOption: TOption): TOptionLink;
var
  OptionLink: TOptionLink;
begin
  OptionLink := TOptionLink.Create(AOption);
  FlstOptionLinks.Add(OptionLink);
  Result := OptionLink;
end; // TfrmBaseOptionsFrame.SubscribeToChanges


end.
