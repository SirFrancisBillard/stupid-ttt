
local PLAYER = FindMetaTable("Player")

function PLAYER:SetPerk(perk)
	self:SetNWString("ttt_perk", tostring(perk))
end

util.AddNetworkString("ttt_sendperk")

net.Receive("ttt_sendperk", function(len, ply)
	local perk = tostring(net.ReadString())
	if not type(gPerks[perk]) == "table" then
		print("PERK IS INVALID")
		return
	end
	ply:SetPerk(perk)
end)

hook.Add("PlayerInitialSpawn", "StupidTTT.OpenPerkMenu", function(ply)
	ply:SetPerk("agra")
	if IsValid(ply) and ply:IsPlayer() then
		ply:ConCommand("ttt_perkmenu")
	end
end)
