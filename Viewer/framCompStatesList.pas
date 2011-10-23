unit framCompStatesList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, Grids, DBGridEh, ExtCtrls, DB, ADODB, ImgList;

type

  TCompStatesList = class(TFrame)
    imglstComps: TImageList;
    dsrcLocalCompStates: TDataSource;
    dstLocalCompStates: TADODataSet;
    pnlCompStates: TPanel;
    grdCompStatesFirst: TDBGridEh;
  private
    { Private declarations }
  public
  //  grdCompStates: TDBGridEh;

    constructor Create(AOwner:TComponent);


  end;

  TMyPanel = class(TPanel)
    CompStatesList: TCompStatesList;
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


constructor TMyPanel.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  self.BorderWidth :=8;

  self.CompStatesList:= TCompStatesList.Create(self);
  self.CompStatesList.Parent := Self ;
  self.CompStatesList.Align := alClient;

end;


end.
