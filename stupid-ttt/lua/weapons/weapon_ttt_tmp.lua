AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "TMP"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_tmp.png"
   SWEP.IconLetter         = "c"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Primary.Damage        = 14
SWEP.Primary.Delay         = 0.09
SWEP.Primary.Cone          = 0.03
SWEP.Primary.ClipSize      = 30
SWEP.Primary.ClipMax       = 60
SWEP.Primary.DefaultClip   = 30
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "smg1"
SWEP.Primary.Recoil        = 1.35
SWEP.Primary.Sound         = Sound( "Weapon_TMP.Single" )

SWEP.AutoSpawnable         = true

SWEP.AmmoEnt               = "item_ammo_smg1_ttt"
SWEP.Kind                  = WEAPON_HEAVY

SWEP.HeadshotMultiplier    = 1.75

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel            = "models/weapons/w_smg_tmp.mdl"

SWEP.IronSightsPos = Vector(-1.93, -5.928, 1.82)
SWEP.IronSightsAng = Vector(1.162, 0, 0)

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 2 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 150)

   -- decay from 3.2 to 1.7
   return 1.7 + math.max(0, (1.5 - 0.002 * (d ^ 1.25)))
end
