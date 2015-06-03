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

unit EhLibImages;

{$I EhLib.Inc}

interface

uses ToolCtrlsEh
{$IFDEF EH_LIB_5}  ,EhLibJPegImage {$ENDIF}
{$IFDEF EH_LIB_11} ,EhLibGIFImage  {$ENDIF} { Borland Developer Studio 2007 }
{$IFDEF EH_LIB_12} ,EhLibPNGImage {$ENDIF} { CodeGear RAD Studio 2009 }
  ;

implementation

initialization
end.
