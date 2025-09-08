require 'swagger_helper'

RSpec.describe 'API V2 Departments', type: :request, openapi_spec: 'v2/swagger.yaml' do
    let(:user) { create(:user) }

  # Shared context para headers de autenticação
  shared_context 'auth headers' do |authorized: true|
    let(:auth_headers) { authenticated_header(user) }
    let('access-token') { authorized ? auth_headers['access-token'] : '' }
    let('client')       { authorized ? auth_headers['client'] : '' }
    let('uid')          { authorized ? auth_headers['uid'] : '' }
  end

  path '/departments' do
    get 'Retrieves all departments' do
      tags 'Departments'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string

      response '200', 'departments found' do
        include_context 'auth headers', authorized: true
        run_test!
      end

      response '401', 'unauthorized' do
        include_context 'auth headers', authorized: false
        let(:department) { { description: 'New Departament', status: true } }
        run_test!
      end
    end

    post 'Creates a department' do
      tags 'Departments'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string
      parameter name: :department, in: :body, schema: {
        type: :object,
        properties: { description: { type: :string }, status: { type: :boolean } },
        required: ['description']
      }

      response '201', 'department created' do
        include_context 'auth headers', authorized: true
        let(:department) { { description: 'Dept 1' } }
        run_test!
      end

      response '401', 'unauthorized' do
        include_context 'auth headers', authorized: false
        let(:department) { { description: 'New Departament', status: true } }
        run_test!
      end
    end
  end

  path '/departments/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a department' do
      tags 'Departments'
      produces 'application/json'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string

      response '200', 'department found' do
        include_context 'auth headers', authorized: true
        let(:id) { Department.create(description: 'Dept 1').id }
        run_test!
      end
    end

    put 'Updates a department' do
      tags 'Departments'
      consumes 'application/json'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string
      parameter name: :department, in: :body, schema: {
        type: :object,
        properties: { description: { type: :string }, status: { type: :boolean } }
      }

      response '200', 'department updated' do
        include_context 'auth headers', authorized: true
        let(:id) { Department.create(description: 'Dept 1').id }
        let(:department) { { status: false } }
        run_test!
      end
    end

    delete 'Deletes a department' do
      tags 'Departments'
      parameter name: 'access-token', in: :header, type: :string
      parameter name: 'client', in: :header, type: :string
      parameter name: 'uid', in: :header, type: :string

      response '204', 'department deleted' do
        include_context 'auth headers', authorized: true
        let(:id) { Department.create(description: 'Dept 1').id }
        run_test!
      end
    end
  end
end
