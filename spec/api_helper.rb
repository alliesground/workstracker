require 'support/api_request_spec_helper'

RSpec.configure do |config|
  config.include ApiRequestSpecHelper, :type => :request
  config.include ApiRequestSpecHelper, :type => :controller
end
