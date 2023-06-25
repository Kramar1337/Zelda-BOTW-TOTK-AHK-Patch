/*
Ссылки на файлы
https://drive.google.com/file/d/1-HXUyTWSoLHWKVI3NUnssAOccHLLM-Ph/view
https://disk.yandex.ru/d/FcPU9OAqL6fnAw
https://www.dropbox.com/s/m8uve9fiw8s0y7q/zAHKpatch.zip?dl=0
https://www.mediafire.com/file/xlqgbdnn93sshnv/zAHKpatch.zip/file
https://mega.nz/file/9cQXlBhQ#7gdBymC_gpr5-VIITWsPA8wwREa-rB1XN_nhKyzzSdg



Запланировано:
 - 

Изменения: 21.06.2023
 - Проверка шины ScpVBus.sys





C:\Windows\System32\drivers\ScpVBus.sys
C:\Windows\System32\DriverStore\FileRepository\scpvbus.inf_amd64_3ef1399659585192\ScpVBus.sys
C:\Windows\System32\DriverStore\FileRepository\scpvbus.inf_amd64_0753931c84d85377\ScpVBus.sys
*/
Version = ZeldaBOTW&TOTK AHK Patch v1.02 by Kramar1337
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;===================================Запуск с запросом админки
CommandLine := DllCall("GetCommandLine", "Str")
If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) {
	Try {
		If (A_IsCompiled) {
			Run *RunAs "%A_ScriptFullPath%" /restart
		} Else {
			Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
		}
	}
	ExitApp
}
;===================================Рисование трей меню
Menu, Tray, NoStandard
Menu, Tray, add, Exit
Menu, Tray, Icon, Exit, shell32.dll,28, 16
Menu, Tray, Default, Exit
Menu, Tray, Icon, data\patch\zeldaicon.ico

;===================================Получить из реестра путь установки репакича от Fitgirl
RegRead, RegDirCheckZ1, HKEY_LOCAL_MACHINE, SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\The Legend of Zelda: BotW_is1, DisplayName
if RegDirCheckZ1 = The Legend of Zelda: BotW
{
	RegRead, RegDirVar, HKEY_LOCAL_MACHINE, SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\The Legend of Zelda: BotW_is1, Inno Setup: App Path
}
if RegDirVar
{
	EditDirPatch := RegDirVar "\Kramcemu"
	EditDirMlc01 := RegDirVar "\cemu\mlc01"
	EditDirUking := RegDirVar "\cemu\games\BOTW_EUR\code\U-King.rpx"
}
Else
{
	EditDirPatch = C:\Zelda\Kramcemu
	EditDirMlc01 = C:\Zelda\mlc01
	EditDirUking = C:\Zelda\U-King.rpx
}
EditZelda2DirPatch = C:\ZeldaTOTK\KramYuzu
EditZelda2NSP = C:\ZeldaTOTK\Game\zelda2.nsp
EditZelda2SaveImport = 




