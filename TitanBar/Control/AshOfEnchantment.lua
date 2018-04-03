-- Ash of Gorgoroth.lua
-- Written by Kaische


_G.AOE = {};

--**v Control of Ash of Gorgoroth v**
AOE["Ctr"] = Turbine.UI.Control();
AOE["Ctr"]:SetParent( TB["win"] );
AOE["Ctr"]:SetMouseVisible( false );
AOE["Ctr"]:SetZOrder( 2 );
AOE["Ctr"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
AOE["Ctr"]:SetBackColor( Turbine.UI.Color( AOEbcAlpha, AOEbcRed, AOEbcGreen, AOEbcBlue ) );
--**^
--**v Ash of Gorgoroth & icon on TitanBar v**
AOE["Icon"] = Turbine.UI.Control();
AOE["Icon"]:SetParent( AOE["Ctr"] );
AOE["Icon"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
AOE["Icon"]:SetSize( 32, 32 );
AOE["Icon"]:SetBackground( WalletItem.AshOfEnchantment.Icon );-- in-game icon 32x32
--**^

AOE["Icon"].MouseMove = function( sender, args )
	AOE["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then MoveAOECtr(sender, args); end
end

AOE["Icon"].MouseLeave = function( sender, args )
	AOE["Lbl"].MouseLeave( sender, args );
end

AOE["Icon"].MouseClick = function( sender, args )
	AOE["Lbl"].MouseClick( sender, args );
end

AOE["Icon"].MouseDown = function( sender, args )
	AOE["Lbl"].MouseDown( sender, args );
end

AOE["Icon"].MouseUp = function( sender, args )
	AOE["Lbl"].MouseUp( sender, args );
end


AOE["Lbl"] = Turbine.UI.Label();
AOE["Lbl"]:SetParent( AOE["Ctr"] );
AOE["Lbl"]:SetFont( _G.TBFont );
AOE["Lbl"]:SetPosition( 0, 0 );
AOE["Lbl"]:SetFontStyle( Turbine.UI.FontStyle.Outline );
AOE["Lbl"]:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );

AOE["Lbl"].MouseMove = function( sender, args )
	AOE["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then
		MoveAOECtr(sender, args);
	else
		ShowToolTipWin( "AOE" );
	end
end

AOE["Lbl"].MouseLeave = function( sender, args )
	ResetToolTipWin();
end

AOE["Lbl"].MouseClick = function( sender, args )
	TB["win"].MouseMove();
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		if not WasDrag then
			
		end
	elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
		_G.sFroAOEtr = "AOE";
		ControlMenu:ShowMenu();
	end
	WasDrag = false;
end

AOE["Lbl"].MouseDown = function( sender, args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		AOE["Ctr"]:SetZOrder( 3 );
		dragStartX = args.X;
		dragStartY = args.Y;
		dragging = true;
	end
end

AOE["Lbl"].MouseUp = function( sender, args )
	AOE["Ctr"]:SetZOrder( 2 );
	dragging = false;
	_G.AOELocX = AOE["Ctr"]:GetLeft();
	settings.AshOfEnchantment.X = string.format("%.0f", _G.AOELocX);
	_G.AOELocY = AOE["Ctr"]:GetTop();
	settings.AshOfEnchantment.Y = string.format("%.0f", _G.AOELocY);
	SaveSettings( false );
end
--**^

function MoveAOECtr(sender, args)
	local CtrLocX = AOE["Ctr"]:GetLeft();
	local CtrWidth = AOE["Ctr"]:GetWidth();
	CtrLocX = CtrLocX + ( args.X - dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = AOE["Ctr"]:GetTop();
	local CtrHeight = AOE["Ctr"]:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - dragStartY );
	if CtrLocY < 0 then CtrLocY = 0; elseif CtrLocY + CtrHeight > TB["win"]:GetHeight() then CtrLocY = TB["win"]:GetHeight() - CtrHeight; end

	AOE["Ctr"]:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end