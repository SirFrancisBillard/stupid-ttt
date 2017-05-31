AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
	SWEP.PrintName          = "Ear Rape Pistol"
	SWEP.Slot               = 6

	SWEP.ViewModelFlip      = false
	SWEP.ViewModelFOV       = 54

	SWEP.EquipMenuData = {
		type = "item_weapon",
		desc = "Shoot someone to distorient them\nwith ear rape."
	};

	SWEP.Icon               = "vgui/ttt/icon_earrape.png"
	SWEP.IconLetter         = "a"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Primary.Recoil        = 0
SWEP.Primary.Damage        = 1
SWEP.Primary.Delay         = 1
SWEP.Primary.Cone          = 0
SWEP.Primary.ClipSize      = 1
SWEP.Primary.Automatic     = true
SWEP.Primary.DefaultClip   = 1
SWEP.Primary.ClipMax       = 1
SWEP.Primary.Ammo          = "None"
SWEP.Primary.Sound         = Sound("Weapon_USP.SilencedShot")
SWEP.Primary.SoundLevel    = 50

SWEP.Kind                  = WEAPON_EQUIP
SWEP.CanBuy                = {ROLE_TRAITOR} -- only traitors can buy
SWEP.WeaponID              = AMMO_SIPISTOL

SWEP.AmmoEnt               = nil
SWEP.IsSilent              = true

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel            = "models/weapons/w_pist_usp_silencer.mdl"

SWEP.IronSightsPos         = Vector(-5.91, -4, 2.84)
SWEP.IronSightsAng         = Vector(-0.5, 0, 0)

SWEP.PrimaryAnim           = ACT_VM_PRIMARYATTACK_SILENCED
SWEP.ReloadAnim            = ACT_VM_RELOAD_SILENCED

SWEP.EarRape = true

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
	return self.BaseClass.Deploy(self)
end
