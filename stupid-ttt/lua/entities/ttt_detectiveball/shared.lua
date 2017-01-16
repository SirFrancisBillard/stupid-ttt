ENT.Type 			= "anim"
ENT.Base 			= "base_anim"



function ENT:Infect(plyr)
	local detective_ids = {}
	for k, ply in pairs(player.GetAll()) do
		if ply:IsRole(ROLE_DETECTIVE) and ply:Alive() then
         		table.insert(detective_ids, ply:EntIndex())
		end
	end
	if (plyr != nil && plyr != NULL && plyr != null && SERVER) then
		if (plyr:IsPlayer() && plyr:IsValid()) then
				if (!timer.Exists("InfectionTimer"..plyr:GetName().."")) then
					timer.Create("InfectionTimer"..plyr:GetName().."", math.random(DetectiveBallConfig.InfectTimeMin, DetectiveBallConfig.InfectTimeMax), 1, 
					function()
						if plyr:Alive() and plyr:GetRole() == ROLE_DETECTIVE then
							if (DetectiveBallConfig.PZ) then
								plyr:SetHealth(100)
								plyr:PrintMessage( HUD_PRINTTALK, "You are healed!")
							end
						elseif plyr:Alive() and plyr:GetRole() == ROLE_TRAITOR then
							if (DetectiveBallConfig.PZ) then
								plyr:PrintMessage( HUD_PRINTCENTER, "You are unmasked!")
								for k, ply in pairs( player.GetAll() ) do
									ply:ChatPrint(plyr:GetName() .. " is a Traitor!" )
									ply:PrintMessage( HUD_PRINTCENTER, plyr:GetName() .. " is a Traitor!" )
								end
							end
						elseif plyr:Alive() and plyr:GetRole() == ROLE_INNOCENT and table.Count(detective_ids) < 3 then
							if (DetectiveBallConfig.PZ) then
								local pos = plyr:GetPos()
								plyr:SetRole(ROLE_DETECTIVE)
								plyr:AddCredits(1)
								plyr:SetHealth(100)
								plyr:SetPos(pos)
								plyr:PrintMessage( HUD_PRINTCENTER, "You are a Detective and healthy!")
								SendFullStateUpdate()
								for k, ply in pairs( player.GetAll() ) do
									ply:ChatPrint(plyr:GetName() .. " is now a Detective!" )
								end
							end
						elseif plyr:Alive() and plyr:GetRole() == ROLE_INNOCENT and table.Count(detective_ids) >= 3 then
							if (DetectiveBallConfig.PZ) then
								plyr:SetHealth(100)
								plyr:PrintMessage( HUD_PRINTTALK, "You are healed!")
							end
						end
					end)
					
				if (DetectiveBallConfig.InfectMessage) then
					if plyr:GetRole() == ROLE_TRAITOR then
						plyr:PrintMessage( HUD_PRINTCENTER, "You will be unmasked in 10 seconds!")
					elseif plyr:GetRole() == ROLE_INNOCENT and table.Count(detective_ids) < 3 then
						plyr:PrintMessage( HUD_PRINTCENTER, "You become a Detective and healing in 10 seconds!")
					elseif plyr:GetRole() == ROLE_INNOCENT and table.Count(detective_ids) >= 3 then
						plyr:PrintMessage( HUD_PRINTCENTER, "Too much Detectives. Only healing in 10 seconds!")
						for k, ply in pairs( player.GetAll() ) do
							if ply:GetRole() == ROLE_DETECTIVE and self.Owner then
								ply:PrintMessage( HUD_PRINTCENTER, "Too much Detectives. Only healing in 10 seconds!")
							end
						end
					elseif plyr:GetRole() == ROLE_DETECTIVE then
						plyr:PrintMessage( HUD_PRINTCENTER, "You will be healed in 10 seconds!")
					end
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
end




function StopTimers(player)
	if (timer.Exists("InfectionTimer"..player:GetName().."")) then
		timer.Destroy("InfectionTimer"..player:GetName().."")
	end
	
	if (timer.Exists("ShakeTimer"..player:GetName().."")) then
		timer.Destroy("ShakeTimer"..player:GetName().."")
	end
end
hook.Add("PlayerSpawn", "Stop Timers", StopTimers)









