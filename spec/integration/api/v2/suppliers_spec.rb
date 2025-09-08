require 'swagger_helper'

RSpec.describe 'API V2 Suppliers', type: :request, openapi_spec: 'v2/swagger.yaml' do
  path '/suppliers' do
    get 'Retrieves all suppliers' do
      tags 'Suppliers'
      produces 'application/json'

      response '200', 'suppliers found' do
        run_test!
      end
    end

    post 'Creates a supplier' do
      tags 'Suppliers'
      consumes 'application/json'
      parameter name: :supplier, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string },
          type_document: { type: :string },
          document: { type: :string },
          address: { type: :string },
          phone: { type: :string },
          comment: { type: :string },
          status: { type: :boolean }
        },
        required: ['description']
      }

      response '201', 'supplier created' do
        let(:supplier) { { description: 'Supplier 1' } }
        run_test!
      end
    end
  end

  path '/suppliers/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a supplier' do
      tags 'Suppliers'
      produces 'application/json'

      response '200', 'supplier found' do
        let(:id) { Supplier.create(description: 'Supplier 1').id }
        run_test!
      end
    end

    put 'Updates a supplier' do
      tags 'Suppliers'
      consumes 'application/json'
      parameter name: :supplier, in: :body, schema: {
        type: :object,
        properties: {
          description: { type: :string },
          status: { type: :boolean }
        }
      }

      response '200', 'supplier updated' do
        let(:id) { Supplier.create(description: 'Supplier 1').id }
        let(:supplier) { { status: false } }
        run_test!
      end
    end

    delete 'Deletes a supplier' do
      tags 'Suppliers'
      response '204', 'supplier deleted' do
        let(:id) { Supplier.create(description: 'Supplier 1').id }
        run_test!
      end
    end
  end
end