;=====================================Ведение логов
FormatTime, TimeString
DebugInformationGet = %TimeString%`n=====Общие логи=====
if RegDirCheckZ1
DebugInformationGet=%DebugInformationGet%`nПоиск Fitgirl репака: %RegDirCheckZ1%
if RegDirVar
DebugInformationGet=%DebugInformationGet%`nПуть Fitgirl репака: %RegDirVar%
DebugInformationGet=%DebugInformationGet%`nАвтопуть Zelda 1: %EditDirPatch%
DebugInformationGet=%DebugInformationGet%`nАвтопуть Zelda 1: %EditDirMlc01%
DebugInformationGet=%DebugInformationGet%`nАвтопуть Zelda 1: %EditDirUking%
IfExist, C:\Program Files\vJoy\x64\vJoyConfig.exe
DebugInformationGet=%DebugInformationGet%`nvJoyConfig: ОК
else
DebugInformationGet=%DebugInformationGet%`nvJoyConfig: Не найден
IfExist, C:\Windows\System32\drivers\ScpVBus.sys
DebugInformationGet=%DebugInformationGet%`nvШина найдена C:\Windows\System32\drivers\ScpVBus.sys
Else
DebugInformationGet=%DebugInformationGet%`nvШина не найдена
IfExist, C:\Amiibo1337
DebugInformationGet=%DebugInformationGet%`nАмибо: ОК
else
DebugInformationGet=%DebugInformationGet%`nАмибо: Не найден
RegRead, KeyCheck1337, HKEY_CURRENT_USER, System\CurrentControlSet\Control\MediaProperties\PrivateProperties\DirectInput\VID_1234&PID_BEAD\Calibration\0, GUID
if KeyCheck1337
DebugInformationGet=%DebugInformationGet%`nVJID GUID: %KeyCheck1337%
else
DebugInformationGet=%DebugInformationGet%`nVJID GUID: Виджой Ид не найден
RegRead, pagefileskek, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management, PagingFiles
if pagefileskek
DebugInformationGet=%DebugInformationGet%`nФайл подкачки: %pagefileskek%
else
DebugInformationGet=%DebugInformationGet%`nФайл подкачки не задан
DebugInformationGet=%DebugInformationGet%`n=====Конец=====

IfExist, C:\Windows\System32\drivers\ScpVBus.sys
CheckCheckCheckVBus2 = 0
else
CheckCheckCheckVBus2 = 1


;===================================Рисовашка меню
Gui,1: -MaximizeBox -DPIScale
GetKeyState, Key1Var, vkA0, P
If Key1Var = U
{
	Gui,1: Add, ActiveX, x0 y0 w767 h431 vWMP, WMPLayer.OCX
	file = %A_ScriptDir%\data\patch\zelda.mp4
	WMP.Url := file
	WMP.uiMode := "none"                   ; нет элементов управления WMP
	WMP.stretchToFit := 1                  ; видео растягивается до заданного диапазона ActiveX
	WMP.enableContextMenu := 0             ; нет реакции на правый клик в поле видео
	WMP.settings.setMode("loop", true)
}
Gui,1: Add, Tab3, x768 y0 w290 h432 -Wrap +Buttons +0x8 vTabVarUp AltSubmit, ZeldaBOTW|ZeldaTOTK|INFO
Gui,1: Tab, 1
Gui,1: Add, GroupBox, x776 y32 w272 h69, Пресеты графики Vulkan
Gui,1: Add, Radio, x784 y48 w252 h23 vRadioBOTW1 +Checked, 1. Высокие + Reshade
Gui,1: Add, Radio, x784 y72 w252 h23, 2. Стандартные
Gui,1: Add, GroupBox, x776 y104 w272 h68, Пресеты управления
Gui,1: Add, Radio, x784 y120 w251 h23 vRadioBOTW2 +Checked, 1. M2J - Modded by Kramar1337
Gui,1: Add, Radio, x784 y144 w250 h23, 2. M2J - Classic
Gui,1: Add, GroupBox, x776 y176 w272 h94, Дополнительно
Gui,1: Add, CheckBox, x784 y192 w114 h23 vCheckFramework +Checked, Framework4
Gui,1: Add, CheckBox, x784 y216 w113 h23 vCheckVC +Checked, VC-redist
Gui,1: Add, CheckBox, x784 y240 w112 h23 vCheckVulkan +Checked, Vulkan-runtime
Gui,1: Add, CheckBox, x920 y192 w117 h23 vCheckScpVBus, ScpVBus
Gui,1: Add, CheckBox, x920 y216 w117 h23 vCheckVJoy +Checked, VJoySetup
Gui,1: Add, CheckBox, x920 y240 w117 h23 vCheckShortcut +Checked, Ярлык батника
Gui,1: Add, GroupBox, x776 y272 w272 h112, Путь установки, папка "mlc01", файл "U-King.rpx"
Gui,1: Add, Edit, x784 y288 w200 h21 vEditDirPatch +Disabled, % EditDirPatch
Gui,1: Add, Edit, x784 y320 w200 h21 vEditDirMlc01 +Disabled, % EditDirMlc01
Gui,1: Add, Edit, x784 y352 w200 h21 vEditDirUking +Disabled, % EditDirUking
Gui,1: Add, Button, x992 y288 w47 h23 gZelda1Dir, Dir
Gui,1: Add, Button, x992 y320 w47 h23 gZelda1mlc01, mlc01
Gui,1: Add, Button, x992 y352 w47 h23 gZelda1UKing, U-King
Gui,1: Add, Button, x960 y392 w80 h23 gInstall1 , Install
Gui,1: Add, Button, x784 y392 w80 h23 gExit, Exit
Gui,1: Tab, 2
Gui,1: Add, GroupBox, x776 y32 w272 h68, Пресеты управления
Gui,1: Add, Radio, x784 y48 w251 h23 vRadioTOTK2 +Checked, 1. M2J - Modded by Kramar1337
Gui,1: Add, Radio, x784 y72 w250 h23, 2. M2J - Classic
Gui,1: Add, GroupBox, x776 y104 w272 h117, Дополнительно
Gui,1: Add, CheckBox, x784 y120 w114 h23 vCheckFramework2 +Checked, Framework4
Gui,1: Add, CheckBox, x784 y144 w113 h23 vCheckVC2 +Checked, VC-redist
Gui,1: Add, CheckBox, x784 y168 w112 h23 vCheckVulkan2 +Checked, Vulkan-runtime
Gui,1: Add, CheckBox, x784 y192 w112 h23 vCheckReshade2 +Checked, Reshade
Gui,1: Add, CheckBox, x920 y120 w117 h23 vCheckScpVBus2 +Checked%CheckCheckCheckVBus2%, ScpVBus
Gui,1: Add, CheckBox, x920 y144 w117 h23 vCheckVJoy2 +Checked, VJoySetup
Gui,1: Add, CheckBox, x920 y168 w117 h23 vCheckShortcut2 +Checked, Ярлык батника
Gui,1: Add, GroupBox, x776 y224 w272 h50, Куда распаковать файлы
Gui,1: Add, Button, x992 y240 w47 h23 gZelda2Dir, Dir
Gui,1: Add, Edit, x784 y240 w200 h21 vEditZelda2DirPatch +Disabled, %EditZelda2DirPatch%
Gui,1: Add, GroupBox, x776 y272 w272 h50, Путь к файлам игры .nsp
Gui,1: Add, Button, x992 y288 w47 h23 gZelda2NSP, NSP
Gui,1: Add, Edit, x784 y288 w200 h21 vEditZelda2NSP +Disabled, %EditZelda2NSP%
Gui,1: Add, GroupBox, x776 y320 w272 h50, Импорт сохранений
Gui,1: Add, Button, x992 y336 w47 h23 gZelda2SaveImport, Import
Gui,1: Add, Edit, x784 y336 w200 h21 vEditZelda2SaveImport +Disabled, %EditZelda2SaveImport%
Gui,1: Add, Button, x960 y392 w80 h23 gInstall2, Install
Gui,1: Add, Button, x784 y392 w80 h23 gExit, Exit
Gui,1: Tab, 3
Gui,1: Add, GroupBox, x768 y32 w287 h233, Debug
Gui,1: Add, Edit, x776 y48 w271 h208 +ReadOnly +Multi vDebugInformationGet, %DebugInformationGet%
Gui,1: Add, Button, x776 y272 w80 h23 gGetListVars1337, Variables
Gui,1: Add, Button, x872 y272 w80 h23 gPickregedit, Regedit
Gui,1: Add, Button, x968 y272 w80 h23 gCopyDebugInformationGet, Copy
Gui,1: Add, GroupBox, x768 y362 w143 h88, Ссылки
Gui,1: Add, Picture, x776 y384 w36 h36 +BackgroundTrans gPicgoyt, data\patch\aYt.png
Gui,1: Add, Picture, x824 y384 w36 h36 +BackgroundTrans gPicgogit, data\patch\aGithub.png
Gui,1: Add, Picture, x872 y384 w30 h36 +BackgroundTrans gPicgoBoo, data\patch\aBoo.png
Gui,1: Add, GroupBox, x912 y362 w143 h88, Дампим игру ( ͡° ͜ʖ ͡°)﻿
Gui,1: Add, Picture, x928 y376 w50 h50 +BackgroundTrans gPicgoBOTW, data\patch\zelda1.png
Gui,1: Add, Picture, x1000 y376 w50 h50 +BackgroundTrans gPicgoTOTK, data\patch\zelda2.png
Gui,1: Tab
Gui,1: Show, w1057 h431 Center, %Version%
Return


PicgoBOTW: 	; Сдампить зельду 1
Run data\tor\Zelda1.torrent
Return

PicgoTOTK: 	; Сдампить зельду 2
Run data\tor\Zelda2.torrent
Return

GetListVars1337: 	; Отладочные работы
ListVars
Return
CopyDebugInformationGet: 	; Копировать содержимое
Gui, 1: Submit, NoHide
Clipboard:=DebugInformationGet
Return

Picgoyt:
Run https://www.youtube.com/channel/UCWokUgKYuToN89x-kogVt-w
Return

Picgogit:
Run https://github.com/Kramar1337
Return

PicgoBoo:
Run https://boosty.to/kramar1337
Return

Pickregedit:
Run, cmd /k @echo Off & reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Applets\Regedit /v LastKey /t REG_SZ /d "HKEY_LOCAL_MACHINE\SOFTWARE\Khronos\Vulkan\ImplicitLayers" /f & start "title" /b regedit.exe & exit
Return

GuiClose:
ExitApp

Exit:
ExitApp
Return




; ==============================================================Zelda 1 указать путь
Zelda1Dir:
FileSelectFolder, EditDirPatch, ::{20d04fe0-3aea-1069-a2d8-08002b30309d},3, Куда распаковать файлы?
if ErrorLevel = 0
{
	if EditDirPatch !=
	{
		GuiControl,1:, EditDirPatch, %EditDirPatch%
	}
}
DebugInformationGet =%TimeString%`nМетка "Zelda1Dir": %EditDirPatch%`n%DebugInformationGet%
GuiControl,1:, DebugInformationGet, %DebugInformationGet%
Return
Zelda1mlc01:
FileSelectFolder, EditDirMlc01, ::{20d04fe0-3aea-1069-a2d8-08002b30309d},3, Путь к папке "mlc01"
if ErrorLevel = 0
{
	if EditDirMlc01 !=
	{
		IfNotExist, %EditDirMlc01%
		{
			Msgbox,,, Не верный путь! Не найдена папка Mlc01:`n%EditDirMlc01%, 5
			Return
		}
		GuiControl,1:, EditDirMlc01, %EditDirMlc01%
	}
	IfNotExist, %EditDirMlc01%
	{
		Msgbox,,, Не верный путь! Не найдена папка Mlc01:`n%EditDirMlc01%, 5
		Return
	}
}
DebugInformationGet =%TimeString%`nМетка "Zelda1mlc01": %EditDirMlc01%`n%DebugInformationGet%
GuiControl,1:, DebugInformationGet, %DebugInformationGet%
Return
Zelda1UKing:
FileSelectFile, EditDirUking, 3,, Путь к файлу "U-King.rpx", U-King.rpx
if ErrorLevel = 0
{
	if EditDirUking !=
	{
		IfNotExist, %EditDirMlc01%
		{
			Msgbox,,, Не верный путь! Не найден файл U-King.rpx:`n%EditDirUking%, 5
			Return
		}
		GuiControl,1:, EditDirUking, %EditDirUking%
	}
	IfNotExist, %EditDirMlc01%
	{
		Msgbox,,, Не верный путь! Не найден файл U-King.rpx:`n%EditDirUking%, 5
		Return
	}
}
DebugInformationGet =%TimeString%`nМетка "Zelda1UKing": %EditDirUking%`n%DebugInformationGet%
GuiControl,1:, DebugInformationGet, %DebugInformationGet%
Return

; ==============================================================Zelda 2 указать путь
Zelda2Dir:
FileSelectFolder, EditZelda2DirPatch, ::{20d04fe0-3aea-1069-a2d8-08002b30309d},3, Куда распаковать файлы?
if ErrorLevel = 0
{
	if EditZelda2DirPatch !=
	{
		GuiControl,1:, EditZelda2DirPatch, %EditZelda2DirPatch%
	}
}
DebugInformationGet =%TimeString%`nМетка "Zelda2Dir": %EditZelda2DirPatch%`n%DebugInformationGet%
GuiControl,1:, DebugInformationGet, %DebugInformationGet%
Return
Zelda2NSP:
FileSelectFile, EditZelda2NSP, 3,, Путь к папке c файлами игры, *.nsp
if ErrorLevel = 0
{
	if EditZelda2NSP !=
	{
		IfNotExist, %EditZelda2NSP%
		{
			Msgbox,,, Не верный путь! Не найден файл:`n%EditZelda2NSP%, 5
			Return
		}
		GuiControl,1:, EditZelda2NSP, %EditZelda2NSP%
	}
	IfNotExist, %EditZelda2NSP%
	{
		Msgbox,,, Не верный путь! Не найден файл:`n%EditZelda2NSP%, 5
		Return
	}
	FileGetSize, OutputVarGetSize, %EditZelda2NSP%, M
	if ErrorLevel = 0
	{
		if OutputVarGetSize < 10000
		Msgbox,,,False`nВыбран не верный файл. Размер файла: %OutputVarGetSize% мб, 3
		Else
		Msgbox,,,True`nРазмер файла: %OutputVarGetSize% мб, 1
	}
}
DebugInformationGet =%TimeString%`nМетка "Zelda2NSP": %EditZelda2NSP%`n%DebugInformationGet%
GuiControl,1:, DebugInformationGet, %DebugInformationGet%
Return
Zelda2SaveImport:
FileSelectFile, EditZelda2SaveImport, 3,, Путь к файлу "option.sav", *.sav
if ErrorLevel = 0
{
	if EditZelda2SaveImport !=
	{
		IfNotExist, %EditZelda2SaveImport%
		{
			Msgbox,,, Не верный путь! Не найден файл option.sav:`n%EditZelda2SaveImport%, 5
			Return
		}
		GuiControl,1:, EditZelda2SaveImport, %EditZelda2SaveImport%
	}
	IfNotExist, %EditZelda2SaveImport%
	{
		Msgbox,,, Не верный путь! Не найден файл option.sav:`n%EditZelda2SaveImport%, 5
		Return
	}
}
DebugInformationGet =%TimeString%`nМетка "Zelda2SaveImport": %EditZelda2SaveImport%`n%DebugInformationGet%
GuiControl,1:, DebugInformationGet, %DebugInformationGet%
Return


;==================================Установка Zelda 2 TOTK
Install2:
Gui, 1: Submit, NoHide
MsgBox 0x24, Ready steady go, Стартуем?
IfMsgBox Yes, {
Goto, Install1go2
} Else IfMsgBox No, {
return
}
return
Install1go2:
IfNotExist, %EditZelda2NSP%
{
	Msgbox,,, Не найден:`n%EditZelda2NSP%, 5
	Return
}
IfNotExist, %EditZelda2DirPatch%
{
	FileCreateDir, %EditZelda2DirPatch%
}
Loop, %EditZelda2DirPatch%\*.*
{
	if A_Index > 0
	{
		MsgBox 0x1, ,Папка не пуста, продолжить установку?
		IfMsgBox OK, {
		} Else IfMsgBox Cancel, {
		Return
		}
		Break
	}
}

