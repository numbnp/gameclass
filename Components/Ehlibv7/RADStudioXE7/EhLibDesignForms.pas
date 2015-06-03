{*******************************************************}
{                                                       }
{                        EhLib v7.0                     }
{                                                       }
{          Design Time module for DropDown Forms        }
{                      Build 7.0.001                    }
{                                                       }
{      Copyright (c) 2013 by Dmitry V. Bolshakov        }
{                                                       }
{*******************************************************}

unit EhLibDesignForms;

{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolCtrlsEh, DynVarsEh, DropDownFormEh,
  DesignIntf, DesignEditors, ToolsAPI;

type

//  TCustomDropDownFormEhWizard = class(TIExpert)
  TCustomDropDownFormEhWizard = class(TNotifierObject, IOTAWizard,
    IOTAFormWizard, IOTARepositoryWizard, IOTANotifier,
{$IFDEF EH_LIB_10}IOTARepositoryWizard80, {$ENDIF}
    IOTACreator, IOTAModuleCreator)
  private
    FUnitIdent: String;
    FClassName: String;
    FFileName: String;
    FProj: IOTAProject;
  public
    { IOTAWizard }
    function GetIDString: string;
    function GetName: string;
    function GetState: TWizardState;
    procedure Execute;
//    procedure ImplExecute; virtual;

{$IFDEF EH_LIB_10}
    { IOTARepositoryWizard80 }
    function GetGalleryCategory: IOTAGalleryCategory;
    function GetPersonality: string;
    function GetDesigner: string;
{$ENDIF}

    { IOTAFormWizard }
    function GetAuthor: string;
    function GetComment: string;
    function GetPage: string;
    function GetGlyph: Cardinal;

    { IOTACreator }
    function GetCreatorType: string;
    function GetExisting: Boolean;
    function GetFileSystem: string;
    function GetOwner: IOTAModule;
    function GetUnnamed: Boolean;

    { IOTAModuleCreator }
    function GetAncestorName: string;
    function GetImplFileName: string;
    function GetIntfFileName: string;
    function GetFormName: string;
    function GetMainForm: Boolean;
    function GetShowForm: Boolean;
    function GetShowSource: Boolean;
    function NewFormFile(const FormIdent, AncestorIdent: string): IOTAFile;
    function NewImplSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    function NewIntfSource(const ModuleIdent, FormIdent, AncestorIdent: string): IOTAFile;
    procedure FormCreated(const FormEditor: IOTAFormEditor);


//    function GetStyle: TExpertStyle; override;
//    function GetAuthor: string; override;
//    function GetComment: string; override;
//    function GetPage: string; override;
//    function GetGlyph: HICON; override;
//    function GetMenuText: string; override;
  end;

{ TCustomDropDownFormEhEditor }

  TCustomDropDownFormEhEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;

{ TUnitFile }

  TUnitFile = class(TInterfacedObject, IOTAFile)
  private
    FModuleName: string;
    FFormName: string;
    FAncestorName: string;
  protected
    function GetSource: string;
    function GetAge: TDateTime;
  public
    constructor Create(const ModuleName, FormName, AncestorName: string);
  end;

{ TFormFile }

  TFormFile = class(TInterfacedObject, IOTAFile)
  private
    FModuleName: string;
    FFormName: string;
    FAncestorName: string;
  protected
    function GetSource: string;
    function GetAge: TDateTime;
  public
    constructor Create(const ModuleName, FormName, AncestorName: string);
  end;

{ TProjectFormClassNames }

type
  TProjectFormClassNames = class(TStringProperty)
  public
    function GetAttributes: TPropertyAttributes; override;
    procedure GetValueList(List: TStrings); virtual;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

procedure Register;

implementation

const
  nl = #13#10;

procedure Register;
begin
  RegisterCustomModule(TCustomDropDownFormEh, TCustomModule);
  RegisterPackageWizard(TCustomDropDownFormEhWizard.Create);
  RegisterSelectionEditor(TCustomDropDownFormEh, TCustomDropDownFormEhEditor);
  RegisterPropertyEditor(TypeInfo(string), TDropDownFormCallParamsEh, 'DropDownFormClassName', TProjectFormClassNames);

  UnlistPublishedProperty(TCustomDropDownFormEh, 'BorderIcons');

  UnlistPublishedProperty(TCustomDropDownFormEh, 'BorderStyle');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'BorderWidth');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'UseDockManager');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'DefaultMonitor');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'DockSite');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'DragKind');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'DragMode');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'FormStyle');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'Position');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'ScreenSnap');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'SnapBuffer');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'Visible');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'WindowState');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'WindowMenu');

  UnlistPublishedProperty(TCustomDropDownFormEh, 'OnDockDrop');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'OnDockOver');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'OnDragDrop');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'OnDragOver');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'OnEndDock');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'OnGetSiteInfo');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'OnStartDock');
  UnlistPublishedProperty(TCustomDropDownFormEh, 'OnUnDock');

//  RegisterLibraryExpert(TCustomDropDownFormEhWizard.Create);
end;

