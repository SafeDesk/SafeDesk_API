class Parent < ApplicationRecord
  has_many :child
  validates :email, uniqueness: true

end
