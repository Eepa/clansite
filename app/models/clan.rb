class Clan < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true, length: {minimum: 2}

  has_many :users

end
