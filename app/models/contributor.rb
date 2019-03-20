class Contributor < ApplicationRecord
  belongs_to :repo
  validates :login, uniqueness: true, presence: true
end
