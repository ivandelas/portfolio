require 'uri'

class CustomValidator < ActiveModel::Validator
  def validate(record)
    if record.class.count == 1
      record.errors[:base] << 'Only one owner is allowed'
    end
  end
end

class Owner < ApplicationRecord
  has_many :projects

  NAME_REGEX = /\A[A-Z][a-z]{2,}\s[A-Z][a-z]{2,}\z/

  validates :name, format: { with: NAME_REGEX }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :github, :linkedin, format: { with: URI.regexp }
  validates :about, length: { minimum: 100 }
  validates_with CustomValidator
end
