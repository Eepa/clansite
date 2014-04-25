class Tank < ActiveRecord::Base

  include RatingAverage

  validates :name, presence: true, uniqueness: true, length: {minimum: 2}
  validates :tier_number, :inclusion => 1..10

  belongs_to :country
  belongs_to :style

  has_many :user_tanks, dependent: :destroy
  has_many :users, through: :user_tanks

end
