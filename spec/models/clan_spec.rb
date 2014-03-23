require 'spec_helper'

describe Clan do
  it "has the name and description set correctly" do
    clan = Clan.new name:"Testi", description: "Testi1"

    clan.name.should == "Testi"
    clan.description.should eq("Testi1")
  end


  it "is not saved without a name" do
    clan = Clan.create name:"", description: ""

    expect(clan).not_to be_valid
    expect(Clan.count).to eq(0)

  end

  it "is not saved with a too short name" do
    clan = Clan.create name:"B", description: ""

    expect(clan).not_to be_valid
    expect(Clan.count).to eq(0)

  end


  describe "with correct name" do

    let!(:clan){FactoryGirl.create(:clan)}

    it "is saved" do
      expect(clan).to be_valid
      expect(Clan.count).to eq(1)
    end

    it "cannot have two with same name" do
      clan2 = Clan.create name: "TestiK"

      expect(clan2).not_to be_valid
      expect(Clan.count).to eq(1)
    end

  end
end
