EhLib 7.0 Build 7.0.133 Professional Edition.
----------------------------------------------

The Library contains components and classes for Borland Delphi versions 7, 9, 
Developer Studio 2006, Delphi 2007, Embarcadero RAD Studio 2009-XE7, Lazarus.

TABLE OF CONTENTS
-----------------
Overview
Installation Library
Installation Help
Demonstration Programs
Registering and Prices
Other information
About author


Where to start.
-------------------

Read about EhLib for Lazarus in the file - Lazarus<*>\readme.txt

Start overview of the library with the main Demo project
.\Demos\Bin\MainDemo.Exe.
(Compiled Demo files are available in the Evaluation version of the library)

Then you can read a summary of the new features and changes
in the file history-eng.html.

More detail about new features can be found in the file -
About EhLib 7 Eng.doc

To install a new version of the library in the IDE, use the installation program
in .\Installer\EhLibInstaller.exe



Overview
--------

The Library contains several components and objects.

TDBGridEh component
TDBGridEh provides all functionality of TDBGrid 
 and adds several new features as follows:
   Allows to select records, columns and rectangle areas.
   Special titles that can correspond to several/all columns.
   Footer that is able to show sum/count/other field values.
   Automatic column resizing to set grid width equal client width.
   Ability to change row and title height.
   Allows automatic broken of a single line long title and data row 
     to a multiline.
   Title can act as button and, optionally show a sort marker.
   Automatically sortmarking.
   Ability to truncate long text with ellipsis.
   Lookup list can show several fields.
   Incremental search in lookup fields.
   Frozen columns.
   DateTime picker support for TDateField and TDateTimeField.
   Allows to show bitmaps from TImageList depending on field value.
   Allows to hide and track horizontal or vertical scrollbars.
   Allows to hide columns.
   Allows to show 3D frame for frozen, footer and data rows.
   Allows to draw memo fields.
   Multiline inplace editor.
   Proportional scrolling independently of sequenced of dataset.
   Automatically show checkboxes for Boolean fields. Allows to show 
    checkboxes for other type of fields.
   Has a procedures to save and restore layout (visible columns, columns 
    order, columns width, sortmarkers, row height) in/from registry or ini file.
   Allows to show hint (ToolTips) for text that don't fit in the cell.
   Allows to export data to Text, Csv, HTML, RTF, XLS and internal formats.
   Allows to import data from Text and internal formats.
   Can sort data in various dataset's.
   Can filter data in various dataset's.
   When DBGridEh is connected to DataSet of TMemTable type it allows:
     To view all data without moving active record.
     To display a tree-type structure of TMemTable records.
     To form list of values in dropdown list of SubTitle filter automatically.
     To create grouping records basing on the selected coulmns.

TDBVertGridEh component
  Component to show one record from dataset in Vertical Orientation.
    Have a special column to show Field Captions
    Can customize inplace editor and data of the cell like in DBGridEh.

TDBLookupComboboxEh component
 Provides all functionality of TDBLookupCombobox and adds 
 several new features as follows:
   Can have flat style.  
   Allows assign values as to KeyValue property just and to 
     display Text property.
   Allows to type (assign) values to Text property not contained in data list
     (Style = csDropDownEh). 
   Allows to hold KeyValue and Text as not affecting to each other values. 
    Take effect when KeyField, ListField, ListSource, DataField and DataSource 
    properties is empty.
   Drop down list can:
     Show titles,
     Have sizing grip,
     Automaticaly set width as sum of DisplayWidth of the list fields (Width = -1),
     Automaticaly drops on user pressed the key.
   Edit button can:
     Show DropDown, Ellipsis or Bitmap image.
     Have specified width.
   Have additional events: OnKeyValueChanged, OnButtonClick.


TDBSumList component
This component is intended for totaling sums and amounts of records in a 
TDataSet with dynamic changes. Component keeps a list of TDBSum 
objects, which contains types of group operations (goSum or goCount) 
and name sum field (goCount name of field is unnecessary).


TPrintDBGridEh component
TPrintDBGridEh provides properties and routines for preview and 
  print of TDBGridEh component with several features:
    Ability to expand rows vertically until all text is printed.
    Ability to scale grid to fit it to page width.
    Ability to print/preview title for grid.
    Ability to print/preview page header and page footer where you can 
     specify macros for current page, current date, current time and/or static 
     text.
    Automatically print/preview multiselected area of TDBGridEh if it area 
     is not empty.
    Ability to print/preview rich text before and after grid.

