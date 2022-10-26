module Mouse

def self.update
    return false unless @enabled
    @window_loc = WINX.call(0,0,"RGSS PLAYER",0)
    rect = '0000000000000000'
    cursor_pos = '00000000'
    WREC.call(@window_loc, rect)
    
    #--------------------------------------------------
    #Doc Edit: get addition data for window
    #--------------------------------------------------
    side, top, side_end, top_end = rect.unpack("llll")
    
    CPOS.call(cursor_pos)
    @m_x, @m_y = cursor_pos.unpack("ll")
    w_x = side + SMET.call(5) + SMET.call(45)
    w_y = top + SMET.call(6) + SMET.call(46) + SMET.call(4)
    @m_x -= w_x; @m_y -= w_y
    
    # Old formul:
	#@m_x = [[@m_x, 0].max,Graphics.width].min
	#@m_y = [[@m_y, 0].max,Graphics.height].min
	
	#--------------------------------------------------
	# New formul (most sync. and smothly):
	#--------------------------------------------------
	if Graphics.fullscreen?
		scr_w = SMET.call(0);
		scr_h = SMET.call(1);
	else
		scr_w = side_end - side;
		scr_h = top_end - top - 24;
	end
	
	if @m_x < 0
		@m_x = 0;
	elsif @m_x > (scr_w-1)
		@m_x = (scr_w-1);
	end
	@m_x += 0.0;
	@m_x = (@m_x / scr_w) * 100;
	@m_x = ((Graphics.width * @m_x) / 100).to_i;

	if @m_y < 0
		@m_y = 0;
	elsif @m_y > (scr_h-1)
		@m_y = (scr_h-1);
	end
	@m_y += 0.0;
	@m_y = (@m_y / scr_h) * 100;
	@m_y = ((Graphics.height * @m_y) / 100).to_i;

    self.UpdateIdle
    return true
end

end