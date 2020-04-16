require 'uri'
require 'net/http'

class OnlyOneValidation < ActiveModel::Validator
  def validate(record)
    if record.class.count == 1 && record.new_record?
      record.errors[:base] << 'Only one owner is allowed'
    end
  end
end

class Owner < ApplicationRecord
  has_many :projects, dependent: :destroy

  NAME_REGEX = /\A[A-Z][a-z]{1,}\s[A-Z][a-z']{2,}\z/
  GITHUB_PROFILE_REGEX = /\Ahttps?:\/\/github\.com\/[A-Za-z\-_]+[^\-_]\z/

  LOCATION_REGEX = /
    \A
    ((([\(A-Z][a-z\.\)]+|[\(\)a-z']+),?\s)*[A-Z][a-z']+,\s){2}
    (([\(A-Z][a-z\.\)]+|[\(\)a-z']+),?\s)*[A-Z][a-z']+
    \z
  /x

  LINKEDIN_PROFILE_REGEX = /
    \Ahttps?:\/\/www\.linkedin\.com\/in\/[a-z0-9\-]+[^\-]\z
  /x

  validates :name, format: { with: NAME_REGEX }
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :github, :linkedin, format: { with: URI.regexp }
  validates :github, format: { with: GITHUB_PROFILE_REGEX }
  validates :linkedin, format: { with: LINKEDIN_PROFILE_REGEX }
  validates :about, length: { minimum: 100 }
  validates :location, format: { with: LOCATION_REGEX }
  validates_with OnlyOneValidation

  has_one_attached :profile_image
end
