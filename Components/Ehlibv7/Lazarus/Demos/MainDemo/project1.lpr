program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, Unit1, FormAbout, FrameMainGrid, FrameMasterDetail, FrameDropDownForms,
  FrameVertGrid, FrameRowDetailPanel, FrameBackgroundImages, FrameDataGrouping,
  FrameEditControls, FrameFishFact, FrameImportExport, FrameLiveRestructure,
  FrameMailBox, FrameMemTableSaveLoad, FrameRowAsPanel, FrameSearchPanel,
  FrameTreeView, FrameWorkingWithHugeData, MemoEditUnit;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

