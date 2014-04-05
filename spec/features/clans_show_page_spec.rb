require 'spec_helper'

describe "Clan show page" do
  let!(:clan){FactoryGirl.create(:clan)}


  it "should not have any members or tanks after creation" do

    visit clan_path(clan)

    expect(page).to have_content 'TestiK'
    expect(page).to have_content 'Description:'
    expect(page).to have_content 'Kiva'

    expect(page).to have_content 'Members: Tanks: Clan does not have any tanks!'


  end

  describe "when user not signed in" do

    let!(:user){FactoryGirl.create(:user, clan: clan)}

    it "should not have any links to edit clan " do
      visit clan_path(clan)

      expect(page).not_to have_content 'Edit'
      expect(page).to have_content 'Members: Testi Tanks: Clan does not have any tanks!'
    end

    it "should show the tanks if user has any" do
      FactoryGirl.create(:user_tank, user: user)
      country = FactoryGirl.create(:country, name: "ISOB")
      style = FactoryGirl.create(:style, name: "HT")
      tank2 = FactoryGirl.create(:tank, country: country, style: style, name: "Testi2")
      FactoryGirl.create(:user_tank, tank: tank2, user: user)

      visit clan_path(clan)

      expect(page).to have_content 'Members: Testi Tanks:'
      expect(page).to have_content 'IS-7'
      expect(page).to have_content 'Testi2'
    end



  end





end