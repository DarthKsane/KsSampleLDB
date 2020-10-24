local _G = getfenv(0)

local MODNAME	= "KsSampleLDB"
local addon = LibStub("AceAddon-3.0"):NewAddon(MODNAME, "AceEvent-3.0")
_G.Broker_ReoriginationArray = addon

local ldb = LibStub:GetLibrary("LibDataBroker-1.1")
local L = LibStub("AceLocale-3.0"):GetLocale(MODNAME)

function addon:OnInitialize()
	self.info = {
		left_text = 0,
		right_text = 0,
	}

	self:RegisterEvent("QUEST_COMPLETE", "UpdateInfo")

	self:UpdateInfo()
	self:MainUpdate()
end


function addon:OnEnable()
	self:UpdateInfo()
end

-- LDB object
addon.obj = ldb:NewDataObject(MODNAME, {
	type = "data source",
	label = "KsSampleLDB",
	text = "Sample text",
	icon = "Interface\\Icons\\inv_scroll_10",
	OnTooltipShow = function(tooltip)
		if not tooltip or not tooltip.AddLine then return end
		tooltip:AddLine(MODNAME.." "..GetAddOnMetadata(MODNAME, "Version"))

		addon:UpdateInfo()
		local p_name = UnitName("player")
		local p_level = UnitLevel("player")
		local p_class, p_eclass = UnitClass("player")
		tooltip:AddDoubleLine(p_name, p_level)
		tooltip:AddDoubleLine(p_class, p_eclass)

		tooltip:AddLine(L["Localization test"])
		tooltip:AddDoubleLine(L["Localization test"], L["Main text"])
		tooltip:AddDoubleLine(addon.info.left_text, addon.info.right_text)
	end,
})



-- Main update function
function addon:MainUpdate()
	self.obj.text =  L["Main text"].." "..(string.format("%d <> %d", self.info.left_text, self.info.right_text))
end


function addon:UpdateInfo()
	self.info.left_text = self.info.left_text +1
	self.info.right_text = self.info.right_text + 2
	self:MainUpdate()
end