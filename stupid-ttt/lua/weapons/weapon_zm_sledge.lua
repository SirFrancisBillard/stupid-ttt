AddCSLuaFile()

SWEP.HoldType              = "crossbow"

if CLIENT then
   SWEP.PrintName          = "Fuckin' HUGE"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_m249"
   SWEP.IconLetter         = "z"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Spawnable             = true
SWEP.AutoSpawnable         = true

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_M249

SWEP.Primary.Damage        = 12
SWEP.Primary.Delay         = 0.04
SWEP.Primary.Cone          = 0.07
SWEP.Primary.ClipSize      = 300
SWEP.Primary.ClipMax       = 300
SWEP.Primary.DefaultClip   = 300
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "AirboatGun"
SWEP.Primary.Recoil        = 0.4
SWEP.Primary.Sound         = Sound("Weapon_m249.Single")

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel            = "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier    = 2.2

SWEP.IronSightsPos         = Vector(-5.96, -5.119, 2.349)
SWEP.IronSightsAng         = Vector(0, 0, 0)
