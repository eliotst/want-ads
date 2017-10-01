class PeopleController < ApplicationController
  before_action do |controller|
    unless controller.send(:is_admin?)
      redirect_to :projects
    end
  end

  def new
    @person = Person.new()
  end

  def create
    @person = Person.new(person_params)
    if @person.save
      redirect_to @person
    else
      flash.now.alert = "Unable to create person"
      render :new
    end
  end

  def edit
    @person = Person.find(params[:id])
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      redirect_to @person
    else
      render 'edit'
    end
  end

  def show
    @person = Person.find(params[:id])
  end

  def index
    @people = Person.all()
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy
    redirect_to people_path
  end

  private
    def person_params
        params.require(:person).permit(:first_name, :last_name,
          :email, :user_type, :password, :password_confirmation)
    end
end
