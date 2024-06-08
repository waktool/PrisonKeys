; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; PRISON KEYS - AutoHotKey 2.0 Macro for Pet Simulator 99
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; DIRECTIVES & CONFIGURATIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

#Requires AutoHotkey v2.0  ; Ensures the script runs only on AutoHotkey version 2.0, which supports the syntax and functions used in this script.
#SingleInstance Force  ; Forces the script to run only in a single instance. If this script is executed again, the new instance will replace the old one.
CoordMode "Mouse", "Window"  ; Sets the coordinate mode for mouse functions (like Click, MouseMove) to be relative to the active window's client area, ensuring consistent mouse positioning across different window states.
CoordMode "Pixel", "Window"  ; Sets the coordinate mode for pixel functions (like PixelSearch, PixelGetColor) to be relative to the active window's client area, improving accuracy in color detection and manipulation.
SetMouseDelay 10  ; Sets the delay between mouse events to 10 milliseconds, balancing speed and reliability of automated mouse actions.


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GLOBAL VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; Titles and verfsioning for GUI elements.
global MACRO_TITLE := "Prison Keys"  ; The title displayed in main GUI elements.
global MACRO_VERSION := "0.3.2"  ; Script version, helpful for user support and debugging.

; User settings loaded from an INI file.
global SETTINGS_INI := A_ScriptDir "\Settings.ini"  ; Path to settings INI file.

; Pixel check settings.
global PRISON_KEY := Map("pixelStart", [658, 702], "pixelEnd", [658, 702], "pixelColour", 0x9AFB19, "pixelTolerance", 5)
global GOLDEN_KEY := Map("pixelStart", [1291, 706], "pixelEnd", [1291, 706], "pixelColour", 0x98FA18, "pixelTolerance", 5)
global YES_BUTTON := Map("pixelStart", [677, 720], "pixelEnd", [677, 720], "pixelColour", 0x88F712, "pixelTolerance", 5)
global CLOSE_BUTTON := Map("pixelStart", [1292, 277], "pixelEnd", [1292, 277], "pixelColour", 0xFF0A4B, "pixelTolerance", 5)


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; LIBRARIES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; Third-party Libraries:
#Include <OCR>

; Macro Related Libraries:
#Include "%A_ScriptDir%\Modules"
#Include "Coords.ahk"
#Include "Zones.ahk"
#Include "Teleport.ahk"
#Include "Movement.ahk"


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MACRO STARTS HERE
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

