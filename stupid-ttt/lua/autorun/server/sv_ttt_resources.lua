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
	resource.AddFile("models/weapons/tfa_doom/c_ssg.mdl")
	resource.AddFile("models/weapons/tfa_doom/w_ssg.mdl")
	resource.AddFile("materials/models/weapons/tfa_doom/ssg/shells_d.vtf")
	resource.AddFile("materials/models/weapons/tfa_doom/ssg/shells_e.vtf")
	resource.AddFile("materials/models/weapons/tfa_doom/ssg/shells_i.vtf")
	resource.AddFile("materials/models/weapons/tfa_doom/ssg/shells_n.vtf")
	resource.AddFile("materials/models/weapons/tfa_doom/ssg/shells_s.vtf")
	resource.AddFile("materials/models/weapons/tfa_doom/ssg/ssg_d.vtf")
	resource.AddFile("materials/models/weapons/tfa_doom/ssg/ssg_e.vtf")
	resource.AddFile("materials/models/weapons/tfa_doom/ssg/ssg_i.vtf")
	resource.AddFile("materials/models/weapons/tfa_doom/ssg/ssg_n.vtf")
	resource.AddFile("materials/models/weapons/tfa_doom/ssg/ssg_s.vtf")

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
