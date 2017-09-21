class RolesController < ApplicationController
    def show
        @role = Role.find(params[:id])
    end

    def index
        @roles = Role.all()
    end

    def destroy
        @role = Role.find(params[:id])
        @role.destroy

        redirect_to roles_path
    end

    def edit
        @role = Role.find(params[:id])
    end

    def update
        person = find_or_create_person()
        @role = Role.find(params[:id])
        @role.person = person

        if person
            @role.person = person
        end

        if @role.update(role_params)
            redirect_to @role
        else
            render 'edit'
        end
    end

    private
        def find_or_create_volunteer()
            person_params = params.require(:volunteer).permit(:first_name, :last_name, :email)

            if person_params[:email] == nil
                return nil
            end

            person = Person.find_by email: person_params[:email]

            if person == nil
                person = Person.new(person_params)
                person.save
            else
                person.update(person_params)
            end

            person
        end

        def role_params
            params.require(:role).permit(
                :title, :description,
                person_attributes: [:first_name, :last_name, :email])
        end
end
