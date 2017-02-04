AddCSLuaFile()

SWEP.HoldType              = "shotgun"

if CLIENT then
   SWEP.PrintName          = "Railgun"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   if TTT_USE_CUSTOM_MODELS then
      SWEP.Icon = "vgui/ttt/icon_shotgun"
   else
      SWEP.Icon = "vgui/ttt/icon_awp.png"
   end
   SWEP.IconLetter         = "B"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY

SWEP.Tracer                = "AR2Tracer"

SWEP.Primary.Ammo          = "Buckshot"
SWEP.Primary.Damage        = 6
SWEP.Primary.Cone          = 0.04
SWEP.Primary.Delay         = 3
SWEP.Primary.ClipSize      = 8
SWEP.Primary.ClipMax       = 24
SWEP.Primary.DefaultClip   = 8
SWEP.Primary.Automatic     = true
SWEP.Primary.NumShots      = 24
SWEP.Primary.Sound         = Sound("ambient/energy/weld2.wav")
SWEP.Primary.Recoil        = 22

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_box_buckshot_ttt"

if TTT_USE_CUSTOM_MODELS then
	SWEP.UseHands              = true
	SWEP.ViewModel             = "models/weapons/cstrike/c_shot_xm1014.mdl"
	SWEP.WorldModel            = "models/weapons/w_shot_xm1014.mdl"

	SWEP.IronSightsPos         = Vector(-6.881, -9.214, 2.66)
	SWEP.IronSightsAng         = Vector(-0.101, -0.7, -0.201)

	SWEP.reloadtimer           = 0

	function SWEP:SetupDataTables()
	   self:DTVar("Bool", 0, "reloading")

	   return self.BaseClass.SetupDataTables(self)
	end

	function SWEP:Reload()

	   --if self:GetNWBool( "reloading", false ) then return end
	   if self.dt.reloading then return end

	   if not IsFirstTimePredicted() then return end

	   if self:Clip1() < self.Primary.ClipSize and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 then

		  if self:StartReload() then
			 return
		  end
	   end

	end

	function SWEP:StartReload()
	   --if self:GetNWBool( "reloading", false ) then
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

	   --wep:SetNWBool("reloading", true)
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

	function SWEP:CanPrimaryAttack()
	   if self:Clip1() <= 0 then
		  self:EmitSound( "Weapon_Shotgun.Empty" )
		  self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
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

	function SWEP:SecondaryAttack()
	   if self.NoSights or (not self.IronSightsPos) or self.dt.reloading then return end
	   --if self:GetNextSecondaryFire() > CurTime() then return end

	   self:SetIronsights(not self:GetIronsights())

	   self:SetNextSecondaryFire(CurTime() + 0.3)
	end
else
	SWEP.UseHands              = true
	SWEP.ViewModel             = "models/weapons/cstrike/c_snip_awp.mdl"
	SWEP.WorldModel            = "models/weapons/w_snip_awp.mdl"

	SWEP.IronSightsPos         = Vector(-6.881, -9.214, 2.66)
	SWEP.IronSightsAng         = Vector(-0.101, -0.7, -0.201)

	SWEP.Secondary.Sound       = Sound("Default.Zoom")

	function SWEP:SetZoom(state)
	   if CLIENT then
		  return
	   elseif IsValid(self.Owner) and self.Owner:IsPlayer() then
		  if state then
			 self.Owner:SetFOV(35, 0.3)
		  else
			 self.Owner:SetFOV(0, 0.2)
		  end
	   end
	end

	function SWEP:PrimaryAttack( worldsnd )
	   self.BaseClass.PrimaryAttack( self.Weapon, worldsnd )
	   self:SetNextSecondaryFire( CurTime() + 0.1 )
	   if IsFirstTimePredicted() then
		   local effectdata = EffectData()
		   effectdata:SetOrigin( self.Owner:GetEyeTrace().HitPos )
		   effectdata:SetStart( self.Owner:GetShootPos() )
		   effectdata:SetAttachment( 1 )
		   effectdata:SetEntity( self )
		   util.Effect( "ToolTracer", effectdata )
	   end
	end

	-- Add some zoom to ironsights for this gun
	function SWEP:SecondaryAttack()
	   if not self.IronSightsPos then return end
	   if self:GetNextSecondaryFire() > CurTime() then return end

	   local bIronsights = not self:GetIronsights()

	   self:SetIronsights( bIronsights )

	   if SERVER then
		  self:SetZoom(bIronsights)
	   else
		  self:EmitSound(self.Secondary.Sound)
	   end

	   self:SetNextSecondaryFire( CurTime() + 0.3)
	end

	function SWEP:PreDrop()
	   self:SetZoom(false)
	   self:SetIronsights(false)
	   return self.BaseClass.PreDrop(self)
	end

	function SWEP:Reload()
		if ( self:Clip1() == self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then return end
	   self:DefaultReload( ACT_VM_RELOAD )
	   self:SetIronsights( false )
	   self:SetZoom( false )
	end


	function SWEP:Holster()
	   self:SetIronsights(false)
	   self:SetZoom(false)
	   return true
	end

	if CLIENT then
	   local scope = surface.GetTextureID("sprites/scope")
	   function SWEP:DrawHUD()
		  if self:GetIronsights() then
			 surface.SetDrawColor( 0, 0, 0, 255 )
			 
			 local scrW = ScrW()
			 local scrH = ScrH()

			 local x = scrW / 2.0
			 local y = scrH / 2.0
			 local scope_size = scrH

			 -- crosshair
			 local gap = 80
			 local length = scope_size
			 surface.DrawLine( x - length, y, x - gap, y )
			 surface.DrawLine( x + length, y, x + gap, y )
			 surface.DrawLine( x, y - length, x, y - gap )
			 surface.DrawLine( x, y + length, x, y + gap )

			 gap = 0
			 length = 50
			 surface.DrawLine( x - length, y, x - gap, y )
			 surface.DrawLine( x + length, y, x + gap, y )
			 surface.DrawLine( x, y - length, x, y - gap )
			 surface.DrawLine( x, y + length, x, y + gap )


			 -- cover edges
			 local sh = scope_size / 2
			 local w = (x - sh) + 2
			 surface.DrawRect(0, 0, w, scope_size)
			 surface.DrawRect(x + sh - 2, 0, w, scope_size)
			 
			 -- cover gaps on top and bottom of screen
			 surface.DrawLine( 0, 0, scrW, 0 )
			 surface.DrawLine( 0, scrH - 1, scrW, scrH - 1 )

			 surface.SetDrawColor(255, 0, 0, 255)
			 surface.DrawLine(x, y, x + 1, y + 1)

			 -- scope
			 surface.SetTexture(scope)
			 surface.SetDrawColor(255, 255, 255, 255)

			 surface.DrawTexturedRectRotated(x, y, scope_size, scope_size, 0)
		  else
			 return self.BaseClass.DrawHUD(self)
		  end
	   end

	   function SWEP:AdjustMouseSensitivity()
		  return (self:GetIronsights() and 0.2) or nil
	   end
	end
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
   return 1 + (dist / 100)
end