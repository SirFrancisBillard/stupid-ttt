AddCSLuaFile()

sound.Add({
	name = "Bullet_Impact.Headshot",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 150,
	pitch = {95, 110},
	sound = "stupid-ttt/headshot.wav"
})

if SERVER then
	util.AddNetworkString("PlayHeadshotSoundOnClient") -- good name

	hook.Add("EntityTakeDamage", "StupidTTT.Headshot", function(ply, dmg)
		if IsValid(ply) and ply:IsPlayer() and dmg:IsBulletDamage() and ply:LastHitGroup() == HITGROUP_HEAD then
			net.Start("PlayHeadshotSoundOnClient")
			net.Send(ply)
			local atk = dmg:GetAttacker()
			if IsValid(atk) and atk:IsPlayer() then
				net.Start("PlayHeadshotSoundOnClient")
				net.Send(atk)
			end
		end
	end)
else
	net.Receive("PlayHeadshotSoundOnClient", function(len)
		sound.Play(Sound("Bullet_Impact.Headshot"), LocalPlayer():GetPos())
	end)
end
