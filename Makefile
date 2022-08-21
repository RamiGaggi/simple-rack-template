.PHONY: check
check: test lint

.PHONY: test
test:
	bundle exec ruby app_test.rb

.PHONY: lint
lint:
	bundle exec rubocop

.PHONY: run-server
run-server:
	bundle exec puma
