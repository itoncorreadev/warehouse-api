require 'rails_helper'

RSpec.describe 'Group API' do
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

  describe 'GET /groups' do

    context 'when no filter param is sent' do
      before do
        create_list(:group, 5)
        get '/groups', params: {}, headers: headers
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns 5 groups from database' do
        expect(json_body[:data].count).to eq(5)
      end
    end

    context 'when filter and sorting params is sent' do
      let!(:notebook_group_1) { create(:group, name: 'Supermarket') }
      let!(:notebook_group_2) { create(:group, name: 'Multimarket') }
      let!(:other_group_1) { create(:group, name: 'Shopping') }
      let!(:other_group_2) { create(:group, name: 'MiniShopping') }

      before do
        get '/groups?q[name_cont]=mark&q[s]=name+ASC', params: {}, headers: headers
      end

      it 'returns only the groups matching and in the correct order' do
        returned_group_name = json_body[:data].map { |t| t[:attributes][:name] }

        expect(returned_group_name).to eq([notebook_group_2.name, notebook_group_1.name])
      end
    end
  end

  describe 'GET /groups/:id' do
    let(:group) { create(:group) }

    before do
      get "/groups/#{group.id}",  params: {}, headers: headers
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'return the json for group' do
      expect(json_body[:data][:attributes][:name]).to eq(group.name)
    end
  end

end
