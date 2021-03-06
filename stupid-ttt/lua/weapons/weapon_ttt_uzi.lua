AddCSLuaFile()

if CLIENT then
    SWEP.PrintName = "Uzi"
    SWEP.Slot = 2
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFOV = 54
    SWEP.Icon = "vgui/ttt/icon_mac"
    SWEP.IconLetter = "l"
end

SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_MAC10

SWEP.Primary.Damage      = 15
SWEP.Primary.Delay       = 0.03
SWEP.Primary.Cone        = 0.06
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.Recoil      = 1.2
SWEP.Primary.Sound       = Sound("Weapon_MAC10.Single")

SWEP.AutoSpawnable = true
SWEP.AmmoEnt = "item_ammo_smg1_ttt"

SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"
SWEP.HoldType = "pistol"

SWEP.IronSightsPos = Vector(-8.921, -9.528, 2.9)
SWEP.IronSightsAng = Vector(0.699, -5.301, -7)

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
   bullet.Tracer = 4
   bullet.TracerName = "Tracer"
   bullet.Force  = 10
   bullet.Damage = dmg
   bullet.Callback = function(ply, tr, dmginfo) 
     return self:RicochetCallback(0, ply, tr, dmginfo) 
   end

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

function SWEP:RicochetCallback(bouncenum, attacker, tr, dmginfo)
	
	if not IsFirstTimePredicted() then
	return {damage = false, effects = false}
	end

	if (tr.HitSky) then return end
	
	self.MaxRicochet = 1
	
	if (bouncenum > self.MaxRicochet) then return end
	
	// -- Bounce vector
	local trace = {}
	trace.start = tr.HitPos
	trace.endpos = trace.start + (tr.HitNormal * 16384)

	local trace = util.TraceLine(trace)

 	local DotProduct = tr.HitNormal:Dot(tr.Normal * -1) 
	
	local ricochetbullet = {}
		ricochetbullet.Num 		= 1
		ricochetbullet.Src 		= tr.HitPos + (tr.HitNormal * 5)
		ricochetbullet.Dir 		= ((2 * tr.HitNormal * DotProduct) + tr.Normal) + (VectorRand() * 0.05)
		ricochetbullet.Spread 	= Vector(0, 0, 0)
		ricochetbullet.Tracer	= 1
		ricochetbullet.TracerName 	= "Impact"
		ricochetbullet.Force		= dmginfo:GetDamageForce() * 0.8
		ricochetbullet.Damage	= dmginfo:GetDamage() * 0.8
		ricochetbullet.Callback  	= function(a, b, c)  
			return self:RicochetCallback(bouncenum + 1, a, b, c) end

	timer.Simple(0, function() attacker:FireBullets(ricochetbullet) end)
	
	return {damage = true, effects = true}
end

function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 2 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 150)

   -- decay from 3.2 to 1.7
   return 1.7 + math.max(0, (1.5 - 0.002 * (d ^ 1.25)))
end
