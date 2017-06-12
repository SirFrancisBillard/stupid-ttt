AddCSLuaFile()

SWEP.HoldType              = "crossbow"

if CLIENT then
   SWEP.PrintName          = "Negev"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_negev.png"
   SWEP.IconLetter         = "z"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Spawnable             = true
SWEP.AutoSpawnable         = false -- DISABLED

SWEP.Kind                  = WEAPON_HEAVY

SWEP.Primary.Damage        = 45
SWEP.Primary.Delay         = 0.1
SWEP.Primary.Cone          = 0.12
SWEP.Primary.ClipSize      = 150
SWEP.Primary.ClipMax       = 150
SWEP.Primary.DefaultClip   = 150
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "AirboatGun"
SWEP.Primary.Recoil        = 10
SWEP.Primary.Sound         = Sound("Weapon_M249.Single")

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel            = "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier    = 2.2

SWEP.IronSightsPos         = Vector(-5.96, -5.119, 2.349)
SWEP.IronSightsAng         = Vector(0, 0, 0)
