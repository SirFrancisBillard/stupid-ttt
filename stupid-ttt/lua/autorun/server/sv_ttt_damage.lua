local scale = CreateConVar("ttt_bullet_damage_scale", "0.5", {FCVAR_ARCHIVE}, "How much bullet damage you take.")
local force = CreateConVar("ttt_explosive_jump_force", "250", {FCVAR_ARCHIVE}, "The power of explosive jumping.")

hook.Add("EntityTakeDamage", "StupidTTT.BulletDamageScale", function(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() and dmg:IsBulletDamage() then
		dmg:ScaleDamage(scale:GetFloat())
	end
end)

hook.Add("EntityTakeDamage", "StupidTTT.GrenadeJumping", function(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() and dmg:GetDamageType() == DMG_BLAST then
		local wep = dmg:GetInflictor()
		if not IsValid(wep) or not wep.CanBeUsedToRocketJump then return end
		local ply = wep:GetOwner()
		-- gotta check if an entity is a number because garry
		if IsValid(ply) and ply == ent then
			dmg:ScaleDamage(0.05)

			local tpos = ply:LocalToWorld(ply:OBBCenter())
			local pos = wep:GetPos()
			local dir = (tpos - pos):GetNormal()
			local phys = ply:GetPhysicsObject()

			-- always need an upwards push to prevent the ground's friction from
			-- stopping nearly all movement
			dir.z = math.abs(dir.z) + 1

			local push = dir * force:GetInt()

			-- try to prevent excessive upwards force
			local vel = ply:GetVelocity() + push
			vel.z = math.min(vel.z, force:GetInt())

			ply:SetVelocity(vel)
		end
	end
end)

hook.Add("EntityTakeDamage", "StupidTTT.EarRape", function(ent, dmg)
	local wep = dmg:GetInflictor()
	if IsValid(ent) and ent:IsPlayer() and IsValid(wep) and wep.EarRape then
		timer.Simple(math.random(3, 5), function()
			if IsValid(ent) and ent:IsPlayer() and ent:Alive() then
				ent:SendLua("play stupid-ttt/earrape/" .. math.random(1, 3) .. ".wav")
			end
		end)
	end
end)
