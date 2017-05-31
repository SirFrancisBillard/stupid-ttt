
PERKMENU = {}

surface.CreateFont("PerkMenu_ServerTitleFont", {
	size = (type(ScrH) == "function" and ScrH() or 1080) / 24,
	weight = 800,
	antialias = true,
	shadow = false,
	font = "Arial"
})

function PERKMENU:Build()
	self:Destroy()

	self.Panel = vgui.Create("DPanel")
	self.Panel:SetSize(ScrW(), ScrH())
	self.Panel:Center()
	self.Panel:MakePopup()
	self.Panel.Paint = function(pnl, w, h)
		draw.RoundedBox(0, 0, 0, w, h, Color(50, 50, 50, 200))
	end

	local ServerTitle = vgui.Create("DLabel", self.Panel)
	ServerTitle:SetFont("PerkMenu_ServerTitleFont")
	ServerTitle:SetSize(ScrW(), ScrH() / 5)
	
	local text = "Choose a Perk"
	surface.SetFont("PerkMenu_ServerTitleFont")
	local offset = surface.GetTextSize(text) / 2
	ServerTitle:SetText(text)
	ServerTitle:SetPos(ScrW() / 2 - offset, (ScrH() / 2) * 0.3)

	local bw = 50
	local marge = 16
	local IsEven = (#gPerks % 2) == 0
	local MainCenterOffset = IsEven and (marge / 2) or ((bw / 2) + marge)
	local b_x = ScrH() / 2
	local b_y = ScrW() / 2
	local b_w = 50
	local b_h = 50
	local WidthOfEachThingy = ScrW() / (#gPerks / 2)

	local PerkButtons = {}

	for k, v in pairs(gPerks) do
		PerkButtons[#PerkButtons + 1] = vgui.Create("DButton", self.Panel)
		PerkButtons[#PerkButtons]:SetText(v.Name)
		PerkButtons[#PerkButtons]:SetTooltip(v.Desc)
		PerkButtons[#PerkButtons]:SetPos(b_x, b_y)
		PerkButtons[#PerkButtons]:SetSize(b_w, b_h)
		PerkButtons[#PerkButtons].DoClick = function()
			SetMyPerk(v.ID)
			self:Destroy()
		end
	end
end

function PERKMENU:Destroy()
	if IsValid(PERKMENU.Panel) and type(PERKMENU.Panel.Remove) == "function" then
		PERKMENU.Panel:Remove()
	end
end

concommand.Add("ttt_perkmenu", function(ply, cmd, args, argsStr)
	PERKMENU:Build()
end)
