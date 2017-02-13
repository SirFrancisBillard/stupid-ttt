include("../sh_ttt_models.lua")

-- Bulk sounds
for i = 1, 10 do
	resource.AddFile("sound/stupid-ttt/allahu/akbar_" .. i .. ".wav")
end

for i = 1, 12 do
	resource.AddFile("sound/stupid-ttt/bullets/snap_" .. i .. ".wav")
end

for i = 1, 13 do
	resource.AddFile("sound/stupid-ttt/emotes/random_" .. i .. ".wav")
end

-- Models
if TTT_USE_CUSTOM_MODELS then
	print("Adding TTT models...")
	resource.AddWorkshop("858272541")
	print("TTT models added!")
end

-- Sounds
resource.AddFile("sound/stupid-ttt/headshot.wav")
resource.AddFile("sound/stupid-ttt/homerun.wav")

-- Icons
resource.AddFile("materials/vgui/ttt/icon_ak47.png")
resource.AddFile("materials/vgui/ttt/icon_aug.png")
resource.AddFile("materials/vgui/ttt/icon_awp.png")
resource.AddFile("materials/vgui/ttt/icon_ball.png")
resource.AddFile("materials/vgui/ttt/icon_banana.png")
resource.AddFile("materials/vgui/ttt/icon_bat.png")
resource.AddFile("materials/vgui/ttt/icon_boomstick.png")
resource.AddFile("materials/vgui/ttt/icon_cloak.png")
resource.AddFile("materials/vgui/ttt/icon_dbarrel.png")
resource.AddFile("materials/vgui/ttt/icon_deathstation.png")
resource.AddFile("materials/vgui/ttt/icon_defib.png")
resource.AddFile("materials/vgui/ttt/icon_dualies.png")
resource.AddFile("materials/vgui/ttt/icon_gl.png")
resource.AddFile("materials/vgui/ttt/icon_hitler.png")
resource.AddFile("materials/vgui/ttt/icon_jihad.png")
resource.AddFile("materials/vgui/ttt/icon_laser.png")
resource.AddFile("materials/vgui/ttt/icon_mp5.png")
resource.AddFile("materials/vgui/ttt/icon_negev.png")
resource.AddFile("materials/vgui/ttt/icon_p90.png")
resource.AddFile("materials/vgui/ttt/icon_pdrank.png")
resource.AddFile("materials/vgui/ttt/icon_pepper.png")
resource.AddFile("materials/vgui/ttt/icon_python.png")
resource.AddFile("materials/vgui/ttt/icon_taser.png")
resource.AddFile("materials/vgui/ttt/icon_tmp.png")
