require 'spec_helper'

describe "user_tanks/edit" do
  before(:each) do
    @user_tank = assign(:user_tank, stub_model(UserTank,
      :user_id => 1,
      :tank_id => 1,
      :rating => 1
    ))
  end

  it "renders the edit user_tank form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_tank_path(@user_tank), "post" do
      assert_select "input#user_tank_user_id[name=?]", "user_tank[user_id]"
      assert_select "input#user_tank_tank_id[name=?]", "user_tank[tank_id]"
      assert_select "input#user_tank_rating[name=?]", "user_tank[rating]"
    end
  end
end
