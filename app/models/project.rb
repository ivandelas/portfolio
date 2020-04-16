require 'uri'
require 'net/http'

class CustomValidation < ActiveModel::Validator
  def validate(record)
    begin
    response_repo = Net::HTTP.get_response(URI(record.repo))
    response_site = Net::HTTP.get_response(URI(record.site))

    if [response_repo.code, response_site.code].any?('404')
      raise URI::InvalidURIError
    end
    rescue URI::InvalidURIError
      record.errors[:base] << 'A URI is not valid'
    end
  end
end

class Project < ApplicationRecord
  belongs_to :owner

  validates :title, length: { minimum: 10, maximum: 150 },
    uniqueness: { case_sensitive: false }

  validates :description, length: { minimum: 50, maximum: 300 }
  validates :site, :repo, format: { with: URI.regexp }
  validates :repo, format: { with: /\A.*\/[A-Za-z\-]+\/[a-z\-\.]+\z/ }
  validates_with CustomValidation

  scope :active_projects, -> { where(active: true) }

  has_one_attached :demo_image
end