Gui, 2: Color, White
Gui, 2: +ToolWindow -Caption +LastFound -DPIScale 
Gui, 2: Margin, 10, 10
Gui, 2: Add, Progress, x16 y16 w357 h37 -Smooth vPro1337, 0
Gui, 2: Add, Button, x392 y16 w89 h37 gPauseGuiCl, Exit
Gui, 2: Font, s10 Bold, Segoe UI
Gui, 2: Add, Text, vTextInstall1 x16 y64 w469 h23, Status: Рисование Gui
Gui, 2: Font
Gui, 2: Show, y0 w498 h96, Install
GuiControl,2:, Pro1337, +10
if CheckFramework2
{
	sleep 200
	GuiControl,2:, TextInstall1, Status: Установка Framework4.exe
	RunWait, data\1zelda\soft\Framework4.exe
}
	GuiControl,2:, Pro1337, +10
if CheckVC2
{
	sleep 200
	GuiControl,2:, TextInstall1, Status: Установка VC_redist.x64.exe
	RunWait, data\1zelda\soft\VC_redist.x64.exe
}
	GuiControl,2:, Pro1337, +10
if CheckVulkan2
{
	sleep 200
	GuiControl,2:, TextInstall1, Status: Установка vulkan-runtime.exe
	RunWait, data\1zelda\soft\vulkan-runtime.exe
}
	GuiControl,2:, Pro1337, +10
