//////////////////////////////////////////////////////////////////////////////
//
// Компонент TY2KFileVersionInfoLabel.
// Предназначен для отображения информации о версии файла,
// полученной компонентом TY2KFileVersionInfo.
// Подписывается на события компонента TY2KFileVersionInfo в соответствии
// с шаблоном observer.
//
//////////////////////////////////////////////////////////////////////////////

unit uY2KFileVersionInfoLabel;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Controls,
  StdCtrls,
  uY2KFileVersionInfo;

type
  TLabelType = (ProductName,
                ProductVersion,
                Comments,
                CompanyName,
                CountryCode,
                FileDescription,
                FileVersion,
                InternalName,
                LegalCopyright,
                LegalTradeMarks,
                OriginalFileName);

  //
  // TY2KFileVersionInfoLabel
  //

  TY2KFileVersionInfoLabel = class(TLabel)
  private
    // fields
    FFileVersionInfo: TY2KFileVersionInfo;
    FFileVersionInfoLink: TY2KFileVersionInfoLink;
    FLabelType:TLabelType;
    FstrDescription:string;

    // private methods
    procedure SetCaption;
    procedure FileVersionInfoChange(Sender:TObject);

  protected
    procedure Notification(AComponent: TComponent;
              Operation: TOperation); override;

  public
    // constructor / destructor
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;

    // public methods
    procedure SetFileVersionInfo(AFileVersionInfo: TY2KFileVersionInfo);
    procedure SetLabelType(ALabelType: TLabelType);
    procedure SetDescription(AstrDescription: string);

  published
    // properties
    property FileVersionInfo: TY2KFileVersionInfo read FFileVersionInfo
        write SetFileVersionInfo;
    property LabelType: TLabelType read FLabelType write SetLabelType;
    property Description: string read FstrDescription write SetDescription;

  end; // TY2KFileVersionInfoLabel


implementation

uses
  Dialogs;

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
// constructor / destructor

constructor TY2KFileVersionInfoLabel.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  FFileVersionInfoLink := TY2KFileVersionInfoLink.Create;
  FFileVersionInfoLink.OnChange := FileVersionInfoChange;
end; // TY2KFileVersionInfoLabel.Create

destructor TY2KFileVersionInfoLabel.Destroy();
begin
  FreeAndNil(FFileVersionInfoLink);
  inherited Destroy();
end; // TY2KFileVersionInfoLabel.Destroy

//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//

procedure TY2KFileVersionInfoLabel.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FileVersionInfo) then
    FileVersionInfo := nil;
end; // TY2KFileVersionInfoLabel.Notification

procedure TY2KFileVersionInfoLabel.SetCaption();
var
  strTempCaption: string;
begin
  if Assigned(FFileVersionInfo) then
    case FLabelType of
      ProductVersion: strTempCaption := FFileVersionInfo.ProductVersion;
      ProductName: strTempCaption := FFileVersionInfo.ProductName;
      Comments: strTempCaption := FFileVersionInfo.Comments;
      CompanyName: strTempCaption := FFileVersionInfo.CompanyName;
      CountryCode: strTempCaption := FFileVersionInfo.CountryCode;
      FileDescription: strTempCaption := FFileVersionInfo.FileDescription;
      FileVersion: strTempCaption := FFileVersionInfo.FileVersion;
      InternalName: strTempCaption := FFileVersionInfo.InternalName;
      LegalCopyright: strTempCaption := FFileVersionInfo.LegalCopyright;
      LegalTradeMarks: strTempCaption := FFileVersionInfo.LegalTradeMarks;
      OriginalFileName: strTempCaption := FFileVersionInfo.OriginalFileName;
    end
  else
    strTempCaption := '';
  Caption := FstrDescription + strTempCaption;
end; // TY2KFileVersionInfoLabel.SetCaption

procedure TY2KFileVersionInfoLabel.SetDescription(AstrDescription:string);
begin
  FstrDescription := AstrDescription;
  SetCaption();
end; // TY2KFileVersionInfoLabel.SetDescription

procedure TY2KFileVersionInfoLabel.SetFileVersionInfo(
    AFileVersionInfo:TY2KFileVersionInfo);
begin
  if Assigned(FileVersionInfo)then
    FileVersionInfo.UnRegisterChanges(FFileVersionInfoLink);

  FFileVersionInfo := AFileVersionInfo;
  if Assigned(FileVersionInfo) then
    begin
      FileVersionInfo.RegisterChanges(FFileVersionInfoLink);
      FileVersionInfo.FreeNotification(Self);
    end;
  SetCaption();
end; // TY2KFileVersionInfoLabel.SetFileVersionInfo

procedure TY2KFileVersionInfoLabel.SetLabelType(ALabelType:TLabelType);
begin
  FLabelType := ALabelType;
  if Assigned(FFileVersionInfo) then
    SetCaption();
end; // TY2KFileVersionInfoLabel.SetLabelType

procedure TY2KFileVersionInfoLabel.FileVersionInfoChange(Sender:TObject);
begin
  if Sender = FileVersionInfo then
    SetCaption();
end; // TY2KFileVersionInfoLabel.FileVersionInfoChange


end. ////////////////////////// end of file //////////////////////////////////
