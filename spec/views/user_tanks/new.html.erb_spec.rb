require 'spec_helper'

describe "user_tanks/new" do
  before(:each) do
    assign(:user_tank, stub_model(UserTank,
      :user_id => 1,
      :tank_id => 1,
      :rating => 1
    ).as_new_record)
  end

  it "renders new user_tank form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", user_tanks_path, "post" do
      assert_select "input#user_tank_user_id[name=?]", "user_tank[user_id]"
      assert_select "input#user_tank_tank_id[name=?]", "user_tank[tank_id]"
      assert_select "input#user_tank_rating[name=?]", "user_tank[rating]"
    end
  end
end
