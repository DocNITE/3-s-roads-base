# Init
Z_STORY_STATS.each {|elem| 
    if $story_stats[elem[0]] == 0
        $story_stats[elem[0]] = elem[1];
    end
}
#msgbox "#{$story_stats["3S: VER_INFO"]}"