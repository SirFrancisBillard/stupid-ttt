AddCSLuaFile()

SWEP.HoldType				  = "duel"

if CLIENT then
	SWEP.PrintName			 = "Pocket Rifle"
	SWEP.Slot					= 1

	SWEP.ViewModelFlip		= false
	SWEP.ViewModelFOV		 = 54

	SWEP.Icon					= "vgui/ttt/icon_pocketrifle.png"
	SWEP.IconLetter			= "B"
end

SWEP.Base						= "weapon_tttbase"

SWEP.Kind						= WEAPON_PISTOL

SWEP.Primary.Ammo	        = "AlyxGun"
SWEP.Primary.Damage		    = 20
SWEP.Primary.Cone		    = 0
SWEP.Primary.Delay			= 1
SWEP.Primary.ClipSize		= 4
SWEP.Primary.ClipMax	    = 36
SWEP.Primary.DefaultClip	= 4
SWEP.Primary.Automatic	    = true
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_Pistol.Single")
SWEP.Primary.Recoil		    = 4.5

SWEP.AutoSpawnable			= true
SWEP.Spawnable				= true
SWEP.AmmoEnt				= "item_ammo_revolver_ttt"

SWEP.UseHands				= true
SWEP.ViewModel 				= Model("models/weapons/c_pistol.mdl")
SWEP.WorldModel				= Model("models/weapons/w_pistol.mdl")

SWEP.IronSightsPos = Vector(-5.56, -20.121, 2.759)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.VElements = {
	["rifle"] = {type = "Model", model = "models/weapons/w_snip_g3sg1.mdl", bone = "ValveBiped.clip", rel = "", pos = Vector(0.002, 1.531, 4.534), angle = Angle(89.393, -5.659, -83.97), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}}
}

SWEP.WElements = {
	["rifle"] = {type = "Model", model = "models/weapons/w_snip_g3sg1.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.475, 2.223, -0.32), angle = Angle(-4.404, -1.211, 180), size = Vector(0.449, 0.449, 0.449), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}}
}

SWEP.Secondary.Sound = Sound("Default.Zoom")

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
