#Requires AutoHotkey v2.0

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; GLOBAL VARIABLES
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

global TELEPORT_ICON_BUTTON := Map("Start", [448, 245], "End", [456, 253], "Colour", 0xDD1242, "Tolerance", 5)
global TELEPORT_SEARCH_CURSOR := Map("Start", [1300, 263], "End", [1316, 263], "Colour", 0xAFAFAF, "Tolerance", 5)
global TELEPORT_SEARCH_TERM := Map("Start", [1380, 246], "End", [1394, 257], "Colour", 0x1E1E1E, "Tolerance", 5)
global TELEPORT_DESTINATION_BLUE := Map("Start", [1003, 401], "End", [1011, 409], "Colour", 0x5CDCFE, "Tolerance", 5)
global TELEPORT_DESTINATION_GREEN := Map("Start", [1003, 401], "End", [1011, 409], "Colour", 0x63F003, "Tolerance", 5)

; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰
; TELEPORT FUNCTIONS
; ▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰▰

; ---------------------------------------------------------------------------------
; openTeleportMenu Function
; Description: Opens the teleport menu within the game if it is not already open.
; Operation:
;   - Checks if the teleport menu is not open.
;   - Sends a click event to the coordinates that open the teleport menu.
;   - Loops for a specified number of iterations, checking if the menu has opened.
; Dependencies: 
;   - isTeleportMenuOpen: Function that checks if the teleport menu is currently open.
;   - Coords: Array containing the coordinates for various controls.
; Return: None; performs the operation to open the teleport menu.
; ---------------------------------------------------------------------------------
openTeleportMenu() {
    if !isTeleportMenuOpen() {  ; Check if the teleport menu is not open.
        SendEvent "{Click, " COORDS["Controls"]["Teleport"][1] ", " COORDS["Controls"]["Teleport"][2] ", 1}"  ; Click to open the teleport menu.
        
        Loop 100 {  ; Loop to check if the menu has opened.
            if isTeleportMenuOpen()  ; Check if the teleport menu is open.
                break  ; Exit the loop if the menu is open.
            Sleep 50  ; Brief pause between checks to reduce CPU usage.
        }
    }
}

; ---------------------------------------------------------------------------------
; clickTeleportSearchBox Function
; Description: Clicks on the teleport search box within the game and waits until it is selected.
; Operation:
;   - Sends a click event to the coordinates of the teleport search box.
;   - Loops for a specified number of iterations, checking if the search box is selected.
; Dependencies: 
;   - isTeleportSearchBoxSelected: Function that checks if the teleport search box is currently selected.
;   - Coords: Array containing the coordinates for various controls.
; Return: None; performs the operation to click and select the teleport search box.
; ---------------------------------------------------------------------------------
clickTeleportSearchBox() {
    Loop 5 {
        SendEvent "{Click, " COORDS["Teleport"]["Search"][1] ", " COORDS["Teleport"]["Search"][2] ", 1}"  ; Click on the teleport search box.
    }
    
    Loop 100 {  ; Loop to check if the search box is selected.
        if isTeleportSearchBoxSelected()  ; Check if the search box is selected.
            break  ; Exit the loop if the search box is selected.
        Sleep 50  ; Brief pause between checks to reduce CPU usage.
    }
}

; ---------------------------------------------------------------------------------
; enterTeleportSearchTerm Function
; Description: Enters a specified zone number into the teleport search box and waits until the term is entered.
; Operation:
;   - Sends the text corresponding to the given zone number to the search box.
;   - Loops for a specified number of iterations, checking if the search term has been entered.
; Dependencies: 
;   - Zone.Get: Function or method to retrieve the text for the given zone number.
;   - isTeleportSearchTermEntered: Function that checks if the search term is entered.
; Return: None; performs the operation to enter the search term.
; ---------------------------------------------------------------------------------
enterTeleportSearchTerm(zoneNumber) {
    SendText ZONE.Get(zoneNumber)  ; Enter the text for the specified zone number into the search box.
    
    Loop 100 {  ; Loop to check if the search term has been entered.
        if isTeleportSearchTermEntered()  ; Check if the search term is entered.
            break  ; Exit the loop if the search term is entered.
        Sleep 50  ; Brief pause between checks to reduce CPU usage.
    }
}