if CheckVJoy2
{
	sleep 200
	GuiControl,2:, TextInstall1, Status: Установка vJoySetup.exe и vJoySetup.bat
	RunWait, data\1zelda\soft\vJoySetup.exe
	RunWait, data\1zelda\soft\vJoySetup.bat
	GuiControl,2:, Pro1337, +10
}
if CheckScpVBus2
{
	GuiControl,2:, TextInstall1, Status: Установка ScpVBus.sys
	RunWait, data\1zelda\soft\ScpVBusDriver\install.bat
}


;========================================================Установка m2j и прочее
sleep 200
GuiControl,2:, TextInstall1, Status: Установка m2j и прочее
GuiControl,2:, Pro1337, +10
if RadioTOTK2 = 1 	;Управление 1 пресет
	FileCopyDir, data\2zelda\m2jcustomz2, %EditZelda2DirPatch%, 1
if RadioTOTK2 = 2 	;Управление 2 пресет
	FileCopyDir, data\2zelda\m2jorigin, %EditZelda2DirPatch%, 1

;========================================================Установка файлов эмулятора
sleep 200
GuiControl,2:, TextInstall1, Status: Установка файлов эмулятора
GuiControl,2:, Pro1337, +5
FileCopyDir, data\2zelda\yuzu, %EditZelda2DirPatch%, 1

	SplitPath, EditZelda2NSP,,EditZelda2NSPx1dir
	StringReplace, EditZelda2NSPx1dir, EditZelda2NSPx1dir, \, /, All
	
	FileRead, RegNewZelda2Str0, data\2zelda\yuzu\user\config\qt-config.ini
	RegNewZelda2NewStr1 := RegExReplace(RegNewZelda2Str0, "Paths\\romsPath(.*)", "Paths\romsPath="EditZelda2NSPx1dir)
	RegNewZelda2NewStr1 := RegExReplace(RegNewZelda2NewStr1, "Paths\\gamedirs\\4\\path(.*)", "Paths\gamedirs\4\path="EditZelda2NSPx1dir)
	FileAppend, %RegNewZelda2NewStr1%, data\qt-config.ini
	FileCopy, data\qt-config.ini, %EditZelda2DirPatch%\user\config, 1
	FileDelete, data\qt-config.ini

