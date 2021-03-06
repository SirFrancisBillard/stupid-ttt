AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "SMG Grenade"

ENT.CanBeUsedToRocketJump = true

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Shooter")
end

function ENT:Initialize()
	self:SetModel("models/Items/AR2_Grenade.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)

	local phys = self:GetPhysicsObject()
	if phys:IsValid() then
		phys:Wake()
		phys:SetBuoyancyRatio(0)
	end

	self.SpawnTime = CurTime()

	if CLIENT then
		local velocity = self:GetOwner():GetAimVector()
		velocity = velocity * 4000
		velocity = velocity + (VectorRand() * 10)
		phys:ApplyForceCenter(velocity)		
	end
end

if SERVER then
	function ENT:Explode()
		util.BlastDamage(self, self:GetOwner(), self:GetPos(), 128, 30)

		local boom = EffectData()
		boom:SetOrigin(self:GetPos())
		util.Effect("Explosion", boom)

		SafeRemoveEntity(self)
	end

	function ENT:PhysicsCollide(data, ent)
		self:Explode()
	end
end

function ENT:Draw()
	self:DrawModel()
end
