BIN_LIB=&mycurlib
LIBLIST=$(BIN_LIB)
SHELL=/QOpenSys/usr/bin/qsh

define MY_CUSTOM_SQLRPGLE_RECIPE
	$(MODULE_VARIABLES)
	@echo "Starting custom SQLRPGLE build for $<"
	@$(call echo_cmd,"=== Creating MY CUSTOM SQLRPGLE module [$(notdir $<)]$(ECHOCCSID)")
	$(eval crtcmd := crtsqlrpgi obj($(call ESCAPE_FOR_RECIPE,$(OBJLIB))/$(basename $(@F))) srcstmf('$<') $(CRTSQLRPGIFLAGS) OPTION(*EVENTF *XREF))
	@$(PRESETUP) \
	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" "$(crtcmd)" "$(PRECMD)" "$(POSTCMD)" "$(notdir $@)" "$<" "$(logFile)"> $(logFile) 2>&1 && $(call logSuccess,$@) || $(call logFail,$@)
	@$(call EVFEVENT_DOWNLOAD,$(notdir $<).evfevent)
	@echo "Custom build complete for $@"
endef

define SQLRPGLE_TO_MODULE_RECIPE =
	$(MODULE_VARIABLES)
	@$(call echo_cmd,"=== Creating SQLRPGLE module [$(notdir $<)]$(ECHOCCSID)")
	$(eval crtcmd := crtsqlrpgi obj($(call ESCAPE_FOR_RECIPE,$(OBJLIB))/$(basename $(@F))) srcstmf('$<') $(CRTSQLRPGIFLAGS))
	@$(PRESETUP) \
	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" "$(crtcmd)" "$(PRECMD)" "$(POSTCMD)" "$(notdir $@)" "$<" "$(logFile)"> $(logFile) 2>&1 && $(call logSuccess,$@) || $(call logFail,$@)
	@$(call EVFEVENT_DOWNLOAD,$(notdir $<).evfevent)
endef

ADDNUM.MODULE: ADDNUM.SQLRPGLE
	$(MODULE_VARIABLES)
	@echo "AUT=$(AUT)"
	@echo "DBGVIEW=$(DBGVIEW)"
	@echo "DBGENCKEY=$(DBGENCKEY)"
	@echo "OBJTYPE=$(OBJTYPE)"
	@echo "OPTION=$(OPTION)"
	@echo "OPTIMIZE=$(OPTIMIZE)"
	@echo "INCDIR=$(INCDIR)"
	@echo "RPGPPOPT=$(RPGPPOPT)"
	@echo "STGMDL=$(STGMDL)"
	@echo "SYSIFCOPT=$(SYSIFCOPT)"
	@echo "TERASPACE=$(TERASPACE)"
	@echo "TGTRLS=$(TGTRLS)"
	@echo "USRPRF=$(USRPRF)"
	@echo "ECHOCCSID=$(ECHOCCSID)"
	@echo "JOBLOGFILE=$(JOBLOGFILE)"
	@echo "PRECMD=$(PRECMD)"
	@echo "POSTCMD=$(POSTCMD)"
	@echo "logFile=$(logFile)"
	@echo "TOP=$(TOP)"
	@echo "LOGPATH=$(LOGPATH)"
	@echo "OBJPATH=$(OBJPATH)"
	@$(PRESETUP)
	@echo "curlib=$(curlib)"
	@echo "preUsrlibl=$(preUsrlibl)"
	@echo "postUsrlibl=$(postUsrlibl)"
	@echo "IBMiEnvCmd=$(IBMiEnvCmd)"
	@echo "iasp=$(iasp)"
	@echo "directory=$(directory)"
	@echo "file=$(file)"
	@echo "logFile=$(logFile)"

