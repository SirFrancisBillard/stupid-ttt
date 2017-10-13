
AddCSLuaFile()

hook.Add("DoPlayerDeath", "StupidTTT.Equipment.Jest", function(ply)
			if IsValid(ply) and ply:IsPlayer() and ply:HasEquipmentItem(EQUIP_JEST) then
				local pos = ply:GetPos()
				ply:EmitSound("Jihad.Scream")

				timer.Simple(1, function()
					local boom = EffectData()
					boom:SetOrigin(pos)

					sound.Play(Sound("^phx/explode0" .. math.random(0, 6) .. ".wav"), pos)

					util.Decal("Rollermine.Crater", pos, pos - Vector(0, 0, 500), nil)
					util.Decal("Scorch", pos, pos - Vector(0, 0, 500), nil)

					util.BlastDamage(ply, ply, pos, math.random(64, 256), math.random(64, 128))

					timer.Simple(0.5, function()
						if not pos then return end

						sound.Play(Sound("Jihad.Islam"), pos)
					end)
				end)
			end
		end)
