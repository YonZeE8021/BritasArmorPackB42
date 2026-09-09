local attachedLocations = rawget(_G, "AttachedLocations")
if not (attachedLocations and attachedLocations.getGroup) then
	return
end

local group = attachedLocations.getGroup("Human")
if group then
	group:getOrCreateLocation("NVFrameworkLight"):setAttachmentName("knife_head")
end