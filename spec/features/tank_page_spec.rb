require 'spec_helper'

describe "Tanks page" do


  it "should not have any before been created" do


    visit tanks_path

    expect(page).to have_content 'Listing tanks'
    expect(page).to have_content 'Number of tanks: 0'
  end


end