-- Yule Tokens.lua


_G.YT = {}; -- Yule Token table in _G

--**v Control of Yule Token v**
YT["Ctr"] = Turbine.UI.Control();
YT["Ctr"]:SetParent( TB["win"] );
YT["Ctr"]:SetMouseVisible( false );
YT["Ctr"]:SetZOrder( 2 );
YT["Ctr"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
YT["Ctr"]:SetBackColor( Turbine.UI.Color( YTbcAlpha, YTbcRed, YTbcGreen, YTbcBlue ) );
--SM["Ctr"]:SetBackColor( Color["red"] ); -- Debug purpose
--**^
--**v Yule Token & icon on TitanBar v**
YT["Icon"] = Turbine.UI.Control();
YT["Icon"]:SetParent( YT["Ctr"] );
YT["Icon"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
YT["Icon"]:SetSize( 32, 32 );
YT["Icon"]:SetBackground( 0x411348E1 );-- in-game icon 32x32-- CURRENTLY MITHRIL COIN ICON --- NEED TO FIND YULE TOKEN ID
--SM["Icon"]:SetBackColor( Color["blue"] ); -- Debug purpose

YT["Icon"].MouseMove = function( sender, args )
	YT["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then MoveYTCtr(sender, args); end
end

YT["Icon"].MouseLeave = function( sender, args )
	YT["Lbl"].MouseLeave( sender, args );
end

YT["Icon"].MouseClick = function( sender, args )
	YT["Lbl"].MouseClick( sender, args );
end

YT["Icon"].MouseDown = function( sender, args )
	YT["Lbl"].MouseDown( sender, args );
end

YT["Icon"].MouseUp = function( sender, args )
	YT["Lbl"].MouseUp( sender, args );
end


YT["Lbl"] = Turbine.UI.Label();
YT["Lbl"]:SetParent( YT["Ctr"] );
YT["Lbl"]:SetFont( _G.TBFont );
YT["Lbl"]:SetPosition( 0, 0 );
YT["Lbl"]:SetFontStyle( Turbine.UI.FontStyle.Outline );
YT["Lbl"]:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );

YT["Lbl"].MouseMove = function( sender, args )
	YT["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then
		MoveYTCtr(sender, args);
	else
		ShowToolTipWin( "YT" );
	end
end

YT["Lbl"].MouseLeave = function( sender, args )
	ResetToolTipWin();
end

YT["Lbl"].MouseClick = function( sender, args )
	TB["win"].MouseMove();
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		if not WasDrag then
			
		end
	elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
		_G.sFromCtr = "YT";
		ControlMenu:ShowMenu();
	end
	WasDrag = false;
end

YT["Lbl"].MouseDown = function( sender, args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		YT["Ctr"]:SetZOrder( 3 );
		dragStartX = args.X;
		dragStartY = args.Y;
		dragging = true;
	end
end

YT["Lbl"].MouseUp = function( sender, args )
	YT["Ctr"]:SetZOrder( 2 );
	dragging = false;
	_G.YTLocX = YT["Ctr"]:GetLeft();
	settings.YuleTokens.X = string.format("%.0f", _G.YTLocX);
	_G.YTLocY = YT["Ctr"]:GetTop();
	settings.YuleTokens.Y = string.format("%.0f", _G.YTLocY);
	SaveSettings( false );
end
--**^

function MoveYTCtr(sender, args)
	local CtrLocX = YT["Ctr"]:GetLeft();
	local CtrWidth = YT["Ctr"]:GetWidth();
	CtrLocX = CtrLocX + ( args.X - dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = YT["Ctr"]:GetTop();
	local CtrHeight = YT["Ctr"]:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - dragStartY );
	if CtrLocY < 0 then CtrLocY = 0; elseif CtrLocY + CtrHeight > TB["win"]:GetHeight() then CtrLocY = TB["win"]:GetHeight() - CtrHeight; end

	YT["Ctr"]:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end