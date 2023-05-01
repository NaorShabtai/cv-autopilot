local QBCore = exports["qb-core"]:GetCoreObject()

---- locals ----

---- functions ----

---- Events ----


---- commands ----

QBCore.Commands.Add("autopilot", ("Active autopilot system"), {}, false, function(source)
TriggerClientEvent("cv-autopilot:client:openui", source)
end)

---- other stuff ----


AddEventHandler('onResourceStart', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	print(resourceName.. ' loading 100% ')
  end)

AddEventHandler('onResourceStop', function(resourceName)
	if (GetCurrentResourceName() ~= resourceName) then
	  return
	end
	print(resourceName..  ' loading 100% ')
  end)

