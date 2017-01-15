AddCSLuaFile()

SWEP.HoldType              = "slam"

if CLIENT then
   SWEP.PrintName          = "Purple Drank"
   SWEP.Slot               = 6

   SWEP.ViewModelFOV       = 54
   SWEP.ViewModelFlip      = false

   SWEP.EquipMenuData = {
      type  = "item_weapon",
      name  = "Purple Drank",
      desc  = "Heals you for 75 health.\n\nSingle use."
   };

   SWEP.Icon               = "vgui/ttt/icon_pdrank.png"
end

SWEP.Base                  = "weapon_tttbase"

-- if I run out of ammo types, this weapon is one I could move to a custom ammo
-- handling strategy, because you never need to pick up ammo for it
SWEP.Primary.Ammo          = "AR2AltFire"
SWEP.Primary.Recoil        = 0.6
SWEP.Primary.Damage        = 75
SWEP.Primary.Delay         = 0.2
SWEP.Primary.Cone          = 0.01
SWEP.Primary.ClipSize      = -1
SWEP.Primary.Automatic     = true
SWEP.Primary.DefaultClip   = -1
SWEP.Primary.ClipMax       = -1
SWEP.Primary.Sound         = Sound("weapons/drink/open.wav")

SWEP.Kind                  = WEAPON_EQUIP
SWEP.CanBuy                = {ROLE_TRAITOR} -- only traitors can buy

SWEP.Tracer                = "AR2Tracer"

SWEP.UseHands              = false
SWEP.ViewModel 				= "models/weapons/v_p_drink.mdl"
SWEP.WorldModel				= "models/weapons/w_p_drink.mdl"

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DEPLOY)
	self.Drinking = false
end

function SWEP:PrimaryAttack()
	if self.Drinking then return end
	self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self.Drinking = true
	if (IsFirstTimePredicted() or game.SinglePlayer()) then
		self:EmitSound(self.Primary.Sound)
		timer.Simple(1, function()
			if self:IsValid() and self.Owner:IsValid() and self.Owner:Alive() and self.Owner:GetActiveWeapon() == self then
				self.Owner:SetHealth(math.Clamp(self.Owner:Health() + self.Primary.Damage, 1, self.Owner:GetMaxHealth()))
				self.Owner:ViewPunch(Angle(-40, 0, 0))
				timer.Simple(6, function()
					if self:IsValid() and self.Owner:IsValid() and self.Owner:Alive() then
						self.Drinking = false
						if SERVER then
							self.Owner:StripWeapon(self.ClassName)
						end
					end
				end)
			end
		end)
	end
end

function SWEP:SecondaryAttack()
end
