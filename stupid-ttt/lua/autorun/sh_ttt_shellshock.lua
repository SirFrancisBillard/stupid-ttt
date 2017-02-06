
local shockDistance = 50 -- Maximum distance, within which you will be effected.	
local maxShock = 10 -- Maximum shocked you can be.  Probably don't change this.
local defaultFadeSpeed = 1 -- Speed at which shock goes away.

if SERVER then
	CreateConVar( "shell_fadespeed", defaultFadeSpeed, _, "How quickly should shellshock fade away?"  )
	CreateConVar( "shell_enabled", 1, _, "Should shellshock be active?"  )

	util.AddNetworkString( "ShotAt" )

	-- Handles whether or not a player or NPC should be effected by a bullet
	hook.Add( "EntityFireBullets", "ShellshockGettingBullets", function( ent, data)
		if ( not IsValid( ent ) or not GetConVar( "shell_enabled" ):GetBool() ) then return end
		data.Callback = function( ply, tr, dmginfo )
			-- Handles players getting shot at
			for k,v in pairs( player.GetAll() ) do
				if v != ent then
					local dist = util.DistanceToLine( tr.StartPos, tr.HitPos, v:EyePos() )
					if dist <= shockDistance then
						local shock = math.Clamp( ( v:GetNWFloat( "ShellshockLevel", 0 ) + ( ( shockDistance - dist ) / shockDistance ) ) * ( 1 + dmginfo:GetDamage()/750 ), 0, maxShock )
						v:SetNWFloat( "ShellshockLevel", shock )

						net.Start( "ShotAt" )
						net.Send( v )

						v:ViewPunch( Angle( math.random( -1, 1 )/( ( maxShock + 1 ) - shock ), math.random( -1, 1 )/( ( maxShock + 1 ) - shock ), math.random( -1, 1 )/( ( maxShock + 1 ) - shock ) ) )

						timer.Create( "Shellshock"..v:EntIndex(), 0.25, 0, function()
							if not IsValid( v ) then return end
							local shock = math.max( v:GetNWFloat( "ShellshockLevel", 0 ) - GetConVar( "shell_fadespeed" ):GetFloat(), 0 )
							v:SetNWFloat( "ShellshockLevel", shock )
						end)
					end
				end
			end
		end
		return true
	end)

	-- Removes the effect on death
	hook.Add( "PlayerSpawn", "ShellshockReset", function( ply )
		ply:SetNWFloat( "ShellshockLevel", 0 )
	end)
else -- CLIENT
	-- Handles near miss sounds
	net.Receive( "ShotAt", function()
		if not IsValid( LocalPlayer() ) then return end
		surface.PlaySound( "stupid-ttt/bullets/snap_" .. math.random(1, 12) .. ".wav")
	end)
	
	-- Draws the screen effects
	hook.Add( "RenderScreenspaceEffects", "ShellshockDrawEffects", function()
		if not IsValid( LocalPlayer() ) then return end
		local level = LocalPlayer():GetNWFloat( "ShellshockLevel", 0 )
		
		if level > 0 then
			DrawSharpen( level, 0.25 )
			local tab = {
				[ "$pp_colour_addr" ] = 0,
				[ "$pp_colour_addg" ] = 0,
				[ "$pp_colour_addb" ] = 0,
				[ "$pp_colour_brightness" ] = 0,
				[ "$pp_colour_contrast" ] = 1,
				[ "$pp_colour_colour" ] = ( 1 - ( level/maxShock ) ),
				[ "$pp_colour_mulr" ] = 0,
				[ "$pp_colour_mulg" ] = 0.02,
				[ "$pp_colour_mulb" ] = 0
			}
			DrawColorModify( tab )
		end
		
	end)
end