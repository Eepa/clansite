require 'spec_helper'

describe User do
  it "has the name set correctly" do
    user = User.new name:"Testi", password: "Test1", password_confirmation:"Test1"

    user.name.should == "Testi"

  end

  it "has the password set correctly" do
    user = User.new name:"Testi", password: "Test1", password_confirmation:"Test1"

    expect(user).to be_valid

  end

  it "has the clan number set correctly" do
    clan = FactoryGirl.create(:clan)
    user = User.create name:"Testi", password: "Test1", password_confirmation:"Test1"

    clan.users << user

    expect(user.clan_id).to eq(1)

  end

  it "is not saved without a name" do
    user = User.create name:"", password: "Test1", password_confirmation:"Test1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)

  end

  it "is not saved with a too short name" do
    user = User.create name:"B", password: "Test1", password_confirmation:"Test1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)

  end

  it "is not saved with password without number" do
    user = User.create name:"TA", password: "Test", password_confirmation:"Test"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)

  end

  it "is not saved with password without uppercase letter" do
    user = User.create name:"TA", password: "test1", password_confirmation:"test1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)

  end

  it "is not saved with too short password" do
    user = User.create name:"TA", password: "Te1", password_confirmation:"Te1"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)

  end


  describe "with correct name and password" do

    let!(:user){FactoryGirl.create(:user)}

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "cannot have two with same name" do
      user2 = User.create name: "Testi",  password: "Test1", password_confirmation:"Test1"

      expect(user2).not_to be_valid
      expect(User.count).to eq(1)
    end

  end
end
