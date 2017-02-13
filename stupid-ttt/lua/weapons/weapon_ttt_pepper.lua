AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "Pepper Spray"
   SWEP.Slot               = 6

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.EquipMenuData = {
      type  = "item_weapon",
      name  = "Pepper Spray",
      desc  = "A non-lethal spray used to stun targets.\nLimited ammo."
   };

   SWEP.Icon               = "vgui/ttt/icon_pepper.png"
   SWEP.IconLetter         = "u"
end

game.AddAmmoType({name = "pepperspray"})
if CLIENT then
	language.Add("pepperspray_ammo", "Liquid Pepper")
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_EQUIP1
SWEP.CanBuy                = {ROLE_DETECTIVE}

SWEP.Primary.Recoil        = 0
SWEP.Primary.Damage        = 0
SWEP.Primary.Delay         = 0.1
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 20
SWEP.Primary.Automatic     = true
SWEP.Primary.DefaultClip   = 100
SWEP.Primary.ClipMax       = 100
SWEP.Primary.Ammo          = "pepperspray"
SWEP.Primary.Sound         = Sound("player/sprayer.wav")

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/c_grenade.mdl"
SWEP.WorldModel            = "models/weapons/w_grenade.mdl"

SWEP.IronSightsPos         = Vector(-5.95, -4, 2.799)
SWEP.IronSightsAng         = Vector(0, 0, 0)

SWEP.NoSights              = true

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	self:SetNextPrimaryFire(CurTime() + 0.1)

	self:ShootEffects()
	self:TakePrimaryAmmo(1)
	self:EmitSound(self.Primary.Sound)

	if CLIENT then return end

	local ent = ents.Create("ent_pepperparticle")
	if not IsValid(ent) then return end

	ent:SetPos(self.Owner:EyePos() + (self.Owner:GetAimVector() * 32))
	ent:SetAngles(self.Owner:EyeAngles())
	ent:SetShooter(self.Owner)
	ent:Spawn()

	local phys = ent:GetPhysicsObject()
	if not IsValid(phys) then ent:Remove() return end

	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 200
	velocity = velocity + (VectorRand() * 10)
	phys:ApplyForceCenter(velocity)
end

function SWEP:Reload()
   self:DefaultReload(ACT_VM_DRAW)
end
