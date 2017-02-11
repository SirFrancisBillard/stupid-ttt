AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Uzi"
    SWEP.Slot = 2
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFOV = 54
    SWEP.Icon = "vgui/ttt/icon_mac"
    SWEP.IconLetter = "l"
end

SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_HEAVY

SWEP.Primary.Damage = 18
SWEP.Primary.Delay = 0.02
SWEP.Primary.Cone = 0.1
SWEP.Primary.ClipSize = 30
SWEP.Primary.ClipMax = 120
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "smg1"
SWEP.Primary.Recoil = 0.2
SWEP.Primary.Sound = Sound("Weapon_MAC10.Single")

SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"
SWEP.HoldType = "pistol"

SWEP.IronSightsPos = Vector(-8.921, -9.528, 2.9)
SWEP.IronSightsAng = Vector(0.699, -5.301, -7)
