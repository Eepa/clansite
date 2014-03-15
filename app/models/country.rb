class Country < ActiveRecord::Base

  validates :name, presence: true, uniqueness: true, length: {minimum: 3}

  has_many :tanks

end
