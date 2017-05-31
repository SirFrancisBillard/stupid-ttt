AddCSLuaFile()

SWEP.HoldType              = "duel"

if CLIENT then
   SWEP.PrintName          = "Dual Elites"
   SWEP.Slot               = 1

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon               = "vgui/ttt/icon_dualies.png"
   SWEP.IconLetter         = "B"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_PISTOL

SWEP.Primary.Ammo          = "smg1"
SWEP.Primary.Damage        = 17
SWEP.Primary.Cone          = 0.025
SWEP.Primary.Delay         = 0.15
SWEP.Primary.ClipSize      = 30
SWEP.Primary.ClipMax       = 90
SWEP.Primary.DefaultClip   = 30
SWEP.Primary.Automatic     = true
SWEP.Primary.NumShots      = 1
SWEP.Primary.Sound         = Sound("Weapon_Elite.Single")
SWEP.Primary.Recoil        = 4.5

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_smg1_ttt"

SWEP.UseHands              = true
SWEP.ViewModel 			   = Model("models/weapons/cstrike/c_pist_elite.mdl")
SWEP.WorldModel			   = Model("models/weapons/w_pist_elite.mdl")

SWEP.NoSights = true

SWEP.IronSightsPos         = Vector(-5.2, -9.214, 2.66)
SWEP.IronSightsAng         = Vector(-0.101, -0.7, -0.201)
