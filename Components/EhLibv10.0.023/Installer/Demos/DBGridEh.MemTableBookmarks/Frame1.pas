unit Frame1;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
  Themes,
  ObjectInspectorEh, EhLibMTE,
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, ExtCtrls,
  GridsEh, DBGridEh, MemTableDataEh, Db, ADODB, DataDriverEh,
  ADODataDriverEh, MemTableEh, StdCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh,
  DBCtrlsEh, Mask;

type
  TfrFrame1 = class(TFrame)
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    Label1: TLabel;
    MemTableEh1: TMemTableEh;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  protected
  public
    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  end;

implementation

uses Unit1;

{$R *.dfm}

{ TfrFrame1 }

constructor TfrFrame1.Create(AOwner: TComponent);
//var
//  OldFontHeight: Integer;
begin
  inherited Create(AOwner);
  Panel1.Height := 36;
end;

procedure TfrFrame1.Button1Click(Sender: TObject);
begin
  MemTableEh1.DisableControls;
  MemTableEh1.First;
  try
    while not MemTableEh1.Eof do
    begin
      if MemTableEh1.FieldByName('Continent').AsString = 'North America' then
        DBGridEh1.SelectedRows.CurrentRowSelected := True;
      MemTableEh1.Next;
    end;
  finally
    MemTableEh1.First;
    MemTableEh1.EnableControls;
  end;
end;

procedure TfrFrame1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if Key = VK_F11 then
//    ShowObjectInspectorForm(ActiveControl, Rect(Left+Width+10, Top, Left+Width+10+300, Top+Height));
end;

procedure TfrFrame1.Button2Click(Sender: TObject);
begin
//  DBGridEh1.FieldColumns['Area'].Title.SortMarker := smDownEh;
  DBGridEh1.FieldColumns['Area'].Title.SetNextSortMarkerValue(False);
  DBGridEh1.DefaultApplySorting;
end;

end.
