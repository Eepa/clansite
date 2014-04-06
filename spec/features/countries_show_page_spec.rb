require 'spec_helper'

describe "Country show page" do
  let!(:country){FactoryGirl.create(:country)}


  it "should not have any members or tanks after creation" do

    visit country_path(country)

    expect(page).to have_content 'Germany'

  end

  describe "when user not signed in" do

    let!(:user){FactoryGirl.create(:user)}

    it "should not have any links to edit country " do
      visit country_path(country)

      expect(page).not_to have_content 'Edit'

    end


  end





end