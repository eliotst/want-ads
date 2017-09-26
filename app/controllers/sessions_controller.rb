class SessionsController < ApplicationController
    def new
    end

    def create
        person = Person.authenticate(params[:email], params[:password])
        if person
            session[:person_id] = person.id
            redirect_to root_url, :notice => "Logged in!"
        else
            flash.now.alert = "Invalid email or password"
            render "new"
        end
    end

    def destroy
        session[:person_id] = nil
        redirect_to root_url, :notice => "Logged out!"
    end
end
