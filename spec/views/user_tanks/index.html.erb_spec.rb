require 'spec_helper'

describe "user_tanks/index" do
  before(:each) do
    assign(:user_tanks, [
      stub_model(UserTank,
        :user_id => 1,
        :tank_id => 2,
        :rating => 3
      ),
      stub_model(UserTank,
        :user_id => 1,
        :tank_id => 2,
        :rating => 3
      )
    ])
  end

  it "renders a list of user_tanks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
