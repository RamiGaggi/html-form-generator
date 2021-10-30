console:
	@bundle exec bin/console;

install:
	@bundle exec bin/setup;

test:
	@bundle exec rspec;

lint:
	@bundle exec rubocop;

rake:
	@bundle exec rake;