TPreviewBox component
TPreviewBox lets you create a customizable runtime preview.


TPrinterPreview object
TPrinterPreview lets you to record printable data in buffer for following 
output them on screen and to printer. TPrinterPreview have all functions and 
properties as in TPrinter object. You can use TPrinterPreview object similarly 
of TPrinter except some details. In TPrinter Printer.Canvas.Handle and 
Printer.Handle is the same but in TPrinterPreview PrinterPreview.Canvas.Handle
represent the metafile in that is recored the data and PrinterPreview.Handle 
represent Printer.Handle. That is mean that you have to use 
PrinterPreview.Canvas.Handle for draw operation (DrawText, DrawTexteEx, e.t.c.) 
and use PrinterPreview.Handle in functions that return information about 
printer facilities (GetDeviceCaps, e.t.c.). Global function PrinterPreview 
returns default PrinterPreview object and shows data in default preview form.

TDBEditEh component 
represents a single or multi-line edit control that can display and edit a field 
in a dataset or can works as non data-aware edit control.

TDBDateTimeEditEh component 
represents a single-line date or time edit control that can display and edit 
a datetime field in a dataset or can works as non data-aware edit control.


TDBComboBoxEh component 
represents a single or multi-line edit control that combines an edit box 
with a scrollable list and can display and edit a field in a dataset or can 
works as non data-aware combo edit control.

TDBNumberEditEh component 
represents a single-line number edit control that can display and edit a numeric 
field in a dataset or can works as non data-aware edit control.


TPropStorageEh, TIniPropStorageManEh, TRegPropStorageManEh components
Components realize technology to store component properties to/from settings 
storage such as ini files, registry etc.

TMemTableEh component
 dataset, which hold data in memory. Its possible consider as an array of 
 records.
 Besides, it:
  Supports a special interface, which allows DBGridEh component  to view all 
    data without moving active record.
  Allows fetch data from TDataDriverEh object (DataDriver property).
  Allows unload change back in DataDriver, operative or postponed (in 
   dependencies of the CachedUpdates property).
  Allows to create a master/detail relations on the client (filtering record) 
   or on the external source (updating parameters [Params] and requiring data 
   from DataDriver).
  Allows once-only (without the dynamic support) sort data, including 
   Calculated and Lookup field.
  Allows create and fill data in design-time and save data in dfm file of the 
   Form.
  Allows keep record in the manner of trees. Each record can have record 
   elements-branches and itself be an element to other parental record. 
   Component TDBGridEh supports to show the tree-type structure of these 
   records.
  Allows to connect to the internal array of other TMemTableEh (via 
   ExternalMemData property) and work with its data: sort, filter, edit.
  Has interface for requesting list of all unique values in one column of 
   records array, ignoring local filter of the DataSet. TDBGridEh uses this 
   property for automatic filling a list in DropDownBox of the subtitle 
   filter cell.

TDataDriverEh component
  carry out two tasks:
    Delivers data to TMemTableEh.
    Processes changed records of TMemTableEh (writes them in other dataset, 
      or call events for processing the changes in program).

TSQLDataDriverEh
  DataDriver that have four objects of the TSQLCommandEh type: SelectCommand, 
  DeleteCommand, InsertCommand, UpdateCommand, GetrecCommand.
  TSQLDataDriverEh can not transfer queries to the server but it call global 
  (for application) event which it is necessary to write to execute SQL 
  expressions on the server.

TBDEDataDriverEh, TIBXDataDriverEh, TDBXDataDriverEh and TADODataDriverEh Components.
  These are SQLDataDrivers that can deliver queries to the server using 
  corresponding drivers of the access to datas.


--------------------
2. Installation Library
--------------------

--------------------
2.1  Installing library automatically
--------------------

Run EhLibInstaller.exe program from "Installer" folder to install EhLib in 
Delphi/C++ Builder IDE. The program creates folders to keep EhLib binary
and other requared files, copies requared files to created folders,
compiles packages, register packages in IDE and write requared paths 
in registry.

