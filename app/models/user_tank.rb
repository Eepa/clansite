class UserTank < ActiveRecord::Base


  validates :rating, numericality: { greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 100,
                                    only_integer: true}

  validates :user, uniqueness: {scope: :tank}

  belongs_to :user
  belongs_to :tank



end
