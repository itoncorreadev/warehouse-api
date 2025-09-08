# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Product API' do
  before { host! 'api.warehouse.test' }

  let!(:user) { create(:user) }
  let!(:group) { create(:group) }
  let!(:category) { create(:category) }
  let!(:auth_data) { user.create_new_auth_token }
  let(:headers) do
    {
      'Content-Type' => Mime[:json].to_s,
      'Accept' => 'application/vnd.warehouse.v2',
      'Authorization' => user.auth_token,
      'access-token' => auth_data['access-token'],
      'uid' => auth_data['uid'],
      'client' => auth_data['client']
    }
  end

  describe 'GET /products' do
    context 'when no filter param is sent' do
      before do
        create_list(:product, 5)
        get '/products', params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 5 products from database' do
        expect(json_body[:data].count).to eq(5)
      end
    end

    context 'when filter and sorting params is sent' do
      let!(:products_one) { create(:product, name: 'Apple Gala') }
      let!(:products_two) { create(:product, name: 'Orange Gala') }

      before do
        get '/products?q[name_cont]=gala&q[s]=name+ASC', params: {}, headers: headers
      end

      it 'return only the products matching and in the correct order' do
        returned_product_names = json_body[:data].map { |t| t[:attributes][:name] }

        expect(returned_product_names).to eq([products_one.name, products_two.name])
      end
    end
  end

  describe 'GET /products/:id' do
    let(:product) { create(:product) }

    before { get "/products/#{product.id}", params: {}, headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the json for product' do
      expect(json_body[:data][:attributes][:description]).to eq(product.description)
    end

    it 'One Product' do
      expect(product.group).to be_kind_of(Group)
    end
  end

  describe 'POST /products' do
    before do
      post '/products', params: { product: product_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:product_params) { attributes_for(:product) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the in database' do
        expect(Product.find_by(name: product_params[:name])).not_to be_nil
      end

      it 'returns the json for created product' do
        expect(json_body[:data][:attributes][:name]).to eq(product_params[:name])
      end

      it 'assigns the created product to the group' do
        expect(json_body[:data][:attributes][:'group-id']).to eq(group.id)
      end

      it 'assigns the created product to the category' do
        expect(json_body[:data][:attributes][:'category-id']).to eq(category.id)
      end
    end

    context 'when the params are invalid' do
      let(:product_params) { attributes_for(:product, name: ' ') }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'does not save the product in the database' do
        expect(Product.find_by(name: product_params[:name])).to be_nil
      end

      it 'returns the json error for name' do
        expect(json_body[:errors]).to have_key(:name)
      end
    end
  end

  describe 'PUT /products/:id' do
    let!(:product) { create(:product) }

    before do
      put "/products/#{product.id}", params: { product: product_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:product_params) { { name: 'New product name' } }

      it 'retuns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json for updated task' do
        expect(json_body[:data][:attributes][:name]).to eq(product_params[:name])
      end

      it 'updates the task in the database' do
        expect(Product.find_by(name: product_params[:name])).not_to be_nil
      end
    end

    context 'when the params are invalid' do
      let(:product_params) { { name: ' ' } }

      it 'returns atatus code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json error for name' do
        expect(json_body[:errors]).to have_key(:name)
      end

      it 'does not update the product in the database' do
        expect(Product.find_by(name: product_params[:name])).to be_nil
      end
    end
  end

  describe 'DELETE /products/:id' do
    let!(:product) { create(:product) }

    before do
      delete "/products/#{product.id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the product from the database' do
      expect { Product.find(product.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
