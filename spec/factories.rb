FactoryGirl.define do

  factory :country do
    name "Germany"

  end

  factory :style do
    name "SPG"
    description "Hieno tankki"
  end

  factory :tank do
    name "IS-7"
    description "Hieno peli"
    tier_number 10
    country
    style
  end

  factory :clan do

    name "TestiK"
    description "Kiva"


  end

  factory :user do

    name "Testi"
    password "Test1"
    password_confirmation "Test1"
    admin true
    clan


  end

  factory :user_tank do

    user
    tank
    rating 57

  end




end