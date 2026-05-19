# Pattern rule: Compile SQLRPGLE Service program directly from source
# The order-only prerequisite (|) ensures the prototype file exists before compilation
# but changes to the prototype won't trigger recompilation (use normal prerequisite if you want that)

ADDNUM.SRVPGM: ADDNUM.sqlrpgle | QPROTOTYPE/ADDNUM.rpgleinc
	$(MODULE_VARIABLES)	
	$(eval crtcmd := crtsqlrpgi obj($(call ESCAPE_FOR_RECIPE,$(OBJLIB))/$(basename $(@F))) srcstmf('$<') $(CRTSQLRPGIFLAGS))
	@$(PRESETUP) \
	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" "$(crtcmd)" "$(PRECMD)" "$(POSTCMD)" "$(notdir $@)" "$<" "$(logFile)"> $(logFile) 2>&1 && $(call logSuccess,$@) || $(call logFail,$@)
	$(SRVPGM_VARIABLES)
	$(eval crtcmd := CRTSRVPGM SRVPGM($(call ESCAPE_FOR_RECIPE,$(OBJLIB))/$(basename $(@F))) EXPORT(*ALL) OPTION(*DUPPROC *DUPVAR) TEXT(*MODULE))
	@$(PRESETUP) \
	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" "$(crtcmd)" "$(PRECMD)" "$(POSTCMD)" "$(notdir $@)" "$<" "$(logFile)"> $(logFile) 2>&1 && $(call logSuccess,$@) || $(call logFail,$@)
	@$(call EVFEVENT_DOWNLOAD,$(notdir $<).evfevent)