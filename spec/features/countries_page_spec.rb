require 'spec_helper'

describe "Countries page" do


  it "should not have any before been created" do


    visit countries_path

    expect(page).to have_content 'Listing countries'
    expect(page).to have_content 'Number of countries: 0'
  end


end