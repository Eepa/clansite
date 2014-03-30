class Clan < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true, length: {minimum: 2}

  has_many :users
  has_many :tanks, through: :users

end
