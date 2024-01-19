class TasksController < ApplicationController
  def index
    @tasks = Task.all

    render json: @tasks
  end

  def create
    task_params = params.require(:task).permit(:title, :description, :completed)
    
    @task = Task.new(task_params)
    if @task.save
      render plain: "success"  
    else
      render plain: "fail"
    end
  end

  def update
    task_params = params.require(:task).permit(:title, :description, :completed)
    @task = Task.find(params[:id])

    if @task.update(task_params)
      render plain: "sucess"
    else
      render plain: "fail"
    end
  end

  def destroy
    @task = Task.find(params[:id])
    if @task.destroy
      render plain: "sucess"
    else
      render plain: "fail"
    end
  end

end