If you have executable installation program (for example, EhLibSetupD7Eval.exe)
then you only need to run program and follow installation process. Setup automatically
writes all units in necessary directory, installs packages and help files in IDE.


--------------------
2.2  Installing library manually
-------------------

Follow next instructions to install files from EhLib archive:

--
2.2.1. For RAD Studio XE2 (Delphi):
---------------------------------------------------------------------

Uninstall previous or evaluation version of EhLib (Old version) from Delphi 
IDE. Remove or copy to other directory files of old version to prevent 
crossing old and new version of EhLib (Including EhLib.bpl, EhLib.dcp or 
EhLibXX.bpl, EhLibXX.dcp, EhLibDataDriversXX, DclEhLibDataDriversXX files). 

Create new folder where source code and binary files will be kept
(For example, C:\RAD_Studio_XE2\Components\EhLib).
Hereinafter this folder will be call as "EhLib folder".

Create new subfolder Lib in the "EhLib folder".
Copy files from folders Common and RADStudioXE2 of EhLib archive into
the folder "[EhLib folder]\Lib" as that all files were in one folder -
"Lib".

Run RAD Studio IDE and Open EhLibProjGroup160.groupproj file from
[EhLib folder]\Lib. Compile all packages of Prject Group.

Install DclEhLibXX.Dpk and DclEhLibDataDriversXX.Dpk packages in IDE
(Use Project/Install menu).

Consistently compile packages EhLibXX.Dpk and EhLibDataDriversXX.Dpk
in next modes:
  Win32\Debug 
  Win64\Release
  Win64\Debug 

After compilation there should be created subfolders a
  Win32\Release, Win32\Debug, Win64\Release, Win64\Debug 
in the "[EhLib folder]\Lib" folder.

Copy the *. dfm and *. res files from the "[Folder EhLib]\Lib" folder
into the each of the next folders:
   Win32\Release, Win32\Debug, Win64\Release, Win64\Debug


In the RAD Studio IDE add next paths: 
"[EhLib folder]\Lib\Win32\Release" path in the "Library path" for the Win32 platform.
"[EhLib folder]\Lib\Win32\Debug" path in the "Debug dcu" for the Win32 platform.
"[EhLib folder]\Lib\" path in the "Brasing path" for the Win32 platform.

"[EhLib folder]\Lib\Win64\Release" path in the "Library path" for the Win64 platform.
"[EhLib folder]\Lib\Win64\Debug" path in the "Debug dcu" for the Win64 platform.
"[EhLib folder]\Lib\" path in the "Brasing path" for the Win64 platform.


--
Copy DEMOS folder from the Archive EhLib to the "[EhLib Folder]".
Open and compile any demo project for test.


2.2.2. Delphi 5.x - 7.x, Delphi 9.X Win32, BDS2006 Win32, Delphi2007, 
   CodeGear RAD Studio 2009:
-------------------------------------------------------------------------------

Uninstall previous or evaluation version of EhLib (Old version) from Delphi 
IDE. Remove or copy to other directory files of old version to prevent 
crossing old and new version of EhLib (Including EhLib.bpl, EhLib.dcp or 
EhLibXX.bpl, EhLibXX.dcp, EhLibDataDriversXX, DclEhLibDataDriversXX files). 

Create directory from which you will install EhLib library 
('EhLib directory') (for example, C:\Delphi[X]\EhLib).

Copy files from Common and Delphi[X] | BDS2006 directories of the EhLib 
archive to 'EhLib directory'.

By default Delphi (5, 6 and 7) places compiled files to the 
<Delphi path>\Projects\Bpl directory and this directory already present 
in the search PATH. But if you overwrite default BPL directory then you need
put compiled EhLibXX.BPL file into directory that is accessible 
through the search PATH (i.e. DOS "PATH" environment variable; for example, 
in the Windows\System directory).

Add, (if needed) 'EhLib directory' in Tools->Environment Options->Library->
Library Path (For Delphi 9 in Tools->Options->Environment Options->
Delphi Options->Library - Win32->Library Path).

Use "File\Open..." menu item of Delphi IDE to open the runtime package - 
EhLibXX.Dpk.
In "Package..." window click "Compile" button to compile the package.

After that open and compile EhLibDataDriversXX.Dpk.

After compiling run-time packages install design-time
packages DclEhLibXX.BPL and DclEhLibDataDriversXX.BPL into the IDE.

