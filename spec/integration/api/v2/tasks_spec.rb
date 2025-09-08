require 'swagger_helper'

RSpec.describe 'API V2 Tasks', type: :request, openapi_spec: 'v2/swagger.yaml' do
  path '/tasks' do
    get 'Retrieves all tasks' do
      tags 'Tasks'
      produces 'application/json'

      response '200', 'tasks found' do
        run_test!
      end
    end

    post 'Creates a task' do
      tags 'Tasks'
      consumes 'application/json'
      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          done: { type: :boolean }
        },
        required: ['title']
      }

      response '201', 'task created' do
        let(:task) { { title: 'Task 1', description: 'Do something', done: false } }
        run_test!
      end
    end
  end

  path '/tasks/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Retrieves a task' do
      tags 'Tasks'
      produces 'application/json'

      response '200', 'task found' do
        let(:id) { Task.create(title: 'Task 1').id }
        run_test!
      end
    end

    put 'Updates a task' do
      tags 'Tasks'
      consumes 'application/json'
      parameter name: :task, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          done: { type: :boolean }
        }
      }

      response '200', 'task updated' do
        let(:id) { Task.create(title: 'Task 1').id }
        let(:task) { { done: true } }
        run_test!
      end
    end

    delete 'Deletes a task' do
      tags 'Tasks'
      response '204', 'task deleted' do
        let(:id) { Task.create(title: 'Task 1').id }
        run_test!
      end
    end
  end
end
