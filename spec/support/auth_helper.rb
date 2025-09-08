module AuthHelper
  def authenticated_header(user)
    token = user.create_new_auth_token
    {
      'access-token' => token['access-token'],
      'client'       => token['client'],
      'uid'          => token['uid'],
      'Content-Type' => 'application/json',
      'Accept'       => 'application/vnd.warehouse.v2'
    }
  end
end

RSpec.configure do |config|
  config.include AuthHelper
end
