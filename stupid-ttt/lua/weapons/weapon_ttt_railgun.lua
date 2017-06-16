AddCSLuaFile()

SWEP.HoldType              = "ar2"

if CLIENT then
   SWEP.PrintName          = "Railgun"
   SWEP.Slot               = 2

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.Icon = "vgui/ttt/icon_laser.png"

   SWEP.IconLetter         = "B"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Kind                  = WEAPON_HEAVY

SWEP.Tracer                = "AR2Tracer"

SWEP.Primary.Delay = 2.5
SWEP.Primary.Recoil = 7
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "357"
SWEP.Primary.Damage = 20
SWEP.Primary.Cone = 0.005
SWEP.Primary.ClipSize = 4
SWEP.Primary.ClipMax = 20 -- keep mirrored to ammo
SWEP.Primary.DefaultClip = 4
SWEP.Primary.Sound = Sound("Weapon_AWP.Single")

SWEP.AutoSpawnable         = true
SWEP.Spawnable             = true
SWEP.AmmoEnt               = "item_ammo_357_ttt"

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_snip_awp.mdl"
SWEP.WorldModel            = "models/weapons/w_snip_awp.mdl"

SWEP.IronSightsPos = Vector(-7.441, -11.761, 2.24)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.VElements = {
	["clip"] = {type = "Model", model = "models/Items/car_battery01.mdl", bone = "v_weapon.awm_clip", rel = "", pos = Vector(0, 1.381, 2.881), angle = Angle(0, 0, -93.724), size = Vector(0.298, 0.298, 0.298), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}},
	["barrel"] = {type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "v_weapon.awm_parent", rel = "", pos = Vector(0, -3.207, -10.056), angle = Angle(0, 0, 0), size = Vector(0.718, 0.718, 0.718), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}},
	["back"] = {type = "Model", model = "models/Items/battery.mdl", bone = "v_weapon.awm_parent", rel = "", pos = Vector(0, -3.53, -0.731), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}}
}

SWEP.WElements = {
	["clip"] = {type = "Model", model = "models/Items/car_battery01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(9.715, 0.908, -1.236), angle = Angle(-0.806, 88.811, 9.029), size = Vector(0.425, 0.425, 0.425), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["barrel"] = {type = "Model", model = "models/Items/combine_rifle_ammo01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-2.3, 0.529, -2.224), angle = Angle(-100.164, -1.129, 0), size = Vector(0.718, 0.718, 0.718), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}}
}

SWEP.Primary.Special1 = "stupid-ttt/railgun.wav"
SWEP.Primary.Special2 = Sound("Buttons.snd3")

SWEP.Secondary.Sound = Sound("Default.Zoom")

function SWEP:ShootBullet( dmg, recoil, numbul, cone )
   self:SendWeaponAnim(self.PrimaryAnim)

   self.Owner:MuzzleFlash()
   self.Owner:SetAnimation( PLAYER_ATTACK1 )

   if not IsFirstTimePredicted() then return end

   local sights = self:GetIronsights()

   numbul = numbul or 1
   cone   = cone   or 0.01

   local bullet = {}
   bullet.Num    = numbul
   bullet.Src    = self.Owner:GetShootPos()
   bullet.Dir    = self.Owner:GetAimVector()
   bullet.Spread = Vector( cone, cone, 0 )
   bullet.Tracer = 1
   bullet.TracerName = "ToolTracer"
   bullet.Force  = 10
   bullet.Damage = dmg

   self.Owner:FireBullets( bullet )

   -- Owner can die after firebullets
   if (not IsValid(self.Owner)) or (not self.Owner:Alive()) or self.Owner:IsNPC() then return end

   if ((game.SinglePlayer() and SERVER) or
       ((not game.SinglePlayer()) and CLIENT and IsFirstTimePredicted())) then

      -- reduce recoil if ironsighting
      recoil = sights and (recoil * 0.6) or recoil

      local eyeang = self.Owner:EyeAngles()
      eyeang.pitch = eyeang.pitch - recoil
      self.Owner:SetEyeAngles( eyeang )
   end

end

function SWEP:PrimaryAttack(worldsnd)
   if ( self:Clip1() == 0 ) then return end
   self.InAttack = true
   self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
   self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

   if SERVER then
       self.ChargeSound = CreateSound(self.Owner, self.Primary.Special1)
       self.ChargeSound:SetSoundLevel(90)
       self.ChargeSound:Play()
   end

   self.mode1 = CurTime() +.05
   if ( self:Clip1() > 1 ) then
       self.mode2 = CurTime() +.6
   end
   if ( self:Clip1() > 2 ) then
        self.mode3 = CurTime() +1.2
   end
   if ( self:Clip1() > 3 ) then
       self.mode4 = CurTime() +1.8
   end
   self.overcharge = CurTime() +2.3
end

function SWEP:Shake()
	if SERVER then
		local shake = ents.Create( "env_shake" )
			shake:SetOwner( self.Owner )
			shake:SetPos( self:GetPos() )
			shake:SetKeyValue( "amplitude", "5" )
			shake:SetKeyValue( "radius", "64" )
			shake:SetKeyValue( "duration", "1.5" )
			shake:SetKeyValue( "frequency", "255" )
			shake:SetKeyValue( "spawnflags", "4" )
			shake:Spawn()
			shake:Activate()
			shake:Fire( "StartShake", "", 0 )
	end
end

