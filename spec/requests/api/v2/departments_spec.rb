require 'rails_helper'

RSpec.describe 'Department API' do
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

  describe 'GET /departments' do

    context 'when no filter param is sent' do
      before do
        create_list(:department, 5)
        get '/departments', params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 5 department from database' do
        expect(json_body[:data].count).to eq(5)
      end
    end
  end
end