; ---------------------------------------------------------------------------------
; isTeleportMenuOpen Function
; Description: Checks if the teleport menu is open by performing a pixel search within a specified area.
; Operation:
;   - Uses the PixelSearch function to look for the teleport icon button within defined coordinates.
;   - Returns true if the pixel matching the specified color and tolerance is found, indicating the menu is open.
; Dependencies: 
;   - TELEPORT_ICON_BUTTON: Array containing the coordinates and color information for the teleport icon button.
; Return: Boolean; true if the teleport menu is open, false otherwise.
; ---------------------------------------------------------------------------------
isTeleportMenuOpen() {
    return PixelSearch(&FoundX, &FoundY,  ; Perform a pixel search.
        TELEPORT_ICON_BUTTON["Start"][1], TELEPORT_ICON_BUTTON["Start"][2],  ; Starting coordinates for the search area.
        TELEPORT_ICON_BUTTON["End"][1], TELEPORT_ICON_BUTTON["End"][2],  ; Ending coordinates for the search area.
        TELEPORT_ICON_BUTTON["Colour"], TELEPORT_ICON_BUTTON["Tolerance"])  ; Color and tolerance for the search.
}

; ---------------------------------------------------------------------------------
; isTeleportSearchBoxSelected Function
; Description: Checks if the teleport search box is selected by performing a pixel search within a specified area.
; Operation:
;   - Uses the PixelSearch function to look for the teleport search cursor within defined coordinates.
;   - Returns true if the pixel matching the specified color and tolerance is found, indicating the search box is selected.
; Dependencies: 
;   - TELEPORT_SEARCH_CURSOR: Array containing the coordinates and color information for the teleport search cursor.
; Return: Boolean; true if the teleport search box is selected, false otherwise.
; ---------------------------------------------------------------------------------
isTeleportSearchBoxSelected() {
    return PixelSearch(&FoundX, &FoundY,  ; Perform a pixel search.
        TELEPORT_SEARCH_CURSOR["Start"][1], TELEPORT_SEARCH_CURSOR["Start"][2],  ; Starting coordinates for the search area.
        TELEPORT_SEARCH_CURSOR["End"][1], TELEPORT_SEARCH_CURSOR["End"][2],  ; Ending coordinates for the search area.
        TELEPORT_SEARCH_CURSOR["Colour"], TELEPORT_SEARCH_CURSOR["Tolerance"])  ; Color and tolerance for the search.
}

; ---------------------------------------------------------------------------------
; isTeleportSearchTermEntered Function
; Description: Checks if the teleport search term has been entered by performing a pixel search within a specified area.
; Operation:
;   - Uses the PixelSearch function to look for the teleport search term indicator within defined coordinates.
;   - Returns true if the pixel matching the specified color and tolerance is found, indicating the search term has been entered.
; Dependencies: 
;   - TELEPORT_SEARCH_TERM: Array containing the coordinates and color information for the teleport search term indicator.
; Return: Boolean; true if the teleport search term is entered, false otherwise.
; ---------------------------------------------------------------------------------
isTeleportSearchTermEntered() {
    return PixelSearch(&FoundX, &FoundY,  ; Perform a pixel search.
        TELEPORT_SEARCH_TERM["Start"][1], TELEPORT_SEARCH_TERM["Start"][2],  ; Starting coordinates for the search area.
        TELEPORT_SEARCH_TERM["End"][1], TELEPORT_SEARCH_TERM["End"][2],  ; Ending coordinates for the search area.
        TELEPORT_SEARCH_TERM["Colour"], TELEPORT_SEARCH_TERM["Tolerance"])  ; Color and tolerance for the search.
}

; ---------------------------------------------------------------------------------
; TeleportToZone Function
; Description: Teleports the player to a specified zone within the game by interacting with the teleport menu.
; Operation:
;   - Updates the current action status to indicate the teleport action.
;   - Sets the current zone to the specified zone number.
;   - Ensures the Roblox window is active and ready for input.
;   - Opens the teleport menu and interacts with the search box to enter the zone number.
;   - Clicks the teleport button to initiate the teleportation.
;   - Closes the teleport menu and resets the current action status.
; Dependencies: 
;   - setCurrentAction, setCurrentZone, activateRoblox, openTeleportMenu, clickTeleportSearchBox, enterTeleportSearchTerm, clickTeleportButton, closeTeleportMenu: Various functions handling specific operations.
; Return: None; performs the teleportation operation.
; ---------------------------------------------------------------------------------
TeleportToZone(zoneNumber) {
    setCurrentAction("Teleporting to Zone " zoneNumber "...")  ; Update UI to show teleport action.
    setCurrentZone(zoneNumber)  ; Set new zone number.
    activateRoblox()  ; Ensure Roblox window is active.
    openTeleportMenu()  ; Open the teleport menu.
    clickTeleportSearchBox()  ; Click on the search box within the teleport menu.
    enterTeleportSearchTerm(zoneNumber)  ; Enter the zone number into the search box.
    clickTeleportButton(zoneNumber)  ; Click the button to initiate teleportation.
    closeTeleportMenu()  ; Close the teleport menu.
    setCurrentAction("-")  ; Reset current action status.
}

