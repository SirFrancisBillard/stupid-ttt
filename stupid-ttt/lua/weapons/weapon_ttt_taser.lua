AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "Taser"
   SWEP.Slot               = 6

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.EquipMenuData = {
      type  = "item_weapon",
      name  = "Taser",
      desc  = "A taser that stuns and damages targets.\nLimited ammo."
   };

   SWEP.Icon               = "vgui/ttt/icon_taser.png"
   SWEP.IconLetter         = "u"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_EQUIP1
SWEP.CanBuy                = {ROLE_DETECTIVE}

game.AddAmmoType({name = "taser"})
if CLIENT then
	language.Add("taser_ammo", "Taser Shots")
end

SWEP.Primary.Recoil        = 0
SWEP.Primary.Damage        = 20
SWEP.Primary.Delay         = 0.1
SWEP.Primary.Cone          = 0
SWEP.Primary.ClipSize      = 1
SWEP.Primary.Automatic     = false
SWEP.Primary.DefaultClip   = 4
SWEP.Primary.ClipMax       = 4
SWEP.Primary.Ammo          = "taser"
SWEP.Primary.Sound         = Sound("ambient/energy/zap1.wav")

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/c_pistol.mdl"
SWEP.WorldModel            = "models/weapons/w_pistol.mdl"

SWEP.IronSightsPos         = Vector(-5.95, -4, 2.799)
SWEP.IronSightsAng         = Vector(0, 0, 0)

SWEP.NoSights              = true

function SWEP:PrimaryAttack()
   if not self:CanPrimaryAttack() then return end

   self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

   if not IsValid(self.Owner) then return end

   self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
   self:TakePrimaryAmmo(1)
   self:EmitSound(Sound("ambient/machines/zap" .. math.random(1, 3) .. ".wav"))
   self.Owner:LagCompensation(true)

   local spos = self.Owner:GetShootPos()
   local sdest = spos + (self.Owner:GetAimVector() * 250)

   local kmins = Vector(1, 1, 1) * -10
   local kmaxs = Vector(1, 1, 1) * 10

   local edata = EffectData()
   edata:SetStart(spos)
   edata:SetOrigin(sdest)
   util.Effect("ManhackSparks", edata)

   local tr = util.TraceHull({start=spos, endpos=sdest, filter=self.Owner, mask=MASK_SHOT_HULL, mins=kmins, maxs=kmaxs})

   -- Hull might hit environment stuff that line does not hit
   if not IsValid(tr.Entity) then
      tr = util.TraceLine({start=spos, endpos=sdest, filter=self.Owner, mask=MASK_SHOT_HULL})
   end

   local hitEnt = tr.Entity

   if SERVER and tr.Hit and tr.HitNonWorld and IsValid(hitEnt) then
      if hitEnt:IsPlayer() then
         local dmg = DamageInfo()
         dmg:SetDamage(self.Primary.Damage)
         dmg:SetAttacker(self.Owner)
         dmg:SetInflictor(self.Weapon or self)
         dmg:SetDamageForce(self.Owner:GetAimVector() * 5)
         dmg:SetDamagePosition(self.Owner:GetPos())
         dmg:SetDamageType(DMG_SHOCK)

         hitEnt:SetNWBool("IsPeppered", true)
         hitEnt:SetNWInt("PepperAmount", 3)

         hitEnt:DispatchTraceAttack(dmg, spos + (self.Owner:GetAimVector() * 3), sdest)
      end
   end

   self.Owner:LagCompensation(false)
end
