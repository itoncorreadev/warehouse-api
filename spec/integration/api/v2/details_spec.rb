require 'swagger_helper'

RSpec.describe 'API V2 Details', type: :request, openapi_spec: 'v2/swagger.yaml' do
  path '/requests/{request_id}/details' do
    parameter name: :request_id, in: :path, type: :integer

    get 'Retrieves all details for a request' do
      tags 'Details'
      produces 'application/json'
      response '200', 'details found' do
        let(:product) { Product.create(name: 'Product 1', group: Group.create(name: 'G1'), category: Category.create(description: 'C1')) }
        let(:department) { Department.create(description: 'Dept 1') }
        let(:user) { User.create(email: 'user@example.com', password: 'password') }
        let(:request_obj) { Request.create(product_id: product.id, department_id: department.id, user_id: user.id) }
        let(:request_id) { request_obj.id }
        run_test!
      end
    end

    post 'Creates a detail for a request' do
      tags 'Details'
      consumes 'application/json'
      parameter name: :detail, in: :body, schema: {
        type: :object,
        properties: {
          quantity: { type: :integer },
          unit_price: { type: :number },
          total_price: { type: :number },
          observation: { type: :string },
          product_id: { type: :integer }
        },
        required: ['quantity', 'product_id']
      }

      response '201', 'detail created' do
        let(:product) { Product.create(name: 'Product 1', group: Group.create(name: 'G1'), category: Category.create(description: 'C1')) }
        let(:department) { Department.create(description: 'Dept 1') }
        let(:user) { User.create(email: 'user@example.com', password: 'password') }
        let(:request_obj) { Request.create(product_id: product.id, department_id: department.id, user_id: user.id) }
        let(:request_id) { request_obj.id }
        let(:detail) { { quantity: 10, product_id: product.id, unit_price: 5.0, total_price: 50.0 } }
        run_test!
      end
    end
  end

  path '/requests/{request_id}/details/{id}' do
    parameter name: :request_id, in: :path, type: :integer
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a detail' do
      tags 'Details'
      produces 'application/json'
      response '200', 'detail found' do
        let(:product) { Product.create(name: 'Product 1', group: Group.create(name: 'G1'), category: Category.create(description: 'C1')) }
        let(:department) { Department.create(description: 'Dept 1') }
        let(:user) { User.create(email: 'user@example.com', password: 'password') }
        let(:request_obj) { Request.create(product_id: product.id, department_id: department.id, user_id: user.id) }
        let(:id) { Detail.create(quantity: 10, product_id: product.id, request_id: request_obj.id).id }
        let(:request_id) { request_obj.id }
        run_test!
      end
    end

    put 'Updates a detail' do
      tags 'Details'
      consumes 'application/json'
      parameter name: :detail, in: :body, schema: { type: :object, properties: { quantity: { type: :integer } } }

      response '200', 'detail updated' do
        let(:product) { Product.create(name: 'Product 1', group: Group.create(name: 'G1'), category: Category.create(description: 'C1')) }
        let(:department) { Department.create(description: 'Dept 1') }
        let(:user) { User.create(email: 'user@example.com', password: 'password') }
        let(:request_obj) { Request.create(product_id: product.id, department_id: department.id, user_id: user.id) }
        let(:id) { Detail.create(quantity: 10, product_id: product.id, request_id: request_obj.id).id }
        let(:request_id) { request_obj.id }
        let(:detail) { { quantity: 15 } }
        run_test!
      end
    end

    delete 'Deletes a detail' do
      tags 'Details'
      response '204', 'detail deleted' do
        let(:product) { Product.create(name: 'Product 1', group: Group.create(name: 'G1'), category: Category.create(description: 'C1')) }
        let(:department) { Department.create(description: 'Dept 1') }
        let(:user) { User.create(email: 'user@example.com', password: 'password') }
        let(:request_obj) { Request.create(product_id: product.id, department_id: department.id, user_id: user.id) }
        let(:id) { Detail.create(quantity: 10, product_id: product.id, request_id: request_obj.id).id }
        let(:request_id) { request_obj.id }
        run_test!
      end
    end
  end
end
