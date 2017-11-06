-- Patching ListBox control to repair SSG's Update 21.2 damage.
-- http://www.lotrointerface.com/downloads/info996-ListBoxpatch.html
-- http://www.lotrointerface.com/forums/member.php?action=getinfo&userid=7095

function Turbine.UI.ListBox:SetMaxItemsPerLine(items)
    self.maxItemsPerLine = items;
    if (self:GetOrientation() == Turbine.UI.Orientation.Horizontal) then
        self:SetMaxRows(2147483647); -- infinity
        self:SetMaxColumns(items);
    else
        self:SetMaxRows(items);
        self:SetMaxColumns(2147483647); -- infinity
    end
end
local Original_SetOrientation = Turbine.UI.ListBox.SetOrientation;
function Turbine.UI.ListBox:SetOrientation(orientation)
    Original_SetOrientation(self, orientation);
    if (self.maxItemsPerLine) then
        -- backward compatibility mode
        self:SetMaxItemsPerLine(self.maxItemsPerLine);
    end
end
