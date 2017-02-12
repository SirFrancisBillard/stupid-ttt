local scale = CreateConVar("ttt_bullet_damage_scale", "0.5", {FCVAR_ARCHIVE}, "How much bullet damage you take.")

hook.Add("EntityTakeDamage", "TTTBulletDamageScale", function(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() and dmg:IsBulletDamage() then
		dmg:ScaleDamage(scale:GetFloat())
	end
end)

hook.Add("EntityTakeDamage", "TTTGrenadeJumping", function(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() and dmg:GetDamageType() == DMG_BLAST then
		local wep = dmg:GetInflictor()
		if not IsValid(wep) or not wep.CanBeUsedToRocketJump then return end
		local ply = wep:GetOwner()
		-- gotta check if an entity is a number because garry
		if IsValid(ply) and ply == ent then
			dmg:ScaleDamage(0.01)
			ply:SetVelocity(Vector(0, 0, dmg:GetDamage() * 1000))
		end
	end
end)
