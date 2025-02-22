.PHONY: check


check:
	mix format --check-formatted
	mix test
	mix dialyzer
	mix credo --strict
	MIX_ENV=mutation mix muzak --min-coverage 95.0
	MIX_ENV=test mix coveralls
