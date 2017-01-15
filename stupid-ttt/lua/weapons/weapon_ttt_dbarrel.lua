AddCSLuaFile()

SWEP.HoldType              = "shotgun"

if CLIENT then
   SWEP.PrintName          = "Double Barrel"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_dbarrel.png"
   SWEP.IconLetter         = "B"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY

SWEP.Primary.Ammo          = "Buckshot"
SWEP.Primary.Damage        = 20
SWEP.Primary.Cone          = 0.4
SWEP.Primary.Delay         = 0.1
SWEP.Primary.ClipSize      = 2
SWEP.Primary.ClipMax       = 24
SWEP.Primary.DefaultClip   = 6
SWEP.Primary.Automatic     = false
SWEP.Primary.NumShots      = 18
SWEP.Primary.Sound         = Sound( "Weapon_XM1014.Single" )
SWEP.Primary.Recoil        = 20

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_box_buckshot_ttt"

SWEP.UseHands              = false
SWEP.ViewModel 				= "models/weapons/v_sawedoff.mdl"
SWEP.WorldModel				= "models/weapons/w_sawedoff.mdl"

SWEP.IronSightsPos         = Vector(-5.2, -9.214, 2.66)
SWEP.IronSightsAng         = Vector(-0.101, -0.7, -0.201)

function SWEP:CanPrimaryAttack()
   if self:Clip1() <= 0 then
      self:EmitSound( "Weapon_Shotgun.Empty" )
      self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
      return false
   end
   return true
end

-- The shotgun's headshot damage multiplier is based on distance. The closer it
-- is, the more damage it does. This reinforces the shotgun's role as short
-- range weapon by reducing effectiveness at mid-range, where one could score
-- lucky headshots relatively easily due to the spread.
function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 3 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 140)

   -- decay from 3.1 to 1 slowly as distance increases
   return 1 + math.max(0, (2.1 - 0.002 * (d ^ 1.25)))
end