sleep 200
GuiControl,2:, TextInstall1, Status: Установка Решейда
GuiControl,2:, Pro1337, +5
;=========================================================Решейд
if CheckReshade2
{
	RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Khronos\Vulkan\ImplicitLayers, C:\ProgramData\ReShade\ReShade64.json
	RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\Khronos\Vulkan\ImplicitLayers, C:\ProgramData\ReShade\ReShade64.json, 0
	FileCreateDir, C:\ProgramData\ReShade
	FileCopyDir, data\1zelda\ReShade, C:\ProgramData\ReShade, 1
	FileCopyDir, data\1zelda\cemuReShade, %EditZelda2DirPatch%, 1
}



;=============================Импорт сейвов
IfExist, %EditZelda2SaveImport%
{
sleep 200
GuiControl,2:, TextInstall1, Status: Импорт сохранений
GuiControl,2:, Pro1337, +5
	SplitPath, EditZelda2SaveImport,,dirVarSave,ExtVar
	if (ExtVar = "sav")
	{
		; RegExMatch(dirVarSave, "user\\(.*)", RegExdirVarSave)
		FileCreateDir, %EditZelda2DirPatch%\user\nand\user\save\0000000000000000\AB4A494E6F36123B8EB9421C649740D3\0100F2C0115B6000
		FileCopyDir, %dirVarSave%, %EditZelda2DirPatch%\user\nand\user\save\0000000000000000\AB4A494E6F36123B8EB9421C649740D3\0100F2C0115B6000, 1
	}
}
Else
{
GuiControl,2:, Pro1337, +5
}

