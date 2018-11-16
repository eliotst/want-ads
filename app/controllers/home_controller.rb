class HomeController < ApplicationController
  def index
    if current_person == nil
      none
    elsif current_person.admin?
      admin
    elsif current_person.organizer?
      organizer
    else
      volunteer
    end
  end

  private
    def admin
      @projects = Project.all()
      render :admin
    end

    def organizer
      @projects = Project.where(person: current_person)
      render :organizer
    end

    def volunteer
      @roles = Role.where(person: current_person)
      render :volunteer
    end

    def none
      @roles = Role.opportunities
      render :noone
    end
end
