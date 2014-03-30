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

    before :each do

      @tanks = ["TES1", "testi2", "Testi3"]

      @tanks.each do |tank1|
        tank = FactoryGirl.create(:tank, name:tank1, country:country, style:style)
        FactoryGirl.create(:user_tank, user:user, tank:tank)
      end

      visit user_tanks_path

    end


    it "lists the users and tanks and total number of users' tanks" do

      expect(page).to have_content "Users have #{@tanks.count} tanks"

      expect(page).to have_content "Testi"

      @tanks.each do |tank|

        expect(page).to have_content tank

      end


    end




  end


end