require 'spec_helper'

describe "Tank show page" do
  let!(:tank){FactoryGirl.create(:tank, name: "Hummel")}


  it "should not have any users after creation" do

    visit tank_path(tank)

    expect(page).to have_content 'Hummel'
    expect(page).to have_content 'Description: Hieno peli'
    expect(page).to have_content 'Country: Germany'
    expect(page).to have_content 'Tier: 10'

    expect(page).to have_content 'Style: SPG Users: Nobody has this tank!'


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





end