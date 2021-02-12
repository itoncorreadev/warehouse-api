require 'rails_helper'

RSpec.describe 'Request API' do
  before { host! 'api.warehouse.test' }

  let!(:user) { create(:user) }
  let!(:department) { create(:department) }
  let!(:supplier) { create(:supplier) }
  let!(:auth_data) {  user.create_new_auth_token }
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

  describe 'GET /requests' do

    context 'when no filter param is sent' do
      before do
        create_list(:request, 5)
        get "/requests", params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 5 products from database' do
        expect(json_body[:data].count).to eq(5)
      end
    end

    context 'when filter and sorting params is sent' do
      let!(:requests_1) { create(:request, description: 'JKL20210201') }
      let!(:requests_2) { create(:request, description: 'JKL20210202') }
      let!(:requests_3) { create(:request, description: 'JBL20210201') }
      let!(:requests_4) { create(:request, description: 'JBL20210202') }

      before do
        get "/requests?q[description_cont]=JKL&q[s]=description+ASC", params: {}, headers: headers
      end

      it 'return only the products matching and in the correct order' do
        returned_request_description = json_body[:data].map { |t| t[:attributes][:description] }

        expect(returned_request_description).to eq([requests_1.description, requests_2.description])
      end
    end
  end

  describe 'GET /requests/:id' do
    let(:request) { create(:request) }

    before do
      get "/requests/#{request.id}", params: {}, headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns the json for request' do
      expect(json_body[:data][:attributes][:description]).to eq(request.description)
    end
  end

  describe 'POST /requests' do
    before do
      post "/requests", params: { request: request_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:request_params) { attributes_for(:request) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the in database' do
        expect(Request.find_by(description: request_params[:description])).not_to be_nil
      end

      it 'returns the json for created request' do
        expect(json_body[:data][:attributes][:description]).to eq(request_params[:description])
      end

      it 'assigns the created task to the current user' do
        expect(json_body[:data][:attributes][:'user-id']).to eq(user.id)
      end
    end

    context 'when the params are invalid' do
      let(:request_params) { attributes_for(:request, description: '') }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the in database' do
        expect(Request.find_by(description: request_params[:description])).to be_nil
      end

      it 'returns the json error for request' do
        expect(json_body[:errors]).to have_key(:description)
      end
    end
  end

  describe 'PUT /requests/:id' do
    let!(:request) { create(:request) }

    before do
      put "/requests/#{request.id}", params: { request: request_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:request_params) { { description: 'Update document' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json for updated task' do
        expect(json_body[:data][:attributes][:description]).to eq(request_params[:description])
      end

      it 'updates the task in the database' do
        expect(Request.find_by(description: request_params[:description])).not_to be_nil
      end
    end

    context 'when the params are invalid' do
      let(:request_params) { { description: '' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'does not update the request in the database' do
        expect( Request.find_by(description: request_params[:description])).to be_nil
      end

      it 'returns the json error for document' do
        expect(json_body[:errors]).to have_key(:description)
      end
    end

  end

  describe 'DELETE /requests/:id' do
    let!(:request) { create(:request) }

    before do
      delete "/requests/#{request.id}"
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the request from the database' do
      expect { Request.find(request.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
