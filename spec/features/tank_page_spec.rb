require 'spec_helper'

describe "Tanks page" do


  it "should not have any before been created" do


    visit tanks_path

    expect(page).to have_content 'Listing tanks'
    expect(page).to have_content 'Number of tanks: 0'
  end


  describe "when tanks exists" do


    let!(:country){FactoryGirl.create(:country)}
    let!(:style){FactoryGirl.create(:style)}
    let!(:tank){FactoryGirl.create(:tank, style: style, country: country)}

    before :each do

      @tanks = ["Hummel", "Testi", "GW. Tiger"]

      @tanks.each do |tank|
        FactoryGirl.create(:tank, name:tank, country:country, style:style)
      end

      visit tanks_path

    end


    it "lists the tanks and their total number" do

      expect(page).to have_content "Number of tanks: 4"

      @tanks.each do |tank|

        expect(page).to have_content tank

      end
      expect(page).to have_content "IS-7"

    end

    it "if user is not signed in it should not be able to visit new tank page and will be redirected correctly" do
      visit new_tank_path

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in'
    end

    it "user should not be able to visit edit tank page and will be redirected correctly" do

      visit edit_tank_path(tank)

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in'

    end




  end

  describe "when tanks exist and user is signed in as admin" do

    let!(:tank){FactoryGirl.create(:tank)}
    let!(:user){FactoryGirl.create(:user)}
    let!(:country){FactoryGirl.create(:country, name: "Britit")}
    let!(:style){FactoryGirl.create(:style, name: "LT")}

    before :each do
      sign_in(name:"Testi", password:"Test1")

    end

    it "user should be able to visit edit tank page and edit tank correctly" do

      visit edit_tank_path(tank)

      expect(current_path).to eq(edit_tank_path(tank))
      fill_in('tank_name', with: "Muutos")
      fill_in('tank_description', with: "muutettu")
      select('Britit', from:'tank[country_id]')
      select('4', from:'tank[tier_number]')
      select('LT', from:'tank[style_id]')
      click_button('Update Tank')

      expect(current_path).to eq(tank_path(tank))

      expect(page).to have_content 'Tank was successfully updated.'
      expect(page).to have_content 'Muutos'
      expect(page).to have_content 'muutettu'
      expect(page).to have_content 'Britit'
      expect(page).to have_content '4'
      expect(page).to have_content 'LT'
    end

    it "user should be able to visit edit tank page and not be able to edit tank incorrectly" do

      visit edit_tank_path(tank)

      expect(current_path).to eq(edit_tank_path(tank))
      fill_in('tank_name', with: "")
      fill_in('tank_description', with: "muutettu")
      select('Britit', from:'tank[country_id]')
      select('4', from:'tank[tier_number]')
      select('LT', from:'tank[style_id]')
      click_button('Update Tank')

      expect(current_path).to eq(tank_path(tank))

      expect(page).to have_content 'prohibited this tank from being saved:'

    end

    it "user should be able to create tank" do

      visit new_tank_path

      fill_in('tank_name', with: "UUSI")
      fill_in('tank_description', with: "lisätty")
      select('Britit', from:'tank[country_id]')
      select('4', from:'tank[tier_number]')
      select('LT', from:'tank[style_id]')

      click_button('Create Tank')

      expect(page).to have_content 'Tank was successfully created.'
      expect(page).to have_content 'UUSI'
      expect(page).to have_content 'lisätty'
      expect(page).to have_content 'Britit'
      expect(page).to have_content '4'
      expect(page).to have_content 'LT'
    end

    it "user should not be able to create tank incorrectly" do

      visit new_tank_path

      fill_in('tank_name', with: "")
      fill_in('tank_description', with: "lisätty")
      select('Britit', from:'tank[country_id]')
      select('4', from:'tank[tier_number]')
      select('LT', from:'tank[style_id]')

      click_button('Create Tank')

      expect(current_path).to eq(tanks_path)

      expect(page).to have_content 'prohibited this tank from being saved:'
    end

    it "user should be able to delete tank" do

      visit tanks_path


      click_link('Destroy')

      expect(current_path).to eq(tanks_path)

      expect(page).not_to have_content 'IS-7'

    end



  end

  describe "when tanks exist and user is signed in as normal user" do

    let!(:tank){FactoryGirl.create(:tank)}
    let!(:user){FactoryGirl.create(:user, admin: false)}

    before :each do
      sign_in(name:"Testi", password:"Test1")

    end

    it "user should not be able to visit edit tank page" do

      visit edit_tank_path(tank)

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in as admin'

    end

    it "user should not be able to create tank" do

      visit new_tank_path

      expect(current_path).to eq(signin_path)

      expect(page).to have_content 'You should be signed in as admin'
    end



  end


end