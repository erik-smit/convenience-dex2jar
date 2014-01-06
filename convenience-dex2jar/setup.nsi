 ;Name and file
!include "MUI.nsh"
!include "Sections.nsh"
!include "LogicLib.nsh"

!macro w7menu Ext Description Cmd
	WriteRegStr	HKCR \
			"${Ext}\shell\dex2jar.W7Menu" \
			"MUIVerb" \
			"dex2jar"
	WriteRegStr	HKCR \
			"${Ext}\shell\dex2jar.W7Menu" \
			"ExtendedSubCommandsKey" \
			"${Ext}\W7Menu"
;	WriteRegStr	HKCR \
			;".dex\shell\dex2jar.W7Menu" \
			;"Icon" \
			;"$INSTDIR\makedex2jarw.exe,1" 
	;compile
	WriteRegStr	HKCR \
			"${Ext}\W7Menu\shell\dex2jar" \
			"MUIVerb" "${Description}"				
	WriteRegStr	HKCR \
			"${Ext}\W7Menu\shell\dex2jar\command" \
			"" \
			'${Cmd}'
!macroend

Name "dex2jar"
OutFile "setup.exe"
RequestExecutionLevel admin
 
InstallDir $PROGRAMFILES\dex2jar
InstallDirRegKey HKLM Software\dex2jar ""
 
; Pages
Page directory
Page instfiles
 
; Sections
Section ""
    SetOutPath "$INSTDIR"
	
    File /r "dex2jar-0.0.9.15\*"
	
	!insertmacro w7menu ".dex" "Translate .dex to .jar" '"$INSTDIR\d2j-dex2jar.bat\" \"%1\"'
	!insertmacro w7menu ".jar" "Translate .jar to .dex" '"$INSTDIR\d2j-jar2dex.bat\" \"%1\"'
	
	WriteUninstaller "$INSTDIR\Uninstall.exe"
SectionEnd

Section "Uninstall"
  
  RMDir /R "$INSTDIR"

  DeleteRegKey /ifempty HKCU "Software\dex2jar"
  DeleteRegKey HKCR ".dex\shell\dex2jar.W7Menu"
  DeleteRegKey HKCR ".jar\shell\dex2jar.W7Menu"
  
SectionEnd