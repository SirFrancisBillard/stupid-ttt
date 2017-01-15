--Jihad Bomb for Trouble in Terrorist Town 
--Code and sounds by B4XT3R [STEAM_0:0:12881658]

--SERVER AND CLIENT STUFF
if SERVER then
	AddCSLuaFile("shared.lua")
	
	resource.AddFile( "weapons/weapon_ttt_jihad/shared.lua" );
	resource.AddFile( "sound/weapons/jihad/allahuackbar1.wav" );
	resource.AddFile( "sound/weapons/jihad/allahuackbar2.wav" );
	resource.AddFile( "sound/weapons/jihad/allahuackbar3.wav" );
	resource.AddFile( "sound/weapons/jihad/allahuackbar4.wav" );
	resource.AddFile( "sound/weapons/jihad/jihad_explosion.wav" );
	resource.AddFile( "sound/weapons/jihad/jihad_beep.wav" );
end

if CLIENT then
	SWEP.PrintName = "Jihad Bomb"
	SWEP.Slot = 6
	SWEP.Icon = "vgui/ttt/icon_c4"
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
		desc = "Powerful explosive. \nThe timer appears to be broken."
	};
end

function SWEP:Reload()
	return false
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)

	util.PrecacheSound( "weapons/jihad/allahuackbar1.wav" )
	util.PrecacheSound( "weapons/jihad/allahuackbar2.wav" )
	util.PrecacheSound( "weapons/jihad/allahuackbar3.wav" )
	util.PrecacheSound( "weapons/jihad/allahuackbar4.wav" )   
	util.PrecacheSound( "weapons/jihad/jihad_explosion.wav" )
	util.PrecacheSound( "weapons/jihad/jihad_beep.wav" )
	
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
		self.Owner:EmitSound("weapons/jihad/jihad_beep.wav", 125, math.random(95,105))
	end
end

function SWEP:Scream()
	if (self.Owner:IsValid()) then
		self.Owner:EmitSound("weapons/jihad/allahuackbar" .. math.random(1,4) .. ".wav", 150, math.random(95,105))
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
		explosion:EmitSound( "weapons/jihad/jihad_explosion.wav", 200, math.random(100,150))
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