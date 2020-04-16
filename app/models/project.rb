require 'uri'

class Project < ApplicationRecord
  belongs_to :owner

  validates :title, length: { minimum: 10, maximum: 150 },
    uniqueness: { case_sensitive: false }

  validates :description, length: { minimum: 50, maximum: 300 }
  validates :site, :repo, format: { with: URI.regexp }

  scope :active_projects, -> { where(active: true) }

  has_one_attached :demo_image
end
