AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = ""
ENT.Author = "FiLzO"
ENT.Information = ""
ENT.Category = ""
ENT.AutomaticFrameAdvance = true
ENT.Spawnable = false
ENT.AdminOnly = false

if SERVER then
    function ENT:Initialize()
        self:SetNoDraw(false)
        self:DrawShadow(true)
        self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        self:SetOwner(self.Owner)
    end
end