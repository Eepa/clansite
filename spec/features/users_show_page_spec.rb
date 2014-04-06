require 'spec_helper'

describe "User show page" do
  let!(:user){FactoryGirl.create(:user)}


  it "should not have any clans or tanks after creation" do
    sign_in(name:"Testi", password:"Test1")
    visit user_path(user)

    click_link("Leave clan")
    click_link("signout")

    visit user_path(user)

    expect(page).to have_content 'Testi'
    expect(page).to have_content 'Clan: Not a member of any clan!'

    expect(page).to have_content 'Tanks:'
    expect(page).to have_content 'User does not have any tanks!'



  end

  describe "when user not signed in" do

    let!(:user){FactoryGirl.create(:user)}

    it "should not have any links to edit user " do
      visit user_path(user)

      expect(page).not_to have_content 'Edit'
      expect(page).to have_content 'Clan: TestiK'
    end

    it "should show the tanks if user has any" do
      FactoryGirl.create(:user_tank, user: user)
      country = FactoryGirl.create(:country, name: "ISOB")
      style = FactoryGirl.create(:style, name: "HT")
      tank2 = FactoryGirl.create(:tank, country: country, style: style, name: "Testi2")
      FactoryGirl.create(:user_tank, tank: tank2, user: user)

      visit user_path(user)

      expect(page).to have_content 'Testi2'
      expect(page).to have_content 'IS-7'

    end



  end





end