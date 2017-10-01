class VerificationTokenMailer < ApplicationMailer
  def verify_interest(interest)
    @verification_token = VerificationToken.new()

    @verification_token.interest = interest
    @verification_token.person = interest.person
    @verification_token.save

    @interest = @verification_token.interest
    @volunteer = @verification_token.person

    mail(to: @volunteer.email, subject: "Want Ads: You must verify your interest")
  end

  def verify_person(person)
    @verification_token = VerificationToken.new
    @verification_token.person = person
    @verification_token.save

    @volunteer = @verification_token.person

    mail(to: @volunteer.email, subject: "Want Ads: You must verify your email address")
  end
end
