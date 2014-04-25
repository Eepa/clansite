require 'spec_helper'

describe "Users page" do


  it "should not have any before been created" do


    visit users_path

    expect(page).to have_content 'Listing users'
    expect(page).to have_content 'Number of users: 0'
  end

  it "should be able to create new user when given right username and password" do

    visit signup_path

    fill_in('user_name', with:"TestiU")
    fill_in('user_password', with:"Test1")
    fill_in('user_password_confirmation', with:"Test1")
    click_button('Create User')



    expect(page).to have_content 'TestiU'
    expect(page).to have_content 'User was successfully created.'
    expect(page).to have_content 'Clan: Not a member of any clan!'
    expect(page).to have_content 'Tanks: User does not have any tanks!'


  end

  it "should not be able to create new user when given wrong username" do

    visit signup_path

    fill_in('user_name', with:"")
    fill_in('user_password', with:"Test1")
    fill_in('user_password_confirmation', with:"Test1")
    click_button('Create User')

    expect(current_path).to eq(users_path)

    expect(page).to have_content 'prohibited this user from being saved:'


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

    it "user should not be able to visit edit user page and will be redirected correctly" do

      visit edit_user_path(user)

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in'

    end



  end

  describe "when user is signed in" do

    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(name:"Testi", password:"Test1")

    end

    it "user should be able to visit edit user page and edit user correctly" do

      visit edit_user_path(user)

      expect(current_path).to eq(edit_user_path(user))
      fill_in('user_password', with: "Muutos1")
      fill_in('user_password_confirmation', with: "Muutos1")

      click_button('Update User')

      expect(current_path).to eq(user_path(user))

      expect(page).to have_content 'User was successfully updated.'

    end

    it "user should be able to visit edit user page and not to be able to edit user incorrectly" do

      visit edit_user_path(user)

      expect(current_path).to eq(edit_user_path(user))
      fill_in('user_password', with: "MOI")
      fill_in('user_password_confirmation', with: "Muutos1")

      click_button('Update User')

      expect(current_path).to eq(user_path(user))

      expect(page).to have_content 'prohibited this user from being saved:'

    end

    it "user should be able to leave clan" do

      visit user_path(user)

      click_link('Leave clan')

      expect(page).to have_content 'You have successfully left the clan!'
      expect(page).to have_content 'Not a member of any clan!'

    end

    it "user should be able to join clan" do
      FactoryGirl.create(:clan, name: "PARAS")
      visit user_path(user)

      click_link('Leave clan')
      click_link('Join clan')

      #expect(current_path).to eq(user_join_clan_path(user))

      expect(current_path).to eq(join_clan_user_path(user))

      select('PARAS', from:'user[clan_id]')

      click_button('Join clan')

      expect(page).to have_content "You have successfully joined in a clan!"
      expect(page).to have_content "Clan: PARAS"

    end

    it "user should be able to delete his account" do

      visit users_path

      click_link('Destroy')

      expect(current_path).to eq(users_path)

      expect(page).not_to have_content 'Testi'
      expect(page).to have_content 'Number of users: 0'

    end



  end



end