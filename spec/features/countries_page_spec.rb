require 'spec_helper'

describe "Countries page" do


  it "should not have any before been created" do


    visit countries_path

    expect(page).to have_content 'Listing countries'
    expect(page).to have_content 'Number of countries: 0'
  end

  describe "when countries exists" do

    before :each do
      @countries = ["Germany", "I-B", "France"]

      @countries.each do |country|
        FactoryGirl.create(:country, name:country)
      end

      visit countries_path

    end


    it "lists the countries and their total number" do

      expect(page).to have_content "Number of countries: #{@countries.count}"

      @countries.each do |country|

        expect(page).to have_content country

      end


    end



  end


end