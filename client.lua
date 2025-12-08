-- Richtung berechnen. // change direction.
function getDirection(heading)
    local directions = {
        "N", "NW", "W", "SW",
        "S", "SE", "E", "NE"
    }
    local index = math.floor((heading + 22.5) / 45) % 8
    return directions[index + 1]
end

CreateThread(function()
    while true do
        Wait(300)

        -- Check ob Pause-Menü offen ist. Wenn ja, überspringen. // Check whether the pause menu is open. If so, skip.
        if IsPauseMenuActive() then
            SendNUIMessage({ action = "toggleHud", show = false })
        else
            local hour = GetClockHours()
            local minute = GetClockMinutes()
            local time = string.format("%02d:%02d", hour, minute)

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)

            local streetHash, _ = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
            local street = GetStreetNameFromHashKey(streetHash)
            local zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
            local dir = getDirection(heading)

            -- HUD anzeigen & Daten senden // Show HUD & send data
            SendNUIMessage({
                action = "toggleHud", show = true
            })

            SendNUIMessage({
                action = "updateHUD",
                direction = dir,
                street = street,
                zone = zone,
                time = time
            })
        end
    end
end)
