# forticlient custom installer
The Forticlient Windows package was built based on the Nullsoft Scriptable Installer System (https://sourceforge.net/projects/nsis/). The first package was produced using version 3.06 of the NSIS software.


WARNING: This is an ugly hack. I am not a Windows installer expert. This is the result of a few hours of using Google and a few failures using other installer packages. That said, this process works and you get a Forticlient installer with your configuration pre-insalled.

Prerequisites for building:

 * NSIS 3 (see above)
 * Code signing certificate issued from a trusted internal or public CA
 * Reg2NSIS windows program (this takes a registry file - our current Forticlient config - and converts it in to NSIS programming .. this is how the NSIS registry code is generated) - Available at (https://nsis.sourceforge.io/Reg2Nsis_-_convert_registry_info_into_NSIS_commands)
 * Windows SDK (provides signtool.exe) https://docs.microsoft.com/en-us/windows/win32/seccrypto/signtool
 * The version of the forticlient MSI you wish to deploy (can be extracted from the forticlient.exe download ... 7Zip was used for this, but many tools exist ... use your favorite!)


IMPORTANT:

Since you are building from an example Forticlient on a build-machine, DO NOT SAVE YOUR USERNAME OR PASSWORD on the Forticlient build machine! Failure to do this will result in being mocked by other people in your IT department.



Build process:

1. Create a directory to build this installer
2. Put your SSL code singing certificate, the signtool.exe utility, and reg2nsis.exe in your directory
3. Extract the forticlient msi using 7Zip or other utility in to your build directory
4. Extract your registry values and save two registry files in your build directory. The values can be found at: HKEY_LOCAL_MACHIN\SOFTWARE\Fortinet\FortiClient\ . Make sure you ONLY get the IPSec and Sslvpn trees as the rest of the data shouldn't be overwritten with the installer.
![registry image](https://github.com/shward/forticlient/blob/main/Resources/reg-edit.png?raw=true)
5. Run reg2nsis on each of the SSL and IPSec registry files
Reg2Nsis.exe XYZ.reg
6. Edit the installer.nsi file and update with your code signing certificate, the registry key output from reg2nsis, and any reference to XYZ with the appropriate value for your org.
7. Launch the Nullsoft installer and select compile NSI script
![registry image](https://github.com/shward/forticlient/blob/main/Resources/nsis-1.png?raw=true)
8. Load your NSI script and watch the magic unfold!
![registry image](https://github.com/shward/forticlient/blob/main/Resources/nsis-2.png?raw=true)

The new installer should be dropped in your build directory. 


Feel free to reach out with any questions if you get stuck. I apologize for the ugly in this script, but it DOES work. -Josh (josh@microbrainsoftware.com)



