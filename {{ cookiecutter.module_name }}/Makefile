include ultra.mk

{% set has_run = cookiecutter.runnable.lower().startswith('y') -%}
{% if has_run -%}
MAIN_MODULE := {{ cookiecutter.module_name }}
{% endif -%}
REQUIREMENTS := development
PYTHON := $(PYTHON{{ cookiecutter.python_version.split('.')[0] }})
VENV := .venv

# Python 2 prints versions to stderr, so instead of simply checking to
# see if there is stdout, we use && to check the error code.
PYVERSION = $(or $(shell $(PYTHON) --version > $(NULL) 2>&1 && \
                         $(PYTHON) --version 2>&1),\
                 INVALID PYTHON!)

ifeq ($(VIRTUAL_ENV), $(call canonicalize,$(abspath $(VENV))))
	# If we are already inside this venv, no prefix is needed to run
	# venv commands.
	INVE :=
else
	# Otherwise, use vex.
	INVE := vex --path $(VENV)
endif

########################################################################

help: ; @: 
	$(info Quick reference of useful make commands:)
	$(info make init                 Initialize venv with $(PYTHON))
	$(info $()                          NOTE: $(PYTHON) is $(PYVERSION))
	$(info make init PYTHON=pythonX  Initialize venv with pythonX)
	{% if has_run -%}
	$(info make run                  Run $(MAIN_MODULE))
	{% endif -%}
	$(info make test                 Run unit tests)
	$(info make shell                Start a venv shell)
	$(info make clean                Delete venv and cache files)

# The '|' denotes that _inve is an order-only prerequisite: just because
# _inve runs doesn't mean $(VENV) needs to be updated.
init $(VENV): | _inve
	$(if $(call not,$(call fromcli,PYTHON)),\
        $(warning WARNING: No Python specified for venv, \
                  using "PYTHON=$(PYTHON)"...))
	$(info Creating $(abspath $(VENV)) ($(PYVERSION)))
	$(PYTHON) -m venv "$(VENV)"
	$(INVE) pip install -r "requirements/$(REQUIREMENTS).pip"
.PHONY: init

# Ensure the $(INVE) command exists, installing vex if needed
_inve:
	$(if $(call eq,vex,$(firstword $(INVE))),\
        @vex --version > $(NULL) || $(PYTHON) -m pip install vex)
.PHONY: _inve

# Ensure the $(INVE) command is usable (has venv)
inve: _inve $(VENV)
.PHONY: inve

shell dev: inve
	$(INVE)
.PHONY: shell dev

{% if has_run -%}
run: inve
	$(INVE) python -m "$(MAIN_MODULE)"
.PHONY: run

{% endif -%}
test: inve
	$(error TODO: implement tests!)
.PHONY: test

clean deinit:
	-$(call recrm,.venv)
	-$(call recrm,$(wildcard *.egg-info))
	-$(call recrm,$(call recsearch,.,%/__pycache__))
.PHONY: clean deinit
