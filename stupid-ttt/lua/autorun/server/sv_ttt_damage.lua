
local scale = CreateConVar("ttt_bullet_damage_scale", "0.8", {FCVAR_ARCHIVE}, "How much bullet damage you take.")

hook.Add("EntityTakeDamage", "StupidTTT.BulletDamageScale", function(ent, dmg)
	if IsValid(ent) and ent:IsPlayer() and dmg:IsBulletDamage() then
		dmg:ScaleDamage(scale:GetFloat())
	end
end)