ADDNUM2.MODULE: ADDNUM2.SQLRPGLE
	@$(call echo_cmd,"=== Creating SQLRPGLE module [$(notdir $<)]$(ECHOCCSID)")
	$(eval crtcmd := crtsqlrpgi obj($(call ESCAPE_FOR_RECIPE,$(OBJLIB))/$(basename $(@F))) srcstmf('$<') $(CRTSQLRPGIFLAGS))
	@echo "crtcmd=$(crtcmd)"
	@$(PRESETUP) \
	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" "$(crtcmd)" "$(PRECMD)" "$(POSTCMD)" "$(notdir $@)" "$<" "$(logFile)"> $(logFile) 2>&1 && $(call logSuccess,$@) || $(call logFail,$@)
	@$(call EVFEVENT_DOWNLOAD,$(notdir $<).evfevent)

ADDNUM3.MODULE: ADDNUM3.SQLRPGLE
	@echo "=== Creating SQLRPGLE module ==="
#  	system -s "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1252)"	
	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" \
	  "CRTSQLRPGI OBJ($(OBJLIB)/ADDNUM) SRCSTMF('$<') OBJTYPE(*MODULE) DBGVIEW(*SOURCE)" \
	  "" "" "$(notdir $@)" "$<" "$(logFile)"
	@$(call EVFEVENT_DOWNLOAD,ADDNUM.SQLRPGLE.evfevent)

# 	echo "=== Creating MY CUSTOM SQLRPGLE module ==="
# 	system -s "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1252)"
# 	liblist -a $(mycurlib);\
# 	system "CRTSQLRPGI OBJ($(OBJLIB)/$(basename $(@F))) SRCSTMF('$<') OBJTYPE(*MODULE) REPLACE(*YES) CLOSQLCSR(*ENDMOD) OPTION(*EVENTF) DBGVIEW(*LIST) TGTRLS(*CURRENT) CVTCCSID(*JOB) COMPILEOPT('INCDIR(''QPROTOTYPE'')')"

#   	system "CRTSRVPGM SRVPGM($(OBJLIB)/$(basename $(@F))) EXPORT(*ALL) TEXT(*MODULE) OPTION(*EVENTF) TGTRLS(*CURRENT)"
# 	system "call EVFEVENT_DOWNLOAD,$(notdir $<).evfevent)"

# 	$(SRVPGM_VARIABLES)
# 	$(eval d = $($@_d))
# 	@$(call echo_cmd,"=== Creating service program [$(tgt)] from modules [$(basename $(filter %.MODULE,$(notdir $^)))] and service programs [$(basename $(filter %.SRVPGM,$(notdir $^$|)))]")
# 	$(eval externalsrvpgms := $(filter %.SRVPGM,$(subst .LIB,,$(subst /QSYS.LIB/,,$|))))
# 	$(eval crtcmd := CRTSRVPGM srcstmf('$<') SRVPGM($(call ESCAPE_FOR_RECIPE,$(OBJLIB))/$(basename $(@F))) MODULE($(basename $(filter %.MODULE,$(notdir $^)))) BNDSRVPGM($(if $(BNDSRVPGMPATH),$(BNDSRVPGMPATH),*NONE)) $(CRTSRVPGMFLAGS))
# 	@$(PRESETUP) \
# 	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" "$(crtcmd)" "$(PRECMD)" "$(POSTCMD)" "$(notdir $@)" "$<" "$(logFile)"> $(logFile) 2>&1 && $(call logSuccess,$@) || $(call logFail,$@)

	
# 	system -s "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1252)"
# 	liblist -a $(LIBLIST);\
# 	system "CRTSQLRPGI OBJ($(BIN_LIB)/$*) SRCSTMF('$<') OBJTYPE(*MODULE) REPLACE(*YES) CLOSQLCSR(*ENDMOD) OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) CVTCCSID(*JOB) COMPILEOPT('INCDIR(''QPROTOTYPE'')')"
# 	system "CRTSRVPGM SRVPGM($(BIN_LIB)/$*) EXPORT(*ALL) TEXT(*MODULE) OPTION(*DUPPROC *DUPVAR)"



