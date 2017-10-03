class PersonRolesController < ApplicationController
  def new
    role_id = params.require(:role_id)
    @role = Role.find(role_id)
    if @role.can_assign(current_person)
      @people = Person.all()
      @person_role = PersonRole.new(role: @role)
      render 'new'
    else
      redirect_to @role
    end
  end

  def create
    @person_role = PersonRole.new(person_role_params)
    if @person_role.role.can_assign(current_person)
      @person_role.save
    end
    redirect_to @person_role.role
  end

  def destroy
    @person_role = PersonRole.find(params[:id])
    RoleMailer.unassign_mail(@person_role).deliver_later
    @person_role.destroy
    redirect_to @person_role.role
  end

  private
    def person_role_params
      params.require(:person_role).permit(:person_id, :role_id)
    end
end
