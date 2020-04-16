require 'uri'

class Owner < ApplicationRecord
  NAME_REGEX = /\A[A-Z][a-z]{2,}\s[A-Z][a-z]{2,}\z/

  validates :name, format: { with: NAME_REGEX }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
end
