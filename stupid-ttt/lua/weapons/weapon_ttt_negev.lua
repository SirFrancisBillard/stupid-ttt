AddCSLuaFile()

SWEP.HoldType              = "crossbow"

if CLIENT then
   SWEP.PrintName          = "Negev"
   SWEP.Slot               = 6

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.EquipMenuData = {
      type = "item_weapon",
      desc = "An accurate, powerful machine gun.\n\nNo downsides really."
   };

   SWEP.Icon               = "vgui/ttt/icon_negev.png"
   SWEP.IconLetter         = "z"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Spawnable             = false
SWEP.AutoSpawnable         = false

SWEP.CanBuy = {ROLE_DETECTIVE, ROLE_TRAITOR}
SWEP.Kind                  = WEAPON_EQUIP

SWEP.Primary.Damage        = 40
SWEP.Primary.Delay         = 0.04
SWEP.Primary.Cone          = 0.035
SWEP.Primary.ClipSize      = 250
SWEP.Primary.ClipMax       = 250
SWEP.Primary.DefaultClip   = 250
SWEP.Primary.Automatic     = true
SWEP.Primary.Ammo          = "AirboatGun"
SWEP.Primary.Recoil        = 3.5
SWEP.Primary.Sound         = Sound("Weapon_m249.Single")

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel            = "models/weapons/w_mach_m249para.mdl"

SWEP.HeadshotMultiplier    = 2.2

SWEP.IronSightsPos         = Vector(-5.96, -5.119, 2.349)
SWEP.IronSightsAng         = Vector(0, 0, 0)
