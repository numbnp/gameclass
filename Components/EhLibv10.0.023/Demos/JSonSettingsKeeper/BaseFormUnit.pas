unit BaseFormUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, IniFiles,
  System.UITypes, SettingsKeepersEh,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TBaseForm = class(TForm)
  private
    procedure ReadBoundsSettings(BoundsSets: TSettingsKeeperEh);
  protected
    procedure DoCreate; override;

    procedure ReadSettings(Keeper: TSettingsKeeperEh); virtual;
    procedure WriteSettings(Keeper: TSettingsKeeperEh); virtual;
    function GetSeettingID: String; virtual;
  public
    destructor Destroy; override;
  end;

var
  BaseForm: TBaseForm;

implementation

{$R *.dfm}

{ TBaseForm }

procedure TBaseForm.DoCreate;
var
  IniFile: TIniFile;
  FormSettingsStr: String;
  FileName: String;
  SetKeeper: TSettingsKeeperEh;
begin
  inherited DoCreate;

  FileName := Copy(ParamStr(0), 1, Length(ParamStr(0))-4) + '.Ini';
  IniFile := TIniFile.Create(FileName);
  FormSettingsStr := IniFile.ReadString('FormSettings', GetSeettingID, '');
  IniFile.Free;

  SetKeeper := TSettingsKeeperEh.Create;
  JSONStringToSettingsKeeper(SetKeeper, FormSettingsStr);

  ReadSettings(SetKeeper);
  SetKeeper.Free;
end;

destructor TBaseForm.Destroy;
var
  IniFile: TIniFile;
  FormSettingsStr: String;
  FileName: String;
  SetKeeper: TSettingsKeeperEh;
begin
  FileName := Copy(ParamStr(0), 1, Length(ParamStr(0))-4) + '.Ini';
  IniFile := TIniFile.Create(FileName);

  SetKeeper := TSettingsKeeperEh.Create;
  WriteSettings(SetKeeper);
  FormSettingsStr := SettingsKeeperToJSONString(SetKeeper);
  IniFile.WriteString('FormSettings', GetSeettingID, FormSettingsStr);
  IniFile.Free;
  SetKeeper.Free;

  inherited Destroy;
end;

function TBaseForm.GetSeettingID: String;
begin
  Result := ClassName;
end;

procedure TBaseForm.ReadSettings(Keeper: TSettingsKeeperEh);
var
  BoundsSets: TSettingsKeeperEh;
begin
  if Keeper.TryGetSubsettingsValue('Bounds', BoundsSets) then
  begin
    ReadBoundsSettings(BoundsSets);
  end;
end;

procedure TBaseForm.ReadBoundsSettings(BoundsSets: TSettingsKeeperEh);
var
  IntValue: Integer;
begin
  if BoundsSets.TryGetIntegerValue('Left', IntValue) then
    Self.Left := IntValue;
  if BoundsSets.TryGetIntegerValue('Top', IntValue) then
    Self.Top := IntValue;
  if BoundsSets.TryGetIntegerValue('Width', IntValue) then
    Self.Width := IntValue;
  if BoundsSets.TryGetIntegerValue('Height', IntValue) then
    Self.Height := IntValue;
end;

procedure TBaseForm.WriteSettings(Keeper: TSettingsKeeperEh);
var
  BoundSettings: TSettingsKeeperEh;
begin
  BoundSettings := TSettingsKeeperEh.Create;
  BoundSettings.Add('Left', Left);
  BoundSettings.Add('Top', Top);
  BoundSettings.Add('Width', Width);
  BoundSettings.Add('Height', Height);

  Keeper.Add('Bounds', BoundSettings);
end;

end.
