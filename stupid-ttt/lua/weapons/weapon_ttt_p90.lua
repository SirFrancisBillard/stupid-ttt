AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "P90"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 64

   SWEP.Icon               = "vgui/ttt/icon_p90.png"
   SWEP.IconLetter         = "w"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY

SWEP.Primary.Damage        = 5
SWEP.Primary.Delay         = 0.04
SWEP.Primary.Cone          = 0.02
SWEP.Primary.ClipSize      = 60
SWEP.Primary.ClipMax       = 60
SWEP.Primary.DefaultClip   = 60
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "smg1"
SWEP.Primary.Recoil        = 1.3
SWEP.Primary.Sound         = Sound( "Weapon_P90.Single" )

SWEP.AutoSpawnable = true
SWEP.Spawnable = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/w_smg_p90.mdl"

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
