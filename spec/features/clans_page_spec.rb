require 'spec_helper'

include OwnTestHelper

describe "Clans page" do


  it "should not have any before been created" do


    visit clans_path

    expect(page).to have_content 'Listing clans'
    expect(page).to have_content 'Number of clans: 0'
  end


  describe "when clans exists" do
    let!(:clan){FactoryGirl.create(:clan)}
    let!(:user){FactoryGirl.create(:user, clan: clan)}

    before :each do
      @clans = ["T1C", "T2C", "T3C"]

      @clans.each do |clan|
        FactoryGirl.create(:clan, name:clan)
      end

      visit clans_path

    end


    it "lists the clans and their total number" do

      expect(page).to have_content "Number of clans: 4"

      @clans.each do |clan|

        expect(page).to have_content clan

      end
      expect(page).to have_content "TestiK"

    end

    it "if user is not signed in it should not be able to visit new clan page and will be redirected correctly" do
      visit new_clan_path

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in'
    end

    it "user should not be able to visit edit clan page and will be redirected correctly" do

      visit edit_clan_path(clan)

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in'

    end
  end

  describe "when clans exist and user is signed in" do

    let!(:clan){FactoryGirl.create(:clan)}
    let!(:user){FactoryGirl.create(:user, clan: clan)}

    before :each do
      sign_in(name:"Testi", password:"Test1")

    end

    it "user should be able to visit edit clan page and edit clan correctly" do

      visit edit_clan_path(clan)

      expect(current_path).to eq(edit_clan_path(clan))
      fill_in('clan_name', with: "Muutos")
      fill_in('clan_description', with: "muutettu")
      click_button('Update Clan')

      expect(current_path).to eq(clan_path(clan))

      expect(page).to have_content 'Clan was successfully updated.'
      expect(page).to have_content 'Muutos'
      expect(page).to have_content 'muutettu'
    end

    it "user should be able to visit edit clan page and not be able to edit clan incorrectly" do

      visit edit_clan_path(clan)

      expect(current_path).to eq(edit_clan_path(clan))
      fill_in('clan_name', with: "")
      fill_in('clan_description', with: "muutettu")
      click_button('Update Clan')

      expect(current_path).to eq(clan_path(clan))

      expect(page).to have_content 'prohibited this clan from being saved:'
    end

    it "user should be able to create clan" do

      visit new_clan_path

      fill_in('clan_name', with: "UUSI")
      fill_in('clan_description', with: "lisätty")
      click_button('Create Clan')

      expect(page).to have_content 'Clan was successfully created.'
      expect(page).to have_content 'UUSI'
      expect(page).to have_content 'lisätty'
    end

    it "user should not be able to create clan incorrectly" do

      visit new_clan_path

      fill_in('clan_name', with: "")
      fill_in('clan_description', with: "lisätty")
      click_button('Create Clan')

      expect(current_path).to eq(clans_path)

      expect(page).to have_content 'prohibited this clan from being saved:'
    end

    it "user should be able to delete clan" do

      visit clans_path


      click_link('Destroy')

      expect(current_path).to eq(clans_path)

      expect(page).not_to have_content 'TestiK'

    end



  end

  describe "when clans exist and user is signed in as normal user" do

    let!(:clan){FactoryGirl.create(:clan)}
    let!(:user){FactoryGirl.create(:user, admin: false, clan: clan)}

    before :each do
      sign_in(name:"Testi", password:"Test1")

    end

    it "user should not be able to visit edit clan page" do

      visit edit_clan_path(clan)

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in as admin'

    end

    it "user should not be able to create clan" do

      visit new_clan_path

      expect(current_path).to eq(signin_path)

      expect(page).to have_content 'You should be signed in as admin'
    end



  end


end