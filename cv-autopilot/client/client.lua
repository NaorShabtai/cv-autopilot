
local QBCore = exports["qb-core"]:GetCoreObject()

---- locals ----

autopilot = false


---- functions ----

function GetStreetAndZone()
    local waypointBlip = GetFirstBlipInfoId(8)
    if DoesBlipExist(waypointBlip)  then
    local waypointCoords = GetBlipInfoIdCoord(waypointBlip)
    local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(waypointCoords.x, waypointCoords.y, waypointCoords.z)
    local currentStreetName = GetStreetNameFromHashKey(currentStreetHash)
    local area = GetLabelText(tostring(GetNameOfZone(waypointCoords.x, waypointCoords.y, waypointCoords.z)))
    local playerStreetsLocation = area
    if not area then 
        area = "UNKNOWN"
    end
    if currentStreetName ~= nil and currentStreetName ~= "" then 
        playerStreetsLocation = currentStreetName .. ", " .. area
    else 
        playerStreetsLocation = area 
    end
    return playerStreetsLocation
   end
end


function autopilotend()
    Citizen.CreateThread(function()
     while true do
         Citizen.Wait(1000)
         waypointBlip = GetFirstBlipInfoId(8)
         if DoesBlipExist(waypointBlip)  then
         waypointCoords = GetBlipInfoIdCoord(waypointBlip)
         PlayerCoords = GetEntityCoords(PlayerPedId())
         local Destination = GetDistanceBetweenCoords(PlayerCoords, waypointCoords, true) 
         if Destination <= 60.0 then
            ClearPedTasks(PlayerPedId())
           end
         end
       end
   end)
end

RegisterNetEvent("cv-autopilot:client:openui", function()
    if IsPedInAnyVehicle(PlayerPedId(), true) then
    PlayerData = QBCore.Functions.GetPlayerData()
    SetNuiFocus(true, true)
    SendNUIMessage({OpenUi = true, plate = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId())),})
    else
    QBCore.Functions.Notify("You are not in vehicle", "error")
    end
end)

---- Events ----


RegisterNUICallback('on', function(data, cb)
   veh = GetVehiclePedIsIn(PlayerPedId(), true)
   if IsPedInAnyVehicle(PlayerPedId(), true) then
   waypointBlip = GetFirstBlipInfoId(8)
   if DoesBlipExist(waypointBlip) then
   waypointCoords = GetBlipInfoIdCoord(waypointBlip)
   autopilot = true
   autopilotend()
   TaskVehicleDriveToCoord(PlayerPedId(), veh, waypointCoords.x, waypointCoords.y, waypointCoords.z, 30.0, 0, 0, 786603, 1.0, 10, 0)
   SetPedKeepTask(PlayerPedId(), true)
   QBCore.Functions.Notify("Driving to  " .. GetStreetAndZone(), "success")
   else
   QBCore.Functions.Notify("No waypoint is marked", "error")
   end
   else
   QBCore.Functions.Notify("You are not in vehicle", "error")
   end
end)

        
    RegisterNUICallback('off', function(data, cb)
    if IsPedInAnyVehicle(PlayerPedId(), true) then
    if autopilot == true then
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Notify("Auto pilot off", "error")
    autopilot = false
    else
        QBCore.Functions.Notify("Auto pilot is not on", "error")
    end
else
        QBCore.Functions.Notify("You are not in vehicle", "error")
    end
end)

        
RegisterNUICallback("CloseUi", function()
SetNuiFocus(false, false)
end)


          


