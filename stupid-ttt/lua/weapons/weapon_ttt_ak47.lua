AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "AK-47"
    SWEP.Slot = 2
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFOV = 54
    SWEP.Icon = "vgui/ttt/icon_ak47.png"
    SWEP.IconLetter = "l"
end

SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M16

SWEP.Primary.Damage = 30
SWEP.Primary.Delay = 0.12
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Recoil = 7
SWEP.Primary.Sound = Sound("Weapon_ak47.Single")

SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.HoldType = "ar2"

SWEP.IronSightsPos = Vector(-6.55, -5, 2.4)
SWEP.IronSightsAng = Vector(2.2, -0.1, 0)

SWEP.DeploySpeed = 1
