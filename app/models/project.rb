require 'uri'
require 'net/http'

class Project < ApplicationRecord
  belongs_to :owner

  validates :title, length: { minimum: 10, maximum: 150 },
    uniqueness: { case_sensitive: false }

  validates :description, length: { minimum: 50, maximum: 300 }
  validates :site, :repo, format: { with: URI.regexp }
  validates :repo, format: { with: /\A.*\/[A-Za-z\-]+\/[a-z\-\.]+\z/ }

  scope :active_projects, -> { where(active: true) }

  has_one_attached :demo_image
end
