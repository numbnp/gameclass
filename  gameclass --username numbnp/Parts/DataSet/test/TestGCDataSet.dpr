program TestGCDataSet;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  uGCDataSet in '..\uGCDataSet.pas',
  uAutoUpdate in '..\uAutoUpdate.pas',
  uY2KCommon in '..\..\Y2KCommon\uY2KCommon.pas',
  uY2KString in '..\..\Y2KCommon\uY2KString.pas',
  uAutoUpdateCollection in '..\uAutoUpdateCollection.pas',
  uUsersDataSet in '..\uUsersDataSet.pas',
  uAccountsDataSet in '..\uAccountsDataSet.pas',
  uSQLTools in '..\..\SQLTools\uSQLTools.pas',
  uAccountsDiscountsDataSet in '..\uAccountsDiscountsDataSet.pas',
  uRegistryDataSet in '..\uRegistryDataSet.pas',
  uAccountSystem in '..\..\Accounts\uAccountSystem.pas',
  uAccounts in '..\..\Accounts\uAccounts.pas',
  uAccountsDiscounts in '..\..\Accounts\uAccountsDiscounts.pas',
  uAccountsDiscountsRecord in '..\..\Accounts\uAccountsDiscountsRecord.pas',
  uAccountsRecord in '..\..\Accounts\uAccountsRecord.pas',
  uRegistryVolume in '..\..\Registry\uRegistryVolume.pas',
  uRegistry in '..\..\Registry\uRegistry.pas',
  uRegistryAccountSystem in '..\..\Registry\uRegistryAccountSystem.pas',
  uRegistryRecord in '..\..\Registry\uRegistryRecord.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
