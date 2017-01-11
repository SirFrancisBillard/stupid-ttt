AddCSLuaFile()

hook.Add("CreateMove", "STUPID_TTT_AUTOHOP", function(ucmd)
	if ucmd:KeyDown( IN_JUMP ) then
		if LocalPlayer():WaterLevel() <= 1 && LocalPlayer():GetMoveType() != MOVETYPE_LADDER && !LocalPlayer():IsOnGround() then
			ucmd:RemoveKey(IN_JUMP)
		end
	end
end)
