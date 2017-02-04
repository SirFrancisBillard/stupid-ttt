-- In first place this mod has name Sven Coop Revive Mod...
sound.Add({
    name = "SvenCoopMEDIC.SCR",
    channel = CHAN_VOICE,
    volume = 0.9,
    level = 80,
    pitch = 100,
    sound = "revive_mod_def/sven_medic.wav"
})

sound.Add({
    name = "SvenCoopReviveUse.SCR",
    channel = CHAN_ITEM,
    volume = 0.9,
    level = 65,
    pitch = 100,
    sound = "revive_mod_def/defibrillator_use.wav"
})

sound.Add({
    name = "SvenCoopReviveCharge.SCR",
    channel = CHAN_ITEM,
    volume = 0.9,
    level = 65,
    pitch = 100,
    sound = "revive_mod_def/defibrillator_charge.wav"
})

sound.Add({
    name = "SvenCoopNoRevive.SCR",
    channel = CHAN_ITEM,
    volume = 1.0,
    level = 65,
    pitch = 100,
    sound = "items/suitchargeno1.wav"
})

sound.Add({
    name = "SvenCoopBodyPhysS.SCR",
    channel = CHAN_BODY,
    volume = 0.9,
    level = 65,
    pitch = 100,
    sound = {"physics/body/body_medium_impact_soft1.wav", "physics/body/body_medium_impact_soft2.wav", "physics/body/body_medium_impact_soft3.wav", "physics/body/body_medium_impact_soft4.wav", "physics/body/body_medium_impact_soft5.wav", "physics/body/body_medium_impact_soft6.wav", "physics/body/body_medium_impact_soft7.wav"}
})

sound.Add({
    name = "SvenCoopBodyPhysH.SCR",
    channel = CHAN_BODY,
    volume = 0.9,
    level = 65,
    pitch = 100,
    sound = {"physics/body/body_medium_impact_hard1.wav", "physics/body/body_medium_impact_hard2.wav", "physics/body/body_medium_impact_hard3.wav", "physics/body/body_medium_impact_hard4.wav", "physics/body/body_medium_impact_hard5.wav", "physics/body/body_medium_impact_hard6.wav"}
})

sound.Add({
    name = "SvenCoopBodyHit.SCR",
    channel = CHAN_BODY,
    volume = 0.9,
    level = 65,
    pitch = 100,
    sound = {"physics/flesh/flesh_impact_bullet1.wav", "physics/flesh/flesh_impact_bullet2.wav", "physics/flesh/flesh_impact_bullet3.wav", "physics/flesh/flesh_impact_bullet4.wav", "physics/flesh/flesh_impact_bullet5.wav"}
})

sound.Add({
    name = "MetroPoliceCallout.SCR",
    channel = CHAN_VOICE,
    volume = VOL_NORM,
    level = SNDLVL_80dB,
    pitch = PITCH_NORM,
    sound = {"npc/metropolice/vo/dispreportssuspectincursion.wav", "npc/metropolice/vo/officerdowniam10-99.wav", "npc/metropolice/vo/officerdowniam10-99.wav", "npc/metropolice/vo/officerneedsassistance.wav", "npc/metropolice/vo/officerneedshelp.wav", "npc/metropolice/vo/officerdowncode3tomy10-20.wav"}
})

sound.Add({
    name = "CombineSCallout.SCR",
    channel = CHAN_VOICE,
    volume = VOL_NORM,
    level = SNDLVL_80dB,
    pitch = PITCH_NORM,
    sound = {"npc/combine_soldier/vo/overwatchsectoroverrun.wav", "npc/combine_soldier/vo/overwatchteamisdown.wav", "npc/combine_soldier/vo/overwatchrequestreinforcement.wav", "npc/combine_soldier/vo/heavyresistance.wav", "npc/combine_soldier/vo/onedown.wav", "npc/combine_soldier/vo/onedutyvacated.wav"}
})

sound.Add({
    name = "MetroPoliceHelp.SCR",
    channel = CHAN_VOICE,
    volume = VOL_NORM,
    level = SNDLVL_80dB,
    pitch = PITCH_NORM,
    sound = {"npc/metropolice/vo/help.wav", "npc/metropolice/vo/takecover.wav", "npc/metropolice/vo/reinforcementteamscode3.wav", "npc/metropolice/vo/backmeupimout.wav", "npc/metropolice/vo/wehavea10-108.wav", "npc/metropolice/vo/watchit.wav"}
})

