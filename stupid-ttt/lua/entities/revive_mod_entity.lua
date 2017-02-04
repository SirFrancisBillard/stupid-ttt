-- Put your Lua here
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
        self:SetModel("models/revive_mod_hand_fix.mdl")
        self:PhysicsInitBox(Vector(8, 30, 8), Vector(-8, -30, 0))
        self:SetRenderMode(RENDERMODE_TRANSALPHA)
        self:SetColor(Color(0, 0, 0, 0))
        self:SetMoveType(MOVETYPE_FLYGRAVITY)
        self:SetMoveCollide(MOVECOLLIDE_FLY_BOUNCE)
        self:SetMaterial("models/inv/inv_texture_fix")
        self:SetNoDraw(true)
        self:DrawShadow(false)
        self:SetCollisionGroup(COLLISION_GROUP_DISSOLVING)
        self:SetUseType(SIMPLE_USE)
        --self:SetOwner( self.Owner )
        self.ReviveDelay = 0
        self.MedicCallDelay = 0
        self.TimeToDie = 0
        self.ShowHp = 0
        self.FRMragdoll = true
        self:SetHealth(GetConVarNumber("revive_mod_injured_health"))
        self:SetMaxHealth(self:Health())
        self.targetme = ents.Create("npc_bullseye")
        self.targetme:Spawn()

        if IsValid(self.targetme) then
            self.targetme.FRMignore = true
            self.targetme:SetModel("models/props_junk/PopCan01a.mdl")
            self.targetme:SetPos(self:GetPos() + self:GetUp() * 0)
            self.targetme:SetCollisionGroup(COLLISION_GROUP_DISSOLVING)
            self.targetme:SetParent(self)
            self.targetme:SetKeyValue("spawnflags", "524288" + "131072")
            self.targetme:SetKeyValue("health", 999999)
        end

        self.dead = ents.Create("revive_attach")
        self.dead:SetModel(self.Model)
        self.dead:SetSkin(self.Skin)
        self.dead:SetMaterial(self.Material)
        self.dead:SetColor(self.Color)
        self.dead:SetBodygroup(1, self.Body1)
        self.dead:SetBodygroup(2, self.Body2)
        self.dead:SetBodygroup(3, self.Body3)
        self.dead:SetBodygroup(4, self.Body4)
        self.dead:SetBodygroup(5, self.Body5)
        self.dead:SetBodygroup(6, self.Body6)
        self.dead:SetBodygroup(7, self.Body7)
        self.dead:SetBodygroup(8, self.Body8)
        self.dead:SetBodygroup(9, self.Body9)
        self.dead.FRMragdoll = true
        self.dead:Spawn()
        self.dead:SetSolid(SOLID_NONE)
        self.dead:SetParent(self)
        self.dead:Fire("setparentattachment", self:GetAttachments()[1].name)
        self.dead:AddEffects(EF_BONEMERGE)
        self.RandomAnim = math.random(1, 5)

        if self.RandomAnim == 1 then
            self.Animation = "Lying_Down"
            --elseif self.RandomAnim == 3 then
            --self.Animation = "arrestpostidle"
        elseif self.RandomAnim == 2 then
            self.Animation = "sniper_victim_pre"
        elseif self.RandomAnim == 3 then
            self.Animation = "d1_town05_Winston_Down"
        elseif self.RandomAnim == 4 then
            self.Animation = "d1_town05_Wounded_Idle_1"
        else
            self.Animation = "d1_town05_Wounded_Idle_2"
        end

        self:AirGround()
    end

    function ENT:Use(activator)
        if activator:IsPlayer() and CurTime() > self.ReviveDelay and (not self.Owner:Alive()) and self.Revive == nil then
            self.NiceGuy = activator
            self.NiceGuyWeapon = self.NiceGuy:GetActiveWeapon()
			if IsValid(self.NiceGuyWeapon) then
				self.NiceGuyWeapon:SendWeaponAnim(ACT_VM_DRAW)
			end
            self.Revive = true
            self.ReviveDelay = CurTime() + 2
            self:EmitSound("SvenCoopReviveCharge.SCR")

            timer.Simple(2, function()
                if IsValid(self) and IsValid(self:GetOwner()) and not self.Owner:Alive() then
                    local effectdata = EffectData()
                    effectdata:SetOrigin(self:GetPos())
                    effectdata:SetStart(self:GetPos())
                    effectdata:SetEntity(self)
                    util.Effect("cball_explode", effectdata)
                    self:EmitSound("SvenCoopReviveUse.SCR")
                    self.Owner.RevivePos = self:GetPos()
                    self.Owner.ReviveAng = self:GetAngles() + Angle(0, 180, 0)

                    self.Owner:ChatPrint(self.NiceGuy:Nick() .. " helped You.")

                    self.Owner.Revived = true
                    self.Owner:SpawnForRound(true)
					self.Owner:SetHealth(15)
					self.Owner:StripWeapons()
					for k, w in pairs(weapons.GetList()) do
						if w and type(w.InLoadoutFor) == "table" and table.HasValue(w.InLoadoutFor, self.Owner:GetRole()) then
							self.Owner:Give(w.ClassName)
						end
					end
                    self.Owner:AddFrags(1)
                    self.NiceGuy:AddFrags(1)
                end
            end)
        elseif activator:IsPlayer() and ((not IsValid(activator:GetActiveWeapon())) or (IsValid(activator:GetActiveWeapon()) and not activator:GetActiveWeapon():GetClass() == "weapon_medkit") or (IsValid(activator:GetActiveWeapon()) and activator:GetActiveWeapon():GetClass() == "weapon_medkit" and activator:GetActiveWeapon():Clip1() < GetConVarNumber("revive_mod_min_energy"))) and self.Revive == nil then
            self:EmitSound("SvenCoopNoRevive.SCR")
            self.ReviveDelay = CurTime() + 2
        end
    end

    function ENT:OnTakeDamage(dmginfo)
        self:TakePhysicsDamage(dmginfo)
        self:SetHealth(self:Health() - dmginfo:GetDamage())
        local effectdata = EffectData()
        effectdata:SetOrigin(self:GetPos())
        effectdata:SetStart(self:GetPos())
        effectdata:SetEntity(self)
        util.Effect("BloodImpact", effectdata)
        self:EmitSound("SvenCoopBodyHit.SCR")

        if self:Health() <= 0 then
            self:CreateCorpse()
        end
    end

    function ENT:CreateCorpse()
        if IsValid(self) and self.SpawnBody == nil then
            self.SpawnBody = true
            self.playerbody = ents.Create("prop_ragdoll")
            self.playerbody:SetModel(self.dead:GetModel())
            self.playerbody:SetSkin(self.dead:GetSkin())
            self.playerbody:SetColor(self.dead:GetColor())
            self.playerbody:SetMaterial(self.dead:GetMaterial())
            self.playerbody:SetBodygroup(1, self.dead:GetBodygroup(1))
            self.playerbody:SetBodygroup(2, self.dead:GetBodygroup(2))
            self.playerbody:SetBodygroup(3, self.dead:GetBodygroup(3))
            self.playerbody:SetBodygroup(4, self.dead:GetBodygroup(4))
            self.playerbody:SetBodygroup(5, self.dead:GetBodygroup(5))
            self.playerbody:SetBodygroup(6, self.dead:GetBodygroup(6))
            self.playerbody:SetBodygroup(7, self.dead:GetBodygroup(7))
            self.playerbody:SetBodygroup(8, self.dead:GetBodygroup(8))
            self.playerbody:SetBodygroup(9, self.dead:GetBodygroup(9))
            self.playerbody:SetPos(self.dead:GetPos())
            self.playerbody:SetAngles(self.dead:GetAngles())
            self.playerbody.FRMragdoll = true
            self.playerbody:Spawn()
            self.playerbody:SetOwner(self.dead)

            if GetConVarNumber("revive_mod_first_person") == 0 then
                self.Owner:SpectateEntity(self.playerbody)
            end

            if GetConVarNumber("revive_mod_first_person") == 1 then
                self.Owner:SetNWBool("ReviveBody", true)
                self.Owner:SetNetworkedEntity("ReviveBody", self.playerbody)
            end

            SafeRemoveEntityDelayed(self.playerbody, GetConVarNumber("revive_mod_corpse_despawn"))
            local phys = self.playerbody:GetPhysicsObject()
            local physCount = self.playerbody:GetPhysicsObjectCount()
            phys:EnableCollisions(false)

            for num = 0, physCount - 1 do
                self.playerbody:SetCollisionGroup(COLLISION_GROUP_DISSOLVING)
            end

            for i = 1, 128 do
                local bone = self.playerbody:GetPhysicsObjectNum(i)

                if IsValid(bone) then
                    local bonepos, boneang = self.dead:GetBonePosition(self.playerbody:TranslatePhysBoneToBone(i))
                    bone:SetPos(bonepos)
                    bone:SetAngles(boneang)
                end
            end

            self:Remove()
        end
    end

    function ENT:Relations(ent)
        if IsValid(ent) then
            for _, finisher in pairs(ents.GetAll()) do
                if finisher:IsNPC() and IsValid(finisher:GetActiveWeapon()) and (not finisher:IsUnreachable(self)) and (finisher:Visible(self.dead)) and (finisher:Disposition(self.Owner) == D_HT) then
                    finisher:AddEntityRelationship(ent, D_HT, -1)
                end
            end
        end
    end

    function ENT:AirGround()
        if self.FlyAnim == true then
            if self:IsOnGround() and self.GroundAnim == nil then
                self.GroundAnim = true

                if self.AirAnim == true then
                    self:SetAngles(self:GetAngles() + Angle(90, 0, 0))
                else
                    self:SetAngles(self:GetAngles())
                end

                self.AirAnim = nil
                local seq = self:LookupSequence(self.Animation)
                self:SetSequence(seq)
                self:SetPlaybackRate(0)
            end

            if not self:IsOnGround() and self.AirAnim == nil then
                self.AirAnim = true
                self.GroundAnim = nil
                self:SetAngles(self:GetAngles() + Angle(-90, 0, 0))
                local seq = self:LookupSequence("d2_coast03_PostBattle_Idle02")
                self:SetSequence(seq)
                self:SetPlaybackRate(0)
            end
        else
            local seq = self:LookupSequence(self.Animation)
            self:SetSequence(seq)
            self:SetPlaybackRate(0)
        end
    end

    function ENT:Think()
        if IsValid(self) then
            self:AirGround()
        end

        if IsValid(self.Owner) and CurTime() > self.ShowHp then
            self.ShowHp = CurTime() + 1
            self.Owner:PrintMessage(HUD_PRINTCENTER, "HP: " .. self:Health())
        end

        if IsValid(self) and CurTime() > self.TimeToDie and self.Revive == nil then
            self.TimeToDie = CurTime() + 1
            self:SetHealth(self:Health() - 1)
        end

        if IsValid(self.targetme) then
            self:Relations(self.targetme)
        end

        if ((not IsValid(self.targetme)) or self.targetme:Health() <= 0) or self:WaterLevel() >= 3 or self:Health() <= 0 then
            self:CreateCorpse()
        end

        for _, npc in pairs(ents.FindInSphere(self:GetPos(), 1000)) do
            if self.AirAnim == nil and npc:IsNPC() and npc.FRMignore == nil and npc:Health() > 0 and (not npc:IsUnreachable(self)) and (npc:Visible(self.dead)) and (npc:HasSpawnFlags(SF_CITIZEN_MEDIC) or npc:GetClass() == "npc_vortigaunt" or npc:GetClass() == "npc_alyx" or npc:GetClass() == "npc_barney" or npc:GetClass() == "npc_combine_s" or npc:GetClass() == "npc_metropolice") and (npc:Disposition(self.Owner) ~= D_HT) and self.MyHero == nil and GetConVarNumber("ai_ignoreplayers") == 0 then
                self.MyHero = npc

                if self.MyHero:GetClass() == "npc_citizen" then
                    self.MyHero:Fire("SpeakResponseConcept", "TLK_ALLY_KILLED", 0)
                elseif self.MyHero:GetClass() == "npc_combine_s" then
                    self.MyHero:EmitSound("CombineSCallout.SCR")
                elseif self.MyHero:GetClass() == "npc_metropolice" then
                    self.MyHero:EmitSound("MetroPoliceCallout.SCR")
                end
            end

            if self.MyHero ~= nil and IsValid(self.MyHero) then
                if self:GetPos():Distance(self.MyHero:GetPos()) > 60 and not self.MyHero:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
                    self.MyHero:SetLastPosition(self:GetPos())
                    self.MyHero:SetSchedule(SCHED_FORCED_GO_RUN)
                elseif self:GetPos():Distance(self.MyHero:GetPos()) <= 60 and CurTime() > self.ReviveDelay and self.Revive == nil and not self.MyHero:IsMoving() then
                    self.Revive = true
                    self.ReviveDelay = CurTime() + 2
                    self:EmitSound("SvenCoopReviveCharge.SCR")
                    local ang = (self:GetPos() - self.MyHero:GetPos()):Angle()
                    local ang2 = self.MyHero:GetAngles()
                    self.MyHero:SetAngles(Angle(ang2.p, ang.y, ang2.r))
                    self.MyHero:SetSchedule(SCHED_COWER)
                    self.MyHero:Fire("SpeakResponseConcept", "TLK_HEAL", 0)

                    timer.Simple(2, function()
                        if IsValid(self) and IsValid(self:GetOwner()) and not self.Owner:Alive() then
                            local effectdata = EffectData()
                            effectdata:SetOrigin(self:GetPos())
                            effectdata:SetStart(self:GetPos())
                            effectdata:SetEntity(self)
                            util.Effect("cball_explode", effectdata)
                            self:EmitSound("SvenCoopReviveUse.SCR")
                            self.Owner.RevivePos = self:GetPos()
                            self.Owner.ReviveAng = self:GetAngles() + Angle(0, 180, 0)
                            self.MathMessage = math.random(1, 5)

                            if self.MathMessage == 1 then
                                self.Owner:PrintMessage(HUD_PRINTTALK, self.MyHero:GetClass() .. " helped You.")
                            elseif self.MathMessage == 2 then
                                self.Owner:PrintMessage(HUD_PRINTTALK, self.MyHero:GetClass() .. " brought You back from the dead.")
                            elseif self.MathMessage == 3 then
                                self.Owner:PrintMessage(HUD_PRINTTALK, self.MyHero:GetClass() .. " saved Your life.")
                            elseif self.MathMessage == 4 then
                                self.Owner:PrintMessage(HUD_PRINTTALK, self.MyHero:GetClass() .. " saved You.")
                            else
                                self.Owner:PrintMessage(HUD_PRINTTALK, self.MyHero:GetClass() .. " revived You.")
                            end

                            self.Owner.Revived = true
                            self.Owner:Spawn()
                            self.Owner:AddFrags(1)
                        end
                    end)
                end
            end
        end

        if (IsValid(self.MyHero) and (self.MyHero:Health() <= 0 or (self.MyHero:IsUnreachable(self)) or (not self.MyHero:Visible(self.dead)))) or GetConVarNumber("ai_ignoreplayers") == 1 then
            if IsValid(self.MyHero) then
                self.MyHero:StopMoving()
            end

            self.MyHero = nil
        end
    end

    function ENT:PhysicsCollide(data, physobj)
        if (data.Speed <= 550 and data.DeltaTime > 0.3) then
            self:EmitSound("SvenCoopBodyPhysS.SCR")
        elseif (data.Speed > 550 and data.DeltaTime > 0.3) then
            self:EmitSound("SvenCoopBodyPhysH.SCR")
        end
    end

    function ENT:OnRemove()
	    if IsValid(self.targetme) then
            self.targetme:Remove()
        end

        if IsValid(self.dead) then
            self.dead:Remove()
        end

        self:StopSound("SvenCoopReviveCharge.SCR")
    end
end
