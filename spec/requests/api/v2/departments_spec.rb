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

    context 'when filter and sorting params is sent' do
      let!(:department_1) { create(:department, description: 'Personal Department') }
      let!(:department_2) { create(:department, description: 'Kitchen') }
      let!(:department_3) { create(:department, description: 'Administrative') }
      let!(:department_4) { create(:department, description: 'Information Technology') }

      before do
        get '/departments?q[description_cont]=en&q[s]=description+ASC', params: {}, headers: headers
      end

      it 'returns only the departments matching and in the correct order' do
        returned_department_description = json_body[:data].map { |t| t[:attributes][:description] }

        expect(returned_department_description).to eq([department_2.description, department_1.description])
      end
    end
  end

  describe 'GET /departments/:id' do
    let(:department) { create(:department) }

    before do
      get "/departments/#{department.id}", params: {}, headers: headers
    end

    it 'return status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'return the json for department' do
      expect(json_body[:data][:attributes][:description]).to eq(department.description)
    end
  end

  describe 'POST /departments' do
    before do
      post '/departments', params: { department: department_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:department_params) { attributes_for(:department) }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns the department in database' do
        expect(Department.find_by(description: department_params[:description])).not_to be_nil
      end

      it 'returns the json for create department' do
        expect(json_body[:data][:attributes][:description]).to eq(department_params[:description])
      end
    end

    context 'when the params are invalid' do
      let(:department_params) { attributes_for(:department, description: ' ') }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'retuns the department in the database' do
        expect(Department.find_by(description: department_params[:description])).to be_nil
      end

      it 'retuns the json error for department' do
        expect(json_body[:errors]).to have_key(:description)
      end
    end
  end

  describe 'PUT /departments/:id' do
    let!(:department) { create(:department) }

    before do
      put "/departments/#{department.id}", params: { department: department_params }.to_json, headers: headers
    end

    context 'when the params are valid' do
      let(:department_params) { { description: 'New Department' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the json for updates department' do
        expect(json_body[:data][:attributes][:description]).to eq(department_params[:description])
      end

      it 'updates the department in database' do
        expect(Department.find_by(description: department_params[:description])).not_to be_nil
      end
    end

    context 'when the params are invalid' do
      let(:department_params) { { description: ' ' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json error for department' do
        expect(json_body[:errors]).to have_key(:description)
      end

      it 'does not update the group in the database' do
        expect(Department.find_by(description: department_params[:description])).to be_nil
      end
    end
  end

  describe 'DELETE /departments/:id' do
    let!(:department) { create(:department) }

    before do
      delete "/departments/#{department.id}", params: {}, headers: headers
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end

    it 'removes the department from the database' do
      expect { Department.find(department.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
