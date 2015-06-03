{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit EhLib;

interface

uses
  GridsEh, GridToolCtrlsEh, ToolCtrlsEh, DynVarsEh, EhLibConsts, EhLibLCL, 
  DBAxisGridsEh, CalculatorEh, DBCtrlsEh, DBGridEhGrouping, DBGridEhToolCtrls, 
  DBGridsEh, DBLookupEh, DBLookupGridsEh, DBLookupUtilsEh, DBSumLst, 
  DbUtilsEh, DropDownFormEh, MemTableDataEh, MemTableEh, MemTreeEh, 
  DataDriverEh, DBGridEhFindDlgs, DBGridEhImpExp, DBGridEhSimpleFilterDlg, 
  DBVertGridsEh, EhLibGIFImage, EhLibImages, EhLibJPegImage, EhLibMTE, 
  EhLibPNGImage, MemoEditFormsEh, ObjectInspectorEh, PictureEditFormsEh, 
  PrnDgDlg, PrntsEh, PropFilerEh, PropStorageEh, SideOwnedComponentsEh, 
  EhLibDesignAbout, EhLibReg, MemTableDesignEh, GridEhEd, 
  DBVertGridsDesignEditorEh, SQLDBDataDriverEh, EditPivotFieldFormEh, 
  PivotGridPivotFieldsEditors, PivotGridRegEh, PivotGridsEh, PivotGridToolsEh, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('CalculatorEh', @CalculatorEh.Register);
  RegisterUnit('EhLibReg', @EhLibReg.Register);
  RegisterUnit('MemTableDesignEh', @MemTableDesignEh.Register);
  RegisterUnit('DBVertGridsDesignEditorEh', @DBVertGridsDesignEditorEh.Register
    );
  RegisterUnit('SQLDBDataDriverEh', @SQLDBDataDriverEh.Register);
  RegisterUnit('PivotGridRegEh', @PivotGridRegEh.Register);
end;

initialization
  RegisterPackage('EhLib', @Register);
end.
