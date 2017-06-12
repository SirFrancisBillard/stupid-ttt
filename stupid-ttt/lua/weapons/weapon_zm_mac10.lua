AddCSLuaFile()

SWEP.HoldType				= "ar2"

if CLIENT then
	SWEP.PrintName		  = "MP5"
	SWEP.Slot				 = 2

	SWEP.ViewModelFlip	 = false
	SWEP.ViewModelFOV	  = 54

	SWEP.Icon				 = "vgui/ttt/icon_mp5.png"
	SWEP.IconLetter		 = "l"
end

SWEP.Base					 = "weapon_tttbase"

SWEP.Kind					 = WEAPON_HEAVY

SWEP.Primary.Damage		= 14
SWEP.Primary.Delay		 = 0.04
SWEP.Primary.Cone		  = 0.05
SWEP.Primary.ClipSize	 = 30
SWEP.Primary.ClipMax	  = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic	= true
SWEP.Primary.Ammo		  = "smg1"
SWEP.Primary.Recoil		= 1.1
SWEP.Primary.Sound		 = Sound("Weapon_MP5Navy.Single")
SWEP.ModulationCone		= 1
SWEP.ModulationDelay	  = 1
SWEP.ModulationTime		= nil

SWEP.NadeSound			  = Sound("weapons/grenade_launcher1.wav")

SWEP.AutoSpawnable		 = true
SWEP.AmmoEnt				 = "item_ammo_smg1_ttt"

SWEP.UseHands				= true
SWEP.ViewModel			  = "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel			 = "models/weapons/w_smg_mp5.mdl"

SWEP.IronSightsPos			  = Vector(-5.3, -7, 2.1)
SWEP.IronSightsAng			  = Vector(0.9, 0.1, 0)

function SWEP:PrimaryAttack(worldsnd)
	local delay = self.Primary.Delay * self.ModulationDelay
	self.ModulationTime = CurTime() + 1
	self.ModulationCone = math.max(0.1, self.ModulationCone * 0.85)
	self.ModulationDelay = math.min(4, self.ModulationDelay * 1.1)

	self:SetNextSecondaryFire( CurTime() + delay )
	self:SetNextPrimaryFire( CurTime() + delay )

	if not self:CanPrimaryAttack() then return end

	if not worldsnd then
		self:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )
	elseif SERVER then
		sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
	end

	self:ShootBullet( self.Primary.Damage, self.Primary.Recoil, self.Primary.NumShots, self:GetPrimaryCone() )

	self:TakePrimaryAmmo( 1 )

	local owner = self.Owner
	if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

	owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )
end

function SWEP:GetPrimaryCone()
	local cone = self.Primary.Cone or 0.2
	cone = cone * self.ModulationCone
	-- 10% accuracy bonus when sighting
	return self:GetIronsights() and (cone * 0.85) or cone
end

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
	local att = dmginfo:GetAttacker()
	if not IsValid(att) then return 2 end

	local dist = victim:GetPos():Distance(att:GetPos())
	local d = math.max(0, dist - 150)

	-- decay from 3.2 to 1.7
	return 1.7 + math.max(0, (1.5 - 0.002 * (d ^ 1.25)))
end

function SWEP:Think()
	if self.ModulationTime and CurTime() > self.ModulationTime then
		self.ModulationTime = nil
		self.ModulationCone = 1
		self.ModulationDelay = 1
	end
end
