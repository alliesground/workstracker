require 'devise/jwt/test_helpers'

module RequestSpecHelper
  include Warden::Test::Helpers

  def self.included(base)
    base.before(:each) { Warden.test_mode! }
    base.after(:each) { Warden.test_reset! }
  end

  def sign_in(resource)
    login_as(resource, scope: warden_scope(resource))
  end

  def sign_out(resource)
    logout(warden_scope(resource))
  end

  def json_response
    @json_response ||= JSON.parse(response.body, symbolize_names: true)
  end

  module HeadersHelpers
    def headers
      { 'Accept' => 'application/json', 
        'Content-Type' => 'application/json' }
    end

    def auth_headers(user)
      Devise::JWT::TestHelpers.auth_headers(headers, user)
    end
  end

  private

  def warden_scope(resource)
    resource.class.name.underscore.to_sym
  end
end
