program Project1_XE10;

uses
  Vcl.Forms,
  AppLangConsts in 'AppLangConsts.pas',
  DDFVendorsUnit in 'DDFVendorsUnit.pas' {DDFVendors: TCustomDropDownFormEh},
  EditVendorUnit in 'EditVendorUnit.pas' {fEditVendor},
  FormAbout in 'FormAbout.pas' {fAbout},
  FrameBackgroundImages in 'FrameBackgroundImages.pas' {frBackgroundImages: TFrame},
  FrameCellDataIsLink in 'FrameCellDataIsLink.pas' {frCellDataIsLink: TFrame},
  FrameDataGrouping in 'FrameDataGrouping.pas' {frDataGrouping: TFrame},
  FrameDataSetTextExporter in 'FrameDataSetTextExporter.pas' {frDataSetExporter: TFrame},
  FrameDataSetTextImporter in 'FrameDataSetTextImporter.pas' {frDataSetImporter: TFrame},
  FrameDropDownForms in 'FrameDropDownForms.pas' {frFrameDropDownForms: TFrame},
  FrameEditControls in 'FrameEditControls.pas' {frEditControls: TFrame},
  FrameEditControls2 in 'FrameEditControls2.pas' {frEditControls2: TFrame},
  FrameFishFact in 'FrameFishFact.pas' {frFishFact: TFrame},
  FrameImportExport in 'FrameImportExport.pas' {frImportExport: TFrame},
  FrameLiveRestructure in 'FrameLiveRestructure.pas' {frLiveRestructure: TFrame},
  FrameMailBox in 'FrameMailBox.pas' {frMailBox: TFrame},
  FrameMainGrid in 'FrameMainGrid.pas' {frMainGrid: TFrame},
  FrameMasterDetail in 'FrameMasterDetail.pas' {frMasterDetail: TFrame},
  FrameMemTableSaveLoad in 'FrameMemTableSaveLoad.pas' {frMemTableSaveLoad: TFrame},
  FramePivotGrid in 'FramePivotGrid.pas' {frPivotGrid: TFrame},
  FramePlanner in 'FramePlanner.pas' {frPlanner: TFrame},
  FrameRowAsPanel in 'FrameRowAsPanel.pas' {frRowAsPanel: TFrame},
  FrameRowDetailPanel in 'FrameRowDetailPanel.pas' {frRowDetailPanel: TFrame},
  FrameSearchPanel in 'FrameSearchPanel.pas' {frSearchPanel: TFrame},
  FrameTreeView in 'FrameTreeView.pas' {frTreeView: TFrame},
  FrameVertGrid in 'FrameVertGrid.pas' {frVertGrid: TFrame},
  FrameWorkingWithHugeData in 'FrameWorkingWithHugeData.pas' {frWorkingWithHugeData: TFrame},
  MemoEditUnit in 'MemoEditUnit.pas' {DropDownMemoEdit: TCustomDropDownFormEh},
  Unit1 in 'Unit1.pas' {Form1},
  UnitEditDialogForCellDataIsLink in 'UnitEditDialogForCellDataIsLink.pas' {FormEditDialogForCellDataIsLink},
  UnitTmpForm in 'UnitTmpForm.pas' {TmpForm},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Amakrits');
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDropDownMemoEdit, DropDownMemoEdit);
  Application.CreateForm(TFormEditDialogForCellDataIsLink, FormEditDialogForCellDataIsLink);
  Application.Run;
end.
