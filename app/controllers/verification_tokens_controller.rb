class VerificationTokensController < ApplicationController
  def new
    @verification_token = VerificationToken.new
    @verification_token.person = Person.new
  end

  def create
    person = find_or_create_person()
    if person == nil
      flash.now.alert = "That person must login with a username and password."
    else
      flash.now.alert = "An email has been sent to that address for verification."
      VerificationTokenMailer.verify_person(person).deliver_later
    end
    redirect_to :login
  end

  def verify
    params.require(:token)
    verification_token = VerificationToken.find_by_token(params[:token])
    if verification_token.expires_at > Time.now
      session[:person_id] = verification_token.person.id
      if verification_token.interest
        interest = verification_token.interest
        interest.verified = true
        interest.verification_token = nil
        interest.save
      end
      redirect_to :roles
    else
      flash.now.alert = "Token is no longer valid"
      render "new"
    end
  end

  private
    def find_or_create_person()
      person_params = params.require(:person).permit(:first_name, :last_name, :email)
      if person_params[:id]
        person = Person.find(person_params[:id])
      else
        person = Person.find_by email: person_params[:email]
      end

      if person == nil
        person = Person.new(person_params)
        person.save
      elsif person.has_password?
        person.update(person_params)
      else
        person = nil
      end

      person
    end
end
