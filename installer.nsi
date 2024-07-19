Outfile "EDF2PSPModinstaller.exe"

Name "EDF 2 PSP Mod Installer"
BrandingText "EDF 2 PSP Mod Installer"

!include "nsDialogs.nsh"
!include "winmessages.nsh"
!include "logiclib.nsh"
!include "MUI.nsh"

Page Custom ChooseLanguage

var dialog
Var LanguageChoice

Function ChooseLanguage
         nsDialogs::Create 1018
         Pop $dialog
         
         ${NSD_CreateLabel} 0 0 50% 12u "Pilih Bahasa"
         Pop $0
         
         ${NSD_CreateFirstRadioButton} 0 14u 20% 12u "Indonesia"
         Pop $1
         ${NSD_OnClick} $1 onLanguageChanged

         ${NSD_CreateAdditionalRadioButton} 20% 14u 20% 12u "Inggris"
         Pop $2
         ${NSD_OnClick} $2 onLanguageChanged
         SendMessage $1 ${BM_Click} "" ""
         Pop $3


         nsDialogs::Show
FunctionEnd

; if english is not selected, then insert 0 to language choice, else insert 1
Function onLanguageChanged
         Pop $0
         ${NSD_GetChecked} $1 $0
         ${If} $0 <> ${BST_UNCHECKED}
               StrCpy $LanguageChoice "0"
         ${Else}
                StrCpy $LanguageChoice "1"
         ${EndIf}
FunctionEnd

Var FOLDER_DIR
!define MUI_DIRECTORYPAGE_TEXT_DESTINATION "Folder PPSSPP"
!define MUI_DIRECTORYPAGE_VARIABLE $FOLDER_DIR
!insertmacro MUI_PAGE_DIRECTORY

!insertmacro MUI_PAGE_INSTFILES

Var LangName

Section
       CreateDirectory "$FOLDER_DIR\memstick\PSP\SYSTEM"
       CreateDirectory "$FOLDER_DIR\memstick\PSP\TEXTURES"

       SetOutPath "$FOLDER_DIR\memstick\PSP\SYSTEM"
       SetOverwrite ON
       File "ULJS00374_ppsspp.ini"

       SetOutPath "$FOLDER_DIR\memstick\PSP\TEXTURES\"
       SetOverwrite ON
       File /r "ULJS00374"
       
       SetOutPath "$FOLDER_DIR\memstick\PSP\TEXTURES\ULJS00374"
       ${If} $LanguageChoice == "0"
             File /r "Indonesian"
             StrCpy $LangName "Indonesian"
       ${Else}
             File /r "English"
              StrCpy $LangName "English"
       ${EndIf}
       
       Rename "$FOLDER_DIR\memstick\PSP\TEXTURES\ULJS00374\$LangName" "$FOLDER_DIR\memstick\PSP\TEXTURES\ULJS00374\ui"
       
       CreateDirectory "$FOLDER_DIR\extras"
       SetOutPath "$FOLDER_DIR\extras"
       File /r "EDF2PSPCONTROLS"
SectionEnd