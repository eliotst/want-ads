class ProjectsController < ApplicationController
    def new
        @project = Project.new()
        3.times do
            @project.roles.build
        end
    end

    def create
        person = find_or_create_organizer()
        @project = Project.new(project_params)
        @project.person = person
        if @project.save
            redirect_to @project
        else
            render :new, @project
        end
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
        if @project
            row_left = @project.roles.length % 3
            fill_row = 3 - row_left
            fill_row.times do
                @project.roles.build
            end
        end
    end

    def update
        person = find_or_create_organizer()
        @project = Project.find(params[:id])
        @project.person = person
        if @project.update(project_params)
            redirect_to @project
        else
            render 'edit'
        end
    end

    private
        def find_or_create_organizer()
            person_params = params.require(:organizer).permit(:first_name, :last_name, :email)
            if person_params[:id]
                person = Person.find(person_params[:id])
            else
                person = Person.find_by email: person_params[:email]
            end

            if person == nil
                person = Person.new(person_params)
                person.save
            else
                person.update(person_params)
            end

            person
        end

        def project_params
            params.require(:project).permit(:title, :description, :state,
                roles_attributes: [:id, :title, :description, :_destroy])
        end
end
