unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MemTableDataEh, Db, DBGridEhGrouping, ADODB, GridsEh, DBGridEh,
  MemTableEh, ToolCtrlsEh, DBGridEhToolCtrls, StdCtrls, Mask, DBCtrlsEh,
  ObjectInspectorEh, BaseFormUnit, SettingsKeepersEh,
  EhLibMTE,
  DBLookupEh, DynVarsEh, DBAxisGridsEh, EhLibVCL, Vcl.ExtCtrls, DBVertGridsEh;

type
  TForm1 = class(TBaseForm)
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    ADOTable1: TADOTable;
    DBVertGridEh1: TDBVertGridEh;
    Splitter1: TSplitter;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  protected
    procedure ReadSettings(Keeper: TSettingsKeeperEh); override;
    procedure WriteSettings(Keeper: TSettingsKeeperEh); override;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F11 then
    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

procedure TForm1.ReadSettings(Keeper: TSettingsKeeperEh);
var
  IntValue: Integer;
  GridSettings: TSettingsKeeperEh;
begin
  inherited ReadSettings(Keeper);
  if Keeper.TryGetIntegerValue('SplitterPosition', IntValue) then
  begin
    DBVertGridEh1.Width := IntValue;
  end;
  if Keeper.TryGetSubsettingsValue('DBGridEh1', GridSettings) then
  begin
    DBGridEh1.ReadSettings(GridSettings);
    DBGridEh1.ApplyFilter;
  end;
  if Keeper.TryGetSubsettingsValue('DBVertGridEh1', GridSettings) then
  begin
    DBVertGridEh1.ReadSettings(GridSettings);
  end;

end;

procedure TForm1.WriteSettings(Keeper: TSettingsKeeperEh);
begin
  inherited WriteSettings(Keeper);

  Keeper.Add('DBGridEh1', DBGridEh1.WriteSettings(TSettingsKeeperEh.Create));
  Keeper.Add('DBVertGridEh1', DBVertGridEh1.WriteSettings(TSettingsKeeperEh.Create));
  Keeper.Add('SplitterPosition', DBVertGridEh1.Width);
end;

end.
