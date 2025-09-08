require 'swagger_helper'

RSpec.describe 'API V2 Requests', type: :request, openapi_spec: 'v2/swagger.yaml' do
  path '/requests' do
    get 'Retrieves all requests' do
      tags 'Requests'
      produces 'application/json'
      response '200', 'requests found' do
        run_test!
      end
    end

    post 'Creates a request' do
      tags 'Requests'
      consumes 'application/json'
      parameter name: :request, in: :body, schema: {
        type: :object,
        properties: {
          date: { type: :string, format: 'date-time' },
          request_type: { type: :string },
          description: { type: :string },
          document_type: { type: :string },
          document_code: { type: :string },
          status: { type: :boolean },
          product_id: { type: :integer },
          department_id: { type: :integer },
          supplier_id: { type: :integer },
          user_id: { type: :integer }
        },
        required: ['product_id', 'department_id', 'user_id']
      }

      response '201', 'request created' do
        let(:product) { Product.create(name: 'Product 1', group: Group.create(name: 'G1'), category: Category.create(description: 'C1')) }
        let(:department) { Department.create(description: 'Dept 1') }
        let(:user) { User.create(email: 'user@example.com', password: 'password') }
        let(:request) do
          {
            product_id: product.id,
            department_id: department.id,
            user_id: user.id,
            description: 'Request 1'
          }
        end
        run_test!
      end
    end
  end

  path '/requests/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a request' do
      tags 'Requests'
      produces 'application/json'
      response '200', 'request found' do
        let(:product) { Product.create(name: 'Product 1', group: Group.create(name: 'G1'), category: Category.create(description: 'C1')) }
        let(:department) { Department.create(description: 'Dept 1') }
        let(:user) { User.create(email: 'user@example.com', password: 'password') }
        let(:id) do
          Request.create(product_id: product.id, department_id: department.id, user_id: user.id, description: 'Request 1').id
        end
        run_test!
      end
    end

    put 'Updates a request' do
      tags 'Requests'
      consumes 'application/json'
      parameter name: :request, in: :body, schema: { type: :object, properties: { status: { type: :boolean } } }

      response '200', 'request updated' do
        let(:product) { Product.create(name: 'Product 1', group: Group.create(name: 'G1'), category: Category.create(description: 'C1')) }
        let(:department) { Department.create(description: 'Dept 1') }
        let(:user) { User.create(email: 'user@example.com', password: 'password') }
        let(:id) do
          Request.create(product_id: product.id, department_id: department.id, user_id: user.id).id
        end
        let(:request) { { status: true } }
        run_test!
      end
    end

    delete 'Deletes a request' do
      tags 'Requests'
      response '204', 'request deleted' do
        let(:product) { Product.create(name: 'Product 1', group: Group.create(name: 'G1'), category: Category.create(description: 'C1')) }
        let(:department) { Department.create(description: 'Dept 1') }
        let(:user) { User.create(email: 'user@example.com', password: 'password') }
        let(:id) do
          Request.create(product_id: product.id, department_id: department.id, user_id: user.id).id
        end
        run_test!
      end
    end
  end
end