runMacro()


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MAIN FUNCTION
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; runMacro Function
; Description: Executes the main macro routine by initializing tasks, displaying the GUI, ensuring the game is active, and unlocking cells.
; Operation:
;   - Completes initial setup tasks required for the macro.
;   - Displays the main graphical user interface.
;   - Activates the Roblox window to ensure it is ready for input.
;   - Continuously checks for any disconnections.
;   - Teleports to a reset position before starting the main cell unlocking routine.
; Dependencies: 
;   - completeInitialisationTasks, showMainGui, activateRoblox, checkForDisconnection, teleportToResetPosition, releasePrisoners: Various functions handling specific operations.
; Return: None; performs the main macro routine.
; ---------------------------------------------------------------------------------
runMacro() {
    completeInitialisationTasks()  ; Perform all initial tasks necessary for the macro's setup.
    showMainGui()  ; Create and display a graphical user interface listing quests and activities.
    activateRoblox()  ; Ensure the Roblox window is active and ready for input.
    checkForDisconnection()  ; Continuously monitor the connection status.
    teleportToResetPosition()  ; Teleport to the reset position.
    releasePrisoners()  ; Start the main routine of unlocking cells.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; PRISON FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; releasePrisoners Function
; Description: Iterates through a list of cells, unlocking and entering them if possible, or checking for chests if not.
; Operation:
;   - Loops through a predefined list of cells.
;   - Moves to each cell and checks if it can be unlocked with a golden key or prison key.
;   - Unlocks and enters the cell if a key is available, otherwise checks for chests in the cell.
;   - Teleports to a reset position after each cell is processed.
;   - Checks for disconnection and waits for cells to refresh before repeating the loop.
; Dependencies: 
;   - moveToCell, isGoldenKeyOption, isPrisonKeyOption, setCurrentAction, UnlockAndEnterCell, clickHoverboard, CheckUnlockedCellForChest, teleportToResetPosition, checkForDisconnect, waitForCellRefresh: Various functions handling specific operations.
; Return: None; performs the unlocking and checking process in a continuous loop.
; ---------------------------------------------------------------------------------
releasePrisoners() {

    Loop {
        prisonCells := ["001", "002", "003", "004", "005", "006", "008", "007"]  ; Define the list of cells to process.
        for prisonCell in prisonCells {
            moveToCell(prisonCell)  ; Move to the specified cell.
            
            if isGoldenKeyOption() || isPrisonKeyOption() || isYesOption() {
                unlockCell(prisonCell)  ; Unlock and enter the cell.
                openChest(prisonCell, true)
            }
            else
                openChest(prisonCell, false)

            checkForDisconnect()  ; Check for disconnection.    
            teleportToResetPosition()  ; Teleport to the reset position.
        }
        useUltimate()
        waitForCellRefresh()  ; Wait for cells to refresh before repeating the loop.
    }
}

; ---------------------------------------------------------------------------------
; waitForCellRefresh Function
; Description: Waits for the cells to refresh within the game, indicating the progress during the wait.
; Operation:
;   - Updates the current action status to indicate the start of the waiting period.
;   - Loops for a specified refresh time, updating the progress each second.
;   - Resets the current action status after the waiting period is over.
; Dependencies: setCurrentAction: Function to update the current action status.
; Return: None; performs a timed wait operation and updates status accordingly.
; ---------------------------------------------------------------------------------
waitForCellRefresh() {
    currentAction := "Waiting for Cells to Refresh..."  ; Define the action description.
    setCurrentAction(currentAction)  ; Indicate the start of the waiting period.
    refreshTime := 5  ; Set the refresh time to 10 seconds.
    
    Loop refreshTime {
        setCurrentAction(currentAction " " A_Index "/" refreshTime)  ; Update waiting progress.
        Sleep 1000  ; Wait for 1 second.
    }
    
    setCurrentAction("-")  ; Reset current action status.
}

; ---------------------------------------------------------------------------------
; moveToCell Function
; Description: Navigates the player to a specified cell within the game using hoverboard movements.
; Operation:
;   - Activates the hoverboard for movement.
;   - Updates the current action status to indicate the movement to the specified cell.
;   - Uses a series of directional movements to reach the desired cell based on its identifier.
;   - Resets the current action status after reaching the cell.
; Dependencies: 
;   - clickHoverboard: Function to toggle hoverboard usage.
;   - setCurrentAction: Function to update the current action status.
;   - moveUpRight, moveUp, moveDown, moveRight, moveLeft, moveDownRight: Functions for directional movements.
; Return: None; performs movement operations to navigate to the specified cell.
; ---------------------------------------------------------------------------------
moveToCell(prisonCell) {
    clickHoverboard(true)  ; Activate hoverboard for movement.
    setCurrentAction("Moving to Cell " prisonCell "...")  ; Update current action status.
    
    Switch prisonCell {   
        Case "001":
            moveFromTeleportSpotToCell001()
        Case "002":
            moveFromTeleportSpotToCell002()
        Case "003":
            moveFromTeleportSpotToCell003()
        Case "004":
            moveFromTeleportSpotToCell004()    
        Case "005":
            moveFromTeleportSpotToCell005()  
        Case "006":
            moveFromTeleportSpotToCell006()
        Case "007":
            moveFromTeleportSpotToCell007()
        Case "008":
            moveFromTeleportSpotToCell008()
        Default:
            ; No movement for unspecified cells.
    }
    
    Sleep 1000  ; Pause briefly to ensure final position is reached.
    setCurrentAction("-")  ; Reset current action status.
}

; ---------------------------------------------------------------------------------
; unlockCell Function
; Description: Handles the process of unlocking a cell based on key preferences and cell position.
; Operation:
;   - Updates the current action status to reflect which cell is being unlocked.
;   - Retrieves the user's key preference from settings.
;   - Based on the cell number, moves the character to the correct position to interact with the lock.
;   - Determines whether to use a golden key or a prison key based on available options and user preference.
;   - Updates the total key count after using a key.
;   - Waits to ensure the door has time to open after the key is used.
; Parameters:
;   - Cell: The specific cell identifier that needs to be unlocked.
; Return: None; this function interacts directly with the game through key presses and updates.
; Dependencies:
;   - setCurrentAction, getSetting, useGoldenKey, usePrisonKey, setTotalKeyCount: Functions that manage game interaction and settings retrieval.
; ---------------------------------------------------------------------------------
unlockCell(prisonCell) {  
    setCurrentAction("Releasing Prisoner " prisonCell "...")  ; Notify the GUI of the action to unlock the cell specified by the parameter.

    ; Move the character to the lock's position based on the cell location
    Switch prisonCell {
        Case "001", "002", "003", "004":
            moveDown(125)  ; Move down to position for unlocking in these cells.
        Case "005", "006", "007", "008":
            moveUp(125)  ; Move up to position for unlocking in these cells.
        Default:
            ; Handle any unexpected cell numbers (not necessary but good for robustness)
    }    

    ; Retrieve the user's preferred key type from settings
    keyPreference := getSetting("keyPreference", "Settings")

    ; Decide which key to use based on the presence of the golden key option, user preference, and other conditions
    if isGoldenKeyOption() && keyPreference == "Golden"
        useGoldenKey()  ; Use a golden key if it's available and preferred.
    else if isPrisonKeyOption() || isYesOption()
        usePrisonKey()  ; Use a prison key if the golden key isn't used/preferred or other conditions apply.

    ; Update the total key count after using a key
    setTotalKeyCount()

    Sleep 2000  ; Delay to ensure the game has time to process the door opening after key use.
}


; ---------------------------------------------------------------------------------
; openChest Function
; Description: Handles the movement and interaction required to open a chest in a game cell.
; Operation:
;   - Updates the current action status to "Opening Chest..." to indicate the operation.
;   - Depending on the cell and whether it's unlocked, moves the character to the chest's location.
;   - Executes a loop to send interaction commands to open the chest.
;   - Waits for a predefined time to ensure that all loot from the chest is collected.
; Parameters:
;   - Cell: The specific cell where the chest is located.
;   - Unlocked: A boolean flag indicating if the chest has already been unlocked (default is false).
; Return: None; this function directly manipulates game controls and updates GUI elements.
; Dependencies:
;   - setCurrentAction: Function that updates the GUI with the current action.
;   - Send, Sleep: Functions to simulate key presses and pause execution, respectively.
; ---------------------------------------------------------------------------------
openChest(prisonCell, cellUnlocked := false) {
    setCurrentAction("Opening Chest...")  ; Inform the GUI about the current action being performed.
    smallAvatar := getSetting("SmallAvatar", "Settings")

    ; Determine movement based on the cell and lock swassdtatus
    Switch prisonCell {
        Case "001", "002", "003", "004":
            if cellUnlocked
                moveUp(230)  ; Move upwards to reach the chest if it's unlocked.
            else if (smallAvatar == "true")
                moveDown(215)
            else
                moveDown(150)  ; Move downwards to reach the chest if it's locked.
            moveRight(500)  ; Move right to align with the chest.

        Case "005", "006", "007", "008":
            if cellUnlocked
                moveDown(230)  ; Move downwards to reach the chest if it's unlocked.
            else if (smallAvatar == "true")
                moveUp(215)
            else      
                moveUp(150)  ; Move upwards to reach the chest if it's locked.
            moveLeft(500)  ; Move left to align with the chest.

        Default:
            ; No default action specified
    }
    
    ; Loop to interact with the chest
    Loop 3 {
        Send "{e}"  ; Press 'e' to interact with the chest.
        Sleep 50  ; Brief pause between interactions to allow game response.
    }
    
    Sleep 2000  ; Wait for two seconds to ensure that all loot is collected.
}

; ---------------------------------------------------------------------------------
; teleportToResetPosition Function
; Description: Teleports the player to a reset position by navigating through predefined zones.
; Operation:
;   - Teleports the player to Zone 200 to initiate the reset sequence.
;   - Immediately teleports the player to Zone 201 to complete the reset sequence.
;   - Waits for 2000 milliseconds to allow the game to process the teleportations.
; Dependencies: teleportToZone: Function to handle teleportation to specific zones.
; Return: None; performs teleportation operations to reset the player's position.
; ---------------------------------------------------------------------------------
teleportToResetPosition() {
    teleportToZone(200)  ; Teleport to the initial reset zone (Zone 200).
    teleportToZone(201)  ; Teleport to the final reset zone (Zone 201).
    Sleep 1000
}

; ---------------------------------------------------------------------------------
; isGoldenKeyOption Function
; Description: Determines if a golden key is required to unlock a cell by detecting a specific color on the screen.
; Operation:
;   - Executes PixelSearch to detect the presence of a specific color within a defined area of the game's UI.
;   - This specific color indicates that a golden key is needed to unlock the cell.
;   - The search is constrained within a rectangular area defined by start and end coordinates.
;   - Uses color tolerance to accommodate slight variations in the detected color, ensuring reliability under different lighting or graphical settings.
; Parameters:
;   - &FoundX, &FoundY: Variables to store the x and y coordinates of the detected color's location.
;   - GOLDEN_KEY["pixelStart"][1], GOLDEN_KEY["pixelStart"][2]: The x and y starting coordinates for the pixel search area.
;   - GOLDEN_KEY["pixelEnd"][1], GOLDEN_KEY["pixelEnd"][2]: The x and y ending coordinates for the pixel search area.
;   - GOLDEN_KEY["pixelColour"]: The RGB color code expected to indicate the need for a golden key.
;   - GOLDEN_KEY["pixelTolerance"]: The tolerance in color detection to handle minor discrepancies.
; Return: Boolean; returns true if the specified color is detected, suggesting that a golden key is needed, false otherwise.
; ---------------------------------------------------------------------------------
isGoldenKeyOption() {
    return PixelSearch(&FoundX, &FoundY, 
        GOLDEN_KEY["pixelStart"][1], GOLDEN_KEY["pixelStart"][2], 
        GOLDEN_KEY["pixelEnd"][1], GOLDEN_KEY["pixelEnd"][2], 
        GOLDEN_KEY["pixelColour"], GOLDEN_KEY["pixelTolerance"])
}

; ---------------------------------------------------------------------------------
; isPrisonKeyOption Function
; Description: Determines if a normal prison key is required to unlock a cell by detecting a specific color on the screen.
; Operation:
;   - Executes PixelSearch to detect the presence of a specific color within a defined area of the game's UI.
;   - This specific color indicates that a normal prison key is needed to unlock the cell.
;   - The search is constrained within a rectangular area defined by start and end coordinates.
;   - Uses color tolerance to accommodate slight variations in the detected color, ensuring reliability under different lighting or graphical settings.
; Parameters:
;   - &FoundX, &FoundY: Variables to store the x and y coordinates of the detected color's location.
;   - PRISON_KEY["pixelStart"][1], PRISON_KEY["pixelStart"][2]: The x and y starting coordinates for the pixel search area.
;   - PRISON_KEY["pixelEnd"][1], PRISON_KEY["pixelEnd"][2]: The x and y ending coordinates for the pixel search area.
;   - PRISON_KEY["pixelColour"]: The RGB color code expected to indicate the need for a prison key.
;   - PRISON_KEY["pixelTolerance"]: The tolerance in color detection to handle minor discrepancies.
; Return: Boolean; returns true if the specified color is detected, suggesting that a normal prison key is needed, false otherwise.
; ---------------------------------------------------------------------------------
isPrisonKeyOption() {
    return PixelSearch(&FoundX, &FoundY, 
        PRISON_KEY["pixelStart"][1], PRISON_KEY["pixelStart"][2], 
        PRISON_KEY["pixelEnd"][1], PRISON_KEY["pixelEnd"][2], 
        PRISON_KEY["pixelColour"], PRISON_KEY["pixelTolerance"])
}

; ---------------------------------------------------------------------------------
; isYesOption Function
; Description: Checks if the "Yes" option is visible on the screen based on pixel color search.
; Operation:
;   - Performs a pixel search within a defined area to detect the specific color that indicates the presence of the "Yes" option.
;   - Utilizes coordinates to define the search area and specific color values to identify the "Yes" option.
; Parameters: None.
; Return: Boolean; returns true if the "Yes" option is found, false otherwise.
; Dependencies:
;   - PixelSearch: Function that searches for a pixel within the specified rectangular area that matches the given color.
;   - YES_BUTTON: A structure containing coordinates, color, and tolerance for the pixel search.
; ---------------------------------------------------------------------------------
isYesOption() {
    ; Search for the pixel within the defined area and return the result
    return PixelSearch(&FoundX, &FoundY, 
        YES_BUTTON["pixelStart"][1], YES_BUTTON["pixelStart"][2], 
        YES_BUTTON["pixelEnd"][1], YES_BUTTON["pixelEnd"][2], 
        YES_BUTTON["pixelColour"], YES_BUTTON["pixelTolerance"])
}

; ---------------------------------------------------------------------------------
; useGoldenKey Function
; Description: Performs a click action using the coordinates of the golden key.
; Operation:
;   - Simulates a mouse left-click at the coordinates specified for the golden key.
;   - Calls a function to update the count of golden keys remaining after use.
; Parameters: None.
; Return: None; directly interacts with the game interface.
; Dependencies:
;   - SendEvent: Function to simulate mouse clicks.
;   - setGoldenKeyCount: Function to update the count of golden keys available.
; ---------------------------------------------------------------------------------
useGoldenKey() {
    SendEvent "{Click, " GOLDEN_KEY["pixelStart"][1] ", " GOLDEN_KEY["pixelStart"][2] ", 1}"  ; Left-click using golden key coordinates.
    setGoldenKeyCount()  ; Update the golden key count after use.
}

; ---------------------------------------------------------------------------------
; usePrisonKey Function
; Description: Performs a click action using the coordinates of the prison key.
; Operation:
;   - Simulates a mouse left-click at the coordinates specified for the prison key.
;   - Calls a function to update the count of prison keys remaining after use.
; Parameters: None.
; Return: None; directly interacts with the game interface.
; Dependencies:
;   - SendEvent: Function to simulate mouse clicks.
;   - setPrisonKeyCount: Function to update the count of prison keys available.
; ---------------------------------------------------------------------------------
usePrisonKey() {
    SendEvent "{Click, " PRISON_KEY["pixelStart"][1] ", " PRISON_KEY["pixelStart"][2] ", 1}"  ; Left-click using prison key coordinates.
    setPrisonKeyCount()  ; Update the prison key count after use.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MACRO SETTINGS/FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; completeInitialisationTasks Function
; Description: Performs a series of initialization tasks to set up the Roblox game environment.
; Operation:
;   - Updates the system tray icon to a custom one.
;   - Activates the Roblox window to ensure it's in focus.
;   - Changes the game window to full screen if not already.
;   - Defines hotkeys for macro controls.
; Dependencies:
;   - updateTrayIcon, activateRoblox, changeToFullscreen, defineHotKeys: Functions to adjust UI elements and settings.
; Return: None; performs setup operations only.
; ---------------------------------------------------------------------------------
completeInitialisationTasks() {
    updateTrayIcon()
    activateRoblox()
    changeToFullscreen()
    defineHotKeys()
}

; ---------------------------------------------------------------------------------
; defineHotKeys Function
; Description: Sets up hotkeys for controlling macros based on user settings.
; Operation:
;   - Retrieves hotkey settings and binds them to macro control functions.
; Dependencies: getSetting: Retrieves user-configured hotkey preferences.
; Return: None; configures hotkeys for runtime use.
; ---------------------------------------------------------------------------------
defineHotKeys() {
    HotKey getSetting("PauseMacroKey", "Settings"), pauseMacro  ; Bind pause macro hotkey.
    HotKey getSetting("ExitMacroKey", "Settings"), exitMacro  ; Bind exit macro hotkey.
}

; ---------------------------------------------------------------------------------
; updateTrayIcon Function
; Description: Sets a custom icon for the application in the system tray.
; Operation:
;   - Composes the file path for the icon and sets it as the tray icon.
; Dependencies: None.
; Return: None; changes the tray icon appearance.
; ---------------------------------------------------------------------------------
updateTrayIcon() {
    iconFile := A_WorkingDir . "\Assets\Prison_Key.ico"  ; Set the tray icon file path.
    TraySetIcon iconFile  ; Apply the new tray icon.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; ROBLOX CLIENT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; activateRoblox Function
; Description: Activates the Roblox game window, ensuring it's the current foreground application.
; Operation:
;   - Attempts to activate the Roblox window using its executable name.
;   - If the window cannot be found, displays an error message and exits the application.
;   - Waits for a predefined delay after successful activation to stabilize the environment.
; Dependencies:
;   - WinActivate: AHK command to focus a window based on given criteria.
;   - MsgBox ExitApp: Functions to handle errors and exit.
;   - Wait: Function to pause the script, ensuring timing consistency.
; Return: None; the function directly interacts with the system's window management.
; ---------------------------------------------------------------------------------
activateRoblox() {
    try {
        WinActivate "ahk_exe RobloxPlayerBeta.exe"  ; Try to focus on Roblox window.
    } catch {
        MsgBox "Roblox window not found."  ; Error message if window is not found.
        ExitApp  ; Exit the script.
    }
    Sleep 200  ; Delay for stabilization after activation.
}

; ---------------------------------------------------------------------------------
; changeToFullscreen Function
; Description: Toggles the Roblox game window to full screen mode if not already.
; Operation:
;   - Checks current window size against the screen resolution and sends F11 if not full screen.
; Dependencies: None.
; Return: None; alters the window state of the game.
; ---------------------------------------------------------------------------------
changeToFullscreen() {
    WinGetPos &X, &Y, &W, &H, "ahk_exe RobloxPlayerBeta.exe"  ; Get current window position.
    if (H != A_ScreenHeight) {
        Send "{F11}"  ; Toggle full screen.
    }
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GUI INITIALISATION
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; showMainGui Function
; Description: Initializes and displays the main graphical user interface for the application.
; Operation:
;   - Sets up the main GUI with properties such as always-on-top to ensure visibility.
;   - Configures visual elements including a list view for activities and control buttons.
;   - Positions the GUI strategically on the screen and attaches event handlers to buttons.
;   - Applies a dark mode theme if enabled, enhancing the interface's accessibility and aesthetics.
; Dependencies:
;   - Gui, guiMain.Show, guiMain.GetPos, guiMain.Move: Functions to create and manage GUI elements.
; Parameters:
;   - None
; Return: None; the function creates and displays the GUI.
; ---------------------------------------------------------------------------------
showMainGui() {
    ; Initialize the main GUI with "AlwaysOnTop" property to ensure it stays in the foreground.
    global guiMain := Gui("+AlwaysOnTop")
    guiMain.Title := MACRO_TITLE " v" MACRO_VERSION  ; Set the GUI title, incorporating version information.
    guiMain.SetFont(, "Segoe UI")  ; Set a modern-looking font for the GUI text.

    ; Create a list view within the GUI to display current activities like timer values.
    global lvCurrent := guiMain.AddListView("Section r1 w425", ["Zone", "Action", "Prison", "Golden", "Total"])
    lvCurrent.Add(, "-", "-", 0, 0, 0, 0, 0, 0, 0) ; Initialize with a default row showing zeroes and a placeholder.
    lvCurrent.ModifyCol(1, 45)  ; Set the width of the first column for the 'Flag' timer.
    lvCurrent.ModifyCol(2, 200) ; Set a larger width for the 'Action' description column.
    lvCurrent.ModifyCol(3, 50) 
    lvCurrent.ModifyCol(4, 50)
    lvCurrent.ModifyCol(5, 50)

    ; Add buttons for interactive controls such as pausing or accessing help and about sections.
    btnPause := guiMain.AddButton("xs", "⏸ &Pause") ; Adds a pause button with a shortcut key.
    btnWiki := guiMain.AddButton("yp", "🌐 &Wiki") ; Adds a wiki button.
    btnReconnect := guiMain.AddButton("yp", "🔁 &Reconnect")

    ; Display the GUI on the screen.
    guiMain.Show()

    ; Position the GUI at the top right of the screen by calculating its width and screen dimensions.
    guiMain.GetPos(,, &Width,)  ; Get the current width of the GUI.
    guiMain.Move(A_ScreenWidth - Width + 8, 0)  ; Move the GUI to just inside the top-right corner.

    ; Attach event handlers to the buttons for defined functionalities.
    btnPause.OnEvent("Click", pauseMacro)  ; Connects the Pause button to its function.
    btnWiki.OnEvent("Click", openWiki)  ; Connects the Help button to its function.
    btnReconnect.OnEvent("Click", reconnectClient)

}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; AUTO-RECONNECT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; checkForDisconnection Function
; Description: Monitors the game to detect if a disconnection has occurred and attempts to reconnect.
; Operation:
;   - Updates the current action status to reflect the connection check.
;   - Determines if a disconnection has occurred.
;   - Initiates a reconnection process if disconnected.
;   - Resets the action status after checking.
; Dependencies:
;   - setCurrentAction, checkForDisconnect, Reconnect: Functions to update UI, check connection, and handle reconnection.
; Return: None; primarily controls game connectivity status.
; ----------------------------------------------------------------------------------------
checkForDisconnection() {
    setCurrentAction("Checking Connection...")  ; Indicate checking connection status.

    isDisconnected := checkForDisconnect()  ; Check for any disconnection.
    if (isDisconnected == true) {
        reconnectClient()  ; Reconnect if disconnected.
        Reload  ; Reload the script to refresh all settings and start fresh.
    }

    setCurrentAction("-")  ; Reset action status.
}

; ----------------------------------------------------------------------------------------
; reconnectClient Function
; Description: Handles the reconnection process by attempting to reconnect to a Roblox game, optionally using a private server.
; Operation:
;   - Retrieves the necessary reconnection settings (time and private server code).
;   - Initiates a connection to Roblox using the appropriate URL scheme.
;   - Displays the reconnect progress in the system tray icon.
; Dependencies:
;   - getSetting, setCurrentAction: Functions to retrieve settings and update UI.
; Return: None; attempts to reconnect to the game.
; ----------------------------------------------------------------------------------------
reconnectClient(*) {
    reconnectTime := getSetting("ReconnectTimeSeconds", "Settings")  ; Get the reconnect duration.

    privateServerLinkCode := getSetting("PrivateServerLinkCode", "Settings")  ; Get the private server code.
    if (privateServerLinkCode == "") {
        try Run "roblox://placeID=8737899170"  ; Default reconnect without private server.
    }
    else {
        try Run "roblox://placeID=8737899170&linkCode=" privateServerLinkCode  ; Reconnect using private server link.
    }

    Loop reconnectTime {
        setCurrentAction("Reconnecting... " A_Index "/" reconnectTime)  ; Update reconnecting progress.
        Sleep 1000  ; Wait for 1 second.
    }
}

; ---------------------------------------------------------------------------------
; checkForDisconnect Function
; Description: Uses OCR to detect disconnection messages within the Roblox game interface.
; Operation:
;   - Activates the Roblox window to ensure it's in focus.
;   - Uses OCR to read the specified screen area for disconnection keywords.
; Dependencies:
;   - activateRoblox, getocrResult: Functions to focus window and perform OCR.
; Return: Boolean; true if disconnected, false otherwise.
; ---------------------------------------------------------------------------------
checkForDisconnect() {
    activateRoblox()  ; Focus the Roblox window.
    X := Coords["OCR"]["DisconnectMessageStart"][1]
    Y := Coords["OCR"]["DisconnectMessageStart"][2]
    W := Coords["OCR"]["DisconnectMessageSize"][1]
    H := Coords["OCR"]["DisconnectMessageSize"][2]
    ocrResult := getOcr(X, Y, W, H, 20)  ; Get OCR results.
    return (RegExMatch(ocrResult, "Disconnected|Reconnect|Leave"))  ; Check for disconnection phrases.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GUI BUTTONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; openWiki Function
; Description: Open the wiki for user assistance.
; Operation:
;   - Executes Notepad with a specified file path to display help documentation.
; Dependencies:
;   - Run: Function to execute external applications.
; Parameters:
;   - None; uses a global variable for the file path.
; Return: None; opens a text file for user reference.
; ---------------------------------------------------------------------------------
openWiki(*) {
    Run "https://github.com/waktool/PrisonKeys/wiki"  ; Open the wiki.
}

; ---------------------------------------------------------------------------------
; pauseMacro Function
; Description: Toggles the pause state of the macro.
; Operation:
;   - Sends a keystroke to simulate a pause/unpause command.
;   - Toggles the pause state of the script.
; Dependencies:
;   - Send: Function to simulate keystrokes.
; Parameters:
;   - None
; Return: None; toggles the paused state of the macro.
; ---------------------------------------------------------------------------------
pauseMacro(*) {
    Send "{F11}"  ; Send the F11 key, which is often used to pause/resume scripts.
    Pause -1  ; Toggle the pause status of the macro.
}

; ---------------------------------------------------------------------------------
; exitMacro Function
; Description: Exits the macro application completely.
; Operation:
;   - Terminates the application.
; Dependencies:
;   - ExitApp: Command to exit the application.
; Parameters:
;   - None
; Return: None; closes the application.
; ---------------------------------------------------------------------------------
exitMacro(*) {
    ExitApp  ; Exit the macro application.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GUI FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; getPrisonKeyCount Function
; Description: Retrieves the current count of prison keys from the GUI list view.
; Operation:
;   - Accesses the GUI list view to extract the text from the cell that represents
;     the current number of prison keys held by the player.
; Parameters: None.
; Return: Integer; returns the number of prison keys currently available as displayed in the GUI.
; Dependencies:
;   - lvCurrent: A global list view object that should be populated with current game data.
;   - GetText: Method of the list view to get text from specified row and column.
; ---------------------------------------------------------------------------------
getPrisonKeyCount() {
    return lvCurrent.GetText(1, 3)  ; Retrieve the count of prison keys from the list view, assumed to be in the third column.
}

; ---------------------------------------------------------------------------------
; getGoldenKeyCount Function
; Description: Retrieves the current count of golden keys from the GUI list view.
; Operation:
;   - Accesses the GUI list view to extract the text from the cell that represents
;     the current number of golden keys held by the player.
; Parameters: None.
; Return: Integer; returns the number of golden keys currently available as displayed in the GUI.
; Dependencies:
;   - lvCurrent: A global list view object that should be populated with current game data.
;   - GetText: Method of the list view to get text from specified row and column.
; ---------------------------------------------------------------------------------
getGoldenKeyCount() {
    return lvCurrent.GetText(1, 4)  ; Retrieve the count of golden keys from the list view, assumed to be in the fourth column.
}

; ---------------------------------------------------------------------------------
; setCurrentAction Function
; Description: Updates the displayed action in a specific UI element to reflect current activities.
; Parameters:
;   - Action: The new action to display, typically a string describing the current activity.
; Operation:
;   - Modifies the text of a specified row in a ListView control to show the new action.
; Dependencies:
;   - lvCurrent.Modify: Method used to update properties of items in a ListView control.
; Return: None; directly modifies the UI to display the updated action.
; ---------------------------------------------------------------------------------
setCurrentAction(currentAction) {
    lvCurrent.Modify(1, , , currentAction)  ; Modify the first row to display the new action.
}

; ---------------------------------------------------------------------------------
; setCurrentZone Function
; Description: Updates the displayed zone in a specific UI element to reflect changes or current status.
; Parameters:
;   - Zone: The new zone to display, typically a string representing the geographic or contextual area.
; Operation:
;   - Modifies the text of the first row in a ListView control to show the updated zone.
; Dependencies:
;   - lvCurrent.Modify: Method used to update properties of items in a ListView control.
; Return: None; directly modifies the UI to display the updated zone information.
; ---------------------------------------------------------------------------------
setCurrentZone(currentZone) {
    lvCurrent.Modify(1, , currentZone)  ; Modify the first row to display the new zone.
}

; ---------------------------------------------------------------------------------
; setPrisonKeyCount Function
; Description: Updates the display of the prison key count in the GUI list view.
; Operation:
;   - Retrieves the current count of prison keys using getPrisonKeyCount().
;   - Increments the count by one to reflect a new total after use or acquisition.
;   - Updates the GUI list view to show the new count of prison keys.
; Parameters: None.
; Return: None; updates the GUI directly.
; Dependencies:
;   - lvCurrent: A global list view object that holds current game data.
;   - getPrisonKeyCount: Function to retrieve the current number of prison keys.
; ---------------------------------------------------------------------------------
setPrisonKeyCount() {
    prisonKeyCount := getPrisonKeyCount() + 1  ; Increment the prison key count.
    lvCurrent.Modify(1, , , , prisonKeyCount)  ; Update the list view at the first row, fourth column (adjust if different).
}

; ---------------------------------------------------------------------------------
; setGoldenKeyCount Function
; Description: Updates the display of the golden key count in the GUI list view.
; Operation:
;   - Retrieves the current count of golden keys using getGoldenKeyCount().
;   - Increments the count by one to reflect a new total after use or acquisition.
;   - Updates the GUI list view to show the new count of golden keys.
; Parameters: None.
; Return: None; updates the GUI directly.
; Dependencies:
;   - lvCurrent: A global list view object that holds current game data.
;   - getGoldenKeyCount: Function to retrieve the current number of golden keys.
; ---------------------------------------------------------------------------------
setGoldenKeyCount() {
    GoldenKeyCount := getGoldenKeyCount() + 1  ; Increment the golden key count.
    lvCurrent.Modify(1, , , , , GoldenKeyCount)  ; Update the list view at the first row, fifth column (adjust if different).
}

; ---------------------------------------------------------------------------------
; setTotalKeyCount Function
; Description: Updates the display of the total key count in the GUI list view.
; Operation:
;   - Retrieves the current counts of both golden and prison keys.
;   - Calculates the total key count by summing the counts.
;   - Updates the GUI list view to show the new total key count.
; Parameters: None.
; Return: None; updates the GUI directly.
; Dependencies:
;   - lvCurrent: A global list view object that holds current game data.
;   - getGoldenKeyCount, getPrisonKeyCount: Functions to retrieve the current number of keys.
; ---------------------------------------------------------------------------------
setTotalKeyCount() {
    TotalKeyCount := getGoldenKeyCount() + getPrisonKeyCount()  ; Calculate the total key count.
    lvCurrent.Modify(1, , , , , , TotalKeyCount)  ; Update the list view at the first row, sixth column (adjust if different).
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; SETTINGS.INI FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; getSetting Function
; Description: Retrieves a setting value from an INI file based on a given key.
; Parameters:
;   - Key: The setting key whose value is to be retrieved.
; Operation:
;   - Reads the value associated with the specified key from a designated INI file section.
; Dependencies:
;   - IniRead: Function used to read data from an INI file.
;   - SETTINGS_INI: Global variable specifying the path to the INI file.
; Return: The value of the specified setting key, returned as a string.
; ---------------------------------------------------------------------------------
getSetting(Key, Section) {
    return IniRead(SETTINGS_INI, Section, Key)  ; Read and return the setting value from the INI file.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; MOVEMENT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; moveRight Function
; Description: Simulates moving right by pressing and holding the 'd' key.
; Parameters:
;   - Milliseconds: Duration to hold the 'd' key.
; Operation:
;   - Presses and holds the 'd' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ---------------------------------------------------------------------------------
moveRight(Milliseconds) {
    Send "{d down}"
    Sleep Milliseconds
    Send "{d up}"
    Sleep 200
}

; ---------------------------------------------------------------------------------
; moveLeft Function
; Description: Simulates moving left by pressing and holding the 'a' key.
; Parameters:
;   - Milliseconds: Duration to hold the 'a' key.
; Operation:
;   - Presses and holds the 'a' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ---------------------------------------------------------------------------------
moveLeft(Milliseconds) {
    Send "{a down}"
    Sleep Milliseconds
    Send "{a up}"
    Sleep 200
}

; ---------------------------------------------------------------------------------
; moveUp Function
; Description: Simulates moving up by pressing and holding the 'w' key.
; Parameters:
;   - Milliseconds: Duration to hold the 'w' key.
; Operation:
;   - Presses and holds the 'w' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ---------------------------------------------------------------------------------
moveUp(Milliseconds) {
    Send "{w down}"
    Sleep Milliseconds
    Send "{w up}"
    Sleep 200
}

; ---------------------------------------------------------------------------------
; moveDown Function
; Description: Simulates moving down by pressing and holding the 's' key.
; Parameters:
;   - Milliseconds: Duration to hold the 's' key.
; Operation:
;   - Presses and holds the 's' key, sleeps for specified milliseconds, then releases the key.
; Return: None; directly interacts with keyboard inputs.
; ---------------------------------------------------------------------------------
moveDown(Milliseconds) {
    Send "{s down}"
    Sleep Milliseconds
    Send "{s up}"
    Sleep 200
}

; ---------------------------------------------------------------------------------
; moveUpLeft Function
; Description: Simulates moving diagonally up-left by pressing and holding the 'w' and 'a' keys.
; Parameters:
;   - Milliseconds: Duration to hold the 'w' and 'a' keys.
; Operation:
;   - Presses and holds both the 'w' and 'a' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ---------------------------------------------------------------------------------
moveUpLeft(Milliseconds) {
    Send "{w down}{a down}"
    Sleep Milliseconds
    Send "{w up}{a up}"
    Sleep 200
}

; ---------------------------------------------------------------------------------
; moveUpRight Function
; Description: Simulates moving diagonally up-right by pressing and holding the 'w' and 'd' keys.
; Parameters:
;   - Milliseconds: Duration to hold the 'w' and 'd' keys.
; Operation:
;   - Presses and holds both the 'w' and 'd' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ---------------------------------------------------------------------------------
moveUpRight(Milliseconds) {
    Send "{w down}{d down}"
    Sleep Milliseconds
    Send "{w up}{d up}"
    Sleep 200
}

; ---------------------------------------------------------------------------------
; moveDownLeft Function
; Description: Simulates moving diagonally down-left by pressing and holding the 's' and 'a' keys.
; Parameters:
;   - Milliseconds: Duration to hold the 's' and 'a' keys.
; Operation:
;   - Presses and holds both the 's' and 'a' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ---------------------------------------------------------------------------------
moveDownLeft(Milliseconds) {
    Send "{s down}{a down}"
    Sleep Milliseconds
    Send "{s up}{a up}"
    Sleep 200
}

; ---------------------------------------------------------------------------------
; moveDownRight Function
; Description: Simulates moving diagonally down-right by pressing and holding the 's' and 'd' keys.
; Parameters:
;   - Milliseconds: Duration to hold the 's' and 'd' keys.
; Operation:
;   - Presses and holds both the 's' and 'd' keys, sleeps for specified milliseconds, then releases the keys.
; Return: None; directly interacts with keyboard inputs.
; ---------------------------------------------------------------------------------
moveDownRight(Milliseconds) {
    Send "{s down}{d down}"
    Sleep Milliseconds
    Send "{s up}{d up}"
    Sleep 200
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; OCR FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; getOcr Function
; Description: Performs OCR (Optical Character Recognition) on a specified rectangular area and returns the result.
; Operation:
;   - Uses the OCR.FromRect function to capture text from the defined coordinates and dimensions.
;   - Returns the full OCR result object or just the recognized text based on the ReturnObject parameter.
; Dependencies: 
;   - OCR.FromRect: Function to perform OCR on a specified rectangular area.
; Return: OCR result object or recognized text.
; ---------------------------------------------------------------------------------
getOcr(X, Y, W, H, Scale, ReturnObject := false) {
    ocrResult := OCR.FromRect(X, Y, W, H, , Scale)  ; Perform OCR on the specified area.
    return ReturnObject ? ocrResult : ocrResult.Text  ; Return the full OCR result object or just the text.
}


; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; HOVERBOARD FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; clickHoverboard Function
; Description: Toggles the hoverboard state and performs additional stabilization if riding.
; Operation:
;   - Sends a key event to toggle the hoverboard.
;   - If riding, updates the action status, performs stabilization movements, and resets the action status.
;   - If not riding, waits for a brief period.
; Dependencies: 
;   - setCurrentAction, moveRight: Functions to update the current action status and perform movements.
; Return: None; performs the operation to toggle the hoverboard and stabilize if necessary.
; ---------------------------------------------------------------------------------
clickHoverboard(Riding) {
    Send "{q}"  ; Toggle the hoverboard state.
    
    if (Riding == true) {
        setCurrentAction("Stabilising Hoverboard...")  ; Update action status to indicate stabilization.
        
        Loop 3 {
            moveRight(10)  ; Perform small right movements to stabilize.
        }
        
        Sleep 1000  ; Wait for 1 second to ensure stabilization.
        setCurrentAction("-")  ; Reset action status.
    }
    else {
        Sleep 200  ; Brief pause if not riding.
    }
}

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; ULTIMATE FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ----------------------------------------------------------------------------------------
; useUltimate Function
; Description: Activates the ultimate ability in the game.
; Operation:
;   - Updates the current action to indicate that the ultimate ability is being used.
;   - Clicks on the ultimate button and waits for the action to process.
;   - Updates the current action to indicate completion.
; Dependencies:
;   - setCurrentAction, LeftClickMouseAndWait: Functions for updating UI actions and performing clicks.
; Return: None; interacts with the game's UI to use an ultimate ability.
; ----------------------------------------------------------------------------------------
useUltimate() {
    setCurrentAction("Using Ultimate")
    Loop 3 {
        SendEvent "{Click, " Coords["Controls"]["Ultimate"][1] ", " Coords["Controls"]["Ultimate"][2] ", 1}" 
    }
    setCurrentAction("-")
}