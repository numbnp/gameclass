program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FrameMainGrid in 'FrameMainGrid.pas' {frMainGrid: TFrame},
  FrameMasterDetail in 'FrameMasterDetail.pas' {frMasterDetail: TFrame},
  FormAbout in 'FormAbout.pas' {fAbout},
  FrameMailBox in 'FrameMailBox.pas' {frMailBox: TFrame},
  FramePlanner in 'FramePlanner.pas' {frPlanner: TFrame},
  FrameEditControls in 'FrameEditControls.pas' {frEditControls: TFrame},
  FrameRowDetailPanel in 'FrameRowDetailPanel.pas' {frRowDetailPanel: TFrame},
  FrameTreeView in 'FrameTreeView.pas' {frTreeView: TFrame},
  FrameBackgroundImages in 'FrameBackgroundImages.pas' {frBackgroundImages: TFrame},
  FrameDataGrouping in 'FrameDataGrouping.pas' {frDataGrouping: TFrame},
  FrameLiveRestructure in 'FrameLiveRestructure.pas' {frLiveRestructure: TFrame},
  FrameRowAsPanel in 'FrameRowAsPanel.pas' {frRowAsPanel: TFrame},
  FrameWorkingWithHugeData in 'FrameWorkingWithHugeData.pas' {frWorkingWithHugeData: TFrame},
  FrameMemTableSaveLoad in 'FrameMemTableSaveLoad.pas' {frMemTableSaveLoad: TFrame},
  FrameSearchPanel in 'FrameSearchPanel.pas' {frSearchPanel: TFrame},
  FrameImportExport in 'FrameImportExport.pas' {frImportExport: TFrame},
  FrameFishFact in 'FrameFishFact.pas' {frFishFact: TFrame},
  FrameDropDownForms in 'FrameDropDownForms.pas' {frFrameDropDownForms: TFrame},
  MemoEditUnit in 'MemoEditUnit.pas' {DropDownMemoEdit: TCustomDropDownFormEh},
  FrameEditControls2 in 'FrameEditControls2.pas' {frEditControls2: TFrame},
  FramePivotGrid in 'FramePivotGrid.pas' {frPivotGrid: TFrame},
  FrameVertGrid in 'FrameVertGrid.pas' {frVertGrid: TFrame},
  UnitEditDialogForCellDataIsLink in 'UnitEditDialogForCellDataIsLink.pas' {FormEditDialogForCellDataIsLink},
  FrameCellDataIsLink in 'FrameCellDataIsLink.pas' {frCellDataIsLink: TFrame},
  FrameDataSetTextExporter in 'FrameDataSetTextExporter.pas' {frDataSetExporter: TFrame},
  FrameDataSetTextImporter in 'FrameDataSetTextImporter.pas' {frDataSetImporter: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MainDemo';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDropDownMemoEdit, DropDownMemoEdit);
  Application.CreateForm(TFormEditDialogForCellDataIsLink, FormEditDialogForCellDataIsLink);
  Application.Run;
end.
