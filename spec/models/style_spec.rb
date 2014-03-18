require 'spec_helper'

describe Style do

  it "has the name set correctly" do
    style = Style.new name:"SPG"

    style.name.should == "SPG"

  end

  it "is not saved without a name" do
    style = Style.new name:""

    expect(style).not_to be_valid
    expect(Style.count).to eq(0)

  end

  describe "with correct name" do

    let!(:style){FactoryGirl.create(:style)}

    it "is saved" do
      expect(style).to be_valid
      expect(Style.count).to eq(1)
    end

    it "cannot have two with same name" do
      style2 = Style.create name: "SPG"

      expect(style2).not_to be_valid
      expect(Style.count).to eq(1)
    end

  end

end
