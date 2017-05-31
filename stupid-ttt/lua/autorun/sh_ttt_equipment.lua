
EQUIP_THING = GenerateNewEquipmentID

local function AddCustomEquipment()
	local item = {
		id = EQUIP_THING,
		loadout = false,
		type = "item_passive",
		material = "vgui/ttt/icon_thing",
		name = "fucking acecool remover",
		desc = "removes all acecools"
	}

	-- table.insert(EquipmentItems[ROLE_TRAITOR], item)
	-- table.insert(EquipmentItems[ROLE_DETECTIVE], item)
end

hook.Add("InitPostEntity", "StupidTTT.Equipment", AddCustomEquipment)
