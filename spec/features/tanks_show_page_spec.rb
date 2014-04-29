require 'spec_helper'

describe "Tank show page" do
  let!(:tank){FactoryGirl.create(:tank, name: "Hummel")}


  it "should not have any users after creation" do

    visit tank_path(tank)

    expect(page).to have_content 'Hummel'
    expect(page).to have_content 'Description: Hieno peli'
    expect(page).to have_content 'Country: Germany'
    expect(page).to have_content 'Tier: 10'

    expect(page).to have_content "Style: SPG"
    expect(page).to have_content "Average rating:"
    expect(page).to have_content "Users: Nobody has this tank!"


  end

  describe "when user not signed in" do

    let!(:user){FactoryGirl.create(:user)}

    it "should not have any links to edit tank " do
      visit tank_path(tank)

      expect(page).not_to have_content 'Edit'

    end

    it "should show the users if user has a tank" do
      FactoryGirl.create(:user_tank, user: user, tank: tank)


      visit tank_path(tank)

      expect(page).to have_content 'Testi'

    end



  end

  describe "when tank has ratings" do


    let!(:clan){FactoryGirl.create(:clan)}
    let!(:user){FactoryGirl.create(:user, clan: clan)}
    let!(:user2){FactoryGirl.create(:user, name:"Testi2", clan: clan)}
    let!(:user3){FactoryGirl.create(:user, name:"Testi3", clan: clan)}

    let!(:user_tank){FactoryGirl.create(:user_tank, user:user, tank:tank)}
    let!(:user_tank2){FactoryGirl.create(:user_tank, user:user2, tank:tank, rating:65)}
    let!(:user_tank3){FactoryGirl.create(:user_tank, user:user3, tank:tank, rating:86)}


    it "page should show right average rating" do

      visit tank_path(tank)

      expect(page).to have_content "Average rating: 69.3"

    end

  end





end