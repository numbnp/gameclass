unit uReportFormsManager;

interface

uses
  Controls,
  Graphics,
  VirtualTrees,
  uReportCommon,
  uReport,
  uReportColumn,
  ufrmReportView,
  ufrmReportChart,
  ufrmReportFolder,
  ufrmReportEdit;

type

  TReportViewType = (rftGrid, rftChart, rftEdit);


  // events types
  TChangeReport = procedure(
      const ASender: TObject; const AnReportId: Integer) of object;

  //
  // TReportFormsManager
  //

  TReportFormsManager = class(TObject)
  private
    // fields
    FOwner: TWinControl;
    FfrmReportView: TfrmReportView;
    FfrmReportChart: TfrmReportChart;
    FfrmReportFolder: TfrmReportFolder;
    FfrmReportEdit: TfrmReportEdit;

    FActiveReport: TReport;

    FOnChangeReport: TChangeReport;
    FOnModifyReport: TModifyReport;

    FBackColor: TColor;
    FFont: TFont;

    // events handlers
    procedure _ChangeReportNode(
        const ASender: TObject; const AnReportId: Integer);
    procedure _ModifyReport(const ASender: TObject);

    // private helper methods
    procedure _CreateReportViewForm();
    procedure _CreateReportChartForm();
    procedure _CreateReportFolderForm();
    procedure _CreateReportEditForm();
    procedure _Storage();
    procedure _SaveActiveReport();

    // fire methods
    procedure _FireChangeReport(const AnReportId: Integer);
    procedure _FireModifyReport();

  public
    // constructor / destructor
    constructor Create(const AOwner: TWinControl);
    destructor Destroy(); override;

    // public methods
    procedure SetActiveReport(const AReport: TReport);
    procedure SetActiveFolder(const AReport: TReport;
        const AtvSource: TVirtualStringTree; const AptrNode: PVirtualNode);
    procedure ResetActiveReport();

    procedure EnableAutofilter(const AbEnable: Boolean);

    procedure SetChartStyle(const AReportChartStyle: TReportChartStyle);
    procedure SetChart3D(const AbChart3D: Boolean);
    procedure SetChartRandomColors(const AbChartRandomColors: Boolean);

    procedure AddReportColumn(const AReportColumn: TReportColumn);
    procedure DeleteReportColumn(const AnId: Integer);
    function GetActiveColumnId(): Integer;
    procedure SaveToFile(OpenAfterSave:Boolean;FileName:string);
    procedure SendFileByEmail();
    procedure Print();

    procedure HideAll();
    procedure ShowForm(const Arft: TReportViewType);

    procedure ReportDeleted(const AnDeletedReportId: Integer);

    procedure SetBackColor(AColor: TColor);
    procedure SetFont(const AFont: TFont);

    // properties
    property OnChangeReport: TChangeReport
        read FOnChangeReport write FOnChangeReport;
    property OnModifyReport: TModifyReport
        read FOnModifyReport write FonModifyReport;

  end; // TReportFormsManager


implementation

uses
  SysUtils,
  Dialogs;


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TReportFormsManager.Create(const AOwner: TWinControl);
begin
  inherited Create();
  FOwner := AOwner;

  FActiveReport := nil;
  FBackColor := clWindow;

  _CreateReportViewForm();
  _CreateReportChartForm();
  _CreateReportFolderForm();
  _CreateReportEditForm();
  FFont := FfrmReportView.Font;

end; // TReportFormsManager.Create


destructor TReportFormsManager.Destroy();
begin
  _Storage();
  _SaveActiveReport();

  FreeAndNil(FfrmReportView);
  FreeAndNil(FfrmReportChart);
  FreeAndNil(FfrmReportFolder);
  FreeAndNil(FfrmReportEdit);

  inherited Destroy();

end; // TReportFormsManager.Destroy


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TReportFormsManager.SetActiveReport(const AReport: TReport);
begin
  if Assigned(FActiveReport) then begin
    _Storage();
    _SaveActiveReport();
  end;
  FActiveReport := AReport;
  FfrmReportView.SetReport(AReport);
  FfrmReportChart.SetReport(AReport);
  FfrmReportFolder.SetReport(AReport);
  FfrmReportEdit.SetReport(AReport);
end; // TReportFormsManager.SetActiveReport


