unit frmCustomReports;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, xmldom, XMLIntf, msxmldom,
  XMLDoc, SynEditHighlighter, SynHighlighterSQL, SynEdit, SynMemo;
                              
type
  TformCustomReportsState = (Edited);
  TformCustomReports = class(TForm)
    lblReports: TLabel;
    lvReports: TListView;
    butCreate: TButton;
    butDelete: TButton;
    butImport: TButton;
    butExport: TButton;
    lblReportName: TLabel;
    editName: TEdit;
    lblReportDescription: TLabel;
    memoDescription: TMemo;
    lblReportSqlCode: TLabel;
    butClose: TButton;
    butSave: TButton;
    updownTabIndex: TUpDown;
    editVersion: TEdit;
    lblVersion: TLabel;
    editTabIndex: TEdit;
    lblTabIndex: TLabel;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    XMLDoc: TXMLDocument;
    memoSQL: TSynMemo;
    SynSQLSyn: TSynSQLSyn;
    butHelp: TButton;
    procedure butCloseClick(Sender: TObject);
    procedure lvReportsClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure memoDescriptionChange(Sender: TObject);
    procedure memoSQLoldChange(Sender: TObject);
    procedure butSaveClick(Sender: TObject);
    procedure butCreateClick(Sender: TObject);
    procedure editNameChange(Sender: TObject);
    procedure butDeleteClick(Sender: TObject);
    procedure editVersionChange(Sender: TObject);
    procedure editTabIndexChange(Sender: TObject);
    procedure updownTabIndexClick(Sender: TObject; Button: TUDBtnType);
    procedure butImportClick(Sender: TObject);
    procedure butExportClick(Sender: TObject);
    procedure butHelpClick(Sender: TObject);
  private
    FState : Set of TformCustomReportsState;
    FSelectedReportId: String;
    procedure UpdateInformation(AbUpdateListFromServer:Boolean);
    procedure DoDesign;
    procedure RedrawLanguage;
    function GetSelectedReport: TCustomReport;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formCustomReports: TformCustomReports;

implementation

uses frmMain,StrUtils,GCLangUtils, frmGCMessageBox, GCConst, GCCommon;
{$R *.dfm}

procedure TformCustomReports.butCloseClick(Sender: TObject);
begin
  ModalResult := mrCancel;
  Hide;
end;

procedure TformCustomReports.UpdateInformation(AbUpdateListFromServer:Boolean);
var
  i:Integer;
  li: TListItem;
begin
  lvReports.Clear;
  if (AbUpdateListFromServer) then begin
    GCustomReports.Load;
    GCustomReports.RebuildTabIndex;
  end;
  if GCustomReports.IndexById(FSelectedReportId)=-1 then
    FSelectedReportId := '';
  for i:=0 to (GCustomReports.Count-1) do begin
      li := lvReports.Items.Add;
      li.Caption := GCustomReports.Items[i].Name;
      li.Data := nil;
  end;
  if FSelectedReportId <>'' then begin
    lvReports.ItemIndex := GCustomReports.IndexById(FSelectedReportId);
    lvReportsClick(Self);
  end;
end;

procedure TformCustomReports.lvReportsClick(Sender: TObject);
var
  li: TListItem;
begin
  li := lvReports.Selected;
  if (li = nil) then begin
    FSelectedReportId := '';
    editName.Text := '';
    memoDescription.Text := '';
    memoSQL.Text := '';
    editTabIndex.Text := '';
    editVersion.Text := '';
  end
  else begin
    FSelectedReportId := GCustomReports.Items[GCustomReports.Index(li.Caption)].Id;
    editName.Text := GetSelectedReport.Name;
    memoDescription.Text := GetSelectedReport.Description;
    memoSQL.Text := GetSelectedReport.SQLCode;
    editVersion.Text := IntToStr(GetSelectedReport.Version);
    editTabIndex.Text := IntToStr(GetSelectedReport.TabIndex);
  end;
  FState := [];
  DoDesign;
end;

procedure TformCustomReports.DoDesign;
begin
  if (Edited in FState) then
    butSave.Enabled := True
  else
    butSave.Enabled := False;
  if (GetSelectedReport = Nil) then begin
    editName.Enabled := False;
    memoDescription.Enabled := False;
    memoSQL.Enabled := False;
  end
  else begin
    editName.Enabled := True;
    memoDescription.Enabled := True;
    memoSQL.Enabled := True;
  end;
end;

