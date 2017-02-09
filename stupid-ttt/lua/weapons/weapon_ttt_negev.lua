AddCSLuaFile()

SWEP.HoldType              = "crossbow"

if CLIENT then
   SWEP.PrintName          = "Negev"
   SWEP.Slot               = 6

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.EquipMenuData = {
      type = "item_weapon",
      desc = "An accurate machine gun with\nnearly endless capacity.\nNo downsides really."
   };

   SWEP.Icon               = "vgui/ttt/icon_negev.png"
   SWEP.IconLetter         = "z"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Spawnable             = false
SWEP.AutoSpawnable         = false

SWEP.CanBuy = {ROLE_DETECTIVE, ROLE_TRAITOR}
SWEP.Kind                  = WEAPON_EQUIP

SWEP.Primary.Damage        = 6
SWEP.Primary.Delay         = 0.02
SWEP.Primary.Cone          = 0.035
SWEP.Primary.ClipSize      = 2500
SWEP.Primary.ClipMax       = 2500
SWEP.Primary.DefaultClip   = 2500
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "AirboatGun"
SWEP.Primary.Recoil        = 0.6
SWEP.Primary.Sound         = Sound("Weapon_m249.Single")

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel            = "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier    = 2.2

SWEP.IronSightsPos         = Vector(-5.96, -5.119, 2.349)
SWEP.IronSightsAng         = Vector(0, 0, 0)
