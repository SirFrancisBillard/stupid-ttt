AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "Machine Pistol"
   SWEP.Slot               = 1

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_tmp.png"
   SWEP.IconLetter         = "c"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Primary.Delay         = 0.04
SWEP.Primary.Recoil        = 1
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "smg1"
SWEP.Primary.Damage        = 18
SWEP.Primary.Cone          = 0.1
SWEP.Primary.ClipSize      = 30
SWEP.Primary.ClipMax       = 60
SWEP.Primary.DefaultClip   = 30
SWEP.Primary.Sound         = Sound( "Weapon_TMP.Single" )

SWEP.AutoSpawnable         = true

SWEP.AmmoEnt               = "item_ammo_smg1_ttt"
SWEP.Kind                  = WEAPON_PISTOL

SWEP.HeadshotMultiplier    = 1.75

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel            = "models/weapons/w_smg_tmp.mdl"

SWEP.IronSightsPos = Vector(-1.93, -5.928, 1.82)
SWEP.IronSightsAng = Vector(1.162, 0, 0)
