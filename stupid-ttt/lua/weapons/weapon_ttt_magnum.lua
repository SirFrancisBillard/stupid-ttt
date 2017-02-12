AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "Handheld GL"
   SWEP.Slot               = 1

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_python.png"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_PISTOL

SWEP.Primary.Ammo          = "AlyxGun" -- hijack an ammo type we don't use otherwise
SWEP.Primary.Recoil        = 8
SWEP.Primary.Damage        = 65
SWEP.Primary.Delay         = 0.6
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 1
SWEP.Primary.ClipMax       = 36
SWEP.Primary.DefaultClip   = 1
SWEP.Primary.Automatic     = true
SWEP.Primary.Sound = Sound("weapons/grenade_launcher1.wav")

SWEP.HeadshotMultiplier    = 3

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_revolver_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/c_357.mdl"
SWEP.WorldModel            = "models/weapons/w_357.mdl"

SWEP.IronSightsPos	       = Vector(-4.64, -3.96, 0.68)
SWEP.IronSightsAng         = Vector(0.214, -0.1767, 0)


function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	self:SetNextPrimaryFire(CurTime() + 0.5)
	self:SetNextSecondaryFire(CurTime() + 0.5)

	self:ShootEffects()
	self:TakePrimaryAmmo(1)
	self:EmitSound(self.Primary.Sound)

	if CLIENT then return end
	
	local ent = ents.Create("ent_smgbomb")
	if not IsValid(ent) then return end

	ent:SetPos(self.Owner:EyePos())
	ent:SetAngles(self.Owner:EyeAngles())
	ent:SetOwner(self.Owner)
	ent:Spawn()
	ent:Activate()
	ent:Fire()
	
	
	local phys = ent:GetPhysicsObject()
	if not IsValid(phys) then ent:Remove() return end

	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 4000
	velocity = velocity + (VectorRand() * 10)
	phys:ApplyForceCenter(velocity)
end
