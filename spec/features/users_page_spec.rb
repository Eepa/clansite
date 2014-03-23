require 'spec_helper'

describe "Users page" do


  it "should not have any before been created" do


    visit users_path

    expect(page).to have_content 'Listing users'
    expect(page).to have_content 'Number of users: 0'
  end


  describe "when users exists" do


    let!(:clan){FactoryGirl.create(:clan)}


    before :each do

      @users = ["TES1", "Testi", "TES2"]

      @users.each do |user|
        FactoryGirl.create(:user, name:user, clan:clan)
      end

      visit users_path

    end


    it "lists the users and their total number" do

      expect(page).to have_content "Number of users: #{@users.count}"

      @users.each do |user|

        expect(page).to have_content user

      end


    end




  end


end