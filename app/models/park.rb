class Park < ApplicationRecord
  has_many :activities
  has_many :addresses
  has_many :images
  has_many :operating_hours
  has_many :entrance_fees
  has_many :entrance_passes
  has_many :topics
  has_one :contact
end
