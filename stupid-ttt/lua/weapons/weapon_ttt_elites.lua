AddCSLuaFile()

SWEP.HoldType				  = "duel"

if CLIENT then
	SWEP.PrintName			 = "Dual Elites"
	SWEP.Slot					= 1

	SWEP.ViewModelFlip		= false
	SWEP.ViewModelFOV		 = 54

	SWEP.Icon					= "vgui/ttt/icon_dualies.png"
	SWEP.IconLetter			= "B"
end

SWEP.Base						= "weapon_tttbase"

SWEP.Kind						= WEAPON_PISTOL

SWEP.Primary.Ammo	        = "smg1"
SWEP.Primary.Damage		    = 10
SWEP.Primary.Cone		    = 0.025
SWEP.Primary.Delay			= 0.2
SWEP.Primary.ClipSize		= 30
SWEP.Primary.ClipMax	    = 90
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic	    = true
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_Elite.Single")
SWEP.Primary.Recoil		    = 4.5

SWEP.AutoSpawnable			= true
SWEP.Spawnable				= true
SWEP.AmmoEnt				= "item_ammo_smg1_ttt"

SWEP.UseHands				= true
SWEP.ViewModel 				= Model("models/weapons/cstrike/c_pist_elite.mdl")
SWEP.WorldModel				= Model("models/weapons/w_pist_elite.mdl")

SWEP.NoSights = true

SWEP.IronSightsPos			= Vector(-5.2, -9.214, 2.66)
SWEP.IronSightsAng			= Vector(-0.101, -0.7, -0.201)

function SWEP:PrimaryAttack(worldsnd)
	local owner = self.Owner
	local delay = self.Primary.Delay
	local damage = self.Primary.Damage

	if IsValid(owner) then
		local hp = owner:Health()
		local max = owner:GetMaxHealth()
		local quart = max / 4
		delay = delay * ((math.max(hp, quart) / max) * 2)
		damage = damage * (max / math.max(hp, quart))
	end

	self:SetNextSecondaryFire( CurTime() + delay )
	self:SetNextPrimaryFire( CurTime() + delay )

	if not self:CanPrimaryAttack() then return end

	if not worldsnd then
		self:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )
	elseif SERVER then
		sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
	end

	self:ShootBullet( damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone() )

	self:TakePrimaryAmmo( 1 )

	if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

	owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0 ) )
end
