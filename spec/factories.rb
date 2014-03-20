FactoryGirl.define do

  factory :country do
    name "Germany"

  end

  factory :style do
    name "SPG"

  end

  factory :tank do
    name "IS-7"
    tier_number 10
    country
    style
  end




end