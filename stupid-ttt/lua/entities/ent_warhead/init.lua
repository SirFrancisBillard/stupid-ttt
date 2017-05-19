AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

local Burn_Sound = Sound("Fire.Plasma")
util.PrecacheModel("models/weapons/w_missile.mdl")

function ENT:Initialize()

        self.Entity:SetModel("models/weapons/w_missile.mdl")
        self.Entity:PhysicsInitSphere( 4, "metal_bouncy" )
        local phys = self.Entity:GetPhysicsObject()
        if (phys:IsValid()) then
                phys:Wake()
                phys:SetDamping( .0001, .0001 )
                phys:EnableGravity( false )
        end
        
        self.Entity:SetAngles(self.Entity:GetOwner():GetAimVector():Angle())
        self.Entity:SetCollisionBounds( Vector()*-4, Vector()*4 )

        self.Sound = CreateSound( self.Entity, Burn_Sound )
        self.Sound:SetSoundLevel( 95 )
        self.Sound:Play()

        self:StartMotionController()

end

function ENT:OnRemove()
	if ( self.Sound ) then
		self.Sound:Stop()
	end
end

function ENT:Think() 
	if self.Dead then
		self:Explode()
	end

	return true
end

function ENT:Explode()
    if ( self.Exploded ) then return end

    self.Exploded = true

    local pos = self:GetPos()

	ParticleEffect("explosion_huge", pos, vector_up:Angle())
	sound.Play(Sound("^phx/explode0" .. math.random(0, 6) .. ".wav"), pos, 150)

	util.BlastDamage(self, self:GetOwner(), pos, 1000, 500)

    self:Remove()
end

function ENT:PhysicsSimulate( phys, deltatime )

        if self.Dead then return SIM_NOTHING end

        local fSin = math.sin( CurTime() * 20 ) * 1.1
        local fCos = math.cos( CurTime() * 20 ) * 1.1

        local vAngular = Vector(0,0,0)
        local vLinear = (self.FlyAngle:Right() * fSin) + (self.FlyAngle:Up() * fCos)
        vLinear = vLinear * deltatime * 1.001

        return vAngular, vLinear, SIM_GLOBAL_FORCE

end

function ENT:PhysicsCollide( data, physobj )

        self.Dead = true

        self.Entity:NextThink(CurTime())

end