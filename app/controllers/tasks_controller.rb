class TasksController < ApplicationController
  def index
    @tasks = Task.all

    render json: @tasks
  end

  def create
    task_params = params.require(:task).permit(:title, :description, :completed)
    
    @task = Task.new(task_params)
    if @task.save
      render json: { status: "success", task: @task }, status: :created
    else
      render json: { status: "fail", errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    task_params = params.require(:task).permit(:title, :description, :completed)
    @task = Task.find(params[:id])

    if @task.update(task_params)
      render json: { status: 'success', task: @task }, status: :ok
    else
      render json: { status: 'fail', errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      render json: { status: 'success' }, status: :no_content
    else
      render json: { status: 'fail' }, status: :internal_server_error
    end
  end

end
