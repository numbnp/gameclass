unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  MemTableDataEh, Db, StdCtrls, MemTableEh, GridsEh, DBGridEh, ExtCtrls,
  Mask, DBCtrlsEh;

type
  TFrame2 = class(TFrame)
    DBGridEh1: TDBGridEh;
    MemTableEh1: TMemTableEh;
    DataSource1: TDataSource;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Panel1: TPanel;
    bFilerOnTyping: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure bFilerOnTypingClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Text: String;
    constructor Create(AOwner: TComponent); override;
  end;

implementation

{$R *.dfm}

procedure TFrame2.Button1Click(Sender: TObject);
begin
  DBGridEh1.SearchPanel.FilterOnTyping := True;

  DBGridEh1.HorzScrollBar.ExtraPanel.Visible :=
    not DBGridEh1.HorzScrollBar.ExtraPanel.Visible;
  if DBGridEh1.HorzScrollBar.ExtraPanel.Visible
    then Button1.Caption := 'Hide ScollBar Panel'
    else Button1.Caption := 'Show ScollBar Panel';
end;

procedure TFrame2.Button2Click(Sender: TObject);
begin

  DBGridEh1.SearchPanel.PersistentShowing := not DBGridEh1.SearchPanel.PersistentShowing;

  if DBGridEh1.SearchPanel.PersistentShowing then
    Button2.Caption := 'Dynamic Show Search Panel'
  else
    Button2.Caption := 'Persistent Show Search Panel';

end;

procedure TFrame2.Button3Click(Sender: TObject);
begin
  if DBGridEh1.SearchPanel.Location = splGridTopEh then
    DBGridEh1.SearchPanel.Location := splHorzScrollBarExtraPanelEh
  else
    DBGridEh1.SearchPanel.Location := splGridTopEh;
end;

procedure TFrame2.bFilerOnTypingClick(Sender: TObject);
begin
  DBGridEh1.SearchPanel.FilterOnTyping := not DBGridEh1.SearchPanel.FilterOnTyping;
  if DBGridEh1.SearchPanel.FilterOnTyping
    then bFilerOnTyping.Caption := 'FilterOnTyping (Yes)'
    else bFilerOnTyping.Caption := 'FilterOnTyping (No)';
end;

procedure TFrame2.Button4Click(Sender: TObject);
begin
  DBGridEh1.SearchPanel.PersistentShowing := not DBGridEh1.SearchPanel.PersistentShowing;
  if DBGridEh1.SearchPanel.PersistentShowing
    then Button4.Caption := 'Persistent Show (Yes)'
    else Button4.Caption := 'Persistent Show (No)';

end;

procedure TFrame2.Button5Click(Sender: TObject);
begin
  DBGridEh1.SearchPanel.FilterEnabled := not DBGridEh1.SearchPanel.FilterEnabled;
  if DBGridEh1.SearchPanel.FilterEnabled
    then Button5.Caption := 'Filter Enabled (Yes)'
    else Button5.Caption := 'Filter Enabled (No)';
end;

procedure TFrame2.Button6Click(Sender: TObject);
begin
  if DBGridEh1.SearchPanel.Location = splGridTopEh then
  begin
    DBGridEh1.SearchPanel.Location := splHorzScrollBarExtraPanelEh;
    DBGridEh1.HorzScrollBar.ExtraPanel.Visible := True;
    Button6.Caption := 'FilterPanel in the Top (No)';
  end else
  begin
    DBGridEh1.SearchPanel.Location := splGridTopEh;
    DBGridEh1.HorzScrollBar.ExtraPanel.Visible := False;
    Button6.Caption := 'FilterPanel in the Top (Yes)';
  end;
end;

constructor TFrame2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Text := 'Use Full Filter Panel facilities when the Grid is connected to TMemTableEh. Filtering in a selected area is supported';
end;

end.