procedure TReportFormsManager.SetActiveFolder(const AReport: TReport;
    const AtvSource: TVirtualStringTree; const AptrNode: PVirtualNode);
begin
  SetActiveReport(AReport);
  FfrmReportFolder.SetFolder(AtvSource, AptrNode);
end; // TReportFormsManager.SetActiveFolder


procedure TReportFormsManager.ResetActiveReport();
begin
  SetActiveReport(FActiveReport);
end; // TReportFormsManager.ResetActiveReport


procedure TReportFormsManager.EnableAutofilter(const AbEnable: Boolean);
begin
  FfrmReportView.EnableAutofilter(AbEnable);
end; // TReportFormsManager.EnableAutofilter


procedure TReportFormsManager.SetChartStyle(
    const AReportChartStyle: TReportChartStyle);
begin
  FfrmReportChart.ChartStyle := AReportChartStyle;
end; // TReportFormsManager.SetChartStyle


procedure TReportFormsManager.SetChart3D(const AbChart3D: Boolean);
begin
  FfrmReportChart.Chart3D := AbChart3D;
end; // TReportFormsManager.SetChart3D


procedure TReportFormsManager.SetChartRandomColors(
    const AbChartRandomColors: Boolean);
begin
  FfrmReportChart.RandomColors := AbChartRandomColors;
end; // TReportFormsManager.SetChartRandomColors


procedure TReportFormsManager.AddReportColumn(
    const AReportColumn: TReportColumn);
begin
  FfrmReportEdit.AddReportColumn(AReportColumn);
end; // TReportFormsManager.AddReportColumn


procedure TReportFormsManager.DeleteReportColumn(const AnId: Integer);
begin
  FfrmReportEdit.DeleteReportColumn(AnId);
end; // TReportFormsManager.DeleteReportColumn


function TReportFormsManager.GetActiveColumnId(): Integer;
begin
  if FfrmReportEdit.Visible then begin
    Result := FfrmReportEdit.GetActiveColumnId();
  end else begin
    Result := 0;
  end;
end; // TReportFormsManager.GetActiveColumnId


procedure TReportFormsManager.SaveToFile(OpenAfterSave:Boolean;FileName:string);
begin
  if FfrmReportView.Visible then begin
    FfrmReportView.SaveTable(OpenAfterSave, FileName {open the file after save});
  end else if FfrmReportChart.Visible then begin
    FfrmReportChart.SaveChart(OpenAfterSave {open the file after save});
  end;
end; // TReportFormsManager.SaveToFile

procedure TReportFormsManager.SendFileByEmail();
begin
  if FfrmReportView.Visible then begin
    FfrmReportView.SendTable;
  end;
end; // TReportFormsManager.SaveToFile

procedure TReportFormsManager.Print();
begin
  if FfrmReportView.Visible then begin
    FfrmReportView.PrintTable();
  end else if FfrmReportChart.Visible then begin
    FfrmReportChart.PrintChart();
  end;
end; // TReportFormsManager.Print


procedure TReportFormsManager.HideAll();
begin
  FfrmReportView.Hide();
  FfrmReportChart.Hide();
  FfrmReportFolder.Hide();
  FfrmReportEdit.Hide();
end; // TReportFormsManager.HideAll


procedure TReportFormsManager.ShowForm(const Arft: TReportViewType);
begin
  ASSERT(Assigned(FActiveReport));
  if not Assigned(FActiveReport) then begin
    exit;
  end;

  if FActiveReport.IsFolder then begin
    FfrmReportView.Hide();
    FfrmReportChart.Hide();
    FfrmReportEdit.Hide();
    FfrmReportFolder.EditMode := (Arft = rftEdit);
    FfrmReportFolder.Show();
  end else begin
    if Arft = rftGrid then begin
      FfrmReportView.Show();
      FfrmReportChart.Hide();
      FfrmReportEdit.Hide();
      FfrmReportFolder.Hide();
    end else if Arft = rftChart then begin
      FfrmReportView.Hide();
      FfrmReportChart.Show();
      FfrmReportEdit.Hide();
      FfrmReportFolder.Hide();
    end else if Arft = rftEdit then begin
      FfrmReportView.Hide();
      FfrmReportChart.Hide();
      FfrmReportEdit.Show();
      FfrmReportFolder.Hide();
    end;
  end;

end; // TReportFormsManager.ShowForm


