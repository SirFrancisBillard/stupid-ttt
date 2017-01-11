AddCSLuaFile()

if CLIENT then
	killicon.Add( "ent_smod_launcher", "vgui/killicons/smod_A35GL",	Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/killicons/smod_A35GL")
end

SWEP.HoldType            = "ar2"

if CLIENT then
   SWEP.PrintName        = "Grenade Launcher"
   SWEP.Slot             = 6

   SWEP.ViewModelFlip    = false
   SWEP.ViewModelFOV     = 54

   SWEP.EquipMenuData = {
      type  = "item_weapon",
      name  = "Grenade Launcher",
      desc  = "A grenade launcher.\n\nLimited ammo."
   };

   SWEP.Icon             = "vgui/ttt/icon_m16"
   SWEP.IconLetter       = "l"
end

SWEP.Base                = "weapon_tttbase"

SWEP.CanBuy              = {ROLE_TRAITOR}
SWEP.Kind                = WEAPON_EQUIP1

SWEP.Primary.Damage      = 60
SWEP.Primary.Delay       = 0.175
SWEP.Primary.Cone        = 0.02
SWEP.Primary.ClipSize    = 30
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "smg1"
SWEP.Primary.Recoil      = 3.2
SWEP.Primary.Sound       = Sound("weapons/grenade_launcher1.wav")

SWEP.AutoSpawnable       = true
SWEP.AmmoEnt             = "item_ammo_smg1_ttt"

SWEP.UseHands            = false
SWEP.ViewModel				= "models/weapons/v_a35.mdl"
SWEP.WorldModel				= "models/weapons/w_a35.mdl"

SWEP.IronSightsPos = Vector( -6.55, -5, 2.4 )
SWEP.IronSightsAng = Vector( 2.2, -0.1, 0 )

SWEP.DeploySpeed         = 1

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

	ent:SetPos(self.Owner:EyePos() + (self.Owner:GetAimVector() * 75))
	ent:SetAngles(self.Owner:EyeAngles())
	ent:Spawn()
	ent:Activate()
	ent:Fire()
	ent:SetOwner(self.Owner)
	
	local phys = ent:GetPhysicsObject()
	if not IsValid(phys) then ent:Remove() return end

	local velocity = self.Owner:GetAimVector()
	velocity = velocity * 4000
	velocity = velocity + (VectorRand() * 10)
	phys:ApplyForceCenter(velocity)
end
