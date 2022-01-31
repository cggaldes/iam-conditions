# VARIABLES =================================
# ===========================================
VARIABLE_1?=123

# FUNCTIONS =================================
# ===========================================
help: help.variables help.available_functions

help.available_functions: ## Help Function
	@echo "==== Available Functions"
	@IFS=$$'\n' ; \
	help_lines=(`fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//'`); \
	for help_line in $${help_lines[@]}; do \
		IFS=$$'#' ; \
		help_split=($$help_line) ; \
		help_command=`echo $${help_split[0]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		help_info=`echo $${help_split[2]} | sed -e 's/^ *//' -e 's/ *$$//'` ; \
		printf "%-30s %s\n" $$help_command $$help_info ; \
	done

help.variables:
	@echo "==== Variables"
	@echo ${VARIABLE_1}

base_function.function_1: ## Base Function 1
	@echo "Base Function 2"

base_function.function_2: ## Base Function 2
	@echo "Base Function 2"

include src/terraform/*.mk