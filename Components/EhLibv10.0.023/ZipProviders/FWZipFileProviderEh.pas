{*******************************************************}
{                                                       }
{                       EhLib v9.4                      }
{                  FWZipFileProviderEh                  }
{                                                       }
{                      Build 9.4.01                     }
{                                                       }
{   Copyright (c) 2014-2019 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{*******************************************************}
{          Zip provider of FWZip class to zip files     }
{                  http://rouse.drkb.ru                 }
{    FWZip: http://rouse.drkb.ru/components.php#fwzip   }
{*******************************************************}

unit FWZipFileProviderEh;

interface

uses
  SysUtils, Classes, FWZipWriter, ZipFileProviderEh;

type

{ TFWZipFileProvider }

  TFWZipFileProvider = class(TCustomFileZipingProviderEh)
  private
    FStream: TStream;
    FZipFile: TFWZipWriter;
  public
    constructor Create;
    destructor Destroy; override;

    class function CreateInstance: TCustomFileZipingProviderEh; override;
    function InitZipFile(FileName: String): TStream; override;
    procedure AddFile(Data: TStream; const FilePathAndName: string); override;
    procedure FinalizeZipFile; override;

    property Stream: TStream read FStream write FStream;
  end;

implementation

{ TFWZipFileProvider }

constructor TFWZipFileProvider.Create;
begin
  inherited Create;
end;

destructor TFWZipFileProvider.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FZipFile);
  FreeAndNil(FStream);
end;

class function TFWZipFileProvider.CreateInstance: TCustomFileZipingProviderEh;
begin
  Result := TFWZipFileProvider.Create;
end;

function TFWZipFileProvider.InitZipFile(FileName: String): TStream;
begin
  if FStream <> nil then
    raise Exception.Create('ZipFile is already Initialized.');
  if FZipFile <> nil then
    raise Exception.Create('ZipFile is already Initialized.');
  if FileName = '' then
    FStream := TMemoryStream.Create
  else
    FStream := TFileStream.Create(FileName, fmCreate);
  Result := FStream;
  FZipFile := TFWZipWriter.Create;
//  FZipFile.Open(Result, zmWrite);
end;

procedure TFWZipFileProvider.AddFile(Data: TStream;
  const FilePathAndName: string);
begin
  FZipFile.AddStream(FilePathAndName, Data);
end;

procedure TFWZipFileProvider.FinalizeZipFile;
begin
  if Assigned(FZipFile) then 
    FZipFile.BuildZip(Stream);
  FreeAndNil(FZipFile);
  FreeAndNil(FStream);
end;

initialization
  RegisterZipFileProviderClass(TFWZipFileProvider);
finalization
  RegisterZipFileProviderClass(nil);
end.

