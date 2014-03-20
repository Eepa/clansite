require 'spec_helper'

describe "Styles page" do


  it "should not have any before been created" do


    visit styles_path

    expect(page).to have_content 'Listing styles'
    expect(page).to have_content 'Number of styles: 0'
  end


end