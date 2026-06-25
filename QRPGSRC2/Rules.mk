# The order-only prerequisite (|) ensures the prototype file exists before compilation
# but changes to the prototype won't trigger recompilation
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

# IBMi Tobi doesn't seem to expand patterns/wildcards on dependencies/prerequisites
# %.SRVPGM: %.sqlrpgle | QPROTOTYPE/%.rpgleinc)
# 	$(MODULE_VARIABLES)	
# 	$(eval crtcmd := crtsqlrpgi obj($(call ESCAPE_FOR_RECIPE,$(OBJLIB))/$(basename $(@F))) srcstmf('$<') $(CRTSQLRPGIFLAGS))
# 	@$(PRESETUP) \
# 	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" "$(crtcmd)" "$(PRECMD)" "$(POSTCMD)" "$(notdir $@)" "$<" "$(logFile)"> $(logFile) 2>&1 && $(call logSuccess,$@) || $(call logFail,$@)
# 	$(SRVPGM_VARIABLES)
# 	$(eval crtcmd := CRTSRVPGM SRVPGM($(call ESCAPE_FOR_RECIPE,$(OBJLIB))/$(basename $(@F))) EXPORT(*ALL) OPTION(*DUPPROC *DUPVAR) TEXT(*MODULE))
# 	@$(PRESETUP) \
# 	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" "$(crtcmd)" "$(PRECMD)" "$(POSTCMD)" "$(notdir $@)" "$<" "$(logFile)"> $(logFile) 2>&1 && $(call logSuccess,$@) || $(call logFail,$@)
# 	@$(call EVFEVENT_DOWNLOAD,$(notdir $<).evfevent)