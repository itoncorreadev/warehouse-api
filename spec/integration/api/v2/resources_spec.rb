require 'swagger_helper'

RSpec.describe 'API V2 Resources', type: :request, swagger_doc: 'v2/swagger.yaml' do
  let(:user) { create(:user) }
  let(:auth_headers) { authenticated_header(user) }

  # Helper: resolve lambdas e retorna atributos válidos
  def attributes_for_resource(res, current_user = nil)
    res[:default_attributes].transform_values do |v|
      value = v.is_a?(Proc) ? instance_exec(&v) : v
      # Se o campo for user_id e existir current_user, força o id do usuário autenticado
      if current_user && res[:default_attributes].key?(:user_id) && v.nil?
        current_user.id
      else
        value
      end
    end
  end


  # Lista de recursos genéricos
  resources = [
    {
      name: :category,
      label: 'Categories',
      schema: {
        type: :object,
        properties: {
          description: { type: :string },
          status: { type: :boolean }
        },
        required: ['description']
      },
      default_attributes: {
        description: 'Default Category',
        status: true
      }
    },
    {
      name: :department,
      label: 'Departments',
      schema: {
        type: :object,
        properties: {
          description: { type: :string },
          status: { type: :boolean }
        },
        required: ['description']
      },
      default_attributes: {
        description: 'Default Department',
        status: true
      }
    },
    {
      name: :group,
      label: 'Groups',
      schema: {
        type: :object,
        properties: {
          name: { type: :string },
          status: { type: :boolean }
        },
        required: ['name']
      },
      default_attributes: {
        name: 'Default Group',
        status: true
      }
    },
    {
      name: :product,
      label: 'Products',
      schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string },
          code: { type: :string },
          product_type: { type: :boolean },
          measure: { type: :string },
          min: { type: :integer },
          med: { type: :integer },
          max: { type: :integer },
          location: { type: :string },
          group_id: { type: :integer },
          category_id: { type: :integer }
        },
        required: ['name', 'group_id', 'category_id']
      },
      default_attributes: {
        name: 'Default Product',
        description: 'Product desc',
        code: 'P001',
        product_type: true,
        measure: 'kg',
        min: 1,
        med: 5,
        max: 10,
        location: 'Shelf A',
        group_id: -> { create(:group).id },
        category_id: -> { create(:category).id }
      }
    },
    {
      name: :task,
      label: 'Tasks',
      schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          deadline: { type: :string, format: :date },
          done: { type: :boolean },
          user_id: { type: :integer }
        },
        required: ['title', 'user_id']
      },
      default_attributes: {
        title: 'Default Task',
        description: 'Task desc',
        deadline: -> { Date.today.iso8601 },
        done: false,
        user_id: -> { user.id }
      }
    }
  ]

  resources.each do |res|
    plural_name = res[:name].to_s.pluralize

    # ----------------- LIST / CREATE -----------------
    path "/#{plural_name}" do
      get "List #{res[:label]}", tags: [res[:label]] do
        produces 'application/json'

        response '200', "#{res[:label]} found" do
          let(:'access-token') { auth_headers['access-token'] }
          let(:client)        { auth_headers['client'] }
          let(:uid)           { auth_headers['uid'] }
          run_test!
        end

        response '401', 'unauthorized' do
          let(:'access-token') { '' }
          let(:client)        { '' }
          let(:uid)           { '' }
          run_test!
        end
      end

      post "Create #{res[:label].singularize}", tags: [res[:label]] do
        consumes 'application/json'
        parameter name: res[:name], in: :body, schema: res[:schema]

        response '201', "#{res[:label].singularize} created" do
          let(:'access-token') { auth_headers['access-token'] }
          let(:client)        { auth_headers['client'] }
          let(:uid)           { auth_headers['uid'] }
          let(res[:name])     { attributes_for_resource(res) }
          run_test!
        end

        response '401', 'unauthorized' do
          let(:'access-token') { '' }
          let(:client)        { '' }
          let(:uid)           { '' }
          let(res[:name])     { attributes_for_resource(res) }
          run_test!
        end
      end
    end

    # ----------------- GET / PUT / DELETE by ID -----------------
    path "/#{plural_name}/{id}" do
      parameter name: :id, in: :path, type: :string, description: "#{res[:label].singularize} ID"

      get "Retrieve a #{res[:label].singularize}", tags: [res[:label]] do
        produces 'application/json'

        response '200', "#{res[:label].singularize} found" do
          let(:'access-token') { auth_headers['access-token'] }
          let(:client)        { auth_headers['client'] }
          let(:uid)           { auth_headers['uid'] }
          let(:id)            { create(res[:name], attributes_for_resource(res)).id }
          run_test!
        end

        response '401', 'unauthorized' do
          let(:'access-token') { '' }
          let(:client)        { '' }
          let(:uid)           { '' }
          let(:id)            { create(res[:name], attributes_for_resource(res)).id }
          run_test!
        end
      end

      put "Update a #{res[:label].singularize}", tags: [res[:label]] do
        consumes 'application/json'
        parameter name: res[:name], in: :body, schema: res[:schema]

        response '200', "#{res[:label].singularize} updated" do
          let(:'access-token') { auth_headers['access-token'] }
          let(:client)        { auth_headers['client'] }
          let(:uid)           { auth_headers['uid'] }
          let(:id)            { create(res[:name], attributes_for_resource(res)).id }
          let(res[:name])     { attributes_for_resource(res) }
          run_test!
        end

        response '401', 'unauthorized' do
          let(:'access-token') { '' }
          let(:client)        { '' }
          let(:uid)           { '' }
          let(:id)            { create(res[:name], attributes_for_resource(res)).id }
          let(res[:name])     { attributes_for_resource(res) }
          run_test!
        end
      end

      delete "Delete a #{res[:label].singularize}", tags: [res[:label]] do
        response '204', "#{res[:label].singularize} deleted" do
          let(:'access-token') { auth_headers['access-token'] }
          let(:client)        { auth_headers['client'] }
          let(:uid)           { auth_headers['uid'] }
          let(:id)            { create(res[:name], attributes_for_resource(res)).id }
          run_test!
        end

        response '401', 'unauthorized' do
          let(:'access-token') { '' }
          let(:client)        { '' }
          let(:uid)           { '' }
          let(:id)            { create(res[:name], attributes_for_resource(res)).id }
          run_test!
        end
      end
    end
  end
end
