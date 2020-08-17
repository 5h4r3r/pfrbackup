

#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>
#include <Date.au3>

Global $timer, $Secs, $Mins, $Hour, $Time
$hGui = GUICreate("InfoTime", 200, 100, -1, -1, $WS_POPUP, BitOR($WS_EX_TOOLWINDOW, $WS_EX_CONTROLPARENT, $WS_EX_TOPMOST))


Local $CTRL_btnRefresh = GUICtrlCreateButton("Обновить сейчас", 25, 50, 150, 40)
GUICtrlSetFont(-1, 12, 600)

Global $CTRL_EdtScreen = GUICtrlCreateEdit("00:00:00", 10, 2, 180, 45, BitOR($ES_READONLY, $ES_CENTER), $WS_EX_STATICEDGE)
GUICtrlSetFont(-1, 25)
GUICtrlSetColor(-1, 0xFF0000)
GUISetState()

$timer = TimerInit()
AdlibRegister("Timer", 50)

While 1
	$iMsg = GUIGetMsg()
	Switch $iMsg
		Case $CTRL_btnRefresh
			$timer = TimerInit()
			;Run("Infotime.exe")
			;Sleep(2000)
			;WinActivate("InfoTime", "Обновить сейчас")

		Case $GUI_EVENT_CLOSE
			ExitLoop

	EndSwitch
WEnd

Func Timer()
	_TicksToTime(1801000 - Int(TimerDiff($timer)), $Hour, $Mins, $Secs)
	Local $sTime = $Time
	$Time = StringFormat("%02i:%02i:%02i", $Hour, $Mins, $Secs)
	If $sTime <> $Time Then GUICtrlSetData($CTRL_EdtScreen, $Time)
EndFunc   ;==>Timer