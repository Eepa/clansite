require 'spec_helper'

describe "UserTanks page" do


  it "should not have any before been created" do


    visit user_tanks_path

    expect(page).to have_content 'Listing users and their tanks'
    expect(page).to have_content 'Users have 0 tank'
  end


  describe "when users have tanks" do

    let!(:user){FactoryGirl.create(:user)}
    let!(:country){FactoryGirl.create(:country)}
    let!(:style){FactoryGirl.create(:style)}
    let!(:tank){FactoryGirl.create(:tank, country:country, style:style)}
    let!(:user_tank){FactoryGirl.create(:user_tank, user:user, tank:tank)}

    before :each do

      @tanks = ["TES1", "testi2", "Testi3"]

      @tanks.each do |tank1|
        tank2 = FactoryGirl.create(:tank, name:tank1, country:country, style:style)
        FactoryGirl.create(:user_tank, user:user, tank:tank2)
      end

      visit user_tanks_path

    end


    it "lists the users and tanks and total number of users' tanks" do

      expect(page).to have_content "Users have 4 tanks"

      expect(page).to have_content "Testi"

      @tanks.each do |tank|

        expect(page).to have_content tank

      end

      expect(page).to have_content "IS-7"

    end

    it "user_tank show-page shows the right information" do

      visit user_tank_path(user_tank)

      expect(page).to have_content "User: Testi"

      expect(page).to have_content "Tank: IS-7"
      expect(page).to have_content "Rating: 57"


    end

    it "if user is not signed in it should not be able to visit new user_tank page and will be redirected correctly" do
      visit new_user_tank_path

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in'
    end

    it "user should not be able to visit edit user_tank page and will be redirected correctly" do

      visit edit_user_tank_path(user_tank)

      expect(current_path).to eq(signin_path)

      expect(page).to have_content 'You should be signed in'

    end




  end

  describe "when user_tank exist and user is signed in" do

    let!(:user){FactoryGirl.create(:user)}
    let!(:country){FactoryGirl.create(:country)}
    let!(:style){FactoryGirl.create(:style)}
    let!(:tank){FactoryGirl.create(:tank, country:country, style:style)}
    let!(:user_tank){FactoryGirl.create(:user_tank, user:user, tank:tank)}

    before :each do
      sign_in(name:"Testi", password:"Test1")

    end

    it "user should be able to visit edit user_tank page and edit user_tank correctly" do

      visit edit_user_tank_path(user_tank)

      expect(current_path).to eq(edit_user_tank_path(user_tank))
      fill_in('user_tank_rating', with: "88")

      click_button('Edit a tank')

      expect(current_path).to eq(user_tank_path(user_tank))

      expect(page).to have_content 'User tank was successfully updated.'
      expect(page).to have_content 'Rating: 88'

    end

    it "user should be able to visit edit user_tank page and not be able to edit user_tank incorrectly" do

      visit edit_user_tank_path(user_tank)

      expect(current_path).to eq(edit_user_tank_path(user_tank))
      fill_in('user_tank_rating', with: "")

      click_button('Edit a tank')

      expect(current_path).to eq(user_tank_path(user_tank))

      expect(page).to have_content 'prohibited this user_tank from being saved:'

    end

    it "user should be able to add tank to himself" do
      FactoryGirl.create(:tank, name:"Hummel", country: country, style:style)
      visit new_user_tank_path

      select('Hummel', from:'user_tank[tank_id]')
      fill_in('user_tank_rating', with: "45")

      click_button('Add a tank')

      visit new_user_tank_path

      expect(page).to have_content 'You already have all the tanks! '

    end

    it "user should not be able to add tank to himself with incorrect rating" do
      FactoryGirl.create(:tank, name:"Hummel", country: country, style:style)
      visit new_user_tank_path

      select('Hummel', from:'user_tank[tank_id]')
      fill_in('user_tank_rating', with: "")

      click_button('Add a tank')

      expect(current_path).to eq(user_tanks_path)

      expect(page).to have_content 'prohibited this user_tank from being saved:'

    end

    it "if user has all tanks cannot add a new tank" do
      FactoryGirl.create(:tank, name:"Hummel", country: country, style:style)
      visit new_user_tank_path

      select('Hummel', from:'user_tank[tank_id]')
      fill_in('user_tank_rating', with: "45")

      click_button('Add a tank')

      expect(page).to have_content 'The tank was successfully added to your account!'
      expect(page).to have_content 'Rating: 45'
      expect(page).to have_content 'Tank: Hummel'

      visit new_user_tank_path

      expect(page).to have_content 'You already have all the tanks! '
    end

    it "user should be able to delete user_tank" do

      visit user_tanks_path


      click_link('Destroy')

      expect(current_path).to eq(user_tanks_path)

      expect(page).not_to have_content 'IS-7'
      expect(page).to have_content 'Users have 0 tanks'

    end



  end

  describe "when user_tank exist and user is signed in and not admin" do

    let!(:clan){FactoryGirl.create(:clan)}
    let!(:user){FactoryGirl.create(:user, clan: clan)}
    let!(:user2){FactoryGirl.create(:user, name:"Testi2", admin:false, clan: clan)}

    let!(:country){FactoryGirl.create(:country)}
    let!(:style){FactoryGirl.create(:style)}
    let!(:tank){FactoryGirl.create(:tank, country:country, style:style)}

    let!(:user_tank){FactoryGirl.create(:user_tank, user:user, tank:tank)}
    let!(:user_tank2){FactoryGirl.create(:user_tank, user:user2, tank:tank)}

    before :each do
      sign_in(name:"Testi2", password:"Test1")

    end

    it "user should be able to visit edit user_tank page of somenoe other and not be able to edit user_tank correctly" do

      visit edit_user_tank_path(user_tank)

      expect(current_path).to eq(edit_user_tank_path(user_tank))
      fill_in('user_tank_rating', with: "87")

      click_button('Edit a tank')

      expect(current_path).to eq(user_tank_path(user_tank))

      expect(page).to have_content 'You cannot update this tank'

    end

  end


end