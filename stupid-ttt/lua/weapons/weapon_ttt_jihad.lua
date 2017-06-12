AddCSLuaFile()

sound.Add({
	name = "Jihad.Scream",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 150, -- literally as loud as Saturn V taking off
	pitch = {100},
	sound = {"stupid-ttt/jihad/jihad_1.wav", "stupid-ttt/jihad/jihad_2.wav"}
})

sound.Add({
	name = "Jihad.Explode",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 150,
	pitch = {100},
	sound = {"ambient/explosions/explode_1.wav", "ambient/explosions/explode_3.wav", "ambient/explosions/explode_4.wav"}
})

sound.Add({
	name = "Jihad.Islam",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 150,
	pitch = {100},
	sound = {"stupid-ttt/music/islam.wav"}
})

if CLIENT then
	SWEP.Slot = 7
	SWEP.Icon = "vgui/ttt/icon_jihad.png"
	SWEP.EquipMenuData = {
		name = "Jihad Bomb",
		type = "item_weapon",
		desc = "Sacrifice your life for Allah."
	}
end

-- SWEP STUFF
SWEP.PrintName = "Jihad Bomb"
SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "slam"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 5
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.UseHands = true
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/cstrike/c_c4.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"

-- TTT CONFIGURATION
SWEP.Kind = WEAPON_EQUIP2
SWEP.AutoSpawnable = false
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.InLoadoutFor = nil
SWEP.LimitedStock = true
SWEP.AllowDrop = false
SWEP.NoSights = true

function SWEP:Reload()
	return false
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)

	util.PrecacheModel("models/Humans/Charple01.mdl")
	util.PrecacheModel("models/Humans/Charple02.mdl")
	util.PrecacheModel("models/Humans/Charple03.mdl")
	util.PrecacheModel("models/Humans/Charple04.mdl")
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 2)

	self.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)

	if SERVER then
		-- todo: consider moving these first four functions outside of SERVER to minimize networking?
		-- update: moved the gesture to shared but kept the sound to sync which sound it plays

		-- BroadcastLua([[Entity(]] .. self.Owner:EntIndex() .. [[):AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)]])

		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.Owner:EmitSound("Jihad.Scream")

		SafeRemoveEntityDelayed(self, 0.99)
		local ply = self.Owner
		timer.Simple(1, function()
			if not IsValid(ply) or not ply:Alive() then return end
			local pos = ply:GetPos()

			ParticleEffect("explosion_huge", pos, vector_up:Angle())
			ply:EmitSound(Sound("Jihad.Explode"))

			util.Decal("Rollermine.Crater", pos, pos - Vector(0, 0, 500), ply)
			util.Decal("Scorch", pos, pos - Vector(0, 0, 500), ply)

			ply:SetModel("models/Humans/Charple0" .. math.random(1, 4) .. ".mdl")
			ply:SetColor(color_white)

			util.BlastDamage(ply, ply, pos, 1000, 230)

			timer.Simple(0.5, function()
				if not pos then return end

				sound.Play(Sound("Jihad.Islam"), pos)
			end)
		end)
	end
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + TTT_TAUNT_DELAY:GetInt())

	if SERVER then
		SendTaunt(self)
	end
end
