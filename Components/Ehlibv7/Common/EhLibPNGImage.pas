{*******************************************************}
{                                                       }
{                        EhLib v7.0                     }
{                                                       }
{        Classes for detection Images stream format     }
{                      Build 7.0.01                     }
{                                                       }
{   Copyright (c) 2011-2012 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit EhLibPNGImage;

{$I EhLib.Inc}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_12} PNGImage, {$ENDIF} { CodeGear RAD Studio 2009 }
  Dialogs, ToolCtrlsEh;

{$IFDEF EH_LIB_12}
type

  TPNGGraphicProviderEh = class(TGraphicProviderEh)
  public
    class function GetImageClassForStream(Start: Pointer): TGraphicClass; override;
  end;
{$ENDIF}

implementation


{$IFDEF EH_LIB_12}

{ TPNGGraphicProviderEh }

class function TPNGGraphicProviderEh.GetImageClassForStream(Start: Pointer): TGraphicClass;
begin
  if (Start <> nil) and (LongWord(Start^) = $474E5089)
    then Result := TPngImage
    else Result := nil;
end;

{$ENDIF}

initialization
{$IFDEF EH_LIB_12}
  RegisterGraphicProviderEh(TPNGGraphicProviderEh);
{$ENDIF}
finalization
end.
