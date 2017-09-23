class InterestsController < ApplicationController
    def new
        role = role_from_params

        if role == nil
            redirect_to :projects
        end
        @interest = Interest.new
        @interest.role = role_from_params
    end

    def create
        person = find_or_create_volunteer()
        @interest = Interest.new(interest_params)
        @interest.person = person
        if @interest.save
            InterestMailer.new_interest_email(@interest).deliver_later
            redirect_to @interest.role
        else
            render :new
        end
    end

    def destroy
        @interest = Interest.find(params[:id])
        role = @interest.role
        @interest.destroy

        redirect_to role
    end

    private
        def find_or_create_volunteer()
            person_params = params.require(:volunteer).permit(:first_name, :last_name, :email)
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

        def interest_params
            params.require(:interest).permit(:role_id)
        end

        def role_from_params
            params.permit(:role_id)
            if params[:role_id]
                role = Role.find(params[:role_id])
            end
        end
end
