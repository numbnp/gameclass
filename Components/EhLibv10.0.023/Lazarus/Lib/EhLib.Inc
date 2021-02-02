{*******************************************************}
{                                                       }
{                       EhLib 9.5                       }
{     Conditional defines that affect compilation       }
{                                                       }
{   Copyright (c) 1998-2020 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$IFDEF FPC}           {Lazarus Free Pascal}
  //{$mode objfpc}{$H+}
  {$MODE Delphi}//{$H+}
  {$DEFINE TBookMarkAsTBytes}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}

  {$IFDEF CPU32}
    //{$fatal This version of EhLib is not compatible with x32 Lazarus Free Pascal compiler.}
  {$ENDIF}

  {$IFDEF CPU64}
//    {$fatal This version of EhLib is not compatible with x64 Lazarus Free Pascal compiler. Please, use x32 compiler.}
  {$ENDIF}

  {$IFDEF LINUX}
    {$DEFINE FPC_LINUX}
    {$DEFINE FPC_CROSSP}
  {$ENDIF}
  {$IFDEF WINDOWS}
    {$DEFINE FPC_WINDWOS}
    {$DEFINE FPC_CROSSP}
  {$ENDIF}
  {$IFDEF Darwin}
    {$DEFINE FPC_MACOS}
    {$DEFINE FPC_CROSSP}
  {$ENDIF}

{$ELSE}
   //From Lazarus, same as MSWINDOWS in Delphi
   {$DEFINE WINDOWS}
{$ENDIF}

//{$DEFINE OLDPREVIEWBOX}

{$BOOLEVAL OFF}
{$WARN SYMBOL_PLATFORM OFF}

{$DEFINE EH_LIB_VCL}

{$DEFINE DESIGNTIME}

{$DEFINE EH_LIB_5}
{$DEFINE EH_LIB_6}
{$DEFINE EH_LIB_7}

{$define eval}

{$IFDEF VER130}         { Borland Delphi 5.0 or CPP Builder 5.0 }
  {$DEFINE EH_LIB_5}
{$ENDIF}

{$IFDEF VER140}         { Borland Delphi 6.0 or CPP Builder 6.0}
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
{$ENDIF}

{$IFDEF VER150}         { Borland Delphi 7.0 }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
{$ENDIF}

{$IFDEF CIL}            { Borland Delphi 8.0 }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
{$ENDIF}

{$IFDEF VER170}         { Borland Delphi 2005 }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
{$ENDIF}

{$IFDEF VER180}         { Borland Developer Studio 2006 }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}

  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER185}         { Borland Developer Studio 2007 }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}

  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER200}         { CodeGear RAD Studio 2009 }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

// Unicode versions of Delphi

{$IFDEF VER210}         { CodeGear RAD Studio 2010, CodeGear RAD Studio Weaver }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER220}         { CodeGear RAD Studio 2011 XE}
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
{$ENDIF}

{$IFDEF VER230}         { Delphi XE2 / C++Builder XE2 (Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER240}         { Delphi XE3 / C++Builder XE3 (Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER250}         { Delphi XE4 / C++Builder XE4 (Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}
  {$DEFINE EH_LIB_18}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER260}         { Delphi XE5 / C++Builder XE5 (Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}
  {$DEFINE EH_LIB_18}
  {$DEFINE EH_LIB_19}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER270}         { Delphi XE6 / C++Builder XE6 (Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}
  {$DEFINE EH_LIB_18}
  {$DEFINE EH_LIB_19}
  {$DEFINE EH_LIB_20}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER280}         { Delphi XE7 / C++Builder XE7 (Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}
  {$DEFINE EH_LIB_18}
  {$DEFINE EH_LIB_19}
  {$DEFINE EH_LIB_20}
  {$DEFINE EH_LIB_21}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER290}         { Delphi XE8 / C++Builder XE8 (Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}
  {$DEFINE EH_LIB_18}
  {$DEFINE EH_LIB_19}
  {$DEFINE EH_LIB_20}
  {$DEFINE EH_LIB_21}
  {$DEFINE EH_LIB_22}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER300}         { Delphi XE10 / C++Builder XE10 (Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}
  {$DEFINE EH_LIB_18}
  {$DEFINE EH_LIB_19}
  {$DEFINE EH_LIB_20}
  {$DEFINE EH_LIB_21}
  {$DEFINE EH_LIB_22}
  {$DEFINE EH_LIB_23}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER310}         { Delphi/C++Builder Berlin XE 10.1 Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}
  {$DEFINE EH_LIB_18}
  {$DEFINE EH_LIB_19}
  {$DEFINE EH_LIB_20}
  {$DEFINE EH_LIB_21}
  {$DEFINE EH_LIB_22}
  {$DEFINE EH_LIB_23}
  {$DEFINE EH_LIB_24}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER320}         { Delphi Tokyo / C++Builder Tokyo XE10.2 (Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}
  {$DEFINE EH_LIB_18}
  {$DEFINE EH_LIB_19}
  {$DEFINE EH_LIB_20}
  {$DEFINE EH_LIB_21}
  {$DEFINE EH_LIB_22}
  {$DEFINE EH_LIB_23}
  {$DEFINE EH_LIB_24}
  {$DEFINE EH_LIB_25}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER330}         { Delphi 10.3 Rio / C++Builder 10.3 Rio (Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}
  {$DEFINE EH_LIB_18}
  {$DEFINE EH_LIB_19}
  {$DEFINE EH_LIB_20}
  {$DEFINE EH_LIB_21}
  {$DEFINE EH_LIB_22}
  {$DEFINE EH_LIB_23}
  {$DEFINE EH_LIB_24}
  {$DEFINE EH_LIB_25}
  {$DEFINE EH_LIB_26}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER340}         { RAD Studio 10.4 Denali Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}
  {$DEFINE EH_LIB_18}
  {$DEFINE EH_LIB_19}
  {$DEFINE EH_LIB_20}
  {$DEFINE EH_LIB_21}
  {$DEFINE EH_LIB_22}
  {$DEFINE EH_LIB_23}
  {$DEFINE EH_LIB_24}
  {$DEFINE EH_LIB_25}
  {$DEFINE EH_LIB_26}
  {$DEFINE EH_LIB_27}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

{$IFDEF VER350}         { RAD Studio 10.5 Win32/Win64) }
  {$DEFINE EH_LIB_5}
  {$DEFINE EH_LIB_6}
  {$DEFINE EH_LIB_7}
  {$DEFINE EH_LIB_8}
  {$DEFINE EH_LIB_9}
  {$DEFINE EH_LIB_10}
  {$DEFINE EH_LIB_11}
  {$DEFINE EH_LIB_12}
  {$DEFINE EH_LIB_13}
  {$DEFINE EH_LIB_14}
  {$DEFINE EH_LIB_16}
  {$DEFINE EH_LIB_17}
  {$DEFINE EH_LIB_18}
  {$DEFINE EH_LIB_19}
  {$DEFINE EH_LIB_20}
  {$DEFINE EH_LIB_21}
  {$DEFINE EH_LIB_22}
  {$DEFINE EH_LIB_23}
  {$DEFINE EH_LIB_24}
  {$DEFINE EH_LIB_25}
  {$DEFINE EH_LIB_26}
  {$DEFINE EH_LIB_27}

  {$DEFINE TBookMarkAsTBytes}
  {$WARN SYMBOL_DEPRECATED OFF}
  {$DEFINE VistaThemesSuppored}
  {$DEFINE EH_LIB_ZIP}
{$ENDIF}

