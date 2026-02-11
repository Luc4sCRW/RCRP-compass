-- Richtung berechnen. // change direction.
local function getDirection(heading)
    local directions = { "N", "NW", "W", "SW", "S", "SE", "E", "NE" }
    local index = math.floor((heading % 360 + 22.5) / 45) % 8
    return directions[index + 1]
end

CreateThread(function()
    local hudVisible = false
    local lastCoords = vector3(0.0, 0.0, 0.0)
    local street, zone = "", ""

    while true do
        Wait(300)

-- Check ob Pause-Menü offen ist. Wenn ja, HUD ausblenden. // check if pause menu is open. If so, hide HUD.
        if IsPauseMenuActive() then
            if hudVisible then
                SendNUIMessage({
                    action = "toggleHud",
                    show = false
                })
                hudVisible = false
            end
        else
            if not hudVisible then
                SendNUIMessage({
                    action = "toggleHud",
                    show = true
                })
                hudVisible = true
            end

            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)

            -- Straße und Zone neu holen, wenn Spieler sich bewegt hat. // refresh street and zone when player has moved.
            if #(coords - lastCoords) > 5.0 then
                local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
                street = GetStreetNameFromHashKey(streetHash)
                zone = GetLabelText(GetNameOfZone(coords.x, coords.y, coords.z))
                lastCoords = coords
            end

            -- Uhrzeit // time
            local time = string.format(
                "%02d:%02d",
                GetClockHours(),
                GetClockMinutes()
            )

            -- HUD aktualisieren // update HUD
            SendNUIMessage({
                action = "updateHUD",
                direction = getDirection(heading),
                street = street,
                zone = zone,
                time = time
            })
        end
    end
end)
