unit UnitEditDialogForCellDataIsLink;

{$MODE Delphi}

interface

uses
  SysUtils, Controls, Forms, Dialogs, StdCtrls, ExtCtrls,
  GridsEh, DBAxisGridsEh, DBVertGridsEh, Classes;

type
  TFormEditDialogForCellDataIsLink = class(TForm)
    DBVertGridEh1: TDBVertGridEh;
    Panel1: TPanel;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEditDialogForCellDataIsLink: TFormEditDialogForCellDataIsLink;

implementation

{$R *.lfm}

end.
