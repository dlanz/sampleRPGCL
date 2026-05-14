# Binder source rules for service programs
# The binder source defines which procedures are exported from the service program

PROJECT_BNDDIR := INABIND1
PROJECT_OPTION := *DUPPROC *DUPVAR

ADDNUM.SRVPGM: private BNDDIR := $(PROJECT_BNDDIR)
ADDNUM.SRVPGM: private OPTION := $(PROJECT_OPTION)

SUBNUM.SRVPGM: private BNDDIR := $(PROJECT_BNDDIR)
SUBNUM.SRVPGM: private OPTION := $(PROJECT_OPTION)

DIVNUM.SRVPGM: private BNDDIR := $(PROJECT_BNDDIR)
DIVNUM.SRVPGM: private OPTION := $(PROJECT_OPTION)

MULTNUM.SRVPGM: private BNDDIR := $(PROJECT_BNDDIR)
MULTNUM.SRVPGM: private OPTION := $(PROJECT_OPTION)

OP_SRCH.SRVPGM: private BNDDIR := $(PROJECT_BNDDIR)
OP_SRCH.SRVPGM: private OPTION := $(PROJECT_OPTION)


# Pattern rule: Create service program from binder source and module
# Normal prerequisites: BND and MODULE files (changes trigger rebuild)
# Order-only prerequisite: matching QPROTOTYPE file (must exist, but changes don't trigger rebuild)
# ADDNUM.SRVPGM: ADDNUM.BND ADDNUM.MODULE
ADDNUM.SRVPGM: ADDNUM.BND ADDNUM.MODULE
SUBNUM.SRVPGM: SUBNUM.BND SUBNUM.MODULE
DIVNUM.SRVPGM: DIVNUM.BND DIVNUM.MODULE
MULTNUM.SRVPGM: MULTNUM.BND MULTNUM.MODULE
OP_SRCH.SRVPGM: OP_SRCH.BND OP_SRCH.MODULE
