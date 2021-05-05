;--------------------------------
;
!define PRODUCT_NAME "XYZ VPN Deploy"
!define PRODUCT_VERSION ".1"
; PRODUCT_PUBLISHER should match the DN in your code signing certificate 
!define PRODUCT_PUBLISHER "XYZ"
;
!include x64.nsh

; The name of the installer
Name "XYZForticlient"

; The file to write
OutFile "XYZ-Forticlient.exe"

; Request application privileges for Windows Vista and higher
RequestExecutionLevel admin

; Build Unicode installer
Unicode True

; The default installation directory
InstallDir $PROGRAMFILES\XYZForticlient

; Registry key to check for directory (so if you install again, it will 
; overwrite the old one automatically)
InstallDirRegKey HKLM "Software\XYZForticlient" "Install_Dir"

; Set this compatible with ALL OSs
ManifestSupportedOS all
SetCompress auto
SetCompressor lzma

Function .onInit
SetRegView 64
FunctionEnd

Function Un.onInit
SetRegView 64
FunctionEnd

;--------------------------------
; Pages

Page components
Page instfiles
ShowInstDetails show

Section -SETTINGS
  SetOutPath "$INSTDIR"
  SetOverwrite on
SectionEnd


;--------------------------------

; The stuff to install
Section "Forticlient Package" SEC06

  MessageBox MB_YESNO "If the installation detects another version of the Forticlient installed it will be removed. The uninstall process will reboot your computer when complete and you may not be given a chance to save your work. If your computer reboots, simply re-run the installer to complete installation. Click Yes to continue or No to cancel." /SD IDYES IDNO aborthack
  DetailPrint "Awesome. Let's get you all set up!"
  Goto next

  next:
  ExecWait `wmic product where "name like 'Forti%%'" call uninstall /nointeractive`
  File "FortiClientVPN.msi"


  SectionIn RO
  ExecWait '"msiexec" /qb /i "$INSTDIR\FortiClientVPN.msi" /norestart INSTALLLEVEL=3 '
  ;File "ipsec.reg"
  ;File "ssl.reg"
  SetRegView 64
  ${DisableX64FSRedirection}
  ; XYZ (to get your attention for this section)
  ; 
  ;; Place output from your reg2nsis here
  ;
  ; XYZ (to get your attention for this section)


  ;clean up install files
  Delete "$INSTDIR\*"
  RMDir "$INSTDIR"

  MessageBox MB_YESNO "Installation complete. Click Yes to reboot your comptuer now or No if you intend to reboot later. Please reboot before attempting to use the updated Forticlient!" IDNO +2 
  Reboot
 
  Goto next2

  aborthack:
  DetailPrint "Bummer. Try again when you're ready to reboot (possibly)!"

  next2:

SectionEnd


!finalize 'signtool.exe sign "%1"' 
