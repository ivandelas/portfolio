require 'uri'

class OnlyOneValidation < ActiveModel::Validator
  def validate(record)
    if record.class.count == 1 && record.new_record?
      record.errors[:base] << 'Only one owner is allowed'
    end
  end
end

class Owner < ApplicationRecord
  has_many :projects, dependent: :destroy

  NAME_REGEX = /\A[[:alpha:]]{2,}\s[[:alpha:]]{2,}\z/
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

  validates :name, format: {
    with: NAME_REGEX,
    message: 'The name format is invalid, something like Bob Smith is expected'
  }

  validates :email, format: {
    with: URI::MailTo::EMAIL_REGEXP,
    message: 'The email format is invalid'
  }

  validates :github, :linkedin, format: {
    with: URI.regexp,
    message: 'The URL format for the github or linkedin profile link is not correct'
  }

  validates :github, format: {
    with: GITHUB_PROFILE_REGEX,
    message: 'A github profile link is expected'
  }

  validates :linkedin, format: {
    with: LINKEDIN_PROFILE_REGEX,
    message: 'A linkedin profile link is expected'
  }

  validates :about, length: {
    minimum: 100,
    message: 'The description about yuorself should be of at least 100 characters'
  }

  validates :location, format: {
    with: LOCATION_REGEX,
    message: 'A location like City, State, Country is expected'
  }

  validates_with OnlyOneValidation

  has_one_attached :profile_image

  has_secure_password
end
