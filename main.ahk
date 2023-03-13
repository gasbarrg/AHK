init: 
#NoEnv
#SingleInstance, Force
#Persistent
#InstallKeybdHook 
#UseHook 
#KeyHistory, 0
#HotKeyInterval 1
#MaxHotKeysPerInterval 127 

SendMode, InputThenPlay
SetWinDelay, -1
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
CoordMode, Pixel, Screen, RGB
CoordMode, Mouse, Screen 
PID := DllCall("GetCurrentProcessID")
Process, Priority, %PID%, High

;Get Middle of screen
ZeroX := (A_ScreenWidth // 2)
ZeroY := (A_ScreenHeight // 2)

;Get search size
CFovX := (A_ScreenWidth // 80)  
CFovY := (A_ScreenHeight // 36) 

;Get search box
ScanL := ZeroX - CFovX
ScanT := ZeroY - CFovY
ScanR := ZeroX + CFovX
ScanB := ZeroY + CFovY

;Other variables
Random, rand , 10 , 20
LastShotTime := 0
MinGunTime := 103
SprayCount := 0
EMCol := 0xA5A528
ColVn := 20 


Loop, {
    ;refresh variables
    Random, rand ,10 , 20
    ThisTime := A_TickCount

    ;Ensure enough time has elapsed
    deltaTime := ThisTime - LastShotTime
    if (deltaTime > MinGunTime){
        if ((ThisTime - LastShotTime) < 375){ ;If time between shots is less than .375, adjust FOV
            SprayCount := SprayCount + 1
            ScanT := ScanT - (5 * SprayCount)
            ScanB := ScanB - (5 * SprayCount)
        }

        Else{
            ;Reset spray
            SprayCount := 0 
            ;Reset Search Box 
            ScanT := ZeroY - CFovY
            ScanB := ZeroY + CFovY
        }

        PixelSearch, AimX, AimY, ScanL, ScanT, ScanR, ScanB, EMCol, ColVn, Fast RGB
			if(ErrorLevel =0){
			MsgBox "Hit"
            ;dllcall("mouse_event","UInt",0x02)
            ;Sleep (rand)
            ;dllcall("mouse_event","UInt",0x04)
            LastShotTime := A_TickCount
		}
        

    }
}

Numpad1:: ;van 
    MinGunTime := 103 
Numpad2:: ;phant
    MinGunTime := 101
Numpad3:: ;judg 
    MinGunTime := 300 ;fix 

~LButton::Pause, On
~LButton Up::Pause, Off 
	
O::ExitApp


;bDim = 10 ; Change this to desired size.
;xPos = % (A_ScreenWidth/2) - bDim
;yPos = % (A_ScreenHeight/2) - bDim

;Gui, -Caption Border AlwaysOnTop ToolWindow 
;Gui, Color, C0C0C0
;Gui, Show, NA W%bDim% H%bDim% X%xPos% Y%yPos%, hitBox

;WinWait, hitBox
;WinSet, TransColor, C0C0C0 255, hitBox


