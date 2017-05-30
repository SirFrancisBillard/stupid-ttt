AddCSLuaFile()

SWEP.HoldType           = "grenade"

if CLIENT then
	SWEP.PrintName       = "Turtle Grenade"
	SWEP.Slot            = 7

	SWEP.ViewModelFlip   = false
	SWEP.ViewModelFOV    = 54

  	SWEP.EquipMenuData = {
		type = "item_weapon",
		desc = "decoy_desc"
	}

	SWEP.Icon            = "vgui/ttt/icon_turtle.png"
	SWEP.IconLetter      = "Q"
end

SWEP.Base               = "weapon_tttbasegrenade"

SWEP.Kind               = WEAPON_EQUIP2
SWEP.CanBuy             = {ROLE_TRAITOR}
SWEP.LimitedStock       = true -- only buyable once

SWEP.UseHands           = true
SWEP.ViewModel          = "models/weapons/cstrike/c_eq_fraggrenade.mdl"
SWEP.WorldModel         = "models/weapons/w_eq_fraggrenade.mdl"

SWEP.Weight             = 5
SWEP.AutoSpawnable      = true
SWEP.Spawnable          = true
-- really the only difference between grenade weapons: the model and the thrown
-- ent.

function SWEP:GetGrenadeName()
   return "ttt_turtlenade_proj"
end
