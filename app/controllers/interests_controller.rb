class InterestsController < ApplicationController
    def new
        role = role_from_params

        if role == nil
            redirect_to :projects
        end
        @interest = Interest.new
        @message = Message.new
        @interest.role = role_from_params
    end

    def create
        @interest = Interest.new(interest_params)
        @interest.verified = true
        if @interest.person_id == nil # shouldn't pass person_id through form
            person = find_or_create_volunteer()
            if person.volunteer?
                @interest.person = person
                @interest.verified = false
            else
                flash.now.alert = "You must be logged in to do that"
                render :new
                return
            end
            message = Message.new(message_params)
            if message.message != ""
                message.person = person
                @interest.conversation.messages.push(message)
            end
        end
        if @interest.save
            if @interest.verified == false
                VerificationTokenMailer.verify_interest(@interest).deliver_later
            end
            InterestMailer.new_interest_email(@interest).deliver_later
            redirect_to @interest.role
        else
            render :new
        end
    end

    def destroy
        if params[:role_id] == nil
            @interest = Interest.find(params[:id])
        else
            @interest = Interest.find_by role_id: params[:role_id], person_id: params[:person_id]
        end
        role = @interest.role
        @interest.destroy

        redirect_to role
    end

    def show
        @interest = Interest.find(params[:id])
    end

    def update
    end

    def assign
        @interest = Interest.find(params[:id])
        role = @interest.role
        if role.can_assign(current_person)
            role.people << @interest.person
            @interest.destroy
            role.save
            RoleMailer.assign_mail(role).deliver_later
            redirect_to role
        else
            redirect_to :projects
        end
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
            params.require(:interest).permit(:role_id, :person_id)
        end

        def message_params
            params.require(:message).permit(:message)
        end

        def role_from_params
            params.permit(:role_id)
            if params[:role_id]
                role = Role.find(params[:role_id])
            end
        end
end
