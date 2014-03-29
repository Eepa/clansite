require 'spec_helper'

describe UserTank do


  it "has the attributes set correctly" do
    user_tank = UserTank.new user_id: 1, tank_id: 7, rating:50

    user_tank.rating.should eq(50)
    user_tank.user_id.should eq(1)
    user_tank.tank_id.should eq(7)
  end

  it "is not saved with too low rating" do

    user = FactoryGirl.create(:user)
    tank = FactoryGirl.create(:tank)

    user_tank = UserTank.create(user_id:user.id, tank_id:tank.id, rating:-56)

    expect(user_tank).not_to be_valid
    expect(UserTank.count).to eq(0)

  end

  it "is not saved with too high tiernumber" do
    user = FactoryGirl.create(:user)
    tank = FactoryGirl.create(:tank)

    user_tank = UserTank.create(user_id:user.id, tank_id:tank.id, rating:156)

    expect(user_tank).not_to be_valid
    expect(UserTank.count).to eq(0)

  end


  describe "with correct rating" do

    let!(:user_tank){FactoryGirl.create(:user_tank)}

    it "is saved" do
      expect(user_tank).to be_valid
      expect(UserTank.count).to eq(1)
    end

    it "a user cannot have two same tanks" do
      user_tank2 = UserTank.create user_id: 1, tank_id: 1, rating: 46

      expect(user_tank2).not_to be_valid
      expect(UserTank.count).to eq(1)
    end

  end
end
