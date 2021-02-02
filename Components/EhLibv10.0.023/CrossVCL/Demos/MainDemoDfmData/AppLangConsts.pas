unit AppLangConsts;

interface

{$I EhLib.Inc}

{$DEFINE EMBEDDED_LANGUAGE_RESOURCES}

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, StdCtrls;

type
{ TApplicationLanguageConsts }

  TApplicationLanguageConsts = class(TComponent)
  private
    FCaption: String;
    FMenuLanguage: String;
    FMenuFile: String;
    FMenuExit: String;
    FMenuAbout: String;
    FAboutWin_AboutInfo: String;
    FAboutWin_EMail: String;
    FAboutWin_Forum: String;
    FAboutWin_TechnicalSupport: String;
    FAboutWin_Close: String;
    FVCLStyle: string;
    FVertMenuMainGrid: string;
    FVertMenuBackgroundImages: string;
    FVertMenuRowAsPanel: string;
    FVertMenuPlanner: string;
    FVertMenuMailBox: string;
    FVertMenuMasterDetail: string;
    FVertMenuDropDownForms: string;
    FVertMenuTreeView: string;
    FVertMenuEditConrols2: string;
    FVertMenuRowDetailPanel: string;
    FVertMenuWorkingWithHugeData: string;
    FVertMenuImportFromTextFile: string;
    FVertMenuEditControls: string;
    FVertMenuFishFact: string;
    FVertMenuDataSet: string;
    FVertMenuCellDataIsLink: string;
    FVertMenuLiveRestructure: string;
    FVertMenuVerticalGrid: string;
    FVertMenuPivotGrid: string;
    FVertMenuSaveLoadData: string;
    FVertMenuImportExport: string;
    FVertMenuSearchPanel: string;
    FVertMenuExportToTextFile: string;
    FVertMenuMemTableEh: string;
    FVertMenuDataGrouping: string;
    FStatusBarInfo: String;
    FDBGridEh1PartDesc: String;
    FDBGridEh1VendorName: String;
    FDBGridEh1PartCost: String;
    FDBGridEh1PartNo: String;
    FDBGridEh1Preferred: String;
    FDBGridEh1PartQty: String;
    FDBGridEh1VendorNumber: String;
    FDBGridEh1Sum: String;
    procedure SetCaption(const Value: String);

  public
    constructor Create(AOwner: TComponent); override;

  published
    property Caption: String read FCaption write SetCaption; //'Demonstration program'
    property StatusBarInfo: String read FStatusBarInfo write FStatusBarInfo; //'EhLib Main Demo. Shows All Major Features and Functions of the Library'
    property MenuFile: String read FMenuFile write FMenuFile; //'File'
    property MenuLanguage: String read FMenuLanguage write FMenuLanguage; //'Language'
    property MenuExit: String read FMenuExit write FMenuExit; //'Exit'
    property MenuAbout: String read FMenuAbout write FMenuAbout; //'MenuAbout'
    property VCLStyle: string read FVCLStyle write FVCLStyle;

    property VertMenuMainGrid: string read FVertMenuMainGrid write FVertMenuMainGrid;//Main Grid
    property VertMenuMasterDetail: string read FVertMenuMasterDetail write FVertMenuMasterDetail;//Master Detail
    property VertMenuEditControls: string read FVertMenuEditControls write FVertMenuEditControls;//Edit Controls
    property VertMenuEditConrols2: string read FVertMenuEditConrols2 write FVertMenuEditConrols2;//Edit Conrols2
    property VertMenuFishFact: string read FVertMenuFishFact write FVertMenuFishFact;//Fish Fact
    property VertMenuVerticalGrid: string read FVertMenuVerticalGrid write FVertMenuVerticalGrid;//Vertical Grid
    property VertMenuCellDataIsLink: string read FVertMenuCellDataIsLink write FVertMenuCellDataIsLink;//Cell Data Is Link
    property VertMenuDropDownForms: string read FVertMenuDropDownForms write FVertMenuDropDownForms;//DropDown Forms
    property VertMenuRowDetailPanel: string read FVertMenuRowDetailPanel write FVertMenuRowDetailPanel;//Row Detail Panel
    property VertMenuRowAsPanel: string read FVertMenuRowAsPanel write FVertMenuRowAsPanel;//Row As Panel
    property VertMenuTreeView: string read FVertMenuTreeView write FVertMenuTreeView;//Tree View
    property VertMenuDataGrouping: string read FVertMenuDataGrouping write FVertMenuDataGrouping;//Data Grouping
    property VertMenuBackgroundImages: string read FVertMenuBackgroundImages write FVertMenuBackgroundImages;//Background Images
    property VertMenuSearchPanel: string read FVertMenuSearchPanel write FVertMenuSearchPanel;//Search Panel
    property VertMenuMailBox: string read FVertMenuMailBox write FVertMenuMailBox;//Mail Box
    property VertMenuImportExport: string read FVertMenuImportExport write FVertMenuImportExport;//Import/Export
    property VertMenuMemTableEh: string read FVertMenuMemTableEh write FVertMenuMemTableEh;//MemTableEh
    property VertMenuSaveLoadData: string read FVertMenuSaveLoadData write FVertMenuSaveLoadData;//Save/Load Data
    property VertMenuLiveRestructure: string read FVertMenuLiveRestructure write FVertMenuLiveRestructure;//Live restructure
    property VertMenuWorkingWithHugeData: string read FVertMenuWorkingWithHugeData write FVertMenuWorkingWithHugeData;//Working with huge data
    property VertMenuPivotGrid: string read FVertMenuPivotGrid write FVertMenuPivotGrid;//PivotGrid
    property VertMenuPlanner: string read FVertMenuPlanner write FVertMenuPlanner;//Planner
    property VertMenuDataSet: string read FVertMenuDataSet write FVertMenuDataSet;//DataSet
    property VertMenuExportToTextFile: string read FVertMenuExportToTextFile write FVertMenuExportToTextFile;//Export to DataSet Text File
    property VertMenuImportFromTextFile: string read FVertMenuImportFromTextFile write FVertMenuImportFromTextFile;//Import from Text File

    property DBGridEh1VendorNumber: String read FDBGridEh1VendorNumber write FDBGridEh1VendorNumber;//Vendor of parts|Vendor Number|1
    property DBGridEh1VendorName: String read FDBGridEh1VendorName write FDBGridEh1VendorName;//Vendor of parts|Vendor Name|2
    property DBGridEh1PartNo: String read FDBGridEh1PartNo write FDBGridEh1PartNo;//Parts|PN|3
    property DBGridEh1PartDesc: String read FDBGridEh1PartDesc write FDBGridEh1PartDesc;//Parts|Description|4
    property DBGridEh1PartCost: String read FDBGridEh1PartCost write FDBGridEh1PartCost;//Parts|Cost|5
    property DBGridEh1PartQty: String read FDBGridEh1PartQty write FDBGridEh1PartQty;//Items|Qry|6
    property DBGridEh1Preferred: String read FDBGridEh1Preferred write FDBGridEh1Preferred;//Preferred
    property DBGridEh1Sum: String read FDBGridEh1Sum write FDBGridEh1Sum;//Sum

    property AboutWin_AboutInfo: String read FAboutWin_AboutInfo write FAboutWin_AboutInfo;
    property AboutWin_TechnicalSupport: String read FAboutWin_TechnicalSupport write FAboutWin_TechnicalSupport;
    property AboutWin_EMail: String read FAboutWin_EMail write FAboutWin_EMail;
    property AboutWin_Forum: String read FAboutWin_Forum write FAboutWin_Forum;
    property AboutWin_Close: String read FAboutWin_Close write FAboutWin_Close;
  end;

