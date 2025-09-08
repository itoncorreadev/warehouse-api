require 'swagger_helper'

RSpec.describe 'API V2 Users', type: :request, openapi_spec: 'v1/swagger.yaml' do
  path '/users' do
    get 'Retrieves all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'users found' do
        run_test!
      end
    end

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[name email password]
      }

      response '201', 'user created' do
        let(:user) { { name: 'Test', email: 'test@example.com', password: 'password' } }
        run_test!
      end
    end
  end

  path '/users/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'

      response '200', 'user found' do
        let(:id) { User.create(name: 'Test', email: 't@t.com', password: '123456').id }
        run_test!
      end
    end

    put 'Updates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string }
        }
      }

      response '200', 'user updated' do
        let(:id) { User.create(name: 'Test', email: 't@t.com', password: '123456').id }
        let(:user) { { name: 'Updated' } }
        run_test!
      end
    end

    delete 'Deletes a user' do
      tags 'Users'
      response '204', 'user deleted' do
        let(:id) { User.create(name: 'Test', email: 't@t.com', password: '123456').id }
        run_test!
      end
    end
  end
end
