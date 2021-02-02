unit BaseFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs;

type
  TMyBaseFrame = class(TFrame)
  private
    { Private declarations }
  public
    procedure UpdateSettings; virtual;
  end;

implementation

{$R *.dfm}

procedure TMyBaseFrame.UpdateSettings;
begin

end;

end.
