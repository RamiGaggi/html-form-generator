console:
	@bundle exec bin/console;

install:
	@bundle config set --local path .bundle && bundle install;

test:
	@bundle exec rspec;

lint:
	@bundle exec rubocop;

rake:
	@bundle exec rake;