; ---------------------------------------------------------------------------------
; clickTeleportButton Function
; Description: Clicks the teleport button for a specified zone, ensuring the destination is ready before and after clicking.
; Operation:
;   - Loops until the destination indicator is either blue or green, indicating it is ready.
;   - Sends a click event to the coordinates of the teleport button.
;   - Closes and reopens the teleport menu to ensure the interaction is registered.
;   - Re-enters the search term and verifies the destination status again.
; Dependencies: 
;   - isDestinationBlue, isDestinationGreen: Functions to check if the destination is ready.
;   - Coords: Array containing the coordinates for various controls.
;   - closeTeleportMenu, openTeleportMenu, clickTeleportSearchBox, enterTeleportSearchTerm: Various functions handling specific operations.
; Return: None; performs the click operation to teleport.
; ---------------------------------------------------------------------------------
clickTeleportButton(zoneNumber) {
    Loop 100 {  ; Loop to check if the destination is ready.
        if isDestinationBlue() || isDestinationGreen()  ; Check if the destination is ready.
            break  ; Exit the loop if the destination is ready.
        Sleep 50  ; Brief pause between checks to reduce CPU usage.
    }
    
    SendEvent "{Click, " COORDS["Teleport"]["Zone"][1] ", " COORDS["Teleport"]["Zone"][2] ", 1}"  ; Click on the teleport button.
    
    closeTeleportMenu()  ; Close the teleport menu.
    Sleep 200  ; Brief pause to ensure the menu is closed.
    
    openTeleportMenu()  ; Reopen the teleport menu.
    clickTeleportSearchBox()  ; Click on the search box within the teleport menu.
    enterTeleportSearchTerm(zoneNumber)  ; Re-enter the zone number into the search box.
    
    Loop 100 {  ; Loop to check if the destination is ready again.
        if isDestinationBlue()  ; Check if the destination is ready.
            break  ; Exit the loop if the destination is ready.
        Sleep 50  ; Brief pause between checks to reduce CPU usage.
    }
}

; ---------------------------------------------------------------------------------
; isDestinationBlue Function
; Description: Checks if the teleport destination indicator is blue by performing a pixel search within a specified area.
; Operation:
;   - Uses the PixelSearch function to look for the blue destination indicator within defined coordinates.
;   - Returns true if the pixel matching the specified color and tolerance is found, indicating the destination is blue.
; Dependencies: 
;   - TELEPORT_DESTINATION_BLUE: Array containing the coordinates and color information for the blue destination indicator.
; Return: Boolean; true if the destination indicator is blue, false otherwise.
; ---------------------------------------------------------------------------------
isDestinationBlue() {
    return PixelSearch(&FoundX, &FoundY,  ; Perform a pixel search.
        TELEPORT_DESTINATION_BLUE["Start"][1], TELEPORT_DESTINATION_BLUE["Start"][2],  ; Starting coordinates for the search area.
        TELEPORT_DESTINATION_BLUE["End"][1], TELEPORT_DESTINATION_BLUE["End"][2],  ; Ending coordinates for the search area.
        TELEPORT_DESTINATION_BLUE["Colour"], TELEPORT_DESTINATION_BLUE["Tolerance"])  ; Color and tolerance for the search.
}

; ---------------------------------------------------------------------------------
; isDestinationGreen Function
; Description: Checks if the teleport destination indicator is green by performing a pixel search within a specified area.
; Operation:
;   - Uses the PixelSearch function to look for the green destination indicator within defined coordinates.
;   - Returns true if the pixel matching the specified color and tolerance is found, indicating the destination is green.
; Dependencies: 
;   - TELEPORT_DESTINATION_GREEN: Array containing the coordinates and color information for the green destination indicator.
; Return: Boolean; true if the destination indicator is green, false otherwise.
; ---------------------------------------------------------------------------------
isDestinationGreen() {
    return PixelSearch(&FoundX, &FoundY,  ; Perform a pixel search.
        TELEPORT_DESTINATION_GREEN["Start"][1], TELEPORT_DESTINATION_GREEN["Start"][2],  ; Starting coordinates for the search area.
        TELEPORT_DESTINATION_GREEN["End"][1], TELEPORT_DESTINATION_GREEN["End"][2],  ; Ending coordinates for the search area.
        TELEPORT_DESTINATION_GREEN["Colour"], TELEPORT_DESTINATION_GREEN["Tolerance"])  ; Color and tolerance for the search.
}

; ---------------------------------------------------------------------------------
; closeTeleportMenu Function
; Description: Closes the teleport menu within the game by clicking the close button.
; Operation:
;   - Sends a click event to the coordinates of the close button in the teleport menu.
; Dependencies: 
;   - Coords: Array containing the coordinates for various controls, including the close button.
; Return: None; performs the operation to close the teleport menu.
; ---------------------------------------------------------------------------------
closeTeleportMenu() {
    SendEvent "{Click, " COORDS["Teleport"]["X"][1] ", " COORDS["Teleport"]["X"][2] ", 1}"  ; Click on the close button of the teleport menu.
}