unit uY2KIPEdit;

interface

uses
  SysUtils, Classes, Controls, StdCtrls;

type
  TY2KIPEdit = class(TEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Y2KControls', [TY2KIPEdit]);
end;

end.
