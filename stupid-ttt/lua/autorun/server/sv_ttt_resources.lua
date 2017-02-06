include("../sh_ttt_models.lua")

for i = 1, 10 do
	resource.AddFile("sound/stupid-ttt/allahu/akbar_" .. i .. ".wav")
end

for i = 1, 12 do
	resource.AddFile("sound/stupid-ttt/bullets/snap_" .. i .. ".wav")
end

for i = 1, 13 do
	resource.AddFile("sound/stupid-ttt/emotes/random_" .. i .. ".wav")
end

if TTT_USE_CUSTOM_MODELS then
	print("Adding TTT models...")
	resource.AddFile("models/weapons/v_sawedoff.mdl")
	resource.AddFile("models/weapons/w_sawedoff.mdl")
	resource.AddFile("materials/models/weapons/v_sawedoff/barrel.vtf")
	resource.AddFile("materials/models/weapons/v_sawedoff/barrel_n.vtf")
	resource.AddFile("materials/models/weapons/v_sawedoff/base.vtf")
	resource.AddFile("materials/models/weapons/v_sawedoff/base_n.vtf")
	resource.AddFile("materials/models/weapons/v_sawedoff/butt.vtf")
	resource.AddFile("materials/models/weapons/v_sawedoff/butt_n.vtf")

	resource.AddFile("models/weapons/v_p_drink.mdl")
	resource.AddFile("models/weapons/w_p_drink.mdl")
	resource.AddFile("materials/models/weapons/pdrink/m_drink_normal.vtf")
	resource.AddFile("materials/models/weapons/pdrink/p_drink_sheet.vtf")
	print("TTT models added!")
end

resource.AddFile("materials/vgui/ttt/icon_ak47.png")
resource.AddFile("materials/vgui/ttt/icon_aug.png")
resource.AddFile("materials/vgui/ttt/icon_awp.png")
resource.AddFile("materials/vgui/ttt/icon_ball.png")
resource.AddFile("materials/vgui/ttt/icon_boomstick.png")
resource.AddFile("materials/vgui/ttt/icon_cloak.png")
resource.AddFile("materials/vgui/ttt/icon_dbarrel.png")
resource.AddFile("materials/vgui/ttt/icon_deathstation.png")
resource.AddFile("materials/vgui/ttt/icon_defib.png")
resource.AddFile("materials/vgui/ttt/icon_dualies.png")
resource.AddFile("materials/vgui/ttt/icon_gl.png")
resource.AddFile("materials/vgui/ttt/icon_hitler.png")
resource.AddFile("materials/vgui/ttt/icon_jihad.png")
resource.AddFile("materials/vgui/ttt/icon_mp5.png")
resource.AddFile("materials/vgui/ttt/icon_negev.png")
resource.AddFile("materials/vgui/ttt/icon_pdrank.png")
resource.AddFile("materials/vgui/ttt/icon_pepper.png")
resource.AddFile("materials/vgui/ttt/icon_python.png")
resource.AddFile("materials/vgui/ttt/icon_taser.png")
