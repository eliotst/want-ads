class PersonRolesController < ApplicationController
  def destroy
    @person_role = PersonRole.find(params[:id])
    RoleMailer.unassign_mail(@person_role).deliver_later
    @person_role.destroy
    redirect_to @person_role.role
  end
end
