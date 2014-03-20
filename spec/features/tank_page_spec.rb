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

    before :each do

      @tanks = ["Hummel", "Testi", "GW. Tiger"]

      @tanks.each do |tank|
        FactoryGirl.create(:tank, name:tank, country:country, style:style)
      end

      visit tanks_path

    end


    it "lists the tanks and their total number" do

      expect(page).to have_content "Number of tanks: #{@tanks.count}"

      @tanks.each do |tank|

        expect(page).to have_content tank

      end


    end




  end


end