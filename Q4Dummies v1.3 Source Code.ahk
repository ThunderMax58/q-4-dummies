; ============================================================================================
; Q For Dummies By ThunderMax (Brandon Ballard)
  Version := "1.4"
  DateModified := "12/10/17"
; Designed For MechWarrior Online & The Golden Foxes
; ============================================================================================

; Next 14 lines checks to see if the program is being launch with admin privileges, if not it forcefully requests them
Loop, %0% ; For each parameter:
{
	param := %A_Index% ; Fetch the contents of the variable whose name is contained in A_Index
	params .= A_Space . param
}
ShellExecute := A_IsUnicode ? "shell32\ShellExecute":"shell32\ShellExecuteA"
If Not A_IsAdmin
{
	If A_IsCompiled
		DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_ScriptFullPath, str, params , str, A_WorkingDir, int, 1)
	Else
		DllCall(ShellExecute, uint, 0, str, "RunAs", str, A_AhkPath, str, """" . A_ScriptFullPath . """" . A_Space . params, str, A_WorkingDir, int, 1)
	ExitApp
}

#Include HtmlBox.ahk ; Includes the HtmlBox function to accommodate HTML & CSS
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases
#InstallKeyBDHook ; Monitors keystrokes for the purpose of activating hotstrings
#IfWinActive MechWarrior Online ; Only works when your inside of the game
SendMode Input ; Recommended for new scripts due to its superior speed and reliability
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory
SetKeyDelay, 0, 0 ; Prevents game interference when keys are pressed
Menu, Tray, NoStandard ; Removes the default AHK menus on the tray icon
Menu, Tray, Add, About / Bindings, AboutQ4D ; Adds the "About / Bindings" menu to the tray icon
Menu, Tray, Add, Exit Q For Dummies, ExitQ4D ; Adds the "Exit Q For Dummies" menu to the tray icon
Menu, Tray, Tip, Q For Dummies ; Gives the tray icon a name when the user hovers over it

; Next 4 lines resets Q, puts toggle mode on, and alerts the user
Send,{Q Up}
ToggleEnabled := True
Toggle := False
SoundBeep 1000, 100 ; Plays a single beep

^!R:: Reload ; Assigns Ctrl-Alt-R as a hotkey to restart the script

^Q:: ; Turns the Q toggle on and off
    If (ToggleEnabled = True)
    {
        Send,{Q Up}
        ToggleEnabled := False
        Toggle := False
        HotKey, Q, Off
        SoundBeep 500, 100
        Sleep 50
        SoundBeep 500, 100 ; Plays two beeps
    }
    Else
    {
        ToggleEnabled := True
        Toggle := False
        HotKey, Q, On
        SoundBeep 1000, 100 ; Plays a single beep
    }
	KeyWait, Q ; Prevents looping
	KeyWait, ^ ; Prevents looping
Return

$Q:: ; Turns the Q key into a toggle
    If (ToggleEnabled = True)
    {
        Toggle := !Toggle
        Send % "{Q " . ((Toggle) ? ("Down") : ("Up")) . "}"
        KeyWait, Q ; Prevents looping
    }
    Else
    {
        Toggle := False
    }
Return

AboutQ4D: ; Opens up a message box when About is clicked
	AboutHTML = 
	(
		<style>
			body {
				text-align: left;
				font-family: Helvetica, Arial, sans-serif;
				font-size: 10pt;
			}
			a, a:link, a:active {
				color: #2E9AFE;
				font-weight: bold; 
			}
			a:visited {
				color: #2E9AFE;
			}
			a:hover {
				color: #08298A;
			}
		</style>

		<div style="font-size:12pt"><b>Q For Dummies by ThunderMax - v%Version% (%DateModified%)</b></div>Made for The Golden Foxes and MechWarrior Online<br>
		Visit The Golden Foxes at <a href="http://foxmwo.com/" target="new">foxmwo.com</a><br>
		<br>
		<b><u>Bindings & Notes:</u></b><br>
		1. "Ctrl+Q" switches toggling mode on and off.<br>
		2. One audible beep is on, two audible beeps is off.<br>
		3. Q For Dummies only works if MechWarrior Online is your active window.
	)
	HtmlBox(AboutHTML, "Q For Dummies - About / Bindings", False, True, False, 500, 200) ; HTML code, Title, Unknown Atrib, Put in body?, Is URL?, Width, Height
Return

ExitQ4D: ; Exists program when Exit is clicked
	ExitApp 
Return