function SWEP:Think()
	if self.mode1 and CurTime() > self.mode1 then
		self.mode1 = nil
		if !self.Owner:KeyDown(IN_ATTACK) then return end
		self.mode = "single"
		self:Shake()
   		if (ConVarExists("ttt_rp_railgun_sound")) then
		      if GetConVar("ttt_rp_railgun_sound"):GetBool() then self:EmitSound( self.Primary.Special2, self.Primary.SoundLevel ) end
		end
	end
	
	if self.mode2 and CurTime() > self.mode2 then
		self.mode2 = nil
		if !self.Owner:KeyDown(IN_ATTACK) then return end
		self.mode = "2"
		self:Shake()
   		if (ConVarExists("ttt_rp_railgun_sound")) then
		      if GetConVar("ttt_rp_railgun_sound"):GetBool() then self:EmitSound( self.Primary.Special2, self.Primary.SoundLevel ) end
		end
	end
	
	if self.mode3 and CurTime() > self.mode3 then
		self.mode3 = nil
		if !self.Owner:KeyDown(IN_ATTACK) then return end
		self.mode = "3"
		self:Shake()
   		if (ConVarExists("ttt_rp_railgun_sound")) then
		      if GetConVar("ttt_rp_railgun_sound"):GetBool() then self:EmitSound( self.Primary.Special2, self.Primary.SoundLevel ) end
		end
	end
	
	if self.mode4 and CurTime() > self.mode4 then
		self.mode4 = nil
		if !self.Owner:KeyDown(IN_ATTACK) then return end
		self.mode = "4"
		self:Shake()
   		if (ConVarExists("ttt_rp_railgun_sound")) then
		      if GetConVar("ttt_rp_railgun_sound"):GetBool() then self:EmitSound( self.Primary.Special2, self.Primary.SoundLevel ) end
		end
	end
	
	if self.overcharge and CurTime() > self.overcharge then
		self.overcharge = nil
		if !self.Owner:KeyDown(IN_ATTACK) then return end
		self:Explode()
	end
	
	if !self.InAttack or self.Owner:KeyDown(IN_ATTACK) then return end
	self.InAttack = nil
	self:BfgFire(true)
	self.mode = "single"
	
	self.mode1 = nil
	self.mode2 = nil
	self.mode3 = nil
	self.mode4 = nil
	self.overcharge = nil
end

function SWEP:Explode()
	if !self.Owner:KeyDown(IN_ATTACK) or !self.InAttack then return end
	util.BlastDamage( self, self:GetOwner(), self:GetPos(), 200, 150 )
	local effectdata = EffectData()
	effectdata:SetOrigin( self:GetPos() )
	util.Effect( "HelicopterMegaBomb", effectdata )
	self:EmitSound("weapons/aw50/bfg_explode"..math.random(1,4)..".wav", 100, 100)
	self.InAttack = nil
	self:TakePrimaryAmmo(self.Primary.ClipSize)
	self.mode = "single"
end

function SWEP:BfgFire(worldsnd)

   self:SetNextSecondaryFire( CurTime() + 0.5 )
   self:SetNextPrimaryFire( CurTime() + 0.5 )

   if not worldsnd then
      self:EmitSound( self.Primary.Sound, self.Primary.SoundLevel )
   elseif SERVER then
      sound.Play(self.Primary.Sound, self:GetPos(), self.Primary.SoundLevel)
   end

	local recoil, damage
	if self.mode == "single" then
		self:TakePrimaryAmmo( 1 )
		recoil = 7
		damage = 20
	end
		
	if self.mode == "2" then
		self:TakePrimaryAmmo( 2 )
		recoil = 16
		damage = 40
	end
		
	if self.mode == "3" then
		self:TakePrimaryAmmo( 3 )
		recoil = 36
		damage = 80
	end
			
	if self.mode == "4" then
		self:TakePrimaryAmmo( 4 )
		recoil = 82
		damage = 160
	end

   self:ShootBullet( damage, recoil, self.Primary.NumShots, self:GetPrimaryCone() )

   local owner = self.Owner
   if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

   owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * recoil, math.Rand(-0.1,0.1) *recoil, 0 ) )

	if self.ChargeSound then self.ChargeSound:Stop() end
end

function SWEP:SetZoom(state)
    if CLIENT then
       return
    elseif IsValid(self.Owner) and self.Owner:IsPlayer() then
       if state then
          self.Owner:SetFOV(20, 0.3)
		  self.Owner:DrawViewModel(false)
       else
          self.Owner:SetFOV(0, 0.2)
		  self.Owner:DrawViewModel(true)
       end
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
	self.InAttack = nil
    self.mode1 = nil
    self.mode2 = nil
    self.mode3 = nil
    self.mode4 = nil
    self.overcharge = nil
    self.mode = "single"
    if self.ChargeSound then self.ChargeSound:Stop() end
    return self.BaseClass.PreDrop(self)
end

function SWEP:Reload()
	if ( self:Clip1() == self.Primary.ClipSize or self.Owner:GetAmmoCount( self.Primary.Ammo ) <= 0 ) then return end
    self:DefaultReload( ACT_VM_RELOAD )
    self:SetIronsights( false )
    self:SetZoom( false )
    self.InAttack = nil
    self.mode1 = nil
    self.mode2 = nil
    self.mode3 = nil
    self.mode4 = nil
    self.overcharge = nil
    self.mode = "single"
    if self.ChargeSound then self.ChargeSound:Stop() end
end


function SWEP:Holster()
    self:SetIronsights(false)
    self:SetZoom(false)
    self.InAttack = nil
    self.mode1 = nil
    self.mode2 = nil
    self.mode3 = nil
    self.mode4 = nil
    self.overcharge = nil
    self.mode = "single"
    if self.ChargeSound then self.ChargeSound:Stop() end
    return true
end

if CLIENT then
   local scope = surface.GetTextureID("sprites/scope")
   function SWEP:DrawHUD()
      if self:GetIronsights() then
         surface.SetDrawColor( 0, 0, 0, 255 )
         
         local x = ScrW() / 2.0
         local y = ScrH() / 2.0
         local scope_size = ScrH()

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
