program Mdiapp;

uses
  Forms,
  MAIN in 'MAIN.PAS' {MainForm},
  CHILDWIN in 'CHILDWIN.PAS' {MDIChild},
  about in 'about.pas' {AboutBox},
  Customers in 'Customers.pas' {fCustomers},
  Employee in 'Employee.pas' {fEmployee},
  Vendors in 'Vendors.pas' {fVendors};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Marine Adventures';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
