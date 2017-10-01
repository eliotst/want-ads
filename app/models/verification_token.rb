class VerificationToken < ApplicationRecord
  belongs_to :person
  has_one :interest

  before_save :generate_token, on: :create

  def generate_token
    self.token = (0...10).map { (65 + rand(26)).chr }.join
    self.expires_at = Time.now + 2.days
  end
end