function GetCurrentProject: IOTAProject;
var
  LServices: IOTAModuleServices;
  LModule: IOTAModule;
  LProject: IOTAProject;
  LProjectGroup: IOTAProjectGroup;
  LMultipleProjects: Boolean;
  i: Integer;
begin
  Result := nil;
  LMultipleProjects := False;
  LServices := BorlandIDEServices as IOTAModuleServices;
  for i := 0 to LServices.ModuleCount - 1 do
  begin
    LModule := LServices.Modules[I];
    if LModule.QueryInterface(IOTAProjectGroup, LProjectGroup) = S_OK then
    begin
      Result := LProjectGroup.ActiveProject;
      Exit;
    end
    else if LModule.QueryInterface(IOTAProject, LProject) = S_OK then
    begin
      if Result = nil then
        Result := LProject
      else
      begin
        LMultipleProjects := True;
      end;
    end;
  end;
  if LMultipleProjects then
    Result := nil;
end;

function GetActiveProjectGroup: IOTAProjectGroup;
var
  ModuleServices: IOTAModuleServices;
  i: Integer;
begin
  Result := nil;
  if Assigned(BorlandIDEServices) then
  begin
    ModuleServices := BorlandIDEServices as IOTAModuleServices;
    for i := 0 to ModuleServices.ModuleCount - 1 do
      if Supports(ModuleServices.Modules[i], IOTAProjectGroup, Result) then
        Break;
  end;
end;

function ProjectExists(const AProjectGroup:IOTAProjectGroup; AProject:string):boolean;
var
  I: Integer;
begin
  Result := false;
  for I := 0 to AProjectGroup.ProjectCount-1 do
  begin
    if UpperCase(ChangeFileExt(ExtractFileName(AProjectGroup.Projects[I].FileName),''))=UpperCase(AProject) then
    begin
      Result := true;
      Exit;
    end;
  end;
end;

function FindNewProjectName(const AProjectGroup:IOTAProjectGroup):string;
var
  A: Integer;
begin
  A := 1;
  if Assigned(AProjectGroup) then
  begin
    while ProjectExists(AProjectGroup, Format('Project%d',[a])) do
      Inc(a);
  end;
  Result := Format('Project%d',[A]);
end;

{ TPropStorageEhSelectionEditor }

procedure TCustomDropDownFormEhEditor.RequiresUnits(Proc: TGetStrProc);
begin
   inherited RequiresUnits(Proc);
   Proc('DropDownFormEh');
end;

{ TCustomDropDownFormEhWizard }

