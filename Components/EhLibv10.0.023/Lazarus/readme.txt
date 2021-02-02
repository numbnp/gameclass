EhLib 9.5 Lazarus Edition

The current version of the library was tested under next platforms:

- Windows Lazarus 2.0.10 r63526 FPC 3.2.0 x86_64-win64-win32/win64
- Linux   Lazarus 2.0

Installing the Library in Lazarus IDE 
-------------------------------------

1. Create a folder C:\lazarus\components\EhLib 
 (We assume that lazarus is installed in C:\lazarus) 

2. Copy the contents of the folder <EhLib Archive>\Larasus<*>\*. * In C:\lazarus\components\EhLib\

2.1 Copy folder <EhLib Archive>\Demos\Data to C:\lazarus\components\EhLib\Demos

3. Run lazarus IDE 

4. Open the C:\lazarus\components\EhLib\Lib\ehlib.lpk 

5. When you open select "Open Package" 

6. Inspector in the batch, select Use-> Install 

7. After compiling and restart the IDE component palette should appear Bookmarks "EhLib Controls" and "Ehlib Components". 

8. Test the component in a project C:\lazarus\components\EhLib\Demos\MainDemo\project1.lpr



Differences in the names of the modules 
---------------------------------------

Lazarus LCL version of EhLib  contains the following differences from the VCL version.

 EhLibVCL.pas -> EhLibLCL.pas
 (Instead of the use EhLibVCL.pas module EhLibLCL.pas)

 DBGridEh.Pas -> DBGridsEh.Pas

Ported components 
-----------------

Most of the design-time features implemented under the Delphi IDE for components such as 
TDBGridEh, TMemTableEh, etc. not implemented in Lazarus IDE.

This version of the EhLib for Lazarus has the following limitations and features of work.

+TDBGridEh:
  Run-Time functional work fully as in VCL version.
    Artefacts on drawing grid futter.
  Design-Time functional works partly:
    TDBGridEh Compomnent Editor - don't work.    

+TDBVertGridEh:
  Run-Time functional work fully as in VCL version.

+TDBEditEh:
  Run-Time functional work fully as in VCL version.

+TDBDateTimeEditEh:
  Run-Time functional work fully as in VCL version.

+TDBNumberEditEh:
  Run-Time functional work fully as in VCL version.

+TDBComboBoxEh:
  Run-Time functional work fully as in VCL version.

+TDBLookupComboboxEh:
  Run-Time functional work fully as in VCL version.

+TDBCheckBoxEh:
  Run-Time functional work fully as in VCL version.

+TDBMemoEh:
  Run-Time functional work fully as in VCL version.

+TDBImageEh:
  Run-Time functional work fully as in VCL version.

+TDBRadioGroupEh:
  Run-Time functional work fully as in VCL version.

+TDBSumList:
  Run-Time functional work fully as in VCL version.

+TPropStorageEh:
  Run-Time functional work fully as in VCL version.

+TIniPropStorageManEh:
  Run-Time functional work fully as in VCL version.

+TRegPropStorageManEh:
  Run-Time functional work fully as in VCL version.


-TDBRichEditEh
  Doesn't exists in Lazarus version as there is no base class in Lazarus to inherit.

-TPreviewBox
  Doesn't exists in Lazarus version as there is no TMetafile class in Lazarus.
  EhLib Printing and Preview technique is based on Metafile objects.

-TPrintDBGridEh
  Doesn't exists in Lazarus version as there is no TMetafile class in Lazarus.

* The TDBEditEh, TDBDateTimeEditEh, TDBNumberEditEh, TDBComboBoxEh, TDBLookupComboboxEh 
  components do not support the EditButtons elements. In the Win32 version, EditButtons are displayed, 
  but the text editor's cursor can go under the EditButtons elements when all text does not fit into 
  the visible area. In GTK2, EditButtons are not displayed at all.

  In the “non-cross-platform, only Win32” mode, you still have the opportunity to provide full support 
  for EditButtons. To do this, you need to comment out the IFDEF symbol directive of the FPC_CROSSP 
  compiler in the EhLib.Inc file and recompile the library.

