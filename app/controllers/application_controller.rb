class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_person

  private
    def current_person
      @current_person ||= Person.find(session[:person_id]) if session[:person_id]
    end

    def is_admin?
      current_person != nil && current_person.admin?
    end
end
