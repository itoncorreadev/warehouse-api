require 'swagger_helper'

RSpec.describe 'API V2 Products', type: :request, openapi_spec: 'v2/swagger.yaml' do
  path '/products' do
    get 'Retrieves all products' do
      tags 'Products'
      produces 'application/json'
      response '200', 'products found' do
        run_test!
      end
    end

    post 'Creates a product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          code: { type: :string },
          product_type: { type: :boolean },
          measure: { type: :string },
          min: { type: :integer },
          med: { type: :integer },
          max: { type: :integer },
          location: { type: :string },
          status: { type: :boolean },
          group_id: { type: :integer },
          category_id: { type: :integer }
        },
        required: ['name', 'group_id', 'category_id']
      }

      response '201', 'product created' do
        let(:group) { Group.create(name: 'Group 1') }
        let(:category) { Category.create(description: 'Category 1') }
        let(:product) { { name: 'Product 1', group_id: group.id, category_id: category.id } }
        run_test!
      end
    end
  end

  path '/products/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a product' do
      tags 'Products'
      produces 'application/json'
      response '200', 'product found' do
        let(:group) { Group.create(name: 'Group 1') }
        let(:category) { Category.create(description: 'Category 1') }
        let(:id) { Product.create(name: 'Product 1', group_id: group.id, category_id: category.id).id }
        run_test!
      end
    end

    put 'Updates a product' do
      tags 'Products'
      consumes 'application/json'
      parameter name: :product, in: :body, schema: {
        type: :object,
        properties: { name: { type: :string }, status: { type: :boolean } }
      }

      response '200', 'product updated' do
        let(:group) { Group.create(name: 'Group 1') }
        let(:category) { Category.create(description: 'Category 1') }
        let(:id) { Product.create(name: 'Product 1', group_id: group.id, category_id: category.id).id }
        let(:product) { { status: false } }
        run_test!
      end
    end

    delete 'Deletes a product' do
      tags 'Products'
      response '204', 'product deleted' do
        let(:group) { Group.create(name: 'Group 1') }
        let(:category) { Category.create(description: 'Category 1') }
        let(:id) { Product.create(name: 'Product 1', group_id: group.id, category_id: category.id).id }
        run_test!
      end
    end
  end
end
