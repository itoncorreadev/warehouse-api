# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Supplier API' do
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

  describe 'GET /suppliers' do
    context 'when no filter param is sent' do
      before do
        create_list(:supplier, 5)
        get '/suppliers', params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 5 suppliers from database' do
        expect(json_body[:data].count).to eq(5)
      end
    end

    context 'when filter and sorting params is sent' do
      let!(:notebook_supplier_one) { create(:supplier, description: 'Supermarket') }
      let!(:notebook_supplier_two) { create(:supplier, description: 'Multimarket') }

      before do
        get '/suppliers?q[description_cont]=mark&q[s]=description+ASC', params: {}, headers: headers
      end

      it 'returns only the suppliers matching and in the correct order' do
        returned_supplier_descriptions = json_body[:data].map { |t| t[:attributes][:description] }

        expect(returned_supplier_descriptions).to eq([notebook_supplier_two.description, notebook_supplier_one.description])
      end
    end
  end

  describe 'GET /suppliers/:id' do
    let(:supplier) { create(:supplier) }

    before { get "/suppliers/#{supplier.id}", params: {}, headers: headers }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the json for supplier' do
      expect(json_body[:data][:attributes][:description]).to eq(supplier.description)
    end
  end

  describe 'POST /suppliers' do
    before do
      post '/suppliers', params: { supplier: supplier_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:supplier_params) { attributes_for(:supplier) }

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'retuns the supplier in database' do
        expect(Supplier.find_by(description: supplier_params[:description])).not_to be_nil
      end

      it 'retuns the json for created supplier' do
        expect(json_body[:data][:attributes][:description]).to eq(supplier_params[:description])
      end
    end

    context 'when the params are invalid' do
      let(:supplier_params) { attributes_for(:supplier, description: ' ') }

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'does not save the task in the database' do
        expect(Supplier.find_by(description: supplier_params[:description])).to be_nil
      end

      it 'returns the json error for title' do
        expect(json_body[:errors]).to have_key(:description)
      end
    end
  end

  describe 'PUT /suppliers/:id' do
    let!(:supplier) { create(:supplier) }

    before do
      put "/suppliers/#{supplier.id}", params: { supplier: supplier_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:supplier_params) { { description: 'New supplier description' } }

      it 'return status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'return the json for update supplier' do
        expect(json_body[:data][:attributes][:description]).to eq(supplier_params[:description])
      end

      it 'retuns the supplier in database' do
        expect(Supplier.find_by(description: supplier_params[:description])).not_to be_nil
      end
    end

    context 'when the params are invalid' do
      let(:supplier_params) { { description: ' ' } }

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json error for description' do
        expect(json_body[:errors]).to have_key(:description)
      end

      it 'does not update the task in the database' do
        expect(Supplier.find_by(description: supplier_params[:description])).to be_nil
      end
    end
  end

  describe 'DELETE /suppliers/:id' do
    let!(:supplier) { create(:supplier) }

    before do
      delete "/suppliers/#{supplier.id}", params: {}, headers: headers
    end

    it 'return status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the supplier from the database' do
      expect { Supplier.find(supplier.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
