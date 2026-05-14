# QPROTOTYPE Rules.mk
# This directory contains RPG include files (.rpgleinc) that don't need compilation
# They are used as order-only prerequisites by other build targets

# List all prototype/include files in this directory
# PROTOTYPE_FILES := $(wildcard QPROTOTYPE/*.rpgleinc)

# Export this variable so it can be used by other Rules.mk files
# export PROTOTYPE_FILES

# No build rules needed - these files are source files only and should not be compiled
# They will be checked for existence via order-only prerequisites in other directories