
PERKMENU = {}

surface.CreateFont("PerkMenu_ServerTitleFont", {
	size = (type(ScrH) == "function" and ScrH() or 1080) / 24,
	weight = 800,
	antialias = true,
	shadow = false,
	font = "Arial"
})

function PERKMENU:SendPerk(perk)
	net.Start("ttt_sendperk")
	net.WriteString(perk)
	net.SendToServer()
end

function PERKMENU:Build()
	self:Destroy()

	self.Panel = vgui.Create("DFrame")
	self.Panel:SetTitle("Select Perk")
	self.Panel:SetSize(1000, 600)
	self.Panel:Center()
	self.Panel:MakePopup()

	local Scroll = vgui.Create("DScrollPanel", self.Panel)
	Scroll:SetSize(950, 550)
	Scroll:SetPos(10, 30)

	local List	= vgui.Create("DIconLayout", Scroll)
	List:SetSize(900, 500)
	List:SetPos(0, 0)
	List:SetSpaceY(5)
	List:SetSpaceX(5)

	for k, v in pairs(gPerks) do
		local ListPanel = List:Add("DPanel")
		ListPanel:SetSize(250, 350)

		local ListImage = List:Add("DImageButton")
		ListImage:SetSize(250, 250)
		ListImage:SetImage("vgui/perks/" .. v.Image)
		ListImage.DoClick = function()
			self:SendPerk(v.ID)
		end

		local ListLabel = List:Add("DLabel")
		ListLabel:SetSize(250, 100)
		ListLabel:SetText(v.Name .. "\n" .. v.Desc)
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
