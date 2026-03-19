
BIN_LIB=CMPSYS
LIBLIST=$(BIN_LIB)
SHELL=/QOpenSys/usr/bin/qsh

all: calc1cl.pgm.clle helloworld.pgm.sqlrpgle

## Targets

calc1cl.pgm.clle: calc1.pgm.sqlrpgle
calc1.pgm.sqlrpgle: divnum.sqlrpgle multnum.sqlrpgle addnum.sqlrpgle subnum.sqlrpgle calc1fm.dspf op_srch.sqlrpgle
op_srch.sqlrpgle: operations.table op_srchfm.dspf

## Rules

%.pgm.sqlrpgle: QRPGSRC/%.pgm.sqlrpgle
	system -s "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/$*) SRCSTMF('$<') COMMIT(*NONE) DBGVIEW(*SOURCE) OPTION(*EVENTF) COMPILEOPT('INCDIR(''QPROTOTYPE'')') REPLACE(*YES)"

%.sqlrpgle: QRPGSRC/%.sqlrpgle
	system -s "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTSQLRPGI OBJ($(BIN_LIB)/$*) SRCSTMF('$<') OBJTYPE(*MODULE) REPLACE(*YES) CLOSQLCSR(*ENDMOD) OPTION(*EVENTF) DBGVIEW(*SOURCE) TGTRLS(*CURRENT) CVTCCSID(*JOB) COMPILEOPT('INCDIR(''QPROTOTYPE'')')"
	system "CRTSRVPGM SRVPGM($(BIN_LIB)/$*) EXPORT(*ALL) TEXT(*MODULE) OPTION(*DUPPROC *DUPVAR)"

%.dspf:
	-system -qi "CRTSRCPF FILE($(BIN_LIB)/QDDSSRC) RCDLEN(112)"
	system "CPYFRMSTMF FROMSTMF('./QDDSSRC/$*.dspf') TOMBR('/QSYS.lib/$(BIN_LIB).lib/QDDSSRC.file/$*.mbr') MBROPT(*REPLACE)"
	system -s "CRTDSPF FILE($(BIN_LIB)/$*) SRCFILE($(BIN_LIB)/QDDSSRC) SRCMBR($*) OPTION(*EVENTF) "

%.table: QDDSSRC/%.table
	liblist -c $(BIN_LIB);\
	system "RUNSQLSTM SRCSTMF('$<') COMMIT(*NONE)"

%.pgm.clle: QCLSRC/%.pgm.clle
	system -s "CHGATR OBJ('$<') ATR(*CCSID) VALUE(1252)"
	liblist -a $(LIBLIST);\
	system "CRTBNDCL PGM($(BIN_LIB)/$*) SRCSTMF('$<') DBGVIEW(*SOURCE) OPTION(*EVENTF) REPLACE(*YES)"