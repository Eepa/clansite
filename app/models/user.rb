class User < ActiveRecord::Base

  has_secure_password

  validates :name, presence: true, uniqueness: true, length: {minimum: 2}
  validates_format_of :password, :with => /\A(([0-9]|[a-z]|[A-Z])*([0-9])([0-9]|[a-z]|[A-Z])*([A-Z])([0-9]|[a-z]|[A-Z])*|([0-9]|[a-z]|[A-Z])*([A-Z])([0-9]|[a-z]|[A-Z])*([0-9])([0-9]|[a-z]|[A-Z])*)\z/
  validates :password, length: {minimum:4}

  belongs_to :clan

end
