# commands

## Create the application

rails _5.2.6_ new docker_compose_test_system_rails_5 \
  --skip-action-mailer \
  --skip-active-record \
  --skip-active-storage \
  --skip-action-cable \
  --skip-sprockets \
  --skip-spring \
  --skip-listen \
  --skip-coffee \
  --skip-javascript \
  --skip-turbolinks \
  --skip-bootsnap

## Set up the environment

cd docker_compose_test_system_rails_5
touch PRIVATE_NOTES.md
asdf local ruby 2.7.3
git add . && git commit -m 'Initial Commit'
bin/bundle install

# Test is working
bin/rails server -p 3008 --early-hints -b 0.0.0.0
bin/rails test
bin/rails test:system

# Get the code

cd ~/wherever-you-want
git clone git@github.com:joel/dctsr5.git
gh repo clone joel/dctsr5

# Start Services

docker compose up start-and-wait-for-services-to-be-up

docker compose logs --follow

docker-compose exec -T web bash -c "RAILS_ENV=test bin/rails test:system"

bin/docker-compose-teardown

# Other commands

docker compose exec web bin/rails test:system

RAILS_ENV=test SELENIUM_HOST=127.0.0.1 SELENIUM_PORT=4444 TEST_APP_HOST=127.0.0.1 TEST_APP_PORT=3001 bin/rails test:system
