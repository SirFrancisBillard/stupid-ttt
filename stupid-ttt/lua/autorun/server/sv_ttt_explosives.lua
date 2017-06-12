
local force = CreateConVar("ttt_explosive_jump_force", "250", {FCVAR_ARCHIVE}, "The power of explosive jumping.")

hook.Add("EntityTakeDamage", "StupidTTT.GrenadeJumping", function(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() and dmg:GetDamageType() == DMG_BLAST then
		local wep = dmg:GetInflictor()
		if not IsValid(wep) or not wep.CanBeUsedToRocketJump then return end
		local ply = wep:GetOwner()
		-- gotta check if an entity is a number because garry
		if IsValid(ply) and ply == ent then
			dmg:ScaleDamage(0.2)

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
