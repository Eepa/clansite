class Tank < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true, length: {minimum: 2}
  validates :tier_number, :inclusion => 1..10

  belongs_to :country
  belongs_to :style

end
