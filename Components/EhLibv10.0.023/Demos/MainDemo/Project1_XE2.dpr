program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FrameMainGrid in 'FrameMainGrid.pas' {frMainGrid: TFrame},
  FrameMasterDetail in 'FrameMasterDetail.pas' {frMasterDetail: TFrame},
  FormAbout in 'FormAbout.pas' {fAbout},
  FrameMailBox in 'FrameMailBox.pas' {frMailBox: TFrame},
  FrameFishFact in 'FrameFishFact.pas' {frFishFact: TFrame},
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
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'MainDemo';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
