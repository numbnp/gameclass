unit framCompStatesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Grids, DBGridEh, ExtCtrls, DB, ADODB, ImgList;

type
  TCompStatesList = class(TFrame)
    imglstComps: TImageList;
    dsrcCompStates: TDataSource;
    dstCompStates: TADODataSet;
    pnlCompStates: TPanel;
    grdCompStatesFirst: TDBGridEh;
  private
    { Private declarations }
  public
  //  grdCompStates: TDBGridEh;

    constructor Create(AOwner:TComponent);


  end;

implementation

{$R *.dfm}

constructor TCompStatesList.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
//  grdCompStates:= grdCompStatesFirst;
end;

end.
