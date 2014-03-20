require 'spec_helper'

describe Country do

  it "has the name set correctly" do
    country = Country.new name:"Germany"

    country.name.should == "Germany"

  end

  it "is not saved without a name" do
    country = Country.create name:""

    expect(country).not_to be_valid
    expect(Country.count).to eq(0)

  end

  it "is not saved with a too short name" do
    country = Country.create name:"AB"

    expect(country).not_to be_valid
    expect(Country.count).to eq(0)

  end

  describe "with correct name" do

    let!(:country){FactoryGirl.create(:country)}

    it "is saved" do
      expect(country).to be_valid
      expect(Country.count).to eq(1)
    end

    it "cannot have two with same name" do
      country2 = Country.create name: "Germany"

      expect(country2).not_to be_valid
      expect(Country.count).to eq(1)
    end

  end




end
