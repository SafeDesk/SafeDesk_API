class Child < ApplicationRecord
  has_one :parent
  has_one :reward

  belongs_to :parent
end