procedure TformCustomReports.FormActivate(Sender: TObject);
begin
  RedrawLanguage;
  FState := [];
  FSelectedReportId := '';
  UpdateInformation(True);
  DoDesign;
end;

procedure TformCustomReports.memoDescriptionChange(Sender: TObject);
begin
  FState := FState + [Edited];
  DoDesign;
end;

procedure TformCustomReports.memoSQLoldChange(Sender: TObject);
begin
  FState := FState + [Edited];
  DoDesign;
end;

procedure TformCustomReports.butSaveClick(Sender: TObject);
begin
  if (GetSelectedReport<>Nil) then begin
    GetSelectedReport.Description := memoDescription.Text;
    GetSelectedReport.SQLCode := memoSQL.Text;
    GetSelectedReport.Name := editName.Text;
    try
      GetSelectedReport.TabIndex := StrToInt(editTabIndex.Text);
    except
    end;
    try
      GetSelectedReport.Version := StrToInt(editVersion.Text);
    except
    end;
    if GCustomReports.CheckSyntax(GetSelectedReport.SQLCode) then
      GetSelectedReport.Save
    else begin
      formGCMessageBox.memoInfo.Text := translate('SQLcodeWarning');
      formGCMessageBox.SetDontShowAgain(false);
      formGCMessageBox.ShowModal;
    end;
  end;
  UpdateInformation(True);
  FState := [];
  DoDesign;
  formMain.frameReport.RedrawCustomReportsButtons;
end;

procedure TformCustomReports.butCreateClick(Sender: TObject);
begin
  GCustomReports.Add('GUID','NewReport'+IntToStr(GCustomReports.Count),'','',GCustomReports.Count,1);
  UpdateInformation(False);
  lvReports.ItemIndex := GCustomReports.Count-1;
  lvReportsClick(Sender);
end;

procedure TformCustomReports.editNameChange(Sender: TObject);
begin
  FState := FState + [Edited];
  DoDesign;
end;

procedure TformCustomReports.butDeleteClick(Sender: TObject);
begin
  if (MessageBox(HWND_TOP,PChar(translate('CustomReportDeleteQuestion')),PChar(translate('Warning')),MB_YESNO or MB_ICONQUESTION)<>IDYES) then
    exit;

  if (GetSelectedReport<>Nil) then
    GetSelectedReport.Delete;
  UpdateInformation(True);
  FState := [];
  DoDesign;
  formMain.frameReport.RedrawCustomReportsButtons;
end;

procedure TformCustomReports.editVersionChange(Sender: TObject);
begin
  FState := FState + [Edited];
  DoDesign;
end;

procedure TformCustomReports.editTabIndexChange(Sender: TObject);
var
  n :Integer;
begin
  FState := FState + [Edited];
  if GetSelectedReport <> nil then begin
    n := GetSelectedReport.Version;
    try
      n := StrToInt(editTabIndex.Text);
      if (n<0) or (n>GCustomReports.Count+1) then
        n := GetSelectedReport.Version;
    except
    end;
    editTabIndex.Text := IntToStr(n);
  end;
  DoDesign;
end;

procedure TformCustomReports.updownTabIndexClick(Sender: TObject;
  Button: TUDBtnType);
var
  n : Integer;
begin
  if GetSelectedReport <> nil then begin
    n := GCustomReports.IndexById(FSelectedReportId);
    if (Button=btNext) and ( n > 0) then begin
        with  GCustomReports.Items[n] do begin
          TabIndex := TabIndex - 1;
          Save;
        end;
        with  GCustomReports.Items[n-1] do begin
          TabIndex := TabIndex + 1;
          Save;
        end;
    end;
    if (Button=btPrev) and ( n < GCustomReports.Count-1) then begin
        with  GCustomReports.Items[n] do begin
          TabIndex := TabIndex + 1;
          Save;
        end;
        with  GCustomReports.Items[n+1] do begin
          TabIndex := TabIndex - 1;
          Save;
        end;
    end;
    UpdateInformation(True);
  end;
end;

function TformCustomReports.GetSelectedReport: TCustomReport;
begin
  if (FSelectedReportId <> '') and (GCustomReports.IndexById(FSelectedReportId) <> -1) then
    Result := GCustomReports.Items[GCustomReports.IndexById(FSelectedReportId)]
  else
    Result := Nil;
end;

procedure TformCustomReports.butImportClick(Sender: TObject);
var
  NodeList: IXMLNodeList;
  i,n:Integer;
  str : String;
begin
  if not OpenDialog.Execute then exit;
   XMLDoc.LoadFromFile(OpenDialog.FileName);
