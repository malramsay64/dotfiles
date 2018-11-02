#
# %FILE%
# %USER%, %FDATE%
#

.DEFAULT_GOAL := help

.PHONY: test
test:  ## Run the test cases

# This allows for the documentation of all the functions in the Makefile, which is
# displayed when runnning `make`. To document a rule, add ## <help text> after the rule.
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# vim:ft=make
#
