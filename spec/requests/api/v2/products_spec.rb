require 'rails_helper'

RSpec.describe 'Product API' do
  before { host! 'api.warehouse.test' }

  let!(:user) { create(:user) }
  let!(:group) { create(:group) }
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

  describe 'GET /products' do
    before do
      create_list(:product, 5, group_id: group.id)
      get '/products', params: {}, headers: headers
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns 5 products from database' do
      expect(json_body[:products].count).to eq(5)
    end


  end

end