;=================================Нинтендовский киндерсюрприз с НФС
sleep 200
GuiControl,2:, Pro1337, +5
GuiControl,2:, TextInstall1, Status: Нинтендовский киндерсюрприз с НФС
FileCreateDir, C:\Amiibo1337
FileCopyDir, data\1zelda\Amiibo1337, C:\Amiibo1337, 1
sleep 200
GuiControl,2:, Pro1337, +10
;===================================================Создание ярлыка
if CheckShortcut2
{
	GuiControl,2:, TextInstall1, Status: Создание ярлыка
	sleep 100
	;=================================Батник ярлык 1
	SplitPath, EditZelda2NSP,,EditZelda2NSPx1dir
	FileRead, StarterTOTKVar, data\2zelda\soft\StarterTOTK.txt
	StarterTOTKVarReplace := RegExReplace(StarterTOTKVar, "228regexma1", EditZelda2DirPatch "\yuzu.exe")
	StarterTOTKVarReplace := RegExReplace(StarterTOTKVarReplace, "228regexma2", EditZelda2NSP)
	StarterTOTKVarReplace := RegExReplace(StarterTOTKVarReplace, "228regexma3", EditZelda2DirPatch)
	FileAppend, %StarterTOTKVarReplace%, StarterTOTK.bat
	FileMove, StarterTOTK.bat, %EditZelda2DirPatch%\, 1
	FileCreateShortcut, %EditZelda2DirPatch%\StarterTOTK.bat, %A_Desktop%\Zelda TOTK.lnk, %EditZelda2DirPatch%\, , THE BEST GAME IN THE WORLD, %EditZelda2DirPatch%\ziconz.ico
	;=================================Батник ярлык 2 с админкой
	FileRead, StarterTOTKVar, data\2zelda\soft\StarterTOTKadmin.txt
	StarterTOTKVarReplace := RegExReplace(StarterTOTKVar, "228regexma1", EditZelda2DirPatch "\yuzu.exe")
	StarterTOTKVarReplace := RegExReplace(StarterTOTKVarReplace, "228regexma2", EditZelda2NSP)
	StarterTOTKVarReplace := RegExReplace(StarterTOTKVarReplace, "228regexma3", EditZelda2DirPatch)
	FileAppend, %StarterTOTKVarReplace%, StarterTOTKadmin.bat
	FileMove, StarterTOTKadmin.bat, %EditZelda2DirPatch%\, 1
	FileCreateShortcut, %EditZelda2DirPatch%\StarterTOTKadmin.bat, %A_Desktop%\Zelda TOTK Admin.lnk, %EditZelda2DirPatch%\, , THE BEST GAME IN THE WORLD, %EditZelda2DirPatch%\ziconz.ico
}
Else
{
	GuiControl,2:, TextInstall1, Status: Ярлык Yuzu.exe
	sleep 100
	FileCreateShortcut, %EditZelda2DirPatch%\Yuzu.exe, %A_Desktop%\Yuzu.lnk, %EditZelda2DirPatch%\, , THE BEST GAME IN THE WORLD, %EditZelda2DirPatch%\ziconz.ico
}
	GuiControl,2:, Pro1337, +5
sleep 200
GuiControl,2:, TextInstall1, Status: Конец потока
sleep 200
Gui, 2: Destroy
Gui, 1: Show
MsgBox,,, Successful, 1
Run, https://boosty.to/kramar1337
Return



;==================================Установка Zelda 1 BOTW
Install1:
Gui, 1: Submit, NoHide
MsgBox 0x24, Ready steady go, Стартуем?
IfMsgBox Yes, {
Goto, Install1go
} Else IfMsgBox No, {
return
}
return
Install1go:
IfNotExist, %EditDirPatch%\Kramcemu
{
	FileCreateDir, %EditDirPatch%
}
IfNotExist, %EditDirMlc01%
{
	Msgbox,,, Не верный путь!`n%EditDirMlc01%, 5
	Return
}
IfNotExist, %EditDirUking%
{
	Msgbox,,, Не верный путь! Не найден файл U-King.rpx:`n%EditDirUking%, 5
	Return
}
Gui, 2: Color, White
Gui, 2: +ToolWindow -Caption +LastFound -DPIScale 
Gui, 2: Margin, 10, 10
Gui, 2: Add, Progress, x16 y16 w357 h37 -Smooth vPro1337, 0
Gui, 2: Add, Button, x392 y16 w89 h37 gPauseGuiCl, Exit
Gui, 2: Font, s10 Bold, Segoe UI
Gui, 2: Add, Text, vTextInstall1 x16 y64 w469 h23, Status: Рисование Gui
Gui, 2: Font
Gui, 2: Show, y0 w498 h96, Install

	GuiControl,2:, Pro1337, +10
if CheckFramework
{
	sleep 200
	GuiControl,2:, TextInstall1, Status: Установка Framework4.exe
	RunWait, data\1zelda\soft\Framework4.exe
}
	GuiControl,2:, Pro1337, +10
