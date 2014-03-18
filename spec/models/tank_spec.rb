require 'spec_helper'

describe Tank do
  it "has the name and tiernumber set correctly" do
    tank = Tank.new name:"Hummel", tier_number: 5

    tank.name.should == "Hummel"
    tank.tier_number.should eq(5)
  end

  it "has the description set correctly" do
    tank = Tank.new name:"Hummel", tier_number: 5, description: "Testi"

    tank.description.should == "Testi"

  end

  it "is not saved without a name" do
    tank = Tank.create name:"", tier_number: 5

    expect(tank).not_to be_valid
    expect(Tank.count).to eq(0)

  end

  it "is not saved with a too short name" do
    tank = Tank.create name:"B", tier_number: 5

    expect(tank).not_to be_valid
    expect(Tank.count).to eq(0)

  end

  it "is not saved with too low tiernumber" do
    tank = Tank.create name:"TA", tier_number: 0

    expect(tank).not_to be_valid
    expect(Tank.count).to eq(0)

  end

  it "is not saved with too high tiernumber" do
    tank = Tank.create name:"TA", tier_number: 20

    expect(tank).not_to be_valid
    expect(Tank.count).to eq(0)

  end


  describe "with correct name" do

    let!(:tank){FactoryGirl.create(:tank)}

    it "is saved" do
      expect(tank).to be_valid
      expect(Tank.count).to eq(1)
    end

    it "cannot have two with same name" do
      tank2 = Tank.create name: "IS-7"

      expect(tank2).not_to be_valid
      expect(Tank.count).to eq(1)
    end

  end
end