sound.Add({
    name = "CombineSHelp.SCR",
    channel = CHAN_VOICE,
    volume = VOL_NORM,
    level = SNDLVL_80dB,
    pitch = PITCH_NORM,
    sound = {"npc/combine_soldier/vo/requestmedical.wav", "npc/combine_soldier/vo/requeststimdose.wav"}
})

if not ConVarExists("revive_mod_revive_enable") then
    CreateClientConVar("revive_mod_revive_enable", '1', (FCVAR_GAMEDLL), "If true, dead Players can be revived by others.", true, true)
end

if not ConVarExists("revive_mod_first_person") then
    CreateClientConVar("revive_mod_first_person", '0', (FCVAR_UNREGISTERED), "First person view from body.", true, true)
end

if not ConVarExists("revive_mod_min_energy") then
    CreateClientConVar("revive_mod_min_energy", '50', (FCVAR_GAMEDLL), "How much Medkit Energy player need to revive other player.", true, true)
end

if not ConVarExists("revive_mod_npc_revive_chance") then
    CreateClientConVar("revive_mod_npc_revive_chance", '2', (FCVAR_GAMEDLL), "1 to YOUR NUMBER that NPCs will be able to revive.", true, true)
end

if not ConVarExists("revive_mod_revive_enable_npc_ally") then
    CreateClientConVar("revive_mod_revive_enable_npc_ally", '1', (FCVAR_GAMEDLL), "If true, dead ally NPCs can be revived by others.", true, true)
end

if not ConVarExists("revive_mod_revive_enable_npc_enemy") then
    CreateClientConVar("revive_mod_revive_enable_npc_enemy", '1', (FCVAR_GAMEDLL), "If true, dead enemy NPCs can be revived by others.", true, true)
end

if not ConVarExists("revive_mod_max_damage") then
    CreateClientConVar("revive_mod_max_damage", '150', (FCVAR_GAMEDLL), "If Player gets killed by this amount of damage or higher, He'll not be able to get revived.", true, true)
end

if not ConVarExists("revive_mod_headshot_death") then
    CreateClientConVar("revive_mod_headshot_death", '1', (FCVAR_GAMEDLL), "If Player gets killed by HeadShot, He'll not be able to get revived.", true, true)
end

if not ConVarExists("revive_mod_injured_health") then
    CreateClientConVar("revive_mod_injured_health", '25', (FCVAR_GAMEDLL), "Amount of health of 'Injured' Player.", true, true)
end

if not ConVarExists("revive_mod_corpse_despawn") then
    CreateClientConVar("revive_mod_corpse_despawn", '15', (FCVAR_GAMEDLL), "Corpse's despawn delay.", true, true)
end

if not ConVarExists("revive_mod_weapon_drop") then
    CreateClientConVar("revive_mod_weapon_drop", '1', (FCVAR_GAMEDLL), "NPCs should drop weapons after death?", true, true)
end

----------------------------------------------------------------------------CLIENT
if (CLIENT) then
    local function FRMcragdoll(data)
        local Pos = data:ReadVector()

        timer.Simple(.01, function()
            for key, crag in pairs(ents.FindInSphere(Pos, 90)) do
                if (crag:GetClass() == "class C_ClientRagdoll") then
                    SafeRemoveEntity(crag)
                end
            end
        end)
    end

    usermessage.Hook("FRMcragdollR", FRMcragdoll)

    function FRMviewFunc(ply, origin, angles, fov)
        local deadbody = ply:GetNetworkedEntity("ReviveBody")
        if (not deadbody or deadbody == NULL or not deadbody:IsValid() or not ply:GetNWBool("AllowView") or not ply:GetNWBool("ReviveBody") or GetViewEntity() ~= ply) then return end
        local eyes = deadbody:GetAttachment(deadbody:LookupAttachment("eyes"))

        local view = {
            origin = eyes.Pos,
            angles = eyes.Ang,
            fov = 90
        }

        return view
    end

    hook.Add("CalcView", "FRMview", FRMviewFunc)
end

