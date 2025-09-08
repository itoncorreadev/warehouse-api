require 'swagger_helper'

RSpec.describe 'API V2 Groups', type: :request, openapi_spec: 'v2/swagger.yaml' do
  path '/groups' do
    get 'Retrieves all groups' do
      tags 'Groups'
      produces 'application/json'
      response '200', 'groups found' do
        run_test!
      end
    end

    post 'Creates a group' do
      tags 'Groups'
      consumes 'application/json'
      parameter name: :group, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          status: { type: :boolean }
        },
        required: ['name']
      }

      response '201', 'group created' do
        let(:group) { { name: 'Group 1' } }
        run_test!
      end
    end
  end

  path '/groups/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a group' do
      tags 'Groups'
      produces 'application/json'
      response '200', 'group found' do
        let(:id) { Group.create(name: 'Group 1').id }
        run_test!
      end
    end

    put 'Updates a group' do
      tags 'Groups'
      consumes 'application/json'
      parameter name: :group, in: :body, schema: {
        type: :object,
        properties: { name: { type: :string }, status: { type: :boolean } }
      }

      response '200', 'group updated' do
        let(:id) { Group.create(name: 'Group 1').id }
        let(:group) { { status: false } }
        run_test!
      end
    end

    delete 'Deletes a group' do
      tags 'Groups'
      response '204', 'group deleted' do
        let(:id) { Group.create(name: 'Group 1').id }
        run_test!
      end
    end
  end
end
