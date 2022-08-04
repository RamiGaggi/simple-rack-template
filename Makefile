.PHONY: check
check: test lint

.PHONY: test
test:
	ENV=test bundle exec ruby app_test.rb

.PHONY: lint
lint:
	ENV=test bundle exec rubocop
