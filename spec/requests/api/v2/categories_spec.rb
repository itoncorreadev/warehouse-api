# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Category API' do
  before { host! 'api.warehouse.test' }

  let!(:user) { create(:user) }
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

  describe 'GET /categories' do
    context 'when no filter param is sent' do
      before do
        create_list(:category, 5)
        get '/categories', params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 5 categories from database' do
        expect(json_body[:data].count).to eq(5)
      end
    end

    context 'when filter and sorting params is sent' do
      let!(:category_one) { create(:category, description: 'Soap 70%') }
      let!(:category_two) { create(:category, description: 'Alcool 70%') }

      before do
        get '/categories?q[description_cont]=70&q[s]=description+ASC', params: {}, headers: headers
      end

      it 'returns only the categories matching and in the correct order' do
        returned_category_description = json_body[:data].map { |t| t[:attributes][:description] }

        expect(returned_category_description).to eq([category_two.description, category_one.description])
      end
    end
  end

  describe 'GET /categories/:id' do
    let(:category) { create(:category) }

    before do
      get "/categories/#{category.id}", params: {}, headers: headers
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'return the json for category' do
      expect(json_body[:data][:attributes][:description]).to eq(category.description)
    end
  end

  describe 'POST /categories' do
    before do
      post '/categories', params: { category: category_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:category_params) { attributes_for(:category) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the category in database' do
        expect(Category.find_by(description: category_params[:description])).not_to be_nil
      end

      it 'returns the json for create category' do
        expect(json_body[:data][:attributes][:description]).to eq(category_params[:description])
      end
    end

    context 'when the params are invalid' do
      let(:category_params) { attributes_for(:category, description: ' ') }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'does not save the category in the database' do
        expect(Category.find_by(description: category_params[:description])).to be_nil
      end

      it 'returns the json error for category' do
        expect(json_body[:errors]).to have_key(:description)
      end
    end
  end

  describe 'PUT /groups/:id' do
    let!(:category) { create(:category) }

    before do
      put "/categories/#{category.id}", params: { category: category_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:category_params) { { description: 'Soap' } }

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'retuns the json for update category' do
        expect(json_body[:data][:attributes][:description]).to eq(category_params[:description])
      end

      it 'updates the category in database' do
        expect(Category.find_by(description: category_params[:description])).not_to be_nil
      end
    end

    context 'when the params are invalid' do
      let(:category_params) { { description: ' ' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json error for category' do
        expect(json_body[:errors]).to have_key(:description)
      end

      it 'does not update the category in the database' do
        expect(Category.find_by(description: category_params[:description])).to be_nil
      end
    end
  end

  describe 'DELETE /groups/:id' do
    let!(:category) { create(:category) }

    before do
      delete "/categories/#{category.id}", params: {}, headers: headers
    end

    it 'return status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the category from the database' do
      expect { Category.find(category.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
