class Scene_Load < Scene_File
  
    #Inject original method
    alias_method :onStatsLoad, :on_load_success
    def on_load_success
        onStatsLoad;
        import(Z_MOD_NAME, "src/event/LoadStoryStats.rb");
	end
end