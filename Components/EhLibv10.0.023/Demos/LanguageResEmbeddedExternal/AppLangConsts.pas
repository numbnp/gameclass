unit AppLangConsts;

interface

{$I EhLib.Inc}

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
    procedure SetCaption(const Value: String);

  public
    constructor Create(AOwner: TComponent); override;

  published
    property Caption: String read FCaption write SetCaption; //'Demonstration program'
    property MenuFile: String read FMenuFile write FMenuFile; //'File'
    property MenuLanguage: String read FMenuLanguage write FMenuLanguage; //'Language'
    property MenuExit: String read FMenuExit write FMenuExit; //'Exit'
  end;

function ApplicationLanguageConsts: TApplicationLanguageConsts;

implementation

uses LanguageResManEh;

{$R AppLangConsts.dfm}

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
