AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Purple Drank"
    SWEP.Slot = 6
    SWEP.ViewModelFOV = 54
    SWEP.ViewModelFlip = false

    SWEP.EquipMenuData = {
        type = "item_weapon",
        name = "Purple Drank",
        desc = "Heals you for 75 health.\nSingle use."
    }

    SWEP.Icon = "vgui/ttt/icon_pdrank.png"
end

SWEP.Base = "weapon_tttbase"

SWEP.Primary.Ammo = "None"
SWEP.Primary.Recoil = 0.6
SWEP.Primary.Damage = 75
SWEP.Primary.Delay = 0.2
SWEP.Primary.Cone = 0.01
SWEP.Primary.ClipSize = -1
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = -1
SWEP.Primary.ClipMax = -1
SWEP.Primary.Sound = Sound("npc/barnacle/barnacle_gulp1.wav")

SWEP.Kind = WEAPON_EQUIP
SWEP.CanBuy = {ROLE_TRAITOR}

SWEP.Tracer = "AR2Tracer"
SWEP.HoldType = "slam"

if TTT_USE_CUSTOM_MODELS then
    SWEP.UseHands = false
    SWEP.ViewModel = "models/weapons/v_p_drink.mdl"
    SWEP.WorldModel = "models/weapons/w_p_drink.mdl"
else
    SWEP.UseHands = true
    SWEP.ViewModel = "models/weapons/c_grenade.mdl"
    SWEP.WorldModel = "models/weapons/w_grenade.mdl"
end

function SWEP:Deploy()
    self:SendWeaponAnim(ACT_VM_DEPLOY)
    self.Drinking = false
end

function SWEP:PrimaryAttack()
    if self.Drinking or self.Owner:Health() >= self.Owner:GetMaxHealth() then return end
    self.Drinking = true

    if (IsFirstTimePredicted() or game.SinglePlayer()) then
        timer.Simple(1, function()
            if self:IsValid() and self.Owner:IsValid() and self.Owner:Alive() and self.Owner:GetActiveWeapon() == self then
                self.Owner:SetHealth(math.Clamp(self.Owner:Health() + self.Primary.Damage, 1, self.Owner:GetMaxHealth()))
                self.Owner:ViewPunch(Angle(-40, 0, 0))
                self:EmitSound(self.Primary.Sound)

                timer.Simple(1, function()
                    if self:IsValid() and self.Owner:IsValid() and self.Owner:Alive() then
                        self.Drinking = false

                        if SERVER then
                            self.Owner:SelectWeapon("weapon_zm_improvised")
                            self.Owner:StripWeapon(self.ClassName)
                        end
                    end
                end)
            end
        end)
    end
end

function SWEP:SecondaryAttack() end
