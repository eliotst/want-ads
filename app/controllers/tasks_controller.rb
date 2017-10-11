class TasksController < ApplicationController
  def new
    params.require(:project_id)
    @task = Task.new
    @task.project = Project.find(params[:project_id])
  end

  def create
    @task = Task.new(task_params)
    if @task.project.has_permission(current_person)
      if @task.save
          redirect_to @task.project
      else
          flash.now.alert = "Unable to create task"
          render :new, @task
      end
    else
      redirect_to @task.project
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  private
    def task_params
      params.require(:task).permit(:project_id, :title, :description)
    end
end
