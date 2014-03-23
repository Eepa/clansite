require 'spec_helper'

describe "Clans page" do


  it "should not have any before been created" do


    visit clans_path

    expect(page).to have_content 'Listing clans'
    expect(page).to have_content 'Number of clans: 0'
  end


  describe "when clans exists" do

    before :each do
      @clans = ["T1C", "T2C", "T3C"]

      @clans.each do |clan|
        FactoryGirl.create(:clan, name:clan)
      end

      visit clans_path

    end


    it "lists the clans and their total number" do

      expect(page).to have_content "Number of clans: #{@clans.count}"

      @clans.each do |clan|

        expect(page).to have_content clan

      end


    end



  end


end