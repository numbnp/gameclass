unit Frame2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, GridsEh,
  DBGridEh, MemTableDataEh, Db, MemTableEh, StdCtrls, Mask, DBCtrlsEh,
  ExtCtrls, DynVarsEh, EhLibVCL, DBAxisGridsEh, ComCtrls, SearchPanelsEh;

type
  TfrFrame2 = class(TFrame)
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel2: TPanel;
    Label2: TLabel;
    TabSheet2: TTabSheet;
    DBMemoEh1: TDBMemoEh;
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    DBEditEh1: TDBEditEh;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBEditEh1Change(Sender: TObject);
    procedure DBEditEh1Enter(Sender: TObject);
    procedure DBEditEh1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Text: String;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

procedure TfrFrame2.Button4Click(Sender: TObject);
begin
  if DBGridEh1.SearchPanel.Location = splExternal
    then DBGridEh1.SearchPanel.Location := splGridTopEh
    else DBGridEh1.SearchPanel.Location := splExternal;
end;

procedure TfrFrame2.Button3Click(Sender: TObject);
begin
  DBGridEh1.SearchPanel.FindPrev;
end;

procedure TfrFrame2.Button2Click(Sender: TObject);
begin
  DBGridEh1.SearchPanel.FindNext;
end;

procedure TfrFrame2.Button1Click(Sender: TObject);
begin
  if Button1.Caption = 'Filter' then
  begin
    DBGridEh1.SearchPanel.ApplySearchFilter;
    Button1.Caption := 'Cancel Filter';
  end else
  begin
    DBGridEh1.SearchPanel.CancelSearchFilter;
    Button1.Caption := 'Filter';
    DBEditEh1.Text := '';
  end;
end;

procedure TfrFrame2.DBEditEh1Change(Sender: TObject);
begin
  DBGridEh1.SearchPanel.SearchingText := DBEditEh1.Text;
  DBGridEh1.SearchPanel.RestartFind;
end;

procedure TfrFrame2.DBEditEh1Enter(Sender: TObject);
begin
  DBGridEh1.SearchPanel.Active := True;
end;

procedure TfrFrame2.DBEditEh1Exit(Sender: TObject);
begin
  DBGridEh1.SearchPanel.Active := False;
end;

constructor TfrFrame2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Text := 'Working with SearchPanel properties from external controls.';
end;

end.
