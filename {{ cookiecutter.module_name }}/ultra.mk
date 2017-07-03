# Some cross-platform makefile utilities
# See https://github.com/Potato42/python-makefile-cc

ifeq ($(OS), Windows_NT)
	canonicalize = $(subst /,\,$1)
	# rmdir thinks that '/'s mean flags, so we need to convert to the
	# canonical windows '\' path separator.
	recrm = rmdir /S/Q $(call canonicalize,$1)
	NULL := nul
	PYTHON2 := py -2
	PYTHON3 := py -3
else
	canonicalize = $1
	recrm = rm -rf $1
	NULL := /dev/null
	PYTHON2 := python2
	PYTHON3 := python3
endif

# $(call walk,top): Recursively list all files in a directory.
# Returns a whitespace separated list of files
walk = $(foreach file,$(wildcard $1/*),$(file) $(call walk,$(file)))

# $(call recsearch,top,pattern): %-patterns, NOT GLOB PATTERNS!
# Returns a whitespace separated list of files matching `pattern`
recsearch = $(filter $2,$(call walk,$1))

# $(call fromcli,variable): `variable` defined as command line argument?
# Returns "command line" for variables defined from the command line, ""
# otherwise.
fromcli = $(findstring command line,$(origin $1))

# $(call not,condition): Logical negation of string emptiness
# Mostly just for readability purposes, returns "true" for empty
# strings, "" otherwise.
not = $(if $1,,true)

# $(call andeq,string1,string2): Test if strings are equal and non-empty
# Returns string2 if both strings are equal and not empty, "" otherwise.
andeq = $(and $(findstring $1,$2),$(findstring $2,$1))

# $(call eq,string1,string2): Test if strings are equal
# Returns "true" if the two strings are equal, "" otherwise.
eq = $(if $(or $1,$2),$(if $(call andeq,$1,$2),true),true)