function ApplicationLanguageConsts: TApplicationLanguageConsts;

implementation

uses LanguageResManEh;

{$R AppLangConsts.dfm}

{$IFDEF EMBEDDED_LANGUAGE_RESOURCES}
  {$IFDEF EH_LIB_12}
    {$R Res\AppLangConsts.BGR.dfm}
    {$R Res\AppLangConsts.CHS.dfm}
    {$R Res\AppLangConsts.CSY.dfm}
    {$R Res\AppLangConsts.DEU.dfm}
    {$R Res\AppLangConsts.ENU.dfm}
    {$R Res\AppLangConsts.ESP.dfm}
    {$R Res\AppLangConsts.FAR.dfm}
    {$R Res\AppLangConsts.FRA.dfm}
    {$R Res\AppLangConsts.JPN.dfm}
    {$R Res\AppLangConsts.KOR.dfm}
    {$R Res\AppLangConsts.PLK.dfm}
    {$R Res\AppLangConsts.PTB.dfm}
    {$R Res\AppLangConsts.RUS.dfm}
    {$R Res\AppLangConsts.SKY.dfm}
    {$R Res\AppLangConsts.TRK.dfm}
    {$R Res\AppLangConsts.UKR.dfm}
  {$ELSE}
    {$R Res.Ansi\AppLangConsts.ENU.dfm}
    {$R Res.Ansi\AppLangConsts.FRA.dfm}
    {$R Res.Ansi\AppLangConsts.RUS.dfm}
    {$R Res.Ansi\AppLangConsts.UKR.dfm}
  {$ENDIF}
{$ENDIF}

var
  FApplicationLanguageConsts: TApplicationLanguageConsts;

procedure InitUnit;
begin
  FApplicationLanguageConsts := TApplicationLanguageConsts.Create(nil);
  LanguageResourceManagerEh.AddLocalizableObject(FApplicationLanguageConsts, FApplicationLanguageConsts.ClassName, 'AppLangConsts', 'ENU');
end;

procedure FinalizeUnit;
begin
  LanguageResourceManagerEh.DeleteLocalizableObject(FApplicationLanguageConsts);
  FreeAndNil(FApplicationLanguageConsts);
end;

function ApplicationLanguageConsts: TApplicationLanguageConsts;
begin
  Result := FApplicationLanguageConsts;
end;

{ TApplicationLanguageConsts }

constructor TApplicationLanguageConsts.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  InitInheritedComponent(Self, TCustomControl);
end;

procedure TApplicationLanguageConsts.SetCaption(const Value: String);
begin
  FCaption := Value;
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.
