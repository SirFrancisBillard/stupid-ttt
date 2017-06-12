AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "M4A1"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 64

   SWEP.Icon               = "vgui/ttt/icon_m16"
   SWEP.IconLetter         = "w"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY

SWEP.Primary.Damage = 17
SWEP.Primary.Delay = 0.08
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "pistol"
SWEP.Primary.Recoil = 1
SWEP.Primary.Sound         = Sound( "Weapon_M4A1.Single" )

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_pistol_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel            = "models/weapons/w_rif_m4a1.mdl"

SWEP.IronSightsPos         = Vector(-7.72, -6.064, 0.72)
SWEP.IronSightsAng         = Vector(2, -1.3, -3.031)
