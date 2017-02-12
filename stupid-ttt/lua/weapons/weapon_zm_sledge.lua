AddCSLuaFile()
SWEP.HoldType = "physgun"

if CLIENT then
    SWEP.PrintName = "Minigun"
    SWEP.Slot = 2
    SWEP.ViewModelFlip = false
    SWEP.ViewModelFOV = 54
    SWEP.Icon = "vgui/ttt/icon_m249"
    SWEP.IconLetter = "z"
end

SWEP.Base = "weapon_tttbase_sck"

SWEP.Spawnable = true
SWEP.AutoSpawnable = true

SWEP.Kind = WEAPON_HEAVY
SWEP.WeaponID = AMMO_M249

SWEP.Primary.Damage = 12
SWEP.Primary.Delay = 0.04
SWEP.Primary.Cone = 0.05
SWEP.Primary.ClipSize = 250
SWEP.Primary.ClipMax = 250
SWEP.Primary.DefaultClip = 250
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "AirboatGun"
SWEP.Primary.Recoil = 1
SWEP.Primary.Sound = Sound("Weapon_m249.Single")

SWEP.UseHands = true
SWEP.ViewModel			= Model ( "models/weapons/c_physcannon.mdl" )
SWEP.WorldModel			= Model ( "models/weapons/w_physics.mdl" )

SWEP.HeadshotMultiplier = 2.2
 
