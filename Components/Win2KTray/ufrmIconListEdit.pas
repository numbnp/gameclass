//////////////////////////////////////////////////////////////////////////////
//
// TIconListProperty - класс-редактор свойств типа TIconList.
//
// TfrmIconListEdit - диалог редактирования свойств типа TIconList.
// Позволяет визуально добавлять иконки в список, удалять иконки
// и очищать список.
//
//////////////////////////////////////////////////////////////////////////////

unit ufrmIconListEdit;

interface

uses
  // system units
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  StdCtrls,
  ComCtrls,
  ImgList,
  DesignIntf,
  DesignEditors,
  // project units
  uIconList;


type

  //
  // TfrmIconListEdit
  //

  TfrmIconListEdit = class(TForm)
    btnOk: TButton;
    lvIconList: TListView;
    sbarIconListEdit: TStatusBar;
    btnAddIcon: TButton;
    btnRemoveIcon: TButton;
    imglstIcons: TImageList;
    btnClear: TButton;
    btnCancel: TButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnAddIconClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnRemoveIconClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    
  private
    // fields
    FIcons: TIconList;
    FbModified: Boolean;

    // events handlers
    procedure _ListChanged(Sender: TObject);

    // private helper methods
    procedure _LoadIconFile(const AstrIconFileName: String);
    procedure _RemoveIcon(const AnIconIndex: Integer);
    procedure _ShowInfoInStatusBar(const AstrInfo: String);

  public
    // properties
    property Icons: TIconList read FIcons write FIcons;
    property Modified: Boolean read FbModified write FbModified;

  end; // TfrmIconListEdit


  //
  // TIconListProperty
  //

  TIconListProperty = class(TClassProperty)
  public
    function GetValue(): string; override;
    procedure SetValue(const Value: string); override;
    procedure Edit(); override;
    function GetAttributes(): TPropertyAttributes; override;
  end; // TIconListProperty


implementation

uses
  TypInfo;


{$R *.dfm}

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TIconListProperty

procedure TIconListProperty.Edit();
var
  Editor: TfrmIconListEdit;
  Component: TPersistent;
  nRes: Integer;
begin
  Editor := TfrmIconListEdit.Create(nil);
  try
    Component := GetComponent(0);
    if Component is TComponent then begin
      Editor.Caption := TComponent(Component).Name + '.' + GetName();
    end;
    Editor.Icons.Assign(TIconList(Pointer(GetOrdValue)));
    Editor.Modified := FALSE;
    nRes := Editor.ShowModal();
    if (nRes = mrOk) and Editor.Modified then begin
      TIconList(Pointer(GetOrdValue)).Assign(Editor.Icons);
      Designer.Modified();
    end;
  finally
    FreeAndNil(Editor);
  end;
end; // TIconListProperty.Edit


function TIconListProperty.GetAttributes(): TPropertyAttributes;
begin
  Result := [paDialog];
end; // TIconListProperty.GetAttributes


function TIconListProperty.GetValue(): string;
var
  List: TIconList;
begin
  List := TIconList(Pointer(GetOrdValue));
  if (List = nil) or (List.Count = 0) then begin
    Result := '(None)'
  end else begin
    Result := '(' + List.ClassName + ')';
  end;
end; // TIconListProperty.GetValue


procedure TIconListProperty.SetValue(const Value: string);
begin
  if Value = '' then begin
    SetOrdValue(0);
  end;
end; // TIconListProperty.SetValue


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// TfrmIconListEdit

const
  SBAR_TEXT = 'Icon count: %d';


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// events handlers

procedure TfrmIconListEdit.FormCreate(Sender: TObject);
begin
  FIcons := TIconList.Create();
  FIcons.OnChange := _ListChanged;
end; // TfrmIconListEdit.FormCreate


procedure TfrmIconListEdit.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FIcons);
end; // TfrmIconListEdit.FormDestroy


procedure TfrmIconListEdit.btnOkClick(Sender: TObject);
begin
  ModalResult := mrOk;
end; // TfrmIconListEdit.btnCloseClick


procedure TfrmIconListEdit.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end; // TfrmIconListEdit.btnCancelClick


procedure TfrmIconListEdit.btnAddIconClick(Sender: TObject);
const
  OPEN_DIALOG_FILTER = 'Ico files(*.ico)|*.ico';
  OPEN_DIALOG_DEF_EXTENSION = '*.ico';
var
  dlgOpen: TOpenDialog;
begin
  dlgOpen := TOpenDialog.Create(Self);
  try
    dlgOpen.Filter := OPEN_DIALOG_FILTER;
    dlgOpen.DefaultExt := OPEN_DIALOG_DEF_EXTENSION;
    if dlgOpen.Execute() then begin
      _LoadIconFile(dlgOpen.FileName);
    end;
  finally
    FreeAndNil(dlgOpen);
  end;
end; // TfrmIconListEdit.btnAddIconClick


procedure TfrmIconListEdit.btnRemoveIconClick(Sender: TObject);
begin
  if Assigned(lvIconList.Selected) then begin
    _RemoveIcon(StrToInt(lvIconList.Selected.Caption));
  end;
end; // TfrmIconListEdit.btnRemoveIconClick


procedure TfrmIconListEdit.btnClearClick(Sender: TObject);
begin
  FIcons.Clear();
end; // TfrmIconListEdit.btnClearClick


procedure TfrmIconListEdit._ListChanged(Sender: TObject);
var
  i: Integer;
begin
  lvIconList.Clear();
  imglstIcons.Clear();
  for i := 0 to FIcons.Count - 1 do begin
    imglstIcons.AddIcon(FIcons[i]);
    with lvIconList.Items.Add() do begin
      ImageIndex := i;
      Caption := IntToStr(i);
    end;
  end;
  _ShowInfoInStatusBar(Format(SBAR_TEXT, [FIcons.Count]));
  Modified := TRUE;
end; // TfrmIconListEdit._ListChanged


//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// private helper methods

procedure TfrmIconListEdit._ShowInfoInStatusBar(const AstrInfo: String);
begin
  sbarIconListEdit.SimpleText := AstrInfo;
end; // TfrmIconListEdit._ShowInfoInStatusBar


procedure TfrmIconListEdit._LoadIconFile(const AstrIconFileName: String);
var
  Icon: TIcon;
begin
  Icon := TIcon.Create();
  try
    Icon.LoadFromFile(AstrIconFileName);
    FIcons.Add(Icon);
  finally
    FreeAndNil(Icon);
  end;
end; // TfrmIconListEdit._LoadIconFile


procedure TfrmIconListEdit._RemoveIcon(const AnIconIndex: Integer);
begin
  ASSERT((0 <= AnIconIndex) and (AnIconIndex < FIcons.Count));

  FIcons.Delete(AnIconIndex);

end; // TfrmIconListEdit._RemoveIcon


end.


