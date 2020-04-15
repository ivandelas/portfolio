class Project < ApplicationRecord
  validates :title, length: { minimum: 10, maximum: 100 },
    uniqueness: { case_sensitive: false }
end
