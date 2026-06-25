# The order-only prerequisite (|) ensures the prototype file exists before compilation
# but changes to the prototype won't trigger recompilation
SUBNUM.MODULE: SUBNUM.sqlrpgle | QPROTOTYPE/SUBNUM.rpgleinc
DIVNUM.MODULE: DIVNUM.sqlrpgle | QPROTOTYPE/DIVNUM.rpgleinc
MULTNUM.MODULE: MULTNUM.sqlrpgle | QPROTOTYPE/MULTNUM.rpgleinc
OP_SRCH.MODULE: OP_SRCH.sqlrpgle OP_SRCHFM.FILE | QPROTOTYPE/OP_SRCH.rpgleinc
CALC1.PGM: calc1.pgm.sqlrpgle CALC1FM.FILE OP_SRCH.SRVPGM ADDNUM.SRVPGM SUBNUM.SRVPGM DIVNUM.SRVPGM MULTNUM.SRVPGM

# IBMi Tobi doesn't seem to expand patterns/wildcards on dependencies/prerequisites
# %.MODULE: %.sqlrpgle | QPROTOTYPE/%.rpgleinc