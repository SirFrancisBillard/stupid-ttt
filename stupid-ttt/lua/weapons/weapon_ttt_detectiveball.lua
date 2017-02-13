AddCSLuaFile()

SWEP.Spawnable 				= false
SWEP.UseHands 				= false

SWEP.ViewModel 				= "models/weapons/c_bugbait.mdl"
SWEP.WorldModel				= "models/weapons/w_bugbait.mdl"

SWEP.UseHands = true
SWEP.HoldType = "grenade"
SWEP.Primary.ClipSize 		= 1
SWEP.Primary.DefaultClip	= 1
SWEP.DrawAmmo = true
SWEP.ViewModelFOV  = 72
SWEP.ViewModelFlip = true

SWEP.EquipMenuData = {
   type = "item_weapon",
   desc = "Turns innocents into Detectives or unmasks traitors.\nWill also heal innocents.\nAcquiring this was extremely painful."
};

SWEP.DrawCrosshair = false
SWEP.Primary.Ammo 			= ""

SWEP.Base				= "weapon_tttbase"


SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.AllowDrop = true
SWEP.ViewModelFlip = false

SWEP.PrintName 				= "Detective Testicle"
SWEP.Slot					= 6
SWEP.Kind = WEAPON_EQUIP1
SWEP.CanBuy = { ROLE_DETECTIVE }
SWEP.AutoSpawnable = false
SWEP.LimitedStock = true

SWEP.Icon = "vgui/ttt/icon_ball.png"

local testing = false

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	self.CanFire = true
end


function SWEP:Reload()
end

function SWEP:Think()
	
end

function SWEP:Throw()
	if (!SERVER) then return end
	
	self:ShootEffects()
	self.BaseClass.ShootEffects(self)
	
	self.Weapon:SendWeaponAnim(ACT_VM_THROW)
	self.CanFire = false
	
	local ent = ents.Create("ttt_DetectiveBall")
	
	timer.Create("BBFireTimer", 1, 1, function()
						self.CanFire = true
						self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
						self:Remove()
						end) 
	
	ent:SetPos(self.Owner:EyePos() + (self.Owner:GetAimVector()* 16))
	ent:SetAngles(self.Owner:EyeAngles())
	ent:Spawn()
	
	local phys = ent:GetPhysicsObject()
	
	if !(phys && IsValid(phys)) then ent:Remove() return end
	
	phys:ApplyForceCenter(self.Owner:GetAimVector():GetNormalized() * 1300)

end

function SWEP:PrimaryAttack()
	if (self.CanFire) then
		self:Throw()
	end
end

function SWEP:SecondaryAttack()
	local plyr = self.Owner
	if (plyr != nil && plyr != NULL && plyr != null && SERVER) then
		if (plyr:IsPlayer() && plyr:IsValid()) then
				if (!timer.Exists("InfectionTimer"..plyr:GetName().."")) then
					timer.Create("InfectionTimer"..plyr:GetName().."", math.random(DetectiveBallConfig.InfectTimeMin, DetectiveBallConfig.InfectTimeMax), 1, 
					function()
						if (plyr:Alive()) then
							if (DetectiveBallConfig.PZ) then
								plyr:SetHealth(100)
								plyr:PrintMessage( HUD_PRINTCENTER, "You are healed!")
							end
						end
					end)

				if (DetectiveBallConfig.InfectMessage) then
					plyr:PrintMessage( HUD_PRINTCENTER, "You will be healed in 10 seconds!")
				end
			end
			if (DetectiveBallConfig.ScreenTick) then
				if (!timer.Exists("ShakeTimer"..plyr:GetName().."")) then
					timer.Create("ShakeTimer"..plyr:GetName().."", DetectiveBallConfig.ScreenTickFreq, 0,
					function()
						plyr:ViewPunch(Angle(math.random(-1,1),math.random(-1,1),math.random(-1,1)))
						timer.Simple(10, function()
							timer.Destroy("ShakeTimer"..plyr:GetName().."")
						end)
					end)
				end 
			end
		end
	end
	if (SERVER) then
		self:Remove()
		DamageLog(Format("DetectiveBall:\t %s [%s] healed %s [%s]", self.Owner:Nick(), self.Owner:GetRoleString(), plyr:Nick(), plyr:GetRoleString()))
	end
end