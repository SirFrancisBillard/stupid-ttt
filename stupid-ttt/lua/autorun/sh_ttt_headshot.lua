AddCSLuaFile()

sound.Add({
	name = "Player.Headshot",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 150,
	pitch = {95, 110},
	sound = "stupid-ttt/headshot.wav"
})

if SERVER then
	util.AddNetworkString("StupidTTT.HeadshotSound")

	hook.Add("EntityTakeDamage", "StupidTTT.Headshot", function(ply, dmg)
		if IsValid(ply) and ply:IsPlayer() and dmg:IsBulletDamage() and ply:LastHitGroup() == HITGROUP_HEAD then
			net.Start("StupidTTT.HeadshotSound")
			net.Send(ply)
			local atk = dmg:GetAttacker()
			if IsValid(atk) and atk:IsPlayer() then
				net.Start("StupidTTT.HeadshotSound")
				net.Send(atk)
			end
		end
	end)
else
	net.Receive("StupidTTT.HeadshotSound", function(len)
		sound.Play(Sound("Player.Headshot"), LocalPlayer():GetPos())
	end)
end
