class RoleMailer < ApplicationMailer
    def assign_mail(role)
        @role = role
        @volunteer = role.person
        mail(to: @volunteer.email, subject: "Want Ads: You have been assigned to a role")
    end

    def unassign_mail(role)
        @role = role
        @volunteer = role.person
        mail(to: @volunteer.email, subject: "Want Ads: You have been unassigned from a role")
    end
end
