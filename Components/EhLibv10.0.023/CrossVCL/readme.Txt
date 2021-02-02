.................................................. .............................
This folder contains files for demonstrating features
of the library when writing GUI programs for operating systems
OS X and Linux using the additional library - CrossVCL.


...............................................................................
To create applications for Linux or MacOS based on your VCL applications
you must have the following software:

- Delphi XE 10.1, Delphi XE 10.2 or higher.
  (Delphi XE 10.1 does not support creating Linux applications)
   https://www.embarcadero.com/products/delphi
   The Delphi editors should include the source code of the VCL library.
   The Delphi editors should include compilers for Linux and MacOS.

- CrossVCL library
  https://www.crossvcl.com/

- EhLib Library
  https://www.ehlib.com/
     The library version should include source codes.

- All third-party libraries that you use in the application should
    compile in compatibility mode with CrossVCL.
  Editions of third-party libraries should include source codes.

 - The source code for your application must be compatible with CrossVCL.
   In the case of creating Linux applications, the source code of your application
   should support compilation in ARC mode.
   https://www.crossvcl.com/devguide.html

- A computer or virtual machine with installed Linux and/or MacOS OS.
   The EhLib library tested under the following OSes "OS X 10.12.2", "Ubuntu 16.04".

...............................................................................
A short step-by-step instruction on compiling and running your application for Linux.

In Delphi XE, the EhLib and CrossVCL libraries must be installed.

Open your project.

On the right button in the project manager, select "Add New Platforms".
  For details, see here:
    https://www.crossvcl.com/guide.html

Now, in the Target Platforms section, the sections "64-bit Linux" and "OS X" should appear.
Compilation for iOS Device is not supported.

To compile "64-bit Linux" programs in Delphi, a new SDK (Software Development Kid) must be created.
which will contain native libraries under Linux.
These libraries will be downloaded once from the Linux computer.

So that Delphi can download the SDK and run the programs on the Linux machine, this machine
you must install the PAServer (Platform Assistant Server) application.
  For installation details, see:
    http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Installing_the_Platform_Assistant_on_Linux

After PAServer is installed and running on a Linux machine in the Delphi project, select
  Targer Platform - Linux64.
and try to compile the project.

Delphi IDE will offer to create a new Connection Profile.
- Enter the IP of your Linux computer
- Check the "Test Connection"
- Click "Continue"

The IDE must connect to the remote computer, create a new SDK repository on the Windows computer and
copy the SDK library from the Linux computer to it.

After that, the compilation process should start.
On your Linux computer there may not be all the libraries needed to build the GUI application.
For example, in Ubuntu 16.04 GL libraries are not installed.
  For detailed information on installing the necessary Linux libraries for CrossVCL, see here:
    https://www.crossvcl.com/faq.html

When you compile the Delphi IDE, you need access to the source files of the EhLib library.
  In the Tools - Options - Delphi Option - Library - Platform section, "64-bit Linux"
  Add a path to the EhLib source files.

When you compile your libraries and applications, errors may occur due to the missing functions:
  Reasons and recommendations for dealing with typical problems related to this, see here:
    https://www.crossvcl.com/devguide.html

If in the above sections there was no description of your problem, then write BagReport here:
  https://bitbucket.org/crossvcl/crossvcl/issues

If everything is compiled, try running your project on F9.
  Delphi will copy the compiled project to a Linux machine and run it with the help of PAServer.

If your application needs additional files to work, then they need to be added in the section
  Delphi IDE - Project - Deployment
This section describes the files that will be copied to the remote machine when the application starts.

To begin, try creating the simplest VCL application and adding it to the Linux machine.

The next step is to compile and run the EhLib Demo application from the folder
<EhLib Archive>\CrossVCL\Demos\MainDemoDfmData\Project1.dpr
or
<EhLib Installed Folder>\CrossVCL\Demos\MainDemoDfmData\Project1.dpr