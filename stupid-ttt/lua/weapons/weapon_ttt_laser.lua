AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "Laser Rifle"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon = "vgui/ttt/icon_laser.png"

   SWEP.IconLetter         = "B"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY

SWEP.Tracer                = "AR2Tracer"

SWEP.Primary.Ammo          = "AirboatGun"
SWEP.Primary.Damage        = 3
SWEP.Primary.Cone          = 0.004
SWEP.Primary.Delay         = 0.01
SWEP.Primary.ClipSize      = 1000
SWEP.Primary.ClipMax       = 1000
SWEP.Primary.DefaultClip   = 1000
SWEP.Primary.Automatic     = true
SWEP.Primary.NumShots      = 1
SWEP.Primary.Sound         = Sound("weapons/ar2/npc_ar2_altfire.wav")
SWEP.Primary.Recoil        = 0.1

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_snip_sg550.mdl"
SWEP.WorldModel            = "models/weapons/w_snip_sg550.mdl"

SWEP.IronSightsPos         = Vector(-6.881, -9.214, 2.66)
SWEP.IronSightsAng         = Vector(-0.101, -0.7, -0.201)

SWEP.Secondary.Sound       = Sound("Default.Zoom")


function SWEP:SetZoom(state)
   if CLIENT then
      return
   elseif IsValid(self.Owner) and self.Owner:IsPlayer() then
      if state then
	     self.Owner:DrawViewModel(false)
         self.Owner:SetFOV(20, 0.3)
      else
	     self.Owner:DrawViewModel(true)
         self.Owner:SetFOV(0, 0.2)
      end
   end
end

function SWEP:PrimaryAttack( worldsnd )
   self.BaseClass.PrimaryAttack( self.Weapon, worldsnd )
   self:SetNextSecondaryFire( CurTime() + 0.1 )
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