//   XMLDoc.Active := True;
  try
    NodeList := XMLDoc.DocumentElement.ChildNodes;
    for i:=0 to (NodeList.Count-1) do // begin
      with NodeList.Nodes[i] do begin
        n := GCustomReports.IndexById(Attributes['id']);
        if n=-1 then begin
          GCustomReports.Add(Attributes['id'],Attributes['name'],
            AnsiReplaceStr(Attributes['description'],#$A,#$D#$A),
            AnsiReplaceStr(Attributes['sqlcode'],#$A,#$D#$A),
            Attributes['tabindex'],Attributes['version']);
          n := GCustomReports.IndexById(Attributes['id']);
          GCustomReports.Items[n].SaveByImport;
        end
        else begin
          str := translate('CustomReportExistWarning1') +
            ' (' + GCustomReports.Items[n].Name + ', ' +
            translate('lblVersion') + ' ' + IntToStr(GCustomReports.Items[n].Version) + ')' + #$D#$A +
            translate('CustomReportExistWarning2') +
            ' (' + Attributes['name'] + ', ' +
            translate('lblVersion') + ' ' +IntToStr(Attributes['version']) + ')' + #$D#$A +
            translate('CustomReportExistWarning3');
          if Application.MessageBox(PChar(str),PChar(translate('Warning')),MB_YESNO)=IDYES then begin
            if GCustomReports.CheckSyntax(Attributes['sqlcode']) then begin
              GCustomReports.Items[n].Name := Attributes['name'];
              GCustomReports.Items[n].Description := AnsiReplaceStr(Attributes['description'],#$A,#$D#$A);
              GCustomReports.Items[n].SQLCode := AnsiReplaceStr(Attributes['sqlcode'],#$A,#$D#$A);
              GCustomReports.Items[n].TabIndex := Attributes['tabindex'];
              GCustomReports.Items[n].Version := Attributes['version'];
              GCustomReports.Items[n].Save;
            end
            else begin
              formGCMessageBox.memoInfo.Text := translate('SQLcodeWarning');
              formGCMessageBox.SetDontShowAgain(false);
              formGCMessageBox.ShowModal;
            end;
          end;
        end;
      end;
  finally
  end;
  UpdateInformation(True);
  formMain.frameReport.RedrawCustomReportsButtons;
end;

procedure TformCustomReports.butExportClick(Sender: TObject);
var
  Node: IXMLNode;
  root: IXMLNode;
  i:Integer;
begin
  if FSelectedReportId<>'' then begin
    i:=GCustomReports.IndexById(FSelectedReportId);
    SaveDialog.FileName := GCustomReports.Items[i].Name;
    if not SaveDialog.Execute then exit;
    XMLDoc.XML.Clear;
    XMLDoc.Active := True;
    XMLDoc.Version := '1.0';
    XMLDoc.Encoding := 'Windows-1251';
    try
      root:= XMLDoc.createElement('CustomReportsListd','');
      XMLDoc.DocumentElement := root;
      Node:= root.AddChild('item');
      Node.SetAttributeNS('id','',GCustomReports.Items[i].id);
      Node.SetAttributeNS('name','',GCustomReports.Items[i].Name);
      Node.SetAttributeNS('description','',GCustomReports.Items[i].Description);
      Node.SetAttributeNS('sqlcode','',GCustomReports.Items[i].SQLCode);
      Node.SetAttributeNS('version','',GCustomReports.Items[i].Version);
      Node.SetAttributeNS('tabindex','',GCustomReports.Items[i].TabIndex);
      XMLDoc.SaveToFile(SaveDialog.FileName);
    finally
    end;
  end;
end;

procedure TformCustomReports.RedrawLanguage;
begin
  Caption := translate('CustomReportsCaption');
  lblReports.Caption := translate('Reports');
  lblReportName.Caption := translate('Name');
  lblReportDescription.Caption := translate('Description');
  lblReportSqlCode.Caption := translate('SQLCode');
  lblVersion.Caption := translate('lblVersion');
  lblTabIndex.Caption := translate('TabIndex');
  butCreate.Caption := translate('Create');
  butSave.Caption := translate('Save');
  butDelete.Caption := translate('Delete');
  butImport.Caption := translate('Import');
  butExport.Caption := translate('Export');
  butClose.Caption := translate('butClose');
  butHelp.Caption := translate('subHelp');
end;

procedure TformCustomReports.butHelpClick(Sender: TObject);
begin
  GCHelp(HELP_CUSTOM_REPORTS);
end;

end.
