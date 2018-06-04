module ApiRequestSpecHelper
  def headers
    { "ACCEPT" => "application/vnd.api+json" }
  end

  def auth_headers
    binding.pry
  end

  def sign_in(user)
    post(
      '/api/auth/sign_in', 
      params: { 
        email: user.email, 
        password: user.password 
      }.to_json,
      headers: {
        'CONTENT_TYPE' => 'application/json',
        'ACCEPT' => 'application/json'
      }
    )
  end

  def json_response
    @json_response ||= JSON.parse(response.body, symbolize_names: true)
  end 
end
