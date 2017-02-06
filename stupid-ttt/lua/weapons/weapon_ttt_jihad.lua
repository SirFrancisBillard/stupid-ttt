AddCSLuaFile()

if CLIENT then
	SWEP.PrintName = "Jihad Bomb"
	SWEP.Slot = 7
	SWEP.Icon = "vgui/ttt/icon_jihad.png"
end

-- SWEP STUFF
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
SWEP.CanBuy = { ROLE_TRAITOR }
SWEP.InLoadoutFor = { nil }
SWEP.LimitedStock = true
SWEP.AllowDrop = false
SWEP.NoSights = true

if CLIENT then
	SWEP.EquipMenuData = {
		name = "Jihad Bomb",
		type = "item_weapon",
		desc = "Sacrifice your life for Allah."
	};
end

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
	self.AllowDrop = false
	self:SetNextPrimaryFire(CurTime() + 5)

	local effectdata = EffectData()
    effectdata:SetOrigin( self:GetPos() )
    effectdata:SetNormal( self:GetPos() )
    effectdata:SetMagnitude( 8 )
    effectdata:SetScale( 1 )
    effectdata:SetRadius( 20 )
    self.BaseClass.ShootEffects( self )
	self:SetHoldType('melee')

	if (SERVER) then
		timer.Simple(3, function() self:Explode() end )
		timer.Simple(2, function() self:Scream() end)
		self.Owner:EmitSound("weapons/c4/c4_beep1.wav", 125, math.random(95,105))
	end
end

function SWEP:Scream()
	if (self.Owner:IsValid()) then
		self.Owner:EmitSound("stupid-ttt/allahu/akbar_" .. math.random(1, 10) .. ".wav", 150, math.random(95,105))
	end
end

function SWEP:Explode()
	local player = self.Owner
	local explosion = ents.Create( "env_explosion" )
	
	if (player:IsValid()) then
		explosion:SetPos( self:GetPos() )
		explosion:SetOwner( self.Owner )
		explosion:SetKeyValue( "iMagnitude", "200" )
		explosion:Spawn()
		explosion:Fire( "Explode", 0, 0 )
		explosion:EmitSound("ambient/explosions/explode_" .. math.random(1, 4) .. ".wav", 200, math.random(100,150))
		self:Remove()
		player:SetModel("models/Humans/Charple0" .. math.random(1,4) .. ".mdl")
		player:SetColor(COLOR_WHITE)
		player:Kill()
	else
		explosion:SetPos( self:GetPos() )
		explosion:SetKeyValue( "iMagnitude", "50" )
		explosion:Spawn()
		explosion:Fire( "Explode", 0, 0 )
		explosion:EmitSound( "weapons/jihad/jihad_explosion.wav", 150, math.random(100,150))
		self:Remove()
	end
end

function SWEP:SecondaryAttack()	
	self:SetNextSecondaryFire( CurTime() + 3 )
	local snd = Sound("stupid-ttt/emotes/random_" .. math.random(1, 13) .. ".wav")
	self:EmitSound(snd)
	if CLIENT then return end
	self:EmitSound(snd)
end
