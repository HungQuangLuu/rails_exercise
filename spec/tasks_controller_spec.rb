require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe '/GET #index' do
    before { get :index }
    it 'return list of tasks' do
      expect(response).to have_http_status(200)
    end
  end

  describe '/POST #create' do
    let!(:task_params) do
      { 'task': { 'title': 'New task', 'description': 'Task description', 'completed': false } }
    end
    before { post :create, params: task_params}

    it 'create a new task' do
      
      expect(response).to have_http_status(201)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['status']).to eq('success')
      expect(parsed_response['task'].select { |key, _| ['title', 'description', 'completed'].include?(key) }).to eq(task_params[:task].transform_keys(&:to_s))
    end
  end 

  describe '/PUT #update' do
    let!(:task_params) do
      { 'task': { 'title': 'New task', 'description': 'Task description', 'completed': false } }
    end
    it 'create a new task' do
      get :index
      tasks = JSON.parse(response.body)
      puts tasks
      if(tasks.length() != 0) 
        put :update, params: { id: tasks[0].id }
        expect(response).to have_http_status(200)
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['status']).to eq('success')
        expect(parsed_response['task'].select { |key, _| ['title', 'description', 'completed'].include?(key) }).to eq(task_params[:task].transform_keys(&:to_s))
      end
    end
  end   

  describe 'DELETE #destroy' do
    it 'destroys the specified task' do
      get :index
      tasks = JSON.parse(response.body)
      if(tasks.length() != 0) 
        delete :destroy, params: { id: tasks[0].id }
        expect(response).to have_http_status(:no_content)
      end

    end
  end
end
