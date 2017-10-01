require 'bcrypt'
class Person < ApplicationRecord
    has_many :projects

    enum user_type: [:volunteer, :organizer, :admin]

    attr_accessor :password
    before_save :provide_defaults, :encrypt_password

    validates_confirmation_of :password,
        unless: Proc.new { |person| person.password.blank? }
    validates_presence_of :password, :on => [:create, :update], if: :needs_password?
    validates_presence_of :email
    validates_uniqueness_of :email

    def self.authenticate(email, password)
        user = find_by_email(email)
        if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
            user
        else
            nil
        end
    end

    def encrypt_password
        if password.present?
            self.password_salt = BCrypt::Engine.generate_salt
            self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
        end
    end

    def full_name
        self.first_name + " " + self.last_name
    end

    def has_password?
        !self.password_hash.nil?
    end

    def needs_password?
        self.password_hash.nil? && (self.admin? || self.organizer?)
    end

    def provide_defaults
        if self.user_type.nil?
            self.user_type = :volunteer
        end
    end
end
