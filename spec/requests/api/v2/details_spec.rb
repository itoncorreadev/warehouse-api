# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'RequestDetail API' do
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

  describe 'GET /requests/:request_id/details' do
    let(:request) { create(:request) }

    context 'when no filter param is sent' do
      before do
        create_list(:detail, 5, request_id: request.id)
        get "/requests/#{request.id}/details", params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 5 products from database' do
        expect(json_body[:data].count).to eq(5)
      end
    end

    context 'when filter and sorting params is sent' do
      let!(:details_one) { create(:detail, observation: 'JKL20210201', request_id: request.id) }
      let!(:details_two) { create(:detail, observation: 'JKL20210202', request_id: request.id) }

      before do
        get "/requests/#{request.id}/details?q[observation_cont]=JKL&q[s]=observation+ASC", params: {}, headers: headers
      end

      it 'return only the products matching and in the correct order' do
        returned_detail_observation = json_body[:data].map { |t| t[:attributes][:observation] }

        expect(returned_detail_observation).to eq([details_one.observation, details_two.observation])
      end
    end
  end

  describe 'GET /requests/:request_id/details/:id' do
    let(:detail) { create(:detail) }

    before do
      get "/requests/#{detail.request_id}/details/#{detail.id}", params: {}, headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the json for request' do
      expect(json_body[:data][:attributes][:quantity]).to eq(detail.quantity)
    end
  end

  describe 'POST /requests/:request_id/details' do
    let(:request) { create(:request) }
    let(:product) { create(:product) }

    before do
      post "/requests/#{request.id}/details", params: { detail: detail_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:detail_params) { attributes_for(:detail, request_id: request.id, product_id: product.id) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the in database' do
        expect(Detail.find_by(quantity: detail_params[:quantity])).not_to be_nil
      end

      it 'returns the json for created details' do
        expect(json_body[:data][:attributes][:quantity]).to eq(detail_params[:quantity])
      end

      it 'assigns the created detail to the request' do
        expect(json_body[:data][:attributes][:'request-id']).to eq(request.id)
      end
    end

    context 'when the params are invalid' do
      let(:detail_params) { attributes_for(:detail, quantity: nil, request_id: request.id, product_id: product.id) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the in database' do
        expect(Detail.find_by(quantity: detail_params[:quantity])).to be_nil
      end

      it 'returns the json error for detail' do
        expect(json_body[:errors]).to have_key(:quantity)
      end
    end
  end

  describe 'PUT /requests/:request_id/details/:id' do
    let!(:detail) { create(:detail) }

    before do
      put "/requests/#{detail.request_id}/details/#{detail.id}", params: { detail: detail_params }.to_json,
                                                                 headers: headers
    end

    context 'when the params are valid' do
      let(:detail_params) { { quantity: 10 } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json for updated detail' do
        expect(json_body[:data][:attributes][:quantity]).to eq(detail_params[:quantity])
      end

      it 'updates the detail in the database' do
        expect(Detail.find_by(quantity: detail_params[:quantity])).not_to be_nil
      end
    end

    context 'when the params are invalid' do
      let(:detail_params) { { quantity: nil } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'does not update the detail in the database' do
        expect(Detail.find_by(quantity: detail_params[:quantity])).to be_nil
      end

      it 'returns the json error for document' do
        expect(json_body[:errors]).to have_key(:quantity)
      end
    end
  end

  describe 'DELETE /requests/:request_id/details/:id' do
    let!(:detail) { create(:detail) }

    before do
      delete "/requests/#{detail.request_id}/details/#{detail.id}"
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end

    it 'removes the detail from the database' do
      expect { Detail.find(detail.request_id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
