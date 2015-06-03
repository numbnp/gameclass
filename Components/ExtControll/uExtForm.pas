unit uExtForm;

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

  TExtForm = class(TForm)
  private
    FbControlsEnabled: Boolean;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  end;

  procedure Register;

implementation

constructor TExtForm.Create(Aowner: TComponent);
begin
  inherited Create(AOwner);
  FbControlsEnabled := False;
end;

procedure TExtForm.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TExtForm.DisableControls;
begin
  FbControlsEnabled := False;
end;


procedure Register;
begin
  RegisterComponents('ExtControls', [TExtForm]);
end;
 
 end.
