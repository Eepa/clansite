class Style < ActiveRecord::Base

  validates :name, uniqueness: true, presence: true

  has_many :tanks

end
