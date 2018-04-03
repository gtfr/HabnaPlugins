-- Anniversary Token.lua
-- Written by ShoeMaker


_G.LAT = {}; -- Anniversary Token table in _G

--**v Control of Anniversary Token v**
LAT["Ctr"] = Turbine.UI.Control();
LAT["Ctr"]:SetParent( TB["win"] );
LAT["Ctr"]:SetMouseVisible( false );
LAT["Ctr"]:SetZOrder( 2 );
LAT["Ctr"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
LAT["Ctr"]:SetBackColor( Turbine.UI.Color( LATbcAlpha, LATbcRed, LATbcGreen, LATbcBlue ) );
--**^
--**v Anniversary Token & icon on TitanBar v**
LAT["Icon"] = Turbine.UI.Control();
LAT["Icon"]:SetParent( LAT["Ctr"] );
LAT["Icon"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
LAT["Icon"]:SetSize( 32, 32 );
LAT["Icon"]:SetBackground( WalletItem.AnniversaryToken.Icon );-- in-game icon 32x32
--**^

LAT["Icon"].MouseMove = function( sender, args )
	LAT["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then MoveLATCtr(sender, args); end
end

LAT["Icon"].MouseLeave = function( sender, args )
	LAT["Lbl"].MouseLeave( sender, args );
end

LAT["Icon"].MouseClick = function( sender, args )
	LAT["Lbl"].MouseClick( sender, args );
end

LAT["Icon"].MouseDown = function( sender, args )
	LAT["Lbl"].MouseDown( sender, args );
end

LAT["Icon"].MouseUp = function( sender, args )
	LAT["Lbl"].MouseUp( sender, args );
end


LAT["Lbl"] = Turbine.UI.Label();
LAT["Lbl"]:SetParent( LAT["Ctr"] );
LAT["Lbl"]:SetFont( _G.TBFont );
LAT["Lbl"]:SetPosition( 0, 0 );
LAT["Lbl"]:SetFontStyle( Turbine.UI.FontStyle.Outline );
LAT["Lbl"]:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );

LAT["Lbl"].MouseMove = function( sender, args )
	LAT["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then
		MoveLATCtr(sender, args);
	else
		ShowToolTipWin( "LAT" );
	end
end

LAT["Lbl"].MouseLeave = function( sender, args )
	ResetToolTipWin();
end

LAT["Lbl"].MouseClick = function( sender, args )
	TB["win"].MouseMove();
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		if not WasDrag then
			
		end
	elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
		_G.sFromCtr = "LAT";
		ControlMenu:ShowMenu();
	end
	WasDrag = false;
end

LAT["Lbl"].MouseDown = function( sender, args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		LAT["Ctr"]:SetZOrder( 3 );
		dragStartX = args.X;
		dragStartY = args.Y;
		dragging = true;
	end
end

LAT["Lbl"].MouseUp = function( sender, args )
	LAT["Ctr"]:SetZOrder( 2 );
	dragging = false;
	_G.LATLocX = LAT["Ctr"]:GetLeft();
	settings.AnniversaryToken.X = string.format("%.0f", _G.LATLocX);
	_G.LATLocY = LAT["Ctr"]:GetTop();
	settings.AnniversaryToken.Y = string.format("%.0f", _G.LATLocY);
	SaveSettings( false );
end
--**^

function MoveLATCtr(sender, args)
	local CtrLocX = LAT["Ctr"]:GetLeft();
	local CtrWidth = LAT["Ctr"]:GetWidth();
	CtrLocX = CtrLocX + ( args.X - dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = LAT["Ctr"]:GetTop();
	local CtrHeight = LAT["Ctr"]:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - dragStartY );
	if CtrLocY < 0 then CtrLocY = 0; elseif CtrLocY + CtrHeight > TB["win"]:GetHeight() then CtrLocY = TB["win"]:GetHeight() - CtrHeight; end

	LAT["Ctr"]:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end