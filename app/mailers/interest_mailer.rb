class InterestMailer < ApplicationMailer
    def new_interest_email(interest)
        @interest = interest
        @organizer = interest.role.project.person
        mail(to: @organizer.email, subject: "Want Ads: New Interest in Role")
    end
end