if CheckVC
{
	sleep 200
	GuiControl,2:, TextInstall1, Status: Установка VC_redist.x64.exe
	RunWait, data\1zelda\soft\VC_redist.x64.exe
}
	GuiControl,2:, Pro1337, +10
if CheckVulkan
{
	sleep 200
	GuiControl,2:, TextInstall1, Status: Установка vulkan-runtime.exe
	RunWait, data\1zelda\soft\vulkan-runtime.exe
}
	GuiControl,2:, Pro1337, +10



if CheckVJoy
{
	sleep 200
	GuiControl,2:, TextInstall1, Status: Установка vJoySetup.exe и vJoySetup.bat
	RunWait, data\1zelda\soft\vJoySetup.exe
	RunWait, data\1zelda\soft\vJoySetup.bat
	GuiControl,2:, Pro1337, +10
}
if CheckScpVBus
{
	GuiControl,2:, TextInstall1, Status: Установка ScpVBus.sys
	RunWait, data\1zelda\soft\ScpVBusDriver\install.bat
}
;========================================================Установка m2j и прочее
sleep 200
GuiControl,2:, TextInstall1, Status: Установка m2j и прочее
	GuiControl,2:, Pro1337, +10
RegRead, KeyCheck1337, HKEY_CURRENT_USER, System\CurrentControlSet\Control\MediaProperties\PrivateProperties\DirectInput\VID_1234&PID_BEAD\Calibration\0, GUID
if KeyCheck1337 	;Если в реестре есть запись то прочитать и записать в файл настроек эмулятора GUID
{
	StringMid, char, KeyCheck1337, 1, 8
	char = 0x%char%
	1step := swap(char, 4)
	StringMid, char, KeyCheck1337, 9, 4
	char = 0x%char%
	2step := swap(char, 2)
	StringMid, char, KeyCheck1337, 13, 4
	char = 0x%char%
	3step := swap(char, 2)
	StringMid, char, KeyCheck1337, 17, 4
	4step := char
	StringMid, char, KeyCheck1337, 21, 12
	5step := char
	FullGUID = %1step%-%2step%-%3step%-%4step%-%5step%
	FileRead, txtcontroller0, data\1zelda\cemu\controllerProfiles\controller0.xml
	endkeyreg1337:= RegExReplace(txtcontroller0, "<uuid>(.*)</uuid>", "<uuid>"(FullGUID)"</uuid>")
	FileAppend, %endkeyreg1337%, data\controller0.xml
	FileCopy, data\controller0.xml, data\1zelda\cemu\controllerProfiles\controller0.xml, 1
	FileDelete, data\controller0.xml
}
Else 	;Если нет записей то создать GUID
{
	RegWrite, REG_BINARY, HKEY_CURRENT_USER, System\CurrentControlSet\Control\MediaProperties\PrivateProperties\DirectInput\VID_1234&PID_BEAD\Calibration\0, GUID, 133722855FD9E8118002444553540000
	FullGUID = 85223713-D95F-11E8-8002-444553540000
	FileRead, txtcontroller0, data\1zelda\cemu\controllerProfiles\controller0.xml
	endkeyreg1337:= RegExReplace(txtcontroller0, "<uuid>(.*)</uuid>", "<uuid>"(FullGUID)"</uuid>")
	FileAppend, %endkeyreg1337%, data\controller0.xml
	FileCopy, data\controller0.xml, data\1zelda\cemu\controllerProfiles\controller0.xml, 1
	FileDelete, data\controller0.xml
}
if RadioBOTW2 = 1 	;Управление 1 пресет
	FileCopyDir, data\1zelda\m2jcustomz1, %EditDirPatch%, 1
if RadioBOTW2 = 2 	;Управление 2 пресет
	FileCopyDir, data\1zelda\m2jorigin, %EditDirPatch%, 1
;========================================================Установка файлов эмулятора
sleep 200
GuiControl,2:, TextInstall1, Status: Установка файлов эмулятора
	GuiControl,2:, Pro1337, +10