procedure TReportFormsManager.ReportDeleted(const AnDeletedReportId: Integer);
begin
  if FActiveReport.UID = AnDeletedReportId then begin
    SetActiveReport(nil);
  end;
end; // TReportFormsManager.ReportDeleted


procedure TReportFormsManager._ChangeReportNode(
    const ASender: TObject; const AnReportId: Integer);
begin
  _FireChangeReport(AnReportId);
end; // TReportFormsManager._ChangeReportNode


procedure TReportFormsManager._ModifyReport(const ASender: TObject);
begin
  _FireModifyReport();
end; // TReportFormsManager._ModifyReport


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TReportFormsManager._CreateReportViewForm();
begin
  FfrmReportView := TfrmReportView.Create(FOwner);
  FfrmReportView.Parent := FOwner;
  FfrmReportView.Align := AlClient;
  FfrmReportView.Color := FBackColor;
end; // TReportFormsManager._CreateReportViewForm


procedure TReportFormsManager._CreateReportChartForm();
begin
  FfrmReportChart := TfrmReportChart.Create(FOwner);
  FfrmReportChart.Parent := FOwner;
  FfrmReportChart.Align := AlClient;
  FfrmReportChart.RandomColors := TRUE;
  FfrmReportChart.Color := FBackColor;
end; // TReportFormsManager._CreateReportChartForm


procedure TReportFormsManager._CreateReportFolderForm();
begin
  FfrmReportFolder := TfrmReportFolder.Create(FOwner);
  FfrmReportFolder.Parent := FOwner;
  FfrmReportFolder.Align := AlClient;
  FfrmReportFolder.OnChangeReportNode := _ChangeReportNode;
  FfrmReportFolder.OnModifyReport := _ModifyReport;
  FfrmReportFolder.Color := FBackColor;
end; // TReportFormsManager._CreateReportFolderForm


procedure TReportFormsManager._CreateReportEditForm();
begin
  FfrmReportEdit := TfrmReportEdit.Create(FOwner);
  FfrmReportEdit.Parent := FOwner;
  FfrmReportEdit.Align := AlClient;
  FfrmReportEdit.OnModifyReport := _ModifyReport;
  FfrmReportEdit.Color := FBackColor;
end; // TReportFormsManager._CreateReportEditForm


procedure TReportFormsManager._Storage();
begin
  FfrmReportChart.Storage();
  FfrmReportFolder.Storage();
  if FfrmReportEdit.Visible then begin
    FfrmReportEdit.Storage();
  end else if FfrmReportView.Visible then begin
    FfrmReportView.Storage();
  end;
end; // TReportFormsManager._Storage


procedure TReportFormsManager._SaveActiveReport();
begin
  if Assigned(FActiveReport) then begin
    FActiveReport.Save(TRUE);
  end;
end; // TReportFormsManager._SaveActiveReport


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// fire methods

procedure TReportFormsManager._FireChangeReport(
    const AnReportId: Integer);
begin
  if Assigned(OnChangeReport) then begin
    OnChangeReport(Self, AnReportId);
  end;
end; // TReportFormsManager._FireChangeReport


procedure TReportFormsManager._FireModifyReport();
begin
  if Assigned(OnModifyReport) then begin
    OnModifyReport(Self);
  end;
end; // TReportFormsManager._FireModifyReport

procedure TReportFormsManager.SetBackColor(AColor: TColor);
begin
  FBackColor := AColor;
  if Assigned(FfrmReportView) then begin
    FfrmReportView.grdReport.Color := FBackColor;
  end;
  if Assigned(FfrmReportChart) then begin
    FfrmReportChart.chartReport.Color := FBackColor;
    FfrmReportChart.cboChartX.Color := FBackColor;
    FfrmReportChart.cboChartY.Color := FBackColor;
  end;
  if Assigned(FfrmReportFolder) then begin
    FfrmReportFolder.edtFolderName.Color := FBackColor;
    FfrmReportFolder.tvReportFolder.Color := FBackColor;
  end;
end;

procedure TReportFormsManager.SetFont(const AFont: TFont);
begin
  FFont := AFont;
  if Assigned(FfrmReportView) then begin
    FfrmReportView.grdReport.Font := FFont;
  end;
  if Assigned(FfrmReportFolder) then begin
    FfrmReportFolder.edtFolderName.Font := FFont;
    FfrmReportFolder.tvReportFolder.Font := FFont;
  end;
end;

end.
