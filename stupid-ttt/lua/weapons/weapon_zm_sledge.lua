AddCSLuaFile()

SWEP.HoldType				  = "crossbow"

if CLIENT then
	SWEP.PrintName			 = "M249"
	SWEP.Slot					= 2

	SWEP.ViewModelFlip		= false
	SWEP.ViewModelFOV		 = 54

	SWEP.Icon					= "vgui/ttt/icon_m249"
	SWEP.IconLetter			= "z"
end

SWEP.Base						= "weapon_tttbase"

SWEP.Spawnable				 = true
SWEP.AutoSpawnable			= true

SWEP.Kind						= WEAPON_HEAVY
SWEP.WeaponID				  = AMMO_M249

SWEP.Primary.Damage		  = 12
SWEP.Primary.Delay			= 0.1
SWEP.Primary.Cone			 = 0
SWEP.Primary.ClipSize		= 250
SWEP.Primary.ClipMax		 = 250
SWEP.Primary.DefaultClip	= 250
SWEP.Primary.Automatic	  = true
SWEP.Primary.Ammo			 = "AirboatGun"
SWEP.Primary.Recoil		  = 2
SWEP.Primary.Sound			= Sound("Weapon_M249.Single")

SWEP.UseHands				  = true
SWEP.ViewModel				 = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel				= "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier	 = 2.2

SWEP.IronSightsPos			= Vector(-5.96, -5.119, 2.349)
SWEP.IronSightsAng			= Vector(0, 0, 0)

SWEP.Primary.ConeMin = 0
SWEP.Primary.ConeMax = 0.5

SWEP.LastShot = 0

function SWEP:PrimaryAttack(worldsnd)
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	self.LastShot = CurTime()

	if not self:CanPrimaryAttack() then return end

	if not worldsnd then
		self:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )
	elseif SERVER then
		sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
	end

	self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self.Primary.Cone )

	self:TakePrimaryAmmo( 1 )

	local owner = self.Owner
	if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

	owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0 ) )

	self.Primary.Cone = math.Clamp(self.Primary.Cone + 0.0025, self.Primary.ConeMin, self.Primary.ConeMax)
end

function SWEP:Think()
	if (CurTime() - self.LastShot) > 0.5 then
		self.Primary.Cone = math.Clamp(self.Primary.Cone - 0.02, self.Primary.ConeMin, self.Primary.ConeMax)
	end
end
