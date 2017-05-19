AddCSLuaFile()

if (CLIENT) then
    SWEP.PrintName = "Warhead"
    SWEP.Slot = 6
    SWEP.SlotPos = 0

    SWEP.EquipMenuData = {
        type = "Weapon",
        model = "models/weapons/w_eq_fraggrenade_thrown.mdl",
        name = "Warhead",
        desc = "Launches a massive warhead with a\nhuge kill radius.\nAllahu akbar."
    }

    SWEP.Icon = "vgui/ttt/icon_rpg"
end

SWEP.Base = "weapon_tttbase"

SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.LimitedStock = true
SWEP.Kind = WEAPON_EQUIP

SWEP.CustomSecondaryAmmo = false
SWEP.HoldType = "rpg"
SWEP.DrawCrosshair = false
SWEP.ViewModel = "models/weapons/c_rpg.mdl"
SWEP.UseHands = true
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"

SWEP.Primary.Reload = Sound("common/null.wav")
SWEP.Primary.Sound = Sound("Weapon_RPG.Single")
SWEP.Primary.SoundNPC = Sound("Weapon_RPG.NPC_Single")
SWEP.Primary.Empty = Sound("Weapon_SMG1.Empty")

function SWEP:Deploy()
    self:EmitSound("items/battery_pickup.wav")
end

function SWEP:Initialize()
    self:SetWeaponHoldType(self.HoldType)
end

SWEP.RunArmAngle = Angle(60, 00, 0)
SWEP.RunArmOffset = Vector(50, 0, -10)
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 55

function SWEP:ShouldDropOnDie()
    return true
end

SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "GaussEnergy"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.AllowDrop = true

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.2)
    if not self:CanPrimaryAttack() then return end
    self:EmitSound("Weapon_RPG.Single")
    self:SetNextPrimaryFire(CurTime() + 1)
    self:SetNextSecondaryFire(CurTime() + 1)
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    self:TakePrimaryAmmo(1)

    if SERVER then
        local grenade = ents.Create("ent_warhead")
        grenade:SetPos(self.Owner:GetShootPos())
        grenade:SetOwner(self.Owner)
        grenade.FlyAngle = self.Owner:GetAimVector():Angle()
        grenade:Spawn()
        local phys = grenade:GetPhysicsObject()

        if (phys:IsValid()) then
            phys:SetVelocity(self.Owner:GetAimVector() * 1000)
        end
    end
end

function SWEP:SecondaryAttack()
    self:SetNextSecondaryFire(CurTime() + TTT_TAUNT_DELAY:GetInt())

    if SERVER then
		SendTaunt(self)
	end
end

function SWEP:Reload() end
