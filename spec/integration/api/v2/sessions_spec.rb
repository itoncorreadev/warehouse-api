require 'swagger_helper'

RSpec.describe 'API V2 Sessions', type: :request, openapi_spec: 'v2/swagger.yaml' do
  path '/sessions' do
    post 'User login' do
      tags 'Sessions'
      consumes 'application/json'
      parameter name: :session, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '201', 'session created' do
        let(:session) { { email: 't@t.com', password: '123456' } }
        run_test!
      end
    end

    delete 'User logout' do
      tags 'Sessions'
      response '204', 'session destroyed' do
        run_test!
      end
    end
  end
end
