class Owner < ApplicationRecord
  NAME_REGEX = /\A[A-Z][a-z]{2,}\s[A-Z][a-z]{2,}\z/

  validates :name, presence: true,
    format: { with: NAME_REGEX }
end
