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

    context 'when no filter param is sent' do
      before do
        create_list(:product, 5, group_id: group.id)
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
      let!(:products_1) { create(:product, name: 'Apple Gala', group_id: group.id) }
      let!(:products_2) { create(:product, name: 'Orange Gala', group_id: group.id) }
      let!(:products_3) { create(:product, name: 'Whater Blue', group_id: group.id) }
      let!(:products_4) { create(:product, name: 'Whater Pure', group_id: group.id) }

      before do
        get '/products?q[name_cont]=gala&q[s]=name+ASC', params: {}, headers: headers
      end

      it 'return only the products matching and in the correct order' do
        returned_product_names = json_body[:data].map { |t| t[:attributes][:name] }

        expect(returned_product_names).to eq([products_1.name, products_2.name])
      end
    end
  end

end
