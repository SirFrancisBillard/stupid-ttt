AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Jihad Bomb"
    SWEP.Slot = 7
    SWEP.Icon = "vgui/ttt/icon_jihad.png"
end

-- SWEP STUFF
SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "slam"
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 5
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.UseHands = true
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 54
SWEP.ViewModel = "models/weapons/cstrike/c_c4.mdl"
SWEP.WorldModel = "models/weapons/w_c4.mdl"
-- TTT CONFIGURATION
SWEP.Kind = WEAPON_EQUIP2
SWEP.AutoSpawnable = false
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.InLoadoutFor = {nil}
SWEP.LimitedStock = true
SWEP.AllowDrop = false
SWEP.NoSights = true

if CLIENT then
    SWEP.EquipMenuData = {
        name = "Jihad Bomb",
        type = "item_weapon",
        desc = "Sacrifice your life for Allah."
    }
end

function SWEP:Reload()
    return false
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
    util.PrecacheModel("models/Humans/Charple01.mdl")
    util.PrecacheModel("models/Humans/Charple02.mdl")
    util.PrecacheModel("models/Humans/Charple03.mdl")
    util.PrecacheModel("models/Humans/Charple04.mdl")
end

function SWEP:PrimaryAttack()
    self.AllowDrop = false
    self:SetNextPrimaryFire(CurTime() + 5)
    local effectdata = EffectData()
    effectdata:SetOrigin(self:GetPos())
    effectdata:SetNormal(self:GetPos())
    effectdata:SetMagnitude(8)
    effectdata:SetScale(1)
    effectdata:SetRadius(20)
    self.BaseClass.ShootEffects(self)
    self:SetHoldType("slam")

    if (SERVER) then
        timer.Simple(3, function()
            self:Explode()
        end)

        timer.Simple(2, function()
            self:Scream()
        end)

        self.Owner:EmitSound("weapons/c4/c4_beep1.wav", 125, math.random(95, 105))
    end
end

function SWEP:Scream()
    if (self.Owner:IsValid()) then
        self.Owner:EmitSound("stupid-ttt/allahu/akbar_" .. math.random(1, 10) .. ".wav", 150, math.random(95, 105))
    end
end

function SWEP:Explode()
	if not IsValid(self) or not IsValid(self.Owner) or not self.Owner:Alive() then return end

    local explosion = ents.Create("env_explosion")
	local dmg = DamageInfo()
	
	dmg:SetAttacker(self.Owner)
	explosion:SetPos(self:GetPos())
	explosion:SetOwner(self.Owner)
	explosion:SetKeyValue("iMagnitude", "200")
	explosion:Spawn()
	explosion:Fire("Explode", 0, 0)
	explosion:EmitSound(Sound("ambient/explosions/explode_" .. math.random(1, 4) .. ".wav", 200, math.random(100, 150)))
	self.Owner:SetModel("models/Humans/Charple0" .. math.random(1, 4) .. ".mdl")
	self.Owner:SetColor(COLOR_WHITE)
	util.BlastDamage(self, self.Owner, self:GetPos(), 800, 300)
	self:Remove()
end

function SWEP:SecondaryAttack()
    self:SetNextSecondaryFire(CurTime() + 3)
    if SERVER then
		SendTaunt(self)
	end
end