SWEP.IronSightsPos = Vector(-5.96, -5.119, 2.349)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.NoSights = true

	SWEP.ViewModelBoneMods = {
		["Doodad_2"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["Doodad_4"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, -6.985, 0), angle = Angle(0, 0, 0) },
		["Prong_B"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["Doodad_1"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["Prong_A"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
		["Doodad_3"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
	}
	
	SWEP.VElements = {
		["cast_point"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(2.828, 1.155, -0.173), angle = Angle(0, 0, 90), size = Vector(0.224, 0.224, 0.224), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe1+++++++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "rotate_main", pos = Vector(3.368, 2.145, 21.156), angle = Angle(0, 145, 0), size = Vector(1.562, 1.562, 1.562), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, use_blood = true },
		["pipe1+++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "rotate_main", pos = Vector(2.987, -2.791, 21.156), angle = Angle(0, -135, 0), size = Vector(1.562, 1.562, 1.562), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, use_blood = true },
		["small_gear"] = { type = "Model", model = "models/Mechanics/gears/gear12x6.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "tank", pos = Vector(0, -0.163, 2.572), angle = Angle(0, 0, 0), size = Vector(0.27, 0.27, 0.27), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, use_blood = true },
		["pipe1+"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "rotate_main", pos = Vector(-3.346, -2.435, 21.156), angle = Angle(0, -45, 0), size = Vector(1.562, 1.562, 1.562), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, use_blood = true },
		["pipe1++++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "rotate_main", pos = Vector(3.897, -0.596, 21.156), angle = Angle(0, -180, 0), size = Vector(1.562, 1.562, 1.562), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, use_blood = true },
		["rotate_main"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "Base", rel = "", pos = Vector(0.718, 2.312, 3.354), angle = Angle(0, 0, 0), size = Vector(0.284, 0.284, 0.284), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, use_blood = true },
		["pipe1"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "rotate_main", pos = Vector(-0.055, -4.14, 21.156), angle = Angle(0, -90, 0), size = Vector(1.562, 1.562, 1.562), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, use_blood = true },
		["tank"] = { type = "Model", model = "models/props_junk/propanecanister001a.mdl", bone = "Base", rel = "", pos = Vector(5.808, 2.193, 0.921), angle = Angle(0, -37.777, 0), size = Vector(0.444, 0.444, 0.444), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {}, use_blood = true },
		["back1"] = { type = "Model", model = "models/props_c17/TrapPropeller_Engine.mdl", bone = "Base", rel = "", pos = Vector(1.611, -1.104, 0.284), angle = Angle(0, -90, 0), size = Vector(0.449, 0.449, 0.449), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, use_blood = true },
		["pipe1++++++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "rotate_main", pos = Vector(0.441, 3.868, 21.156), angle = Angle(0, 90, 0), size = Vector(1.562, 1.562, 1.562), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, use_blood = true },
		["pipe1+++++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "rotate_main", pos = Vector(-2.599, 3.188, 21.156), angle = Angle(0, 45, 0), size = Vector(1.562, 1.562, 1.562), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, use_blood = true },
		["pipe1++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "rotate_main", pos = Vector(-4.144, 0.497, 21.156), angle = Angle(0, -3.516, 0), size = Vector(1.562, 1.562, 1.562), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {}, use_blood = true },
		["viewmodel"] = { type = "Model", model = SWEP.ViewModel, bone = "ValveBiped.Bip01_L_Hand", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {}, Bonemerge = true, use_blood = true },
	}

	SWEP.WElements = {
		["pipe1+++++++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "rotate_main", pos = Vector(3.368, 2.145, 14.729), angle = Angle(0, 145, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe1+++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "rotate_main", pos = Vector(2.987, -2.935, 14.675), angle = Angle(0, -135, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rotate_2"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(20.127, -2.662, -5.739), angle = Angle(-92.155, 0, -9.886), size = Vector(1, 0.695, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["small_gear"] = { type = "Model", model = "models/Mechanics/gears/gear12x6.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "tank", pos = Vector(0, -0.163, 2.572), angle = Angle(0, 0, 0), size = Vector(0.27, 0.27, 0.27), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe1+"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "rotate_main", pos = Vector(-3.346, -2.435, 14.63), angle = Angle(0, -45, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe1++++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "rotate_main", pos = Vector(3.897, -0.596, 14.621), angle = Angle(0, -180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["rotate_main"] = { type = "Model", model = "models/props_c17/oildrum001.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "rotate_2", pos = Vector(0, 0, -2.756), angle = Angle(0, 0, 0), size = Vector(0.284, 0.284, 0.284), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe1"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "rotate_main", pos = Vector(-0.055, -4.14, 14.571), angle = Angle(0, -90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["tank"] = { type = "Model", model = "models/props_junk/propanecanister001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.868, 1.394, -8.683), angle = Angle(-0.689, -83.414, -92.02), size = Vector(0.389, 0.389, 0.389), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
		["pipe1++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "rotate_main", pos = Vector(-4.144, 0.497, 14.555), angle = Angle(0, -3.516, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe1+++++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "rotate_main", pos = Vector(-2.599, 3.188, 14.654), angle = Angle(0, 45, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["pipe1++++++"] = { type = "Model", model = "models/props_canal/mattpipe.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "rotate_main", pos = Vector(0.441, 3.868, 14.777), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["back1"] = { type = "Model", model = "models/props_c17/TrapPropeller_Engine.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(12.354, -2.154, -8.778), angle = Angle(65.126, -74.172, -99.08), size = Vector(0.34, 0.34, 0.34), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
		["cast"] = { type = "Model", model = "models/props_junk/PopCan01a.mdl", bone = "ValveBiped.Anim_Attachment_LH", rel = "", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 0), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}

function SWEP:Reload() end

local spin = Sound( "npc/combine_gunship/engine_rotor_loop1.wav" )

function SWEP:Deploy()
	self.Windup = CreateSound(self.Owner, "NPC_AttackHelicopter.ChargeGun")
	self.Spinning = CreateSound(self.Owner, spin)
	self.FireSound = CreateSound(self.Owner, "NPC_CombineGunship.CannonSound")//"NPC_AttackHelicopter.FireGun"
	return self.BaseClass.Deploy(self)
end

function SWEP:StopCasting() end
function SWEP:IsCasting() return false end

function SWEP:SetShooting( b )
	if b then
		self:StopSpinning()
	end

	self:SetDTBool( 1, b )
end

function SWEP:IsShooting()
	return self:GetDTBool( 1 )
end

function SWEP:SetSpinning( b )
	self:SetDTBool( 2, b )
end

function SWEP:IsSpinning()
	return self:GetDTBool( 2 )
end

function SWEP:StopSpinning()
	self:SetSpinning( false )
	if self.Spinning then
		self.Spinning:Stop()
	end
end

function SWEP:StopCharging()
	self:SetChargeEnd(0)
	if self.Windup then
		self.Windup:Stop()
	end
end

function SWEP:StopShooting()
	self:SetShooting(false)
	if self.FireSound then
		self.FireSound:Stop()
	end
end

function SWEP:IsCharging()
	return self:GetChargeEnd() > 0
end

function SWEP:SetChargeEnd(spellend)
	self:SetDTFloat(0, spellend)
end

function SWEP:GetChargeEnd()
	return self:GetDTFloat(0)
end

SWEP.NextCharge = 0
function SWEP:PrimaryAttack()

	if self:IsSpinning() then
		self:SetShooting(true)
		self:StopSpinning()
	end

	if self:IsShooting() then 
	
		self.Weapon:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		if not self:CanPrimaryAttack() then return end
		
		--self:TakePrimaryAmmo(1)
		--self:EmitSound(self.Primary.Sound)
		local Owner = self.Owner
		
		if Owner.ViewPunch then Owner:ViewPunch( Angle(self.Primary.Recoil * -0.12, math.Rand(-0.1,0.1) * self.Primary.Recoil, 0) ) end
		if ( ( game.SinglePlayer() && SERVER ) || ( !game.SinglePlayer() && CLIENT && IsFirstTimePredicted() ) ) then
			local eyeang = self.Owner:EyeAngles()
			local recoil = self.Primary.Recoil//math.Rand( 0.1, 0.2 )
			eyeang.pitch = eyeang.pitch - recoil*0.12
			self.Owner:SetEyeAngles( eyeang )
		end
		
		self:ShootBullet( self.Primary.Damage, self.Primary.NumShots, self.Primary.Cone )
		
		if CLIENT and self:IsShooting() and self:Clip1() > 0 and !GAMEMODE.ThirdPerson and IsValid(self.VElements["rotate_main"].modelEnt) then
			local effectdata = EffectData() 
			effectdata:SetOrigin( self.VElements["rotate_main"].modelEnt:GetPos()+self.VElements["rotate_main"].modelEnt:GetAngles():Up()*4 ) 
			effectdata:SetAngles( self.Owner:GetAimVector():Angle() )
			effectdata:SetScale( 2 )
			util.Effect( "MuzzleEffect", effectdata ) 
		end
	
		return 
	end
	if self:IsCharging() then return end
	if self.NextCharge >= CurTime() then return end

	self:SetChargeEnd(CurTime()+1.1)
end

function SWEP:SecondaryAttack()
	
	if self:IsCharging() then return end
	if self:IsSpinning() then return end
	if self:IsShooting() then return end
	if self.NextCharge >= CurTime() then return end

	self:SetChargeEnd(CurTime()+1.1)
end

SWEP.SpinRate = 0

function SWEP:Think()
	local spinning = 0
	
	local act = ACT_VM_IDLE
	if self.IdleAnim then
		act = self.IdleAnim
	end
	if self.IdleAnimation and self.IdleAnimation <= CurTime() then
		self.IdleAnimation = nil
		self:SendWeaponAnim(act)
	end
	
	if self:IsCharging() and self:GetChargeEnd() <= CurTime() then
		self:StopCharging()
		if self.Owner:KeyDown( IN_ATTACK2 ) and not self.Owner:KeyDown( IN_ATTACK ) then
			self:SetSpinning( true )
		else
			self:SetShooting(true)
		end
	end
	
	/*if self.Owner:IsDurationSpell() then
		if self:IsCasting() and (self:GetSpellEnd()-self.SpellTime*0.4) <= CurTime() and not self.Owner:KeyDown(IN_ATTACK2) then
			self:StopCasting()
		end
	else
		if self:IsCasting() and self:GetSpellEnd() <= CurTime() then
			self:StopCasting()
		end
	end*/
	
	if self:IsShooting() then
		if self.Owner:KeyDown( IN_ATTACK2 ) and not self.Owner:KeyDown( IN_ATTACK ) then
			self:StopShooting()
			self:SetSpinning( true )		
		else
			if self.FireSound then
				self.FireSound:PlayEx(1,95)
				self.FireSound:PlayEx(1,95)
			end
		end
		spinning = 5
	end
	
	if self:IsSpinning() then
		if self.Spinning then
			self.Spinning:PlayEx(1,140)
		end
		spinning = 5
	end
	
	if self:IsCharging() then
		if self.Windup then
			self.Windup:PlayEx(1,100)
		end
		spinning = 5
	end
	
	if CLIENT then
		self.SpinRate = math.Approach(self.SpinRate, spinning, FrameTime()*((self.SpinRate+1) ^ 1.5))
		if self.VElements then
			if self.VElements["rotate_main"] then
				self.VElements["rotate_main"].angle.y = self.VElements["rotate_main"].angle.y + self.SpinRate//math.Approach(self.VElements["rotate_main"].angle.y, self.BarrelAngle, FrameTime()*860)
				/*if self:IsShooting() and self:Clip1() > 0 and !GAMEMODE.ThirdPerson and IsValid(self.VElements["rotate_main"].modelEnt) then
					local effectdata = EffectData() 
					effectdata:SetOrigin( self.VElements["rotate_main"].modelEnt:GetPos()+self.VElements["rotate_main"].modelEnt:GetAngles():Up()*4 ) 
					effectdata:SetAngles( self.Owner:GetAimVector():Angle() ) 
					effectdata:SetScale( 2 )
					util.Effect( "MuzzleEffect", effectdata ) 
				end*/
			end
			if self.VElements["small_gear"] then
				self.VElements["small_gear"].angle.y = self.VElements["small_gear"].angle.y - self.SpinRate*2//math.Approach(self.VElements["rotate_main"].angle.y, self.BarrelAngle, FrameTime()*860)
			end
			
		end
	end
	
	if self:IsCharging() then
		local charge = false
		
		if not self.Owner:KeyDown(IN_ATTACK2) and self.Owner:KeyDown(IN_ATTACK) then
			charge = true
		end
		
		if not self.Owner:KeyDown(IN_ATTACK) and self.Owner:KeyDown(IN_ATTACK2) then
			charge = true
		end
		
		if self.Owner:KeyDown(IN_ATTACK) and self.Owner:KeyDown(IN_ATTACK2) then
			charge = true
		end
	
		if not charge then
			self:StopCharging()
		end

	end
	
	if self:IsSpinning() and (not self.Owner:KeyDown(IN_ATTACK2)) then
		self:StopSpinning()
	end
	
	if self:IsShooting() and (not self.Owner:KeyDown(IN_ATTACK) or self:Clip1() <= 0) then
		self:StopShooting()
	end

	self:NextThink(CurTime())
end

function SWEP:Move(mv)
	if self:IsShooting() then
		mv:SetMaxSpeed( mv:GetMaxSpeed()*0.25 )
	end
	if self:IsCharging() or self:IsSpinning() then
		mv:SetMaxSpeed( mv:GetMaxSpeed()*0.65 )
	end
end

function SWEP:Holster()
	self.BaseClass.Holster(self)

	if CLIENT then
		if IsValid(self.CastPoint) then
			self.CastPoint:StopParticles()
			self.CastPoint.Particle = nil
			
		end
		local vm
		if IsValid(self.Owner) then
			vm = self.Owner:GetViewModel()
		end
		if IsValid(vm) then
			vm:StopParticles()
			self:ResetBonePositions(vm)
		end
    end
	
	self:StopCasting()
	
	if self.RestrictHolster then
		return false
	end
	
	if self:IsCharging() then return false end
	if self:IsShooting() then return false end
	if self:IsSpinning() then return false end
	
	return self.BaseClass.Holster(self)
end

function SWEP:OnRemove()
	if self.Windup then
		self.Windup:Stop()
	end
	if self.FireSound then
		self.FireSound:Stop()
	end
	if self.Spinning then
		self.Spinning:Stop()
	end
	self:StopCasting()  
    self.BaseClass.OnRemove(self)
end

SWEP.wSpinRate = 0
function SWEP:OnDrawWorldModel()

	local spinning = 0
	
	if self:IsSpinning() then
		spinning = 6
	end
	
	if self:IsShooting() then
		spinning = 6
	end
	
	if self:IsCharging() then
		spinning = 6
	end
	
	self.wSpinRate = math.Approach(self.wSpinRate, spinning, FrameTime()*((self.wSpinRate+1) ^ 2))
	if self.WElements then
		if self.WElements["rotate_main"] then
			self.WElements["rotate_main"].angle.y = self.WElements["rotate_main"].angle.y + self.wSpinRate*2//math.Approach(self.VElements["rotate_main"].angle.y, self.BarrelAngle, FrameTime()*860)
			if self:IsShooting() and self:Clip1() > 0 and IsValid(self.WElements["rotate_main"].modelEnt) then
				local effectdata = EffectData() 
				effectdata:SetOrigin( self.WElements["rotate_main"].modelEnt:GetPos()+self.WElements["rotate_main"].modelEnt:GetAngles():Up()*25 ) 
				effectdata:SetAngles( self.Owner:GetAimVector():Angle() ) 
				effectdata:SetScale( 2 )
				util.Effect( "MuzzleEffect", effectdata ) 
			end
		end
		if self.WElements["small_gear"] then
			self.WElements["small_gear"].angle.y = self.WElements["small_gear"].angle.y - self.wSpinRate*2//math.Approach(self.VElements["rotate_main"].angle.y, self.BarrelAngle, FrameTime()*860)
		end	
	end

end
