require 'uri'

class Project < ApplicationRecord
  belongs_to :owner

  validates :title, length: { minimum: 10, maximum: 150 },
    uniqueness: { case_sensitive: false }

  validates :description, length: { minimum: 50, maximum: 300 }

  validates :site, :repo, format: {
    with: URI.regexp,
    message: 'A valid URL is expected'
  }

  validates :repo, format: {
    with: /\A.*\/[A-Za-z0-9\-]+\/[a-z0-9\-\._]+\z/,
    message: 'A valid repository url is expected'
  }

  scope :active_projects, -> { where(active: true) }

  has_one_attached :demo_image
end