FileCopyDir, data\1zelda\cemu, %EditDirPatch%, 1
if RadioBOTW1 = 1 	;Графика 1 пресет
{
	FileSetAttrib, -R, %EditDirPatch%\settings.xml
	FileDelete, %EditDirPatch%\settings.xml
	FileRead, NewStr0, data\1zelda\cemu-data\1\settings.xml
	NewStr1 := RegExReplace(NewStr0, "zxccode1cxz", EditDirMlc01)
	GetGamesDir := RegExReplace(EditDirUking, "\BOTW_EUR\code\U-King.rpx", "")
	NewStr2 := RegExReplace(NewStr1, "zxccode2cxz", GetGamesDir)
	NewStr3 := RegExReplace(NewStr2, "zxccode3cxz", EditDirUking)
	FileAppend, %NewStr3%, %EditDirPatch%\settings.xml
	;===============Решейд
	RegDelete, HKEY_LOCAL_MACHINE, SOFTWARE\Khronos\Vulkan\ImplicitLayers, C:\ProgramData\ReShade\ReShade64.json
	RegWrite, REG_DWORD, HKEY_LOCAL_MACHINE, SOFTWARE\Khronos\Vulkan\ImplicitLayers, C:\ProgramData\ReShade\ReShade64.json, 0
	FileCreateDir, C:\ProgramData\ReShade
	FileCopyDir, data\1zelda\ReShade, C:\ProgramData\ReShade, 1
	FileCopyDir, data\1zelda\cemuReShade, %EditDirPatch%, 1
}
if RadioBOTW1 = 2 	;Графика 2 пресет
{
	FileSetAttrib, -R, %EditDirPatch%\settings.xml
	FileDelete, %EditDirPatch%\settings.xml
	FileRead, NewStr0, data\1zelda\cemu-data\2\settings.xml
	NewStr1 := RegExReplace(NewStr0, "zxccode1cxz", EditDirMlc01)
	GetGamesDir := RegExReplace(EditDirUking, "\BOTW_EUR\code\U-King.rpx", "")
	NewStr2 := RegExReplace(NewStr1, "zxccode2cxz", GetGamesDir)
	NewStr3 := RegExReplace(NewStr2, "zxccode3cxz", EditDirUking)
	FileAppend, %NewStr3%, %EditDirPatch%\settings.xml
}
;=================================Нинтендовский киндерсюрприз с НФС
sleep 200
	GuiControl,2:, Pro1337, +10
GuiControl,2:, TextInstall1, Status: Нинтендовский киндерсюрприз с НФС
FileCreateDir, C:\Amiibo1337
FileCopyDir, data\1zelda\Amiibo1337, C:\Amiibo1337, 1
sleep 200

	GuiControl,2:, Pro1337, +10
if CheckShortcut
{
	GuiControl,2:, TextInstall1, Status: Батники ярлыки
	sleep 100
	;=================================Батник ярлык 1
	FileRead, StarterBOTWVar, data\1zelda\soft\StarterBOTW.txt
	StarterBOTWVarReplace := RegExReplace(StarterBOTWVar, "228regexma1", EditDirPatch "\Cemu.exe")
	StarterBOTWVarReplace := RegExReplace(StarterBOTWVarReplace, "228regexma2", EditDirUking)
	StarterBOTWVarReplace := RegExReplace(StarterBOTWVarReplace, "228regexma3", EditDirPatch)
	FileAppend, %StarterBOTWVarReplace%, StarterBOTW.bat
	FileMove, StarterBOTW.bat, %EditDirPatch%\, 1
	FileCreateShortcut, %EditDirPatch%\StarterBOTW.bat, %A_Desktop%\Zelda BOTW.lnk, %EditDirPatch%\, , THE BEST GAME IN THE WORLD, %EditDirPatch%\ziconz.ico
	;=================================Батник ярлык 2 с админкой
	FileRead, StarterBOTWVar, data\1zelda\soft\StarterBOTWadmin.txt
	StarterBOTWVarReplace := RegExReplace(StarterBOTWVar, "228regexma1", EditDirPatch "\Cemu.exe")
	StarterBOTWVarReplace := RegExReplace(StarterBOTWVarReplace, "228regexma2", EditDirUking)
	StarterBOTWVarReplace := RegExReplace(StarterBOTWVarReplace, "228regexma3", EditDirPatch)
	FileAppend, %StarterBOTWVarReplace%, StarterBOTWadmin.bat
	FileMove, StarterBOTWadmin.bat, %EditDirPatch%\, 1
	FileCreateShortcut, %EditDirPatch%\StarterBOTWadmin.bat, %A_Desktop%\Zelda BOTW Admin.lnk, %EditDirPatch%\, , THE BEST GAME IN THE WORLD, %EditDirPatch%\ziconz.ico
}
Else
{
	GuiControl,2:, TextInstall1, Status: Ярлык Cemu.exe
	sleep 100
	FileCreateShortcut, %EditDirPatch%\Cemu.exe, %A_Desktop%\Cemu.lnk, %EditDirPatch%\, , THE BEST GAME IN THE WORLD, %EditDirPatch%\ziconz.ico
}
	GuiControl,2:, Pro1337, +10
sleep 200
GuiControl,2:, TextInstall1, Status: Конец потока
sleep 200
Gui, 2: Destroy
Gui, 1: Show
MsgBox,,, Successful, 1
Run, https://boosty.to/kramar1337
return

PauseGuiCl:
Gui, 2: Destroy
Gui, 1: Show
ExitApp

; Функция переворачивания байтов для конвертации GUID (идентификатор виртуального джойстика)
swap(num, size)  {  ; size — количество байт в числе, поддерживается 2, 4, 8
   if !type := {2: "UShort", 4: "UInt", 8: "UInt64"}[size]
      Return
   VarSetCapacity(buff, size*2, 0)
   NumPut(num, buff, type)
   Loop % size
      DllCall("msvcrt\memmove", Ptr, &buff + size*2 - A_Index, Ptr, &buff + A_Index - 1, Ptr, 1)
   Return Format( "{:X}", NumGet(&buff + size, type) )
}








