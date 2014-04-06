require 'spec_helper'

describe "Style show page" do
  let!(:style){FactoryGirl.create(:style)}


  it "should not have any members or tanks after creation" do

    visit style_path(style)

    expect(page).to have_content 'SPG'
    expect(page).to have_content 'Description:'
    expect(page).to have_content 'Hieno tankki'




  end

  describe "when user not signed in" do

    let!(:user){FactoryGirl.create(:user)}

    it "should not have any links to edit style " do
      visit style_path(style)

      expect(page).not_to have_content 'Edit'

    end


  end





end