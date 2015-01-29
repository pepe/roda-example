$LOAD_PATH.unshift(File.dirname('lib'))

require 'app'
require 'capybara/rspec'

RSpec.configure do |config|
  include Rack::Test::Methods
end

Capybara.configure do |config|
  config.app = App::User.app
end

def app
  App::User.app
end
