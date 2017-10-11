class ProjectsController < ApplicationController
    helper_method :can_create_projects?

    def new
        if can_create_projects?
            @project = Project.new()
            organizer = @project.roles.build(
                title: "Organizer",
                description: "Primary organizer for the project.",
                role_type: "organizer",
                number_of_people: 1,
            )
            5.times do
                @project.roles.build
            end
        else
            flash.now.alert = "You cannot do that"
            redirect_to :projects
        end
    end

    def create
        if can_create_projects?
            @project = Project.new(project_params)
            @project.person = current_person
            if @project.save
                redirect_to @project
            else
                flash.now.alert = "Unable to create project"
                render :new, @project
            end
        else
            flash.now.alert = "You cannot do that"
            redirect_to :projects
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
        if @project != nil && @project.has_permission(current_person)
            @project.destroy
            redirect_to projects_path
        else
            redirect_to @project
        end
    end

    def edit
        @project = Project.find(params[:id])
        if @project != nil && @project.has_permission(current_person)
            row_left = @project.roles.length % 3
            fill_row = 3 - row_left
            fill_row.times do
                @project.roles.build
            end
        else
            redirect_to @project
        end
    end

    def update
        @project = Project.find(params[:id])
        if @project != nil && @project.has_permission(current_person)
            @project.person = current_person
            if @project.update(project_params)
                redirect_to @project
            else
                render 'edit'
            end
        else
            redirect_to projects_path
        end
    end

    private
        def can_create_projects?
            current_person != nil &&
                (current_person.admin? || current_person.organizer?)
        end

        def project_params
            params.require(:project).permit(:title, :description, :state,
                roles_attributes: [:id, :title, :description, :number_of_people, :role_type, :_destroy])
        end
end
