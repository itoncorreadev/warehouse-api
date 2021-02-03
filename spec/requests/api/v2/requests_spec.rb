require 'rails_helper'

RSpec.describe 'Request API' do
  before { host! 'api.warehouse.test' }

  let!(:user) { create(:user) }
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
        get '/requests', params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 5 products from database' do
        expect(json_body[:data].count).to eq(5)
      end
    end

    context 'when filter and sorting params is sent' do
      let!(:requests_1) { create(:request, document: 'JKL20210201') }
      let!(:requests_2) { create(:request, document: 'JKL20210202') }
      let!(:requests_3) { create(:request, document: 'JBL20210201') }
      let!(:requests_4) { create(:request, document: 'JBL20210202') }

      before do
        get '/requests?q[document_cont]=JKL&q[s]=document+ASC', params: {}, headers: headers
      end

      it 'return only the products matching and in the correct order' do
        returned_request_date = json_body[:data].map { |t| t[:attributes][:document] }

        expect(returned_request_date).to eq([requests_1.document, requests_2.document])
      end
    end
  end
end
