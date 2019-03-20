class Repo < ApplicationRecord
  has_many :contributors
  validates :repo_name, uniqueness: true, presence: true
end