----------------------------------------------------------------------------SERVER
if (SERVER) then
    hook.Add("PlayerDisconnected", "REVIVEMODREMOVEONLEAVE", function(ply)
        if IsValid(ply.revivebody) then
            SafeRemoveEntity(ply.revivebody)
        end
    end)

    hook.Add("SetupMove", "REVIVEMODREMOVEONLEAVE", function(ply, mv, cmd)
        if GetConVarNumber("revive_mod_revive_enable") == 1 then
            if ply:Alive() then
                ply.weps = {}

                for u, l in pairs(ply:GetWeapons()) do
                    if not table.HasValue(ply.weps, l:GetClass()) then
                        table.insert(ply.weps, l:GetClass())
                    end
                end
            end

            if IsValid(ply:GetActiveWeapon()) then
                ply.WeaponInMyHand = ply:GetActiveWeapon():GetClass()
            end
        end
    end)

    hook.Add("PlayerSpawn", "REVIVEMODREMOVE", function(ply)
        if GetConVarNumber("revive_mod_revive_enable") == 0 then
            ply.RevivePos = nil
            ply.ReviveAng = nil

            if IsValid(ply.revivebody) then
                ply:UnSpectate()
                SafeRemoveEntity(ply.revivebody)
            end
        end

        if GetConVarNumber("revive_mod_revive_enable") == 1 then
            ply:SetNWBool("ReviveBody", false)
            ply.HeadShotFRM = nil
            ply.KilledBySomethingPowerful = nil

            if ply.Revived == true then
                ply.Revived = nil
                local wep = ply.weps

                for i = 1, #wep do
                    ply:Give(wep[i])
                    --ply:GiveAmmo( 30, wep[i]:GetPrimaryAmmoType(), true )
                end
            end

            if IsValid(ply.revivebody) then
                ply:UnSpectate()
                SafeRemoveEntity(ply.revivebody)
            end

            if ply.RevivePos ~= nil then
                ply:SetPos(ply.RevivePos + Vector(0, 0, 16))
                ply.RevivePos = nil
            end

            if ply.ReviveAng ~= nil then
                ply:SetAngles(ply.ReviveAng)
                ply.ReviveAng = nil
            end
        end
    end)

    hook.Add("EntityTakeDamage", "REVIVEMODDAMAGE", function(target, dmginfo)
        local attacker = dmginfo:GetAttacker()

        if target:IsPlayer() then
            target.FRMpushforce = dmginfo:GetDamage() * math.random(3, 6)
            target.DamageLimit = dmginfo:GetDamage()
        end

        if target:IsNPC() then
            target.FRMpushforce = dmginfo:GetDamage() * math.random(3, 6)
            target.DamageLimit = dmginfo:GetDamage()
        end

        if (target:IsPlayer() or target:IsNPC()) and (dmginfo:IsDamageType(DMG_FALL) or dmginfo:IsDamageType(DMG_BURN) or dmginfo:IsDamageType(DMG_SLOWBURN) or dmginfo:IsDamageType(DMG_DISSOLVE) or dmginfo:IsDamageType(DMG_DROWN)) then
            target.KilledBySomethingPowerful = true
        else
            target.KilledBySomethingPowerful = nil
        end
    end)

    hook.Add("ScalePlayerDamage", "REVIVEMODHEADSHOT", function(ply, hitgroup, dmginfo)
        if GetConVarNumber("revive_mod_headshot_death") == 1 then
            if (hitgroup == HITGROUP_HEAD) then
                ply.HeadShotFRM = true
            else
                ply.HeadShotFRM = nil
            end
        end
    end)

    hook.Add("ScaleNPCDamage", "REVIVEMODHEADSHOTNPC", function(npc, hitgroup, dmginfo)
        if GetConVarNumber("revive_mod_headshot_death") == 1 then
            if (hitgroup == HITGROUP_HEAD) then
                npc.HeadShotFRM = true
            else
                npc.HeadShotFRM = nil
            end
        end
    end)

    hook.Add("OnNPCKilled", "REVIVEMODREVIVENPC", function(victim, killer, weapon)
        if GetConVarNumber("revive_mod_revive_enable_npc_ally") == 1 then
            ReviveAlliesList = {"npc_citizen", "npc_alyx", "npc_barney", "npc_kleiner", "npc_magnusson", "npc_mossman", "npc_eli", "npc_gman", "npc_breen", "npc_monk"}
            ReviveEnemiesList = {"npc_metropolice", "npc_combine_s"}

            if victim.Infect == nil then
                victim.Infect = 0
            end

            if victim.FRMpushforce == nil then
                victim.FRMpushforce = 0
            end

            if victim.DamageLimit == nil then
                victim.DamageLimit = 0
            end

            if victim.HeadShotFRM == true or (victim.DamageLimit >= (victim:GetMaxHealth() + 30)) or victim.KilledBySomethingPowerful == true or victim.Infect > 0 or victim.FRMignore == true then
                -------------
                -------------
            else
                if math.random(1, GetConVarNumber("revive_mod_npc_revive_chance")) == 1 then
                    if table.HasValue(ReviveAlliesList, victim:GetClass()) then
                        victim:SetKeyValue("spawnflags", "8192")
                        victim.revivebody = ents.Create("revive_mod_entity_npc")

                        if IsValid(victim:GetActiveWeapon()) then
                            victim.revivebody.Weapon = victim:GetActiveWeapon():GetClass()
                        else
                            victim.revivebody.Weapon = nil
                        end

                        if IsValid(victim.revivebody) then
                            victim.revivebody:SetPos(victim:GetPos() + victim:GetUp() * 30)

                            if IsValid(killer) and victim ~= killer then
                                local ang = (killer:GetPos() - victim.revivebody:GetPos()):Angle()
                                local ang2 = victim.revivebody:GetAngles()
                                victim.revivebody:SetAngles(Angle(ang2.p, ang.y, ang2.r))
                            elseif (not IsValid(killer)) or victim == killer then
                                local ang2 = victim:GetAngles()
                                victim.revivebody:SetAngles(Angle(0, ang2.y, 0))
                            end

                            if IsValid(killer) and victim:Visible(killer) and victim ~= killer then
                                victim.revivebody.FlyAnim = true
                            elseif (not IsValid(killer)) or (not victim:Visible(killer)) or victim == killer then
                                victim.revivebody.FlyAnim = nil
                            end

                            if victim.LikeFilzoPlayers == true then
                                victim.revivebody.LikeFilzoPlayers = true
                            end

                            victim.revivebody:SetOwner(victim)
                            victim.revivebody:SetHealth(victim:GetMaxHealth() * .5)
                            victim.revivebody.Class = victim:GetClass()
                            victim.revivebody.Model = victim:GetModel()
                            victim.revivebody.Skin = victim:GetSkin()
                            victim.revivebody.Material = victim:GetMaterial()
                            victim.revivebody.Color = victim:GetColor()
                            victim.revivebody.NPCHealth = victim:GetMaxHealth()
                            victim.revivebody.Body1 = victim:GetBodygroup(1)
                            victim.revivebody.Body2 = victim:GetBodygroup(2)
                            victim.revivebody.Body3 = victim:GetBodygroup(3)
                            victim.revivebody.Body4 = victim:GetBodygroup(4)
                            victim.revivebody.Body5 = victim:GetBodygroup(5)
                            victim.revivebody.Body6 = victim:GetBodygroup(6)
                            victim.revivebody.Body7 = victim:GetBodygroup(7)
                            victim.revivebody.Body8 = victim:GetBodygroup(8)
                            victim.revivebody.Body9 = victim:GetBodygroup(9)
                            victim.revivebody:Spawn()

                            if IsValid(killer) and victim ~= killer then
                                if victim.FRMpushforce > 350 then
                                    victim.FRMpushforce = 350
                                end

                                victim.revivebody:SetVelocity(killer:GetForward() * victim.FRMpushforce + killer:GetUp() * victim.FRMpushforce)
                            else
                                victim.revivebody:SetVelocity(victim:GetVelocity() * 0.88)
                            end
                        end

                        umsg.Start("FRMcragdollR")
                        umsg.Vector(victim:GetPos())
                        umsg.End()
                        local RagPos = victim:GetPos() + Vector(0, 0, 30)

                        timer.Simple(.01, function()
                            for _, rag in pairs(ents.FindInSphere(RagPos, 90)) do
                                if (rag:GetClass() == "prop_ragdoll") then
                                    if rag.FRMragdoll == nil then
                                        SafeRemoveEntity(rag)
                                    end
                                end
                            end
                        end)
                    end
                end
            end
        end

        if GetConVarNumber("revive_mod_revive_enable_npc_enemy") == 1 then
            if victim.Infect == nil then
                victim.Infect = 0
            end

            if victim.FRMpushforce == nil then
                victim.FRMpushforce = 0
            end

            if victim.DamageLimit == nil then
                victim.DamageLimit = 0
            end

            if victim.HeadShotFRM == true or victim.DamageLimit >= GetConVarNumber("revive_mod_max_damage") or victim.KilledBySomethingPowerful == true or victim.Infect > 0 or victim.FRMignore == true then
                -------------
                -------------
            else
                if math.random(1, GetConVarNumber("revive_mod_npc_revive_chance")) == 1 then
                    if table.HasValue(ReviveEnemiesList, victim:GetClass()) then
                        victim:SetKeyValue("spawnflags", "8192")
                        victim.revivebody = ents.Create("revive_mod_entity_npc")

                        if IsValid(victim:GetActiveWeapon()) then
                            victim.revivebody.Weapon = victim:GetActiveWeapon():GetClass()
                        else
                            victim.revivebody.Weapon = nil
                        end

                        if IsValid(victim.revivebody) then
                            victim.revivebody:SetPos(victim:GetPos() + victim:GetUp() * 30)

                            if IsValid(killer) and victim ~= killer then
                                local ang = (killer:GetPos() - victim.revivebody:GetPos()):Angle()
                                local ang2 = victim.revivebody:GetAngles()
                                victim.revivebody:SetAngles(Angle(ang2.p, ang.y, ang2.r))
                            elseif (not IsValid(killer)) or victim == killer then
                                local ang2 = victim:GetAngles()
                                victim.revivebody:SetAngles(Angle(0, ang2.y, 0))
                            end

                            if IsValid(killer) and victim:Visible(killer) and victim ~= killer then
                                victim.revivebody.FlyAnim = true
                            elseif (not IsValid(killer)) or (not victim:Visible(killer)) or victim == killer then
                                victim.revivebody.FlyAnim = nil
                            end

                            if victim.LikeFilzoPlayers == true then
                                victim.revivebody.LikeFilzoPlayers = true
                            end

                            victim.revivebody:SetOwner(victim)
                            victim.revivebody:SetHealth(victim:GetMaxHealth() * .5)
                            victim.revivebody.Class = victim:GetClass()
                            victim.revivebody.Model = victim:GetModel()
                            victim.revivebody.Skin = victim:GetSkin()
                            victim.revivebody.Material = victim:GetMaterial()
                            victim.revivebody.Color = victim:GetColor()
                            victim.revivebody.NPCHealth = victim:GetMaxHealth()
                            victim.revivebody.Body1 = victim:GetBodygroup(1)
                            victim.revivebody.Body2 = victim:GetBodygroup(2)
                            victim.revivebody.Body3 = victim:GetBodygroup(3)
                            victim.revivebody.Body4 = victim:GetBodygroup(4)
                            victim.revivebody.Body5 = victim:GetBodygroup(5)
                            victim.revivebody.Body6 = victim:GetBodygroup(6)
                            victim.revivebody.Body7 = victim:GetBodygroup(7)
                            victim.revivebody.Body8 = victim:GetBodygroup(8)
                            victim.revivebody.Body9 = victim:GetBodygroup(9)
                            victim.revivebody:Spawn()

                            if IsValid(killer) and victim ~= killer then
                                if victim.FRMpushforce > 350 then
                                    victim.FRMpushforce = 350
                                end

                                victim.revivebody:SetVelocity(killer:GetForward() * victim.FRMpushforce + killer:GetUp() * victim.FRMpushforce)
                            else
                                victim.revivebody:SetVelocity(victim:GetVelocity() * 0.88)
                            end
                        end

                        umsg.Start("FRMcragdollR")
                        umsg.Vector(victim:GetPos())
                        umsg.End()
                        local RagPos = victim:GetPos() + Vector(0, 0, 30)

                        timer.Simple(.01, function()
                            for _, rag in pairs(ents.FindInSphere(RagPos, 90)) do
                                if (rag:GetClass() == "prop_ragdoll") then
                                    if rag.FRMragdoll == nil then
                                        SafeRemoveEntity(rag)
                                    end
                                end
                            end
                        end)
                    end
                end
            end
        end
    end)

    hook.Add("PlayerDeath", "REVIVEMODREVIVE", function(victim, weapon, attacker)
        if GetConVarNumber("revive_mod_revive_enable") == 1 then
            if victim.Infect == nil then
                victim.Infect = 0
            end

            if victim.FRMpushforce == nil then
                victim.FRMpushforce = 0
            end

            if victim.DamageLimit == nil then
                victim.DamageLimit = 0
            end

            if victim.HeadShotFRM == true or victim.DamageLimit >= GetConVarNumber("revive_mod_max_damage") or victim.KilledBySomethingPowerful == true or victim.Infect > 0 then
                --[[
if victim.WeaponInMyHand=="weapon_physgun" or victim.WeaponInMyHand=="gmod_tool" or victim.WeaponInMyHand=="gmod_camera" then
else
local vichand=victim:LookupBone("ValveBiped.Bip01_R_Hand")
local weapondrop = ents.Create(victim.WeaponInMyHand)
weapondrop:SetPos(victim:GetBonePosition(vichand))
weapondrop:SetAngles(victim:GetAngles())
weapondrop:Spawn()
local phys = weapondrop:GetPhysicsObject()
phys:SetVelocity(victim:GetForward()*math.random(70,150) + victim:GetUp()*math.random(100,180) + victim:GetRight()*math.random(-100,100))
end
]]
                --
                -------------
                -------------
            else
                victim.revivebody = ents.Create("revive_mod_entity")

                if IsValid(victim.revivebody) then
                    victim.revivebody:SetPos(victim:GetPos() + victim:GetUp() * 30)

                    if IsValid(attacker) and victim ~= attacker then
                        local ang = (attacker:GetPos() - victim.revivebody:GetPos()):Angle()
                        local ang2 = victim.revivebody:GetAngles()
                        victim.revivebody:SetAngles(Angle(ang2.p, ang.y, ang2.r))
                    elseif (not IsValid(attacker)) or victim == attacker then
                        local ang2 = victim:GetAngles()
                        victim.revivebody:SetAngles(Angle(0, ang2.y, 0))
                    end

                    if IsValid(attacker) and victim:Visible(attacker) and victim ~= attacker then
                        victim.revivebody.FlyAnim = true
                    elseif (not IsValid(attacker)) or (not victim:Visible(attacker)) or victim == attacker then
                        victim.revivebody.FlyAnim = nil
                    end

                    victim.revivebody:SetOwner(victim)
                    victim.revivebody.Model = victim:GetModel()
                    victim.revivebody.Skin = victim:GetSkin()
                    victim.revivebody.Material = victim:GetMaterial()
                    victim.revivebody.Color = victim:GetColor()
                    victim.revivebody.Body1 = victim:GetBodygroup(1)
                    victim.revivebody.Body2 = victim:GetBodygroup(2)
                    victim.revivebody.Body3 = victim:GetBodygroup(3)
                    victim.revivebody.Body4 = victim:GetBodygroup(4)
                    victim.revivebody.Body5 = victim:GetBodygroup(5)
                    victim.revivebody.Body6 = victim:GetBodygroup(6)
                    victim.revivebody.Body7 = victim:GetBodygroup(7)
                    victim.revivebody.Body8 = victim:GetBodygroup(8)
                    victim.revivebody.Body9 = victim:GetBodygroup(9)
                    victim.revivebody:Spawn()

                    if GetConVarNumber("revive_mod_first_person") == 0 then
                        victim:Spectate(OBS_MODE_CHASE)
                        victim:SpectateEntity(victim.revivebody)
                    end

                    if GetConVarNumber("revive_mod_first_person") == 1 then
                        victim:SetNWBool("ReviveBody", true)
                        victim:SetNWInt("AllowView", true)
                        victim:SetNetworkedEntity("ReviveBody", victim.revivebody.dead)
                    end

                    if IsValid(attacker) and victim ~= attacker then
                        if victim.FRMpushforce > 350 then
                            victim.FRMpushforce = 350
                        end

                        victim.revivebody:SetVelocity(attacker:GetForward() * victim.FRMpushforce + attacker:GetUp() * victim.FRMpushforce)
                    else
                        victim.revivebody:SetVelocity(victim:GetVelocity() * 0.88)
                    end
                end

                if IsValid(victim:GetRagdollEntity()) then
                    local plyrag = victim:GetRagdollEntity()
                    plyrag:Remove()
                end

                local RagPos = victim:GetPos() + Vector(0, 0, 30)

                timer.Simple(.01, function()
                    for _, rag in pairs(ents.FindInSphere(RagPos, 90)) do
                        if (rag:GetClass() == "prop_ragdoll") then
                            if rag.FRMragdoll == nil then
                                SafeRemoveEntity(rag)
                            end
                        end
                    end
                end)
            end
        end
    end)
end