For that use "File\Open..." menu item to open design-time package 
DclEhLibXX.Dpk.
In "Package..." window click "Compile" button to compile the package
and then click "Install" button to register EhLib components on
the component palette.

Open and install DclEhLibDataDriversXX.Dpk package.

EhLib components have to appear on 'EhLib' page of components palette.


2.2.4. Delphi 9.X Vcl.Net, , BDS2006 Vcl.Net:
----------------------------------------

Uninstall previous or evaluation version of EhLib (Old version) from Delphi
IDE. Remove or copy to other directory files of old version to prevent
crossing old and new version of EhLib 
(Including Vcl.EhLib90.dll, Vcl.DclEhLib90.dll, Vcl.EhLibDataDrivers90.dll, 
Vcl.DclEhLibDataDrivers90.dll files).

Create directory from which you will install EhLib library
('EhLib directory') (for example, C:\BDS\3.0\EhLibVclNet).

Copy files from Common and Delphi9 directories of the EhLib archive
to 'EhLib directory'.

In Delphi IDE:

Add, (if needed) 'EhLib directory' in Component->Installed .NET Components ...->
  Assembly Search Paths.
Add, (if needed) 'EhLib directory' in Tools->Options->Environment Options->
Delphi Options->Library - NET->Library Path.

Use "File\Open..." menu item of Delphi IDE to open the runtime package -
Vcl.EhLibXX.Dpk.
In "Project Manager..." window, click right button above 'Vcl.EhLibXX.Dll' and
select "Build" menu to compile package.

After that, open and compile Vcl.EhLibDataDriversXX.Dpk, 
Vcl.DclEhLibXX.Dpk and Vcl.DclEhLibDataDriversXX.Dpk.

Open menu "Component->Installed .NET Components ..."->.NET VCL Components.
Press 'Add...' button. Locate 'Vcl.DclEhLibXX.dll' and press 'Open'.
(By default, this file have to be located in 'EhLib directory' directory)
Press 'Ok' in 'Installed .NET Components' Dialog. 

4. Documentation and Help
-------------------------

4.1. This version of library doesn't have embedded help files for Delphi8 or Higher.
     But the online help is available on the ehlib home page - 
     http://www.ehlib.com/online-help

4.2. Delphi 7.x:

  Copy the EhLib.hlp and EhLib.cnt files to the Delphi HELP subdirectory.
  Select Help|Customize to start the OpenHelp application. Add the EhLib.cnt 
  file to the Contents page, add the EhLib.hlp file to the Index and Link pages.

5. Demonstration Programs and Projects
--------------------------------------

Demonstration programs use tables from the DEMOS directory 
and ADO Data Access.

Read description of Demo projects in the file
Demos\Info Eng.doc


6. Registering and Prices
-------------------------

The EhLib is a Commercial product. If you find it useful and want to receive 
the latest versions please register your evaluation copy.

You can read detailed information about prices on ehlib home prices page
http://www.ehlib.com/buy

You can read detailed information about registration at 
https://secure.shareit.com/shareit/product.html?productid=102489

After registration you will receive (e-mail only) address of
registered version for downloading and password for unpacking.

By registering the components you get the following advantages:

1.  You  will  get new versions of the library free within a year from
the date of registration.
2. You will get technical support for the library all the time.
3. You encourage EhLib Team to make the library even better.


7. Other information
-----------------

(1)
Information for user who already have old version of TDBGridEH or TDBSumList 
or EhLib installed:

Before installation this version of EhLib uninstall previous version of 
TDBGridEh or TDBSumList or EhLib from IDE and remove or copy this files
to other directory to prevent crossing of new and old files.

(2) 
If at compile-time under C++ Builder you get next error:
  [Linker Error] Unresolved external 'AlphaBlend' referenced from C:\PROGRAM
  FILES\BORLAND\CBUILDER6\PROJECTS\LIB\EHLIBB60.LIB|C:\VCL6\EhLib\Common\DBGridEh.pas

then add msimg32.lib library in Linker options of your Project.
It is placed at $(BCB)\lib\psdk\msimg32.lib


8. About Company
----------------

Contact as if you have any questions, comments or suggestions:
EhLib Team
www: http://www.ehlib.com
E-mail: support@ehlib.com
Skype support: ehlib.support