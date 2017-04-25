AddCSLuaFile()

local JihadSounds = {}

for i = 1, 10 do
	table.insert(JihadSounds, "stupid-ttt/allahu/akbar_" .. i .. ".wav")
end

sound.Add({
	name = "Jihad.Scream",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 150, -- literally as loud as Saturn V taking off
	pitch = {95, 110},
	sound = JihadSounds
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

	if SERVER then
		-- todo: consider moving these first four functions outside of SERVER to minimize networking?

		self.Owner:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)
		BroadcastLua([[Entity(]] .. self.Owner:EntIndex() .. [[):AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_TAUNT_ZOMBIE, true)]])

		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
		self.Owner:EmitSound("Jihad.Scream")

		SafeRemoveEntityDelayed(self, 0.99)
		local ply = self.Owner
		timer.Simple(1, function()
			if not IsValid(ply) or not ply:Alive() then return end

			local explosion = ents.Create("env_explosion")
			explosion:SetPos(ply:GetPos())
			explosion:SetOwner(ply)
			explosion:SetKeyValue("iMagnitude", "200")
			explosion:Spawn()
			explosion:Fire("Explode", 0, 0)
			explosion:EmitSound(Sound("ambient/explosions/explode_" .. math.random(1, 4) .. ".wav", 200, math.random(100, 150)))

			ply:SetModel("models/Humans/Charple0" .. math.random(1, 4) .. ".mdl")
			ply:SetColor(color_white)

			util.BlastDamage(ply, ply, ply:GetPos(), 400, 300)
		end)
	end
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 3)

	if SERVER then
		SendTaunt(self)
	end
end
