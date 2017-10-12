class TasksController < ApplicationController
  def new
    @task = Task.new
    @task.project = Project.find(params[:project_id])
    if params[:parent_id]
      @task.parent = Task.find(params[:parent_id])
    end
    @people = Person.all
    @roles = Role.where(project: @task.project)
  end

  def create
    @task = Task.new(task_params)
    if @task.project.has_permission(current_person)
      if @task.save
          redirect_to @task.project
      else
          flash.now.alert = "Unable to create task"
          @roles = Role.where(project: @task.project)
          @people = Person.all
          render :new
      end
    else
      redirect_to @task.project
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
    @people = Person.all
    @roles = Role.where(project: @task.project)
  end

  def update
    @task = Task.find(params[:id])
    if @task.project.has_permission(current_person)
      if @task.update(task_params)
        redirect_to @task
      else
        render :edit
      end
    else
      redirect_to @task
    end
  end

  def destroy
    @task = Task.find(params[:id])
    project = @task.project
    if @task.project.has_permission(current_person)
      @task.destroy
      redirect_to project
    else
      redirect_to @task
    end
  end

  def uncomplete
    @task = Task.find(params[:id])
    if @task.has_permission?(current_person)
      @task.status = "incomplete"
      @task.save
    end
    redirect_to @task
  end

  def complete
    @task = Task.find(params[:id])
    if @task.has_permission?(current_person)
      @task.status = "complete"
      @task.save
    end
    redirect_to @task
  end

  def volunteer
    @task = Task.find(params[:id])
    if @task.is_eligible?(current_person)
      @task.person = current_person
      @task.save
    end
    redirect_to @task
  end

  private
    def task_params
      params.require(:task).permit(:project_id, :title, :description, :role_id, :person_id, :parent_id)
    end
end
