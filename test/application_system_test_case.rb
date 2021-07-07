require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  if ENV['SELENIUM_HOST']
    Capybara.register_driver :headless_chrome do |app|
      capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
        chromeOptions: { args: %w(--no-sandbox --headless --disable-gpu --disable-dev-shm-usage --start-maximized --disable-extensions) }
      )

      puts("REMOTE URL [http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub]")

      Capybara::Selenium::Driver.new app,
        url: "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub",
        browser: :remote,
        desired_capabilities: capabilities
    end
    driven_by :headless_chrome
  else
    driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
  end

  setup do
    if ENV['TEST_APP_HOST']
      Capybara.run_server = false
      # Capybara.server_host = '0.0.0.0'
      # Capybara.server_port = ENV['TEST_APP_PORT'].to_i
      Capybara.app_host = "http://#{ENV['TEST_APP_HOST']}:#{ENV['TEST_APP_PORT']}"

      puts("APP URL [http://#{ENV['TEST_APP_HOST']}:#{ENV['TEST_APP_PORT']}]")
    end
  end
end
