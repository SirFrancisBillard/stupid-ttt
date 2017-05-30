
hook.Add("EntityTakeDamage", "StupidTTT.EarRape", function(ent, dmg)
	local wep = dmg:GetInflictor()
	if IsValid(ent) and ent:IsPlayer() and IsValid(wep) and wep.EarRape then
		timer.Simple(math.random(3, 5), function()
			if IsValid(ent) and ent:IsPlayer() and ent:Alive() then
				ent:ConCommand("play stupid-ttt/earrape/earrape_" .. math.random(1, 3) .. ".wav")
			end
		end)
	end
end)
