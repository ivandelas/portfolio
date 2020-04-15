require 'uri'

class Project < ApplicationRecord
  validates :title, length: { minimum: 10, maximum: 100 },
    uniqueness: { case_sensitive: false }
  validates :description, length: { minimum: 50, maximum: 200 }
  validates :site, format: { with: URI.regexp }
end
