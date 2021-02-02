program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  FrameFive in 'FrameFive.pas' {frFrameFive: TFrame},
  FrameThree in 'FrameThree.pas' {frFrameThree: TFrame},
  FrameOne in 'FrameOne.pas' {frFrameOne: TFrame},
  FrameTwo in 'FrameTwo.pas' {frFrameTwo: TFrame},
  FrameFour in 'FrameFour.pas' {frFrameFour: TFrame},
  MemoEditUnit3 in 'MemoEditUnit3.pas' {DropDownMemoEdit3: TCustomDropDownFormEh},
  MemoEditUnit1 in 'MemoEditUnit1.pas' {DropDownMemoEdit1: TCustomDropDownFormEh},
  MemoEditUnit2 in 'MemoEditUnit2.pas' {DropDownMemoEdit2: TCustomDropDownFormEh},
  DDFVendorsUnit in 'DDFVendorsUnit.pas' {DDFVendors: TCustomDropDownFormEh},
  EditVendorUnit in 'EditVendorUnit.pas' {fEditVendor};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Test Demo';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDropDownMemoEdit1, DropDownMemoEdit1);
  Application.Run;
end.
