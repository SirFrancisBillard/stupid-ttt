
for k, v in pairs(weapons.GetList()) do
	if (v.ClassName:find("weapon_ttt_") or v.ClassName:find("weapon_zm_")) and isnumber(v.Primary.Damage) and isnumber(v.Primary.Delay) then
		local dmg = v.Primary.Damage
		if isnumber(v.Primary.NumShots) then
			dmg = dmg  * v.Primary.NumShots
		end
		local delay = v.Primary.Delay
		print(v.ClassName .. " - " .. dmg .. " - " .. delay .. " - " .. math.Round(dmg / delay))
	end
end
