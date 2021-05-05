# forticlient
The Forticlient Windows package was built based on the Nullsoft Scriptable Installer System (https://sourceforge.net/projects/nsis/). The first package was produced using version 3.06 of the NSIS software.



Prerequisites for building:

 * NSIS 3 (see above)
 * Code signing certificate issued from a trusted internal or public CA
 * Reg2NSIS windows program (this takes a registry file - our current Forticlient config - and converts it in to NSIS programming .. this is how the NSIS registry code is generated) - Available at (https://nsis.sourceforge.io/Reg2Nsis_-_convert_registry_info_into_NSIS_commands)
 * Windows SDK (provides signtool.exe) https://docs.microsoft.com/en-us/windows/win32/seccrypto/signtool
 The version of the forticlient MSI you wish to deploy (can be extracted from the forticlient.exe download ... 7Zip was used for this, but many tools exist ... use your favorite!)


IMPORTANT:

Since you are building from an example Forticlient on a build-machine, DO NOT SAVE YOUR USERNAME OR PASSWORD on the Forticlient build machine!





Build process:

1. Put your SSL code singing certificate and extracted registry keys into the Resources directory.
2. Run reg2nsis on each of the SSL and IPSec registry files.
3. Edit the installer.nsi file and update with your code signing certificate and the registry key output from reg2nsis