# CALC1.PGM: calc1.pgm.sqlrpgle QPROTOTYPE/ddsconst.rpgleinc QPROTOTYPE/addnum.rpgleinc QPROTOTYPE/subnum.rpgleinc QPROTOTYPE/multnum.rpgleinc QPROTOTYPE/divnum.rpgleinc QPROTOTYPE/op_srch.rpgleinc CALC1FM.FILE
# OP_SRCH.PGM: op_srch.pgm.sqlrpgle QPROTOTYPE/op_srch.rpgleinc QPROTOTYPE/ddsconst.rpgleinc OP_SRCHFM.FILE
# %.MODULE: %.sqlrpgle QPROTOTYPE/%.rpgleinc
# 	system -s "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1252)"
# 	liblist -a $(LIBLIST);\
# 	system "CRTSQLRPGI OBJ($(BIN_LIB)/$*) SRCSTMF('$<') OBJTYPE(*MODULE) REPLACE(*YES) CLOSQLCSR(*ENDMOD) OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) CVTCCSID(*JOB) COMPILEOPT('INCDIR(''QPROTOTYPE'')')"
# 	system "CRTSRVPGM SRVPGM($(BIN_LIB)/$*) EXPORT(*ALL) TEXT(*MODULE) OPTION(*DUPPROC *DUPVAR)"
# DIVNUM.MODULE: divnum.sqlrpgle QPROTOTYPE/divnum.rpgleinc
# MULTNUM.MODULE: multnum.sqlrpgle QPROTOTYPE/multnum.rpgleinc
# SUBNUM.MODULE: subnum.sqlrpgle QPROTOTYPE/subnum.rpgleinc

# ADDNUM.MODULE: addnum.sqlrpgle QPROTOTYPE/addnum.rpgleinc
# 	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" "CRTSRVPGM SRVPGM($(OBJLIB)/ADDNUM) SRCSTMF('addnum.sqlrpgle') $(CRTSRVPGMFLAGS)" "$(PRECMD)" "$(POSTCMD)" "ADDNUM.MODULE" "addnum.sqlrpgle" "$(logFile)"


# CRTSBSD.FILE:
# 	system -i "CRTSBSD SBSD(BATCHWL/BATCHSBSD) POOLS((1 *SHRPOOL3 *N *MB))"

# %.sqlrpgle: %.sqlrpgle QPROTOTYPE/%.rpgleinc
# 	@$(call echo_cmd,"=== Custom Command Works [$(notdir $<)]$(ECHOCCSID)")
# 	$(MODULE_VARIABLES)
# 	@$(call echo_cmd,"=== Custom Command Works [$(notdir $<)]$(ECHOCCSID)")

# 	@$(call echo_cmd,"=== Creating SQLRPGLE module [$(notdir $<)]$(ECHOCCSID)")
# 	$(eval crtcmd := crtsqlrpgi obj($(call ESCAPE_FOR_RECIPE,$(OBJLIB))/$(basename $(@F))) srcstmf('$<') $(CRTSQLRPGIFLAGS))
# 	@$(PRESETUP) \
# 	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" "$(crtcmd)" "$(PRECMD)" "$(POSTCMD)" "$(notdir $@)" "$<" "$(logFile)"> $(logFile) 2>&1 && $(call logSuccess,$@) || $(call logFail,$@)
# 	@$(call EVFEVENT_DOWNLOAD,$(notdir $<).evfevent)
# 	$(SRVPGM_VARIABLES)
# 	$(eval d = $($@_d))
# 	@$(call echo_cmd,"=== Creating service program [$(tgt)] from modules [$(basename $(filter %.MODULE,$(notdir $^)))] and service programs [$(basename $(filter %.SRVPGM,$(notdir $^$|)))]")
# 	$(eval externalsrvpgms := $(filter %.SRVPGM,$(subst .LIB,,$(subst /QSYS.LIB/,,$|))))
# 	$(eval crtcmd := CRTSRVPGM srcstmf('$<') SRVPGM($(call ESCAPE_FOR_RECIPE,$(OBJLIB))/$(basename $(@F))) EXPORT(*ALL) $(CRTSRVPGMFLAGS))
# 	@$(PRESETUP) \
# 	$(SCRIPTSPATH)/launch "$(JOBLOGFILE)" "$(crtcmd)" "$(PRECMD)" "$(POSTCMD)" "$(notdir $@)" "$<" "$(logFile)"> $(logFile) 2>&1 && $(call logSuccess,$@) || $(call logFail,$@)