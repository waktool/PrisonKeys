#Requires AutoHotkey v2.0

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT FUNCTIONS
; ----------------------------------------------------------------------------------------
; Description: These functions handle character movement from the teleportation spot to
;   each of the eight cells. The values can be modified in need.
; * Note: Available directions are as follows: 
;   MoveUp, MoveDown, MoveLeft, MoveRight, MoveUpLeft, MoveUpRight, MoveDownLeft, MoveDownRight
; * Note: The numbers are the time in milliseconds to move in each direction.
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

MoveFromTeleportSpotToCell001() {
    MoveUpRight(375)
    MoveUp(1500)
}

MoveFromTeleportSpotToCell002() {
    MoveUpRight(900)
    MoveRight(85)
    MoveUp(1000)
}

MoveFromTeleportSpotToCell003() {
    MoveUpRight(700)
    MoveRight(925)
    MoveUp(230)
    MoveLeft(1330)
    MoveUp(1000)
}

MoveFromTeleportSpotToCell004() {
    MoveUpRight(700)
    MoveRight(925)
    MoveUp(230)
    MoveLeft(555)
    MoveUp(1000)
}

MoveFromTeleportSpotToCell005() {
    MoveDownRight(1100)
    MoveDown(1000)
}

MoveFromTeleportSpotToCell006() {
    MoveDownRight(375)
    MoveDown(1500)
}

MoveFromTeleportSpotToCell007() {
    MoveDownRight(800)
    MoveRight(800)
    MoveDown(1000)
    MoveUp(105)
    MoveLeft(480)
    MoveDown(1000)
}

MoveFromTeleportSpotToCell008() {
    MoveDownRight(800)
    MoveRight(800)
    MoveDown(1000)
    MoveUp(105)
    MoveLeft(1250)
    MoveDown(1000)
}