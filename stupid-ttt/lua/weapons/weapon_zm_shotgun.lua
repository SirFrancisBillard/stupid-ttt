AddCSLuaFile()

SWEP.HoldType              = "shotgun"

if CLIENT then
    SWEP.Slot = 2
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFOV = 54

    if TTT_USE_CUSTOM_MODELS then
        SWEP.Icon = "vgui/ttt/icon_dbarrel.png"
    else
        SWEP.Icon = "vgui/ttt/icon_shotgun"
    end

    SWEP.IconLetter = "B"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY
SWEP.WeaponID              = AMMO_SHOTGUN

SWEP.Primary.Ammo          = "Buckshot"
SWEP.Primary.ClipMax       = 24
SWEP.Primary.Cone = 0.2
SWEP.Primary.Automatic     = true
SWEP.Primary.NumShots      = 18
SWEP.Primary.Sound         = Sound("Weapon_XM1014.Single")
SWEP.Primary.Recoil        = 20

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_box_buckshot_ttt"

SWEP.UseHands = true

if TTT_USE_CUSTOM_MODELS then
	SWEP.PrintName = "Super Shotgun"
	
	SWEP.ViewModel = "models/weapons/tfa_doom/c_ssg.mdl"
	SWEP.WorldModel = "models/weapons/tfa_doom/w_ssg.mdl"

	SWEP.Primary.ClipSize = 2
	SWEP.Primary.Damage = 26
	SWEP.Primary.DefaultClip = 2
	SWEP.Primary.Delay = 0.4

	SWEP.IronSightsPos = Vector(-1.5, 0, 1.159)
	SWEP.IronSightsAng = Vector(0.6, 0.219, 0.127)

	local function IsGood(ent)
		return IsValid(ent) and IsValid(ent.Owner) and ent.Owner:Alive() and IsValid(ent.Owner:GetActiveWeapon()) and ent.Owner:GetActiveWeapon():GetClass() == ent.ClassName
	end

	local function QueueSound(ent, time, snd)
		timer.Simple(time, function()
			if not IsGood(ent) or SERVER then return end
			surface.PlaySound(snd)
		end)
	end

	local r_out = Sound("weapons/m4a1/m4a1_clipout.wav")
	local r_in = Sound("weapons/awp/awp_clipin.wav")

	function SWEP:Reload()
		if self:DefaultReload(ACT_VM_RELOAD) and IsFirstTimePredicted() then
			self:SetIronsights(false)
			QueueSound(self, 0.2, r_out)
			QueueSound(self, 0.6, r_in)
		end
	end
else
	SWEP.PrintName = "Shotgun"

	SWEP.ViewModel = "models/weapons/cstrike/c_shot_xm1014.mdl"
	SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"

	SWEP.IronSightsPos = Vector(-6.881, -9.214, 2.66)
	SWEP.IronSightsAng = Vector(-0.101, -0.7, -0.201)

	SWEP.reloadtimer = 0

	SWEP.Primary.ClipSize = 8
	SWEP.Primary.Damage = 6
	SWEP.Primary.DefaultClip = 8
	SWEP.Primary.Delay = 0.5

	function SWEP:SetupDataTables()
	   self:DTVar("Bool", 0, "reloading")

	   return self.BaseClass.SetupDataTables(self)
	end

	function SWEP:Reload()
	   if self.dt.reloading then return end

	   if not IsFirstTimePredicted() then return end

	   if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then

		  if self:StartReload() then
			 return
		  end
	   end

	end

	function SWEP:StartReload()
	   if self.dt.reloading then
		  return false
	   end

	   self:SetIronsights( false )

	   if not IsFirstTimePredicted() then return false end

	   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	   local ply = self.Owner

	   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then
		  return false
	   end

	   local wep = self

	   if wep:Clip1() >= self.Primary.ClipSize then
		  return false
	   end

	   wep:SendWeaponAnim(ACT_SHOTGUN_RELOAD_START)

	   self.reloadtimer =  CurTime() + wep:SequenceDuration()

	   self.dt.reloading = true

	   return true
	end

	function SWEP:PerformReload()
	   local ply = self.Owner

	   -- prevent normal shooting in between reloads
	   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	   if not ply or ply:GetAmmoCount(self.Primary.Ammo) <= 0 then return end

	   if self:Clip1() >= self.Primary.ClipSize then return end

	   self.Owner:RemoveAmmo( 1, self.Primary.Ammo, false )
	   self:SetClip1( self:Clip1() + 1 )

	   self:SendWeaponAnim(ACT_VM_RELOAD)

	   self.reloadtimer = CurTime() + self:SequenceDuration()
	end

	function SWEP:FinishReload()
	   self.dt.reloading = false
	   self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)

	   self.reloadtimer = CurTime() + self:SequenceDuration()
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

	function SWEP:SecondaryAttack()
	   if self.NoSights or (not self.IronSightsPos) or self.dt.reloading then return end

	   self:SetIronsights(not self:GetIronsights())

	   self:SetNextSecondaryFire(CurTime() + 0.3)
	end
end

function SWEP:CanPrimaryAttack()
   if self:Clip1() <= 0 then
      self:EmitSound( "Weapon_Shotgun.Empty" )
      self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
      return false
   end
   return true
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
   return 1 + math.max(0, (2.1 - 0.002 * (d ^ 1.25)))
end
