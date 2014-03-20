require 'spec_helper'

describe "Styles page" do


  it "should not have any before been created" do


    visit styles_path

    expect(page).to have_content 'Listing styles'
    expect(page).to have_content 'Number of styles: 0'
  end


  describe "when styles exists" do

    before :each do
      @styles = ["SPG", "HT", "MT"]

      @styles.each do |style|
        FactoryGirl.create(:style, name:style)
      end

      visit styles_path

    end


    it "lists the styles and their total number" do

      expect(page).to have_content "Number of styles: #{@styles.count}"

      @styles.each do |style|

        expect(page).to have_content style

      end


    end



  end


end