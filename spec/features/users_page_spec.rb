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

  describe "when user exists" do

    let!(:user){FactoryGirl.create(:user)}

    before :each do
      visit signin_path
    end

    it "should be able to login with right name and password" do

      fill_in('name', with:"Testi")
      fill_in('password', with:"Test1")
      click_button('Log in')

      expect(current_path).to eq(user_path(user))

      expect(page).to have_content 'Login successful!'


    end

    it "should not be able to login with right name and incorrect password" do

      fill_in('name', with:"Testi")
      fill_in('password', with:"Test")
      click_button('Log in')

      expect(current_path).to eq(signin_path)

      expect(page).to have_content 'Incorrect username or password!'


    end

    it "should not be able to login with incorrect name and right password" do

      fill_in('name', with:"Test")
      fill_in('password', with:"Test1")
      click_button('Log in')

      expect(current_path).to eq(signin_path)

      expect(page).to have_content 'Incorrect username or password!'


    end

    it "should not be able to login when user does not exist" do

      fill_in('name', with:"TestiA")
      fill_in('password', with:"Test12")
      click_button('Log in')

      expect(current_path).to eq(signin_path)

      expect(page).to have_content 'Incorrect username or password!'


    end

    it "should be able to logout" do

      sign_in(name:"Testi", password:"Test1")



      click_link("signout")
      expect(current_path).to eq(root_path)

    end

  end


end