procedure TCustomDropDownFormEhWizard.Execute;
begin
  {$IFDEF EH_LIB_10}
  (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName('', FUnitIdent, FClassName, FFileName);
  FClassName := 'TDropDownForm' + Copy(FUnitIdent, 5, Length(FUnitIdent));
  {$ELSE}
  (BorlandIDEServices as IOTAModuleServices).GetNewModuleAndClassName('TDropDownForm', FUnitIdent, FClassName, FFileName);
  {$ENDIF}
//  ShowMessage(FUnitIdent+':'+FClassName+':'+FFileName);
  //(BorlandIDEServices as IOTAModuleServices).CreateModule(Self);
  FProj := GetCurrentProject;
  if FProj <> nil then
  begin
//    (BorlandIDEServices as IOTAModuleServices).CreateModule(TATBUnitCreator.Create(LProj, FUnitIdent, FClassName, FFileName));
    (BorlandIDEServices as IOTAModuleServices).CreateModule(Self);
  end;
  FProj := nil;
end;

function TCustomDropDownFormEhWizard.GetAuthor: string;
begin
  Result := 'EhLib Team';
end;

function TCustomDropDownFormEhWizard.GetComment: string;
begin
  Result := 'Creates a new DropDown Form.'
end;

function TCustomDropDownFormEhWizard.GetGlyph: Cardinal;
begin
  Result := 0;  // use standard icon
end;

function TCustomDropDownFormEhWizard.GetIDString: string;
begin
  Result := 'EhLib.DropDownFormWizard';
end;

function TCustomDropDownFormEhWizard.GetName: string;
begin
  Result := 'DropDown Form';
end;

function TCustomDropDownFormEhWizard.GetPage: string;
begin
  Result := 'EhLib Forms';
end;

function TCustomDropDownFormEhWizard.GetState: TWizardState;
begin
  Result := [wsEnabled];
end;

{ IOTACreator }

function TCustomDropDownFormEhWizard.GetCreatorType: string;
begin
  Result := sForm;
end;

function TCustomDropDownFormEhWizard.GetExisting: Boolean;
begin
  Result := False;
end;

function TCustomDropDownFormEhWizard.GetFileSystem: string;
begin
  Result := '';
end;

function TCustomDropDownFormEhWizard.GetUnnamed: Boolean;
begin
  Result := True;
end;

function TCustomDropDownFormEhWizard.GetOwner: IOTAModule;
begin
  Result := FProj;
end;

{ IOTAModuleCreator }

procedure TCustomDropDownFormEhWizard.FormCreated(const FormEditor: IOTAFormEditor);
begin

end;

function TCustomDropDownFormEhWizard.GetAncestorName: string;
begin
  Result := 'CustomDropDownFormEh';
end;

function TCustomDropDownFormEhWizard.GetFormName: string;
begin
  Result := FClassName;
  if (Length(Result) > 0) and (Result[1] = 'T') then
    Result := Copy(Result, 2, Length(Result));
end;

function TCustomDropDownFormEhWizard.GetImplFileName: string;
var
  LPath: string;
begin
  LPath := ExtractFileDir(FProj.FileName);
//  Result := IncludeTrailingPathDelimiter(LPath) + 'DropDownFormUnit.pas';
  Result := FFileName;
end;

function TCustomDropDownFormEhWizard.GetIntfFileName: string;
begin
  Result := '';
end;

function TCustomDropDownFormEhWizard.GetMainForm: Boolean;
begin
  Result := False;
end;

function TCustomDropDownFormEhWizard.GetShowForm: Boolean;
begin
  Result := True;
end;

function TCustomDropDownFormEhWizard.GetShowSource: Boolean;
begin
  Result := True;
end;

function TCustomDropDownFormEhWizard.NewFormFile(const FormIdent,
  AncestorIdent: string): IOTAFile;
begin
//  Result := nil;
  Result := TFormFile.Create('', FormIdent, AncestorIdent);
end;

function TCustomDropDownFormEhWizard.NewImplSource(const ModuleIdent,
  FormIdent, AncestorIdent: string): IOTAFile;
begin
//  Result := nil;
  Result := TUnitFile.Create(ModuleIdent, FormIdent, AncestorIdent);
end;

function TCustomDropDownFormEhWizard.NewIntfSource(const ModuleIdent,
  FormIdent, AncestorIdent: string): IOTAFile;
begin
  Result := nil;
end;

{$IFDEF EH_LIB_10}
{ IOTARepositoryWizard80 }

function TCustomDropDownFormEhWizard.GetGalleryCategory: IOTAGalleryCategory;
begin
  Result := nil;
end;

function TCustomDropDownFormEhWizard.GetPersonality: string;
begin
  Result := sDelphiPersonality;
end;

function TCustomDropDownFormEhWizard.GetDesigner: string;
begin
  Result := dVCL;
end;
{$ENDIF}

{ TFormFile }
constructor TFormFile.Create(const ModuleName, FormName, AncestorName: string);
begin
  inherited Create;
  FModuleName := ModuleName;
  FFormName := FormName;
  FAncestorName := AncestorName;
end;

function TFormFile.GetSource: string;
const
  FormText =
  'object %0:s: T%0:s'+nl+
  '    Caption = ''%0:s'''+nl+
  'end';
begin
  Result := Format(FormText, [FFormName]);
end;

function TFormFile.GetAge: TDateTime;
begin
  Result := -1;
end;

{ TUnitFile }

constructor TUnitFile.Create(const ModuleName, FormName, AncestorName: string);
begin
  inherited Create;
  FModuleName := ModuleName;
  FFormName := FormName;
  FAncestorName := AncestorName;
end;

function TUnitFile.GetAge: TDateTime;
begin
  Result := -1;
end;

function TUnitFile.GetSource: string;
begin
  Result := Format(
    'unit %0:s;'+nl+
    ''+nl+
    'interface'+nl+
    ''+nl+
    'uses'+nl+
    '  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,'+nl+
    '  DropDownFormEh, Dialogs, DynVarsEh, ToolCtrlsEh;'+nl+
    ''+nl+
    'type'+nl+
    '  T%1:s = class(TCustomDropDownFormEh)'+nl+
    '  private'+nl+
    '    { Private declarations }'+nl+
    '  public'+nl+
    '    { Public declarations }'+nl+
    '  end;'+nl+
    ''+nl+
    'var'+nl+
    '  %1:s: T%1:s;'+nl+
    ''+nl+
    'implementation'+nl+
    ''+nl+
    '{$R *.dfm}'+nl+
    ''+nl+
    'end.'
  , [FModuleName, FFormName]);
end;

{ TProjectFormClassNames }

function TProjectFormClassNames.GetAttributes: TPropertyAttributes;
begin
  Result := [paValueList, paSortList, paMultiSelect];
end;

procedure TProjectFormClassNames.GetValueList(List: TStrings);
var
  i: Integer;
  Prj: IOTAProject;
  Module: IOTAModuleInfo;
//  AClass: TClass;
  ClassName: String;
begin
  Prj := GetActiveProject;
  if Prj = nil then Exit;

  for i := 0 to Prj.GetModuleCount-1 do
  begin
    Module := Prj.GetModule(i);
    if Module.FormName <> '' then
    begin
      ClassName := 'T'+Module.FormName;
      List.Add(ClassName);
    end;
  end;
end;

procedure TProjectFormClassNames.GetValues(Proc: TGetStrProc);
var
  I: Integer;
  Values: TStringList;
begin
  Values := TStringList.Create;
  try
    GetValueList(Values);
    for I := 0 to Values.Count - 1 do Proc(Values[I]);
  finally
    Values.Free;
  end;
end;

end.
