AddCSLuaFile()

SWEP.HoldType            = "ar2"

if CLIENT then
   SWEP.PrintName        = "MP5"
   SWEP.Slot             = 2

   SWEP.ViewModelFlip    = false
   SWEP.ViewModelFOV     = 54

   SWEP.Icon             = "vgui/ttt/icon_mac"
   SWEP.IconLetter       = "l"
end

SWEP.NoSights = true

SWEP.Base                = "weapon_tttbase"

SWEP.Kind                = WEAPON_HEAVY
SWEP.WeaponID            = AMMO_MAC10

SWEP.Primary.Damage      = 12
SWEP.Primary.Delay       = 0.065
SWEP.Primary.Cone        = 0.02
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.Recoil      = 0.8
SWEP.Primary.Sound       = Sound("Weapon_mp5navy.Single")

SWEP.NadeSound           = Sound("weapons/grenade_launcher1.wav")

SWEP.AutoSpawnable       = true
SWEP.AmmoEnt             = "item_ammo_smg1_ttt"

SWEP.UseHands            = true
SWEP.ViewModel           = "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel          = "models/weapons/w_smg_mp5.mdl"

SWEP.IronSightsPos       = Vector(-8.921, -9.528, 2.9)
SWEP.IronSightsAng       = Vector(0.699, -5.301, -7)

function SWEP:SecondaryAttack()
	if self:Clip1() < self.Primary.ClipSize then return end

	self:SetNextPrimaryFire(CurTime() + 0.1)
	self:SetNextSecondaryFire(CurTime() + 0.1)

	self:ShootEffects()
	self:TakePrimaryAmmo(self.Primary.ClipSize)
	self:EmitSound(self.NadeSound)

	if CLIENT then return end
	
	local ent = ents.Create("ent_smgbomb")
	if not IsValid(ent) then return end

	ent:SetPos(self.Owner:EyePos() + (self.Owner:GetAimVector() * 75))
	ent:SetAngles(self.Owner:EyeAngles())
	ent:Spawn()
	ent:Activate()
	ent:Fire()
	ent:SetOwner(self.Owner)
	
	local phys = ent:GetPhysicsObject()
	if not IsValid(phys) then ent:Remove() return end

	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 4000
	velocity = velocity + (VectorRand() * 10)
	phys:ApplyForceCenter(velocity)
end
