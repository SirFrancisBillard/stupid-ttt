
EQUIP_JEST = GenerateNewEquipmentID()

local function AddCustomEquipment()
	local jest = {
		id = EQUIP_JEST,
		loadout = false,
		type = "item_passive",
		material = "vgui/ttt/icon_nades",
		name = "Jest",
		desc = [[You will deal no damage.
			However, when killed, you will explode spectacularly.
			This cannot be undone.]]
	}

	table.insert(EquipmentItems[ROLE_TRAITOR], jest)
end

AddCustomEquipment() -- idk

hook.Add("InitPostEntity", "StupidTTT.Equipment", AddCustomEquipment)
