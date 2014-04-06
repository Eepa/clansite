require 'spec_helper'

describe "Countries page" do


  it "should not have any before been created" do


    visit countries_path

    expect(page).to have_content 'Listing countries'
    expect(page).to have_content 'Number of countries: 0'
  end

  describe "when countries exists" do

    let!(:country){FactoryGirl.create(:country)}

    before :each do
      @countries = ["U.S.S.R", "I-B", "France"]

      @countries.each do |country|
        FactoryGirl.create(:country, name:country)
      end

      visit countries_path

    end


    it "lists the countries and their total number" do

      expect(page).to have_content "Number of countries: 4"

      @countries.each do |country|

        expect(page).to have_content country


      end
      expect(page).to have_content "Germany"

    end

    it "if user is not signed in it should not be able to visit new country page and will be redirected correctly" do
      visit new_country_path(country)

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in'
    end

    it "user should not be able to visit edit country page and will be redirected correctly" do

      visit edit_country_path(country)

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in'

    end

  end

  describe "when country exist and user is signed in" do

    let!(:country){FactoryGirl.create(:country)}
    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(name:"Testi", password:"Test1")

    end

    it "user should be able to visit edit country page and edit country correctly" do

      visit edit_country_path(country)

      expect(current_path).to eq(edit_country_path(country))
      fill_in('country_name', with: "Muutos")

      click_button('Update Country')

      expect(current_path).to eq(country_path(country))

      expect(page).to have_content 'Country was successfully updated.'
      expect(page).to have_content 'Muutos'

    end

    it "user should be able to create country" do

      visit new_country_path

      fill_in('country_name', with: "UUSI")

      click_button('Create Country')

      expect(page).to have_content 'Country was successfully created.'
      expect(page).to have_content 'UUSI'

    end

    it "user should be able to delete country" do

      visit countries_path


      click_link('Destroy')

      expect(current_path).to eq(countries_path)

      expect(page).not_to have_content 'Germany'

    end



  end


end