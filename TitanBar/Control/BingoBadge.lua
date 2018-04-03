-- BingoBadges.lua
-- Written by ShoeMaker


_G.BB = {}; -- Bingo Badge table in _G

--**v Control of Bingo Badges v**
BB["Ctr"] = Turbine.UI.Control();
BB["Ctr"]:SetParent( TB["win"] );
BB["Ctr"]:SetMouseVisible( false );
BB["Ctr"]:SetZOrder( 2 );
BB["Ctr"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
BB["Ctr"]:SetBackColor( Turbine.UI.Color( BBbcAlpha, BBbcRed, BBbcGreen, BBbcBlue ) );
--**^
--**v Bingo Badge & icon on TitanBar v**
BB["Icon"] = Turbine.UI.Control();
BB["Icon"]:SetParent( BB["Ctr"] );
BB["Icon"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
BB["Icon"]:SetSize( 32, 32 );
BB["Icon"]:SetBackground( WalletItem.BingoBadge.Icon );-- in-game icon 32x32
--**^

BB["Icon"].MouseMove = function( sender, args )
	BB["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then MoveBBCtr(sender, args); end
end

BB["Icon"].MouseLeave = function( sender, args )
	BB["Lbl"].MouseLeave( sender, args );
end

BB["Icon"].MouseClick = function( sender, args )
	BB["Lbl"].MouseClick( sender, args );
end

BB["Icon"].MouseDown = function( sender, args )
	BB["Lbl"].MouseDown( sender, args );
end

BB["Icon"].MouseUp = function( sender, args )
	BB["Lbl"].MouseUp( sender, args );
end


BB["Lbl"] = Turbine.UI.Label();
BB["Lbl"]:SetParent( BB["Ctr"] );
BB["Lbl"]:SetFont( _G.TBFont );
BB["Lbl"]:SetPosition( 0, 0 );
BB["Lbl"]:SetFontStyle( Turbine.UI.FontStyle.Outline );
BB["Lbl"]:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );

BB["Lbl"].MouseMove = function( sender, args )
	BB["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then
		MoveBBCtr(sender, args);
	else
		ShowToolTipWin( "BB" );
	end
end

BB["Lbl"].MouseLeave = function( sender, args )
	ResetToolTipWin();
end

BB["Lbl"].MouseClick = function( sender, args )
	TB["win"].MouseMove();
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		if not WasDrag then
			
		end
	elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
		_G.sFromCtr = "BB";
		ControlMenu:ShowMenu();
	end
	WasDrag = false;
end

BB["Lbl"].MouseDown = function( sender, args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		BB["Ctr"]:SetZOrder( 3 );
		dragStartX = args.X;
		dragStartY = args.Y;
		dragging = true;
	end
end

BB["Lbl"].MouseUp = function( sender, args )
	BB["Ctr"]:SetZOrder( 2 );
	dragging = false;
	_G.BBLocX = BB["Ctr"]:GetLeft();
	settings.BingoBadge.X = string.format("%.0f", _G.BBLocX);
	_G.BBLocY = BB["Ctr"]:GetTop();
	settings.BingoBadge.Y = string.format("%.0f", _G.BBLocY);
	SaveSettings( false );
end
--**^

function MoveBBCtr(sender, args)
	local CtrLocX = BB["Ctr"]:GetLeft();
	local CtrWidth = BB["Ctr"]:GetWidth();
	CtrLocX = CtrLocX + ( args.X - dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = BB["Ctr"]:GetTop();
	local CtrHeight = BB["Ctr"]:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - dragStartY );
	if CtrLocY < 0 then CtrLocY = 0; elseif CtrLocY + CtrHeight > TB["win"]:GetHeight() then CtrLocY = TB["win"]:GetHeight() - CtrHeight; end

	BB["Ctr"]:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end