AddCSLuaFile()

SWEP.HoldType            = "shotgun"

if CLIENT then
    SWEP.PrintName = "Grenade Launcher"
    SWEP.Slot = 6
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFOV = 54

    SWEP.EquipMenuData = {
        type = "item_weapon",
        name = "Grenade Launcher",
        desc = "A grenade launcher.\nLimited ammo."
    }

    SWEP.Icon = "vgui/ttt/icon_gl.png"
    SWEP.IconLetter = "l"
end

SWEP.Base                = "weapon_tttbase"

SWEP.CanBuy              = {ROLE_TRAITOR}
SWEP.Kind                = WEAPON_EQUIP1

game.AddAmmoType({name = "gl"})
if CLIENT then
	LANG.AddToLanguage("english", "ammo_gl", "SMG Grenades")
end

SWEP.Primary.Damage = 60
SWEP.Primary.Delay = 0.05
SWEP.Primary.Cone = 0.02
SWEP.Primary.ClipSize = 6
SWEP.Primary.ClipMax = 54
SWEP.Primary.DefaultClip = 54
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "gl"
SWEP.Primary.Recoil = 3.2
SWEP.Primary.Sound = Sound("weapons/grenade_launcher1.wav")

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"

SWEP.IronSightsPos = Vector(-6.881, -9.214, 2.66)
SWEP.IronSightsAng = Vector(-0.101, -0.7, -0.201)

SWEP.DeploySpeed = 1

function SWEP:SecondaryAttack()
    self:SetNextSecondaryFire(CurTime() + 3)
    if SERVER then
		SendTaunt(self)
	end
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end

	self:SetNextPrimaryFire(CurTime() + 0.5)
	self:SetNextSecondaryFire(CurTime() + 0.5)

	self:ShootEffects()
	self:TakePrimaryAmmo(1)
	self:EmitSound(self.Primary.Sound)

	if CLIENT then return end
	
	local ent = ents.Create("ent_smgbomb")
	if not IsValid(ent) then return end

	ent:SetPos(self.Owner:EyePos())
	ent:SetAngles(self.Owner:EyeAngles())
	ent:SetOwner(self.Owner)
	ent:Spawn()
	ent:Activate()
	ent:Fire()
	
	local phys = ent:GetPhysicsObject()
	if not IsValid(phys) then ent:Remove() return end

	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 4000
	velocity = velocity + (VectorRand() * 10)
	phys:ApplyForceCenter(velocity)
end

function SWEP:SetupDataTables()
    self:DTVar("Bool", 0, "reloading")

    return self.BaseClass.SetupDataTables(self)
end

function SWEP:Reload()
    --if self:GetNWBool( "reloading", false ) then return end
    if self.dt.reloading then return end
    if not IsFirstTimePredicted() then return end

    if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount(self.Primary.Ammo) > 0 then
        if self:StartReload() then return end
    end
end

function SWEP:StartReload()
    --if self:GetNWBool( "reloading", false ) then
    if self.dt.reloading then return false end
    self:SetIronsights(false)
    if not IsFirstTimePredicted() then return false end
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    local ply = self.Owner
    if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then return false end
    local wep = self
    if wep:Clip1() >= self.Primary.ClipSize then return false end
    wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)
    self.reloadtimer = CurTime() + wep:SequenceDuration()
    --wep:SetNWBool("reloading", true)
    self.dt.reloading = true

    return true
end

function SWEP:PerformReload()
    local ply = self.Owner
    -- prevent normal shooting in between reloads
    self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then return end
    if self:Clip1() >= self.Primary.ClipSize then return end
    self.Owner:RemoveAmmo(1, self.Primary.Ammo, false)
    self:SetClip1(self:Clip1() + 1)
    self:SendWeaponAnim(ACT_VM_RELOAD)
    self.reloadtimer = CurTime() + self:SequenceDuration()
end

function SWEP:FinishReload()
    self.dt.reloading = false
    self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
    self.reloadtimer = CurTime() + self:SequenceDuration()
end

function SWEP:CanPrimaryAttack()
    if self:Clip1() <= 0 then
        self:EmitSound("Weapon_Shotgun.Empty")
        self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)

        return false
    end

    return true
end

function SWEP:Think()
    if self.dt.reloading and IsFirstTimePredicted() then
        if self.Owner:KeyDown(IN_ATTACK) then
            self:FinishReload()

            return
        end

        if self.reloadtimer <= CurTime() then
            if self.Owner:GetAmmoCount(self.Primary.Ammo) <= 0 then
                self:FinishReload()
            elseif self:Clip1() < self.Primary.ClipSize then
                self:PerformReload()
            else
                self:FinishReload()
            end

            return
        end
    end
end

function SWEP:Deploy()
    self.dt.reloading = false
    self.reloadtimer = 0

    return self.BaseClass.Deploy(self)
end

-- The shotgun's headshot damage multiplier is based on distance. The closer it
-- is, the more damage it does. This reinforces the shotgun's role as short
-- range weapon by reducing effectiveness at mid-range, where one could score
-- lucky headshots relatively easily due to the spread.
function SWEP:GetHeadshotMultiplier(victim, dmginfo)
    local att = dmginfo:GetAttacker()
    if not IsValid(att) then return 3 end
    local dist = victim:GetPos():Distance(att:GetPos())
    local d = math.max(0, dist - 140)
    -- decay from 3.1 to 1 slowly as distance increases

    return 1 + math.max(0, 2.1 - 0.002 * (d ^ 1.25))
end
