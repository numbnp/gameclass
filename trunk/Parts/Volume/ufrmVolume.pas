unit ufrmVolume;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls;

type
  TfrmVolume = class(TForm)
    pnlVolume: TPanel;
    tbMain: TTrackBar;
    cbMute: TCheckBox;
    cbCustom: TCheckBox;
    lblMain: TLabel;
    ListViewVolume: TListView;
    butClose: TButton;
    cbOnlyLimit: TCheckBox;

    procedure Load();
    procedure OnChangeMain(Sender: TObject);
    procedure OnClickMute(Sender: TObject);
    procedure OnClickCustomVolume(Sender: TObject);
    procedure ListViewVolumeSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure butCloseClick(Sender: TObject);
    procedure cbOnlyLimitClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FbControlsEnabled: Boolean;
  public
    procedure EnableControls;
    procedure DisableControls;
    property ControlsEnabled: Boolean
        read FbControlsEnabled write FbControlsEnabled;
  end;


var
  frmVolume   : TfrmVolume;
implementation

uses
  StrUtils,
  GClangutils,
  gccomputers,
  uRegistry, uRegistryVolume,gcconst;

{$R *.dfm}

procedure TfrmVolume.Load();
Var
  i : Integer;
begin
  ListViewVolume.Visible := False;
  ListViewVolume.Items.Add.Caption := translate('CommonSoundVolume');
  for i := 0 to CompsCount-1 do
     ListViewVolume.Items.Add.Caption := IntToStr(Comps[i].number)
        + IfThen(GRegistry.Volume[i+1].Custom, ' ('+translate('Custom')+')',
        '');
  ListViewVolume.Visible := True;
end;

procedure TfrmVolume.OnChangeMain(Sender: TObject);
begin
  if not ControlsEnabled then exit;
  DisableControls;
  if (ListViewVolume.Selected <> nil) then
  begin
    GRegistry.Volume[ListViewVolume.Selected.Index].Main := VOLUME_MAX
        - tbMain.Position * (VOLUME_MAX div tbMain.Max);
    GRegistry.Volume[ListViewVolume.Selected.Index].Wave := VOLUME_MAX
        - tbMain.Position * (VOLUME_MAX div tbMain.Max);
  end;
  EnableControls;
end;

procedure TfrmVolume.OnClickMute(Sender: TObject);
begin
  If (ListViewVolume.Selected <> nil) Then
    GRegistry.Volume[ListViewVolume.Selected.Index].Mute := cbMute.Checked;
end;

procedure TfrmVolume.OnClickCustomVolume(Sender: TObject);
begin
  if (ListViewVolume.Selected <> nil) then begin
    GRegistry.Volume[ListViewVolume.Selected.Index].Custom := cbCustom.Checked;
    ListViewVolumeSelectItem(nil, ListViewVolume.Selected, true);

    if ListViewVolume.Selected.Index <> 0 then
      ListViewVolume.Selected.Caption :=
          IntToStr(Comps[ListViewVolume.Selected.Index-1].number)
          + IfThen(GRegistry.Volume[ListViewVolume.Selected.Index].Custom,
          ' ('+translate('Custom')+')','');
  End;
end;

procedure TfrmVolume.ListViewVolumeSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
  DisableControls;
  if (Item.Index = 0) then
     cbCustom.Visible := false
  else
     cbCustom.Visible := true;

   if GRegistry.Volume[Item.Index].Custom = true then begin
     tbMain.Enabled := true;
     cbMute.Enabled := true;
   end else begin
     tbMain.Enabled := false;
     cbMute.Enabled := false;
  end;
  tbMain.Position := tbMain.Max
      - GRegistry.Volume[Item.Index].Main * tbMain.Max div VOLUME_MAX;
  cbMute.Checked := GRegistry.Volume[Item.Index].Mute;
  cbCustom.Checked := GRegistry.Volume[Item.Index].Custom;
  EnableControls;
end;

procedure TfrmVolume.FormActivate(Sender: TObject);
begin
  Caption := translate('Volume');
  butClose.Caption := translate('butClose');
  cbMute.Caption := translate('cbMute');
  cbCustom.Caption := translate('cbCustom');
  cbOnlyLimit.Caption := translate('OnlyLimit');
  cbOnlyLimit.Checked := GRegistry.Volume.OnlyLimit;
  ListViewVolume.SetFocus;
  if (CompsSelCount = 1) then
    frmVolume.ListViewVolume.Selected := frmVolume.ListViewVolume.Items[ComputersGetIndex(CompsSel[0])+1]
  else
    frmVolume.ListViewVolume.Selected := frmVolume.ListViewVolume.Items[0];

end;

procedure TfrmVolume.butCloseClick(Sender: TObject);
begin
  ModalResult := mrOk;
  Hide;
end;

procedure TfrmVolume.cbOnlyLimitClick(Sender: TObject);
begin
  GRegistry.Volume.OnlyLimit := cbOnlyLimit.Checked;
end;

procedure TfrmVolume.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=27) then ModalResult := mrCancel;
end;

procedure TfrmVolume.EnableControls;
begin
  FbControlsEnabled := True;
end;

procedure TfrmVolume.DisableControls;
begin
  FbControlsEnabled := False;
end;


end.
