{*******************************************************}
{                                                       }
{                       EhLib 7.0                       }
{              Design window for XXXXXXXXX              }
{                     (Build 7.0.01)                    }
{   Copyright (c) 2013-2013 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit EhLibDesignEditFavouriteComponents;

//{$I EhLib.Inc}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
{$IFDEF DESIGNTIME}
  DesignIntf, ToolsAPI,
  ComponentDesigner,
{$ENDIF}
  ToolCtrlsEh, Dialogs, ExtCtrls, Buttons, StdCtrls, CheckLst;

type
  TSelectComponentListFormEh = class(TForm)
    Label2: TLabel;
    bOk: TButton;
    bCancel: TButton;
    Bevel1: TBevel;
    clbComponentList: TCheckListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    FFavouriteSl: TStringList;
    FAllSl: TStringList;

    procedure Initialize;
    function Edit: Boolean;
  end;

var
  SelectComponentListFormEh: TSelectComponentListFormEh;

function SelectFavouriteComponentList(slFavourite, slAll: TStringList): Boolean;

function GetFavouriteComponentList(AClass: TClass; slFavourite: TStringList; DividePackages: Boolean): Boolean;
function SetFavouriteComponentList(AClass: TClass; slFavourite: TStringList): Boolean;

implementation

{$R *.dfm}

uses Registry, MemTableDesignEh, EhLibReg;

function GetFavouriteComponentList(AClass: TClass; slFavourite: TStringList; DividePackages: Boolean): Boolean;
var
  ClassName: String;
  rif: TRegIniFile;
  BaseRegKey: String;

  procedure DeleteObsoleteClasses(list: TStringList);
  var
    regList: TStringList;
    i: Integer;
  begin
    regList := TStringList.Create;
    GetComponentNamesEh(regList, AClass, False);
    for i := list.Count-1 downto 0 do
    begin
      if regList.IndexOf(list[i]) < 0 then
        list.Delete(i);
    end;
    regList.Free;
  end;

  procedure DivideClassesInPackages(list: TStringList);
  var
    regList: TStringList;
    i, k: Integer;
  begin
    regList := TStringList.Create;
    GetComponentNamesEh(regList, AClass, True);

    for i := regList.Count-1 downto 0 do
      if (regList[i] <> '-') and (list.IndexOf(regList[i]) < 0) then
        regList.Delete(i);

    while (regList.Count > 0) and (regList[regList.Count-1] = '-') do
      regList.Delete(regList.Count-1);

    k := -1;
    for i := regList.Count-1 downto 0 do
    begin
      if regList[i] = '-' then
      begin
        if k >= 0 then
          regList.Delete(k);
        k := i;
      end else
        k := -1;
    end;

    while (regList.Count > 0) and (regList[0] = '-') do
      regList.Delete(0);

    list.Assign(regList);
    regList.Free;
  end;

begin
  ClassName := AClass.ClassName;
  Result := False;
{$IFDEF DESIGNTIME}
  BaseRegKey := ActiveDesigner.Environment.GetBaseRegKey;
{$ELSE}
  BaseRegKey := 'Software\Borland\Delphi\7.0';
{$ENDIF}
  rif := TRegIniFile.Create(BaseRegKey + '\' + EhLibRegKey);
  try
    if rif.OpenKey('FavoriteComponentList\'+ClassName, False) then
    begin
      rif.GetValueNames(slFavourite);
      if DividePackages
        then DivideClassesInPackages(slFavourite)
        else DeleteObsoleteClasses(slFavourite);
      Result := True;
    end;
  finally
    rif.Free;
  end;
end;

function SetFavouriteComponentList(AClass: TClass; slFavourite: TStringList): Boolean;
var
  ClassName: String;
  rif: TRegIniFile;
  i: Integer;
  BaseRegKey: String;
begin
  ClassName := AClass.ClassName;
  Result := False;
{$IFDEF DESIGNTIME}
  BaseRegKey := ActiveDesigner.Environment.GetBaseRegKey;
{$ELSE}
  BaseRegKey := 'Software\Borland\Delphi\7.0';
{$ENDIF}
  rif := TRegIniFile.Create(BaseRegKey + '\' + EhLibRegKey + '\FavoriteComponentList');
  try
    rif.EraseSection(ClassName);
    if rif.OpenKey(ClassName, True) then
    begin
      for i := 0 to slFavourite.Count-1 do
        rif.WriteString('', slFavourite[i], '');
      Result := True;
    end;
  finally
    rif.Free;
  end;
end;

function SelectFavouriteComponentList(slFavourite, slAll: TStringList): Boolean;
var
  f: TSelectComponentListFormEh;
begin
  f := TSelectComponentListFormEh.Create(nil);
  try
    f.FFavouriteSl.Assign(slFavourite);
    f.FAllSl.Assign(slAll);
    Result := f.Edit;
    if Result then
    begin
      slFavourite.Assign(f.FFavouriteSl);
    end;
  finally
    f.Free;
  end;
end;

{ TSelectComponentListFormEh }

procedure TSelectComponentListFormEh.FormCreate(Sender: TObject);
begin
  FFavouriteSl := TStringList.Create;
  FAllSl := TStringList.Create;
end;

procedure TSelectComponentListFormEh.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FFavouriteSl);
  FreeAndNil(FAllSl);
end;

function TSelectComponentListFormEh.Edit: Boolean;
var
  i: Integer;
begin
  Initialize;
  if ShowModal = mrOK then
  begin
    Result := True;
    FFavouriteSl.Clear;
    for i := 0 to clbComponentList.Items.Count-1  do
    begin
      if clbComponentList.Checked[i] then
        FFavouriteSl.AddObject(clbComponentList.Items[i], clbComponentList.Items.Objects[i]);
    end;
  end else
    Result := False;
end;

procedure TSelectComponentListFormEh.Initialize;
var
  i: Integer;
begin
  clbComponentList.Items.Assign(FAllSl);
  for i := 0 to FAllSl.Count-1 do
    if FFavouriteSl.IndexOf(FAllSl[i]) >= 0 then
      clbComponentList.Checked[i] := True;
end;

end.
