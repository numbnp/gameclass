//////////////////////////////////////////////////////////////////////////////
//
// Модуль регистрации компонентов.
// Содержит процедуру регистрации и классы редакторов свойств.
//
//////////////////////////////////////////////////////////////////////////////

unit RegY2KControls;

interface

uses
  Classes,
  Dialogs,
  TypInfo,
  DesignIntf,
  DesignEditors;

type

  //
  // TFilenameProperty
  //

  TFilenameProperty = class(TStringProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
  end; // TFilenameProperty

procedure Register;

implementation

uses
  uY2KHTMLHelp,
  uY2KHelpLabel,
  uY2KSysInfo,
  uY2KSysInfoLabel,
  uY2KSysInfoButton,
  uY2KFileVersionInfo,
  uY2KFileVersionInfoLabel,
  uY2KTitledPanel,
  uY2KTitledLine,
  uY2KLinkLabel,
  uY2KLine,
  uY2KCheckedPanel,
  uY2KListBox,
  uY2KLinkImage,
  uY2KTreeView,
  uY2KLinkedPanel,
  uY2KNetTreeView;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TFilenameProperty


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// public methods

procedure TFilenameProperty.Edit();
var FileOpen: TOpenDialog;
begin
  FileOpen := TOpenDialog.Create(nil);
  FileOpen.Filename := GetValue;
  FileOpen.Options := FileOpen.Options + [ofShowHelp, ofPathMustExist,
    ofFileMustExist];
  try
    if FileOpen.Execute then SetValue(FileOpen.Filename);
  finally
    FileOpen.Free;
  end;
end; // TFilenameProperty.Edit()

function TFilenameProperty.GetAttributes(): TPropertyAttributes;
begin
  Result := [paDialog, paRevertable];
end; // TFilenameProperty.GetAttributes()


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// registration procedure

procedure Register;
begin
  RegisterComponents('Y2KControls', [TY2KLinkLabel]);
  RegisterComponents('Y2KControls', [TY2KSysInfo]);
  RegisterComponents('Y2KControls', [TY2KSysInfoLabel]);
  RegisterComponents('Y2KControls', [TY2KSysInfoButton]);
  RegisterComponents('Y2KControls', [TY2KHTMLHelp]);
  RegisterPropertyEditor(TypeInfo(string), TY2KHTMLHelp,
                        'HelpFileName', TFileNameProperty);
  RegisterComponents('Y2KControls', [TY2KHelpLabel]);
  RegisterComponents('Y2KControls', [TY2KFileVersionInfo]);
  RegisterPropertyEditor(TypeInfo(string), TY2KFileVersionInfo,
                        'ExeFile', TFileNameProperty);
  RegisterComponents('Y2KControls', [TY2KFileVersionInfoLabel]);
  RegisterComponents('Y2KControls', [TY2KLine]);
  RegisterComponents('Y2KControls', [TY2KTitledLine]);
  RegisterComponents('Y2KControls', [TY2KTitledPanel]);
  RegisterComponents('Y2KControls', [TY2KCheckedPanel]);
  RegisterComponents('Y2KControls', [TY2KListBox]);
  RegisterComponents('Y2KControls', [TY2KLinkImage]);
  RegisterComponents('Y2KControls', [TY2KTreeView]);
  RegisterComponents('Y2KControls', [TY2KLinkedPanel]);
  RegisterComponents('Y2KControls', [TY2KNetTreeView]);
end; // Register


end.
