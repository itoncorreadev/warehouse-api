# spec/integration/api/v2/categories_spec.rb
require 'swagger_helper'

RSpec.describe 'API V2 Categories', type: :request, swagger_doc: 'v2/swagger.yaml' do
  let(:user) { create(:user) }

  # Shared context para headers de autenticação
  shared_context 'auth headers' do |authorized: true|
    let(:auth_headers) { authenticated_header(user) }
    let('access-token') { authorized ? auth_headers['access-token'] : '' }
    let('client')       { authorized ? auth_headers['client'] : '' }
    let('uid')          { authorized ? auth_headers['uid'] : '' }
  end

  path '/categories' do
    get 'List categories' do
      tags 'Categories'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string

      response '200', 'categories found' do
        include_context 'auth headers', authorized: true
        run_test!
      end

      response '401', 'unauthorized' do
        include_context 'auth headers', authorized: false
        run_test!
      end
    end

    post 'Create category' do
      tags 'Categories'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string },
          status: { type: :boolean }
        },
        required: ['description']
      }

      response '201', 'category created' do
        include_context 'auth headers', authorized: true
        let(:category) { { description: 'New Category', status: true } }
        run_test!
      end

      response '401', 'unauthorized' do
        include_context 'auth headers', authorized: false
        let(:category) { { description: 'New Category', status: true } }
        run_test!
      end
    end
  end

  path '/categories/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'Category ID'

    get 'Retrieve a category' do
      tags 'Categories'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string

      response '200', 'category found' do
        include_context 'auth headers', authorized: true
        let(:id) { create(:category).id }
        run_test!
      end

      response '401', 'unauthorized' do
        include_context 'auth headers', authorized: false
        let(:id) { create(:category).id }
        run_test!
      end
    end

    put 'Update a category' do
      tags 'Categories'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string
      parameter name: :category, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string },
          status: { type: :boolean }
        }
      }

      response '200', 'category updated' do
        include_context 'auth headers', authorized: true
        let(:id) { create(:category).id }
        let(:category) { { description: 'Updated Category', status: false } }
        run_test!
      end

      response '401', 'unauthorized' do
        include_context 'auth headers', authorized: false
        let(:id) { create(:category).id }
        let(:category) { { description: 'Updated Category', status: false } }
        run_test!
      end
    end

    delete 'Delete a category' do
      tags 'Categories'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string

      response '204', 'category deleted' do
        include_context 'auth headers', authorized: true
        let(:id) { create(:category).id }
        run_test!
      end

      response '401', 'unauthorized' do
        include_context 'auth headers', authorized: false
        let(:id) { create(:category).id }
        run_test!
      end
    end
  end
end
