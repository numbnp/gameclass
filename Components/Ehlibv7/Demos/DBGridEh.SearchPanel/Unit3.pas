unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, GridsEh,
  DBGridEh, MemTableDataEh, Db, MemTableEh, StdCtrls, Mask, DBCtrlsEh,
  ExtCtrls;

type
  TFrame3 = class(TFrame)
    DBGridEh1: TDBGridEh;
    Button4: TButton;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    Panel1: TPanel;
    DBEditEh1: TDBEditEh;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Bevel1: TBevel;
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

procedure TFrame3.Button4Click(Sender: TObject);
begin
  if DBGridEh1.SearchPanel.Location = splExternal
    then DBGridEh1.SearchPanel.Location := splGridTopEh
    else DBGridEh1.SearchPanel.Location := splExternal;
end;

procedure TFrame3.Button3Click(Sender: TObject);
begin
  DBGridEh1.SearchPanel.FindPrev;
end;

procedure TFrame3.Button2Click(Sender: TObject);
begin
  DBGridEh1.SearchPanel.FindNext;
end;

procedure TFrame3.Button1Click(Sender: TObject);
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

procedure TFrame3.DBEditEh1Change(Sender: TObject);
begin
  DBGridEh1.SearchPanel.SearchingText := DBEditEh1.Text;
  DBGridEh1.SearchPanel.RestartFind;
end;

procedure TFrame3.DBEditEh1Enter(Sender: TObject);
begin
  DBGridEh1.SearchPanel.Active := True;
end;

procedure TFrame3.DBEditEh1Exit(Sender: TObject);
begin
  DBGridEh1.SearchPanel.Active := False;
end;

constructor TFrame3.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Text := 'Working with SearchPanel properties from external controls.';
end;

end.
