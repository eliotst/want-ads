class ProjectsController < ApplicationController
    def new
        @project = Project.new()
    end

    def create
        @person = find_or_create_person()
        @project = Project.new(project_params)
        @project.save
        redirect_to @project
    end

    def show
        @project = Project.find(params[:id])
    end

    def index
        @projects = Project.all()
    end

    def destroy
        @project = Project.find(params[:id])
        @project.destroy

        redirect_to projects_path
    end

    def edit
        @project = Project.find(params[:id])
    end

    def update
        @project = Project.find(params[:id])
        if @project.update(project_params)
            redirect_to @project
        else
            render 'edit'
        end
    end

    private
        def find_or_create_person
            person_params = params.require(:person).permit(:first_name, :last_name, :email)
            if person_params[:id]
                @person = Person.find(person_params[:id])
            else
                @person = Person.find_by email: person_params[:email]
            end
        end

        def project_params
            params.require(:project).permit(:title, :description, :state)
        end
end
