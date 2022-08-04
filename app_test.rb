# frozen_string_literal: true

require "minitest/autorun"
require "rack/test"
require_relative "app"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    App.new
  end

  def test_root
    get "/"
    assert_predicate(last_response, :ok?)
    assert_equal "This is root!", last_response.body
  end
end
