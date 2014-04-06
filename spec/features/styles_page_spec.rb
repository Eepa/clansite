require 'spec_helper'

describe "Styles page" do


  it "should not have any before been created" do


    visit styles_path

    expect(page).to have_content 'Listing styles'
    expect(page).to have_content 'Number of styles: 0'
  end


  describe "when styles exists" do

    let!(:style){FactoryGirl.create(:style)}

    before :each do
      @styles = ["LT", "HT", "MT"]

      @styles.each do |style|
        FactoryGirl.create(:style, name:style)
      end

      visit styles_path

    end


    it "lists the styles and their total number" do

      expect(page).to have_content "Number of styles: 4"

      @styles.each do |style|

        expect(page).to have_content style

      end

      expect(page).to have_content "SPG"

    end

    it "if user is not signed in it should not be able to visit new style page and will be redirected correctly" do
      visit new_style_path

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in'
    end

    it "user should not be able to visit edit style page and will be redirected correctly" do

      visit edit_style_path(style)

      expect(current_path).to eq(signin_path)


      expect(page).to have_content 'You should be signed in'

    end



  end

  describe "when style exist and user is signed in" do

    let!(:style){FactoryGirl.create(:style)}
    let!(:user){FactoryGirl.create(:user)}

    before :each do
      sign_in(name:"Testi", password:"Test1")

    end

    it "user should be able to visit edit style page and edit style correctly" do

      visit edit_style_path(style)

      expect(current_path).to eq(edit_style_path(style))
      fill_in('style_name', with: "Muutos")
      fill_in('style_description', with: "Muutos descriptioniin")
      click_button('Update Style')

      expect(current_path).to eq(style_path(style))

      expect(page).to have_content 'Style was successfully updated.'
      expect(page).to have_content 'Muutos'
      expect(page).to have_content 'Muutos descriptioniin'

    end

    it "user should be able to create style" do

      visit new_style_path

      fill_in('style_name', with: "UUSI")
      fill_in('style_description', with: 'Uusi desc')
      click_button('Create Style')

      expect(page).to have_content 'Style was successfully created.'
      expect(page).to have_content 'UUSI'
      expect(page).to have_content 'Uusi desc'

    end

    it "user should be able to delete style" do

      visit styles_path


      click_link('Destroy')

      expect(current_path).to eq(styles_path)

      expect(page).not_to have_content 'SPG'

    end



  end


end