# frozen_string_literal: true

require "application_system_test_case"

class ImagesTest < ApplicationSystemTestCase
  setup do
    #
  end

  test "visiting the welcome page" do
    visit root_path
    assert_selector "h1", text: "Hello World!"
  end
end