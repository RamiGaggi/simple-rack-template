# frozen_string_literal: true

require "rack/handler/puma"

class App
  ROUTES = {
    "/" => "This is root!"
  }.freeze

  def self.config
    case ENV.fetch("ENV", nil)
    when "production"
      { environment: ENV.fetch("ENV"),
        Host:        ENV.fetch("HOST"),
        Port:        ENV.fetch("PORT"),
        Thread:      ENV.fetch("THREADS") }
    when "test"
      { environment: "test",
        Host:        "0.0.0.0",
        Port:        3001,
        Thread:      "0:5" }
    else
      { environment: "development",
        Host:        "0.0.0.0",
        Port:        3001,
        Thread:      "0:5" }
    end
  end

  def call(env)
    path = env["PATH_INFO"]
    content = ROUTES[path]
    if content
      status = 200
      body = [content]
    else
      status = 404
      body = ["Not Found"]
    end
    headers = { "Content-Type" => "text/plain" }
    [status, headers, body]
  end
end

Rack::Handler::Puma.run(App.new, **App.config) if __FILE__ == $PROGRAM_NAME
