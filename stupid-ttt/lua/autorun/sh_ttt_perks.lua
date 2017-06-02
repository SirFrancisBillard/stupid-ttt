
local PLAYER = FindMetaTable("Player")

function PLAYER:GetPerk()
	return self:GetNWString("ttt_perk", "agra")
end

gPerks = {}

function RegisterPerk(tbl)
	gPerks[tbl.ID] = tbl
	if type(tbl.Init) == "function" then
		tbl.Init()
	end
end

RegisterPerk({
	ID = "agra",
	Name = "Agra",
	Desc = [[Being the fatass you are, you always carry some chocolate around.
		When you are low on health, you can eat chocolate to regenerate.]],
	Image = "agra.png",
	Init = function()
		timer.Create("StupidTTT.Perks.Agra", 2, 0, function()
			for k, v in pairs(player.GetAll()) do
				if IsValid(v) and v:IsPlayer() and v:GetPerk() == "agra" and v:GetHealth() < (v:GetMaxHealth() / 4) then
					v:SetHealth(math.min(v:Health() + 2, v:GetMaxHealth() / 4))
				end
			end
		end)
	end,
	OnEquip = function(ply) end,
	OnHolster = function(ply) end
})

RegisterPerk({
	ID = "billard",
	Name = "Sir Francis Billard",
	Desc = [[Being the fatass you are, you always carry some chocolate around.
		When you are low on health, you can eat chocolate to regenerate.]],
	Image = "billard.png",
	Init = function()
		timer.Create("StupidTTT.Perks.Billard", 2, 0, function()
			for k, v in pairs(player.GetAll()) do
				if IsValid(v) and v:IsPlayer() and v:GetPerk() == "billard" and v:GetHealth() < (v:GetMaxHealth() / 4) then
					v:SetHealth(math.min(v:Health() + 2, v:GetMaxHealth() / 4))
				end
			end
		end)
	end,
	OnEquip = function(ply) end,
	OnHolster = function(ply) end
})

RegisterPerk({
	ID = "blaze",
	Name = "Blaze Gambla",
	Desc = [[It is your Jihadi instinct to carry explosives with you at all times.
		There is a small chance that you may explode upon death.
		Allahu akbar.]],
	Image = "blaze.png",
	Init = function()
		hook.Add("DoPlayerDeath", "StupidTTT.Perks.Blaze", function(ply)
			if IsValid(ply) and ply:IsPlayer() and ply:GetPerk() == "blaze" and math.random(1, 8) == 1 then
				local pos = ply:GetPos()
				ply:EmitSound("Jihad.Scream")

				timer.Simple(1, function()
					local boom = EffectData()
					boom:SetOrigin(pos)

					sound.Play(Sound("^phx/explode0" .. math.random(0, 6) .. ".wav"), pos)

					util.Decal("Rollermine.Crater", pos, pos - Vector(0, 0, 500), nil)
					util.Decal("Scorch", pos, pos - Vector(0, 0, 500), nil)

					util.BlastDamage(ply, ply, pos, math.random(64, 256), math.random(64, 128))

					timer.Simple(1.2, function()
						if not pos then return end

						sound.Play(Sound("Jihad.Islam"), pos)
					end)
				end)
			end
		end)
	end,
	OnEquip = function(ply) end,
	OnHolster = function(ply) end
})

RegisterPerk({
	ID = "tayte",
	Name = "Tayte",
	Desc = [[You were born with an incredibly thick skull.
		Occasionally, headshots will deal less damage.]],
	Image = "tayte.png",
	Init = function()
		hook.Add("EntityTakeDamage", "StupidTTT.Perks.Tayte", function(ply, dmg)
			if IsValid(ply) and ply:IsPlayer() and ply:GetPerk() == "tayte" and dmg:IsBulletDamage() and ply:LastHitGroup() == HITGROUP_HEAD and math.random(1, 8) == 1 then
				dmg:ScaleDamage(0.2)
				ply:ChatPrint("Your thick skull protected your head from a bullet!")
			end
		end)
	end,
	OnEquip = function(ply) end,
	OnHolster = function(ply) end
})

RegisterPerk({
	ID = "tielar",
	Name = "Tielar",
	Desc = [[Your internet is abysmal.
		Occasionally, bullets that should have hit you will completely miss.]],
	Image = "tayte.png",
	Init = function()
		hook.Add("EntityTakeDamage", "StupidTTT.Perks.Tielar", function(ply, dmg)
			if IsValid(ply) and ply:IsPlayer() and ply:GetPerk() == "tielar" and dmg:IsBulletDamage() and math.random(1, 30) == 1 then
				dmg:ScaleDamage(0)
				ply:ChatPrint("Your internet protected you from a bullet!")
			end
		end)
	end,
	OnEquip = function(ply) end,
	OnHolster = function(ply) end
})
