require 'spec_helper'

describe "user_tanks/show" do
  before(:each) do
    @user_tank = assign(:user_tank, stub_model(UserTank,
      :user_id => 1,
      :tank_id => 2,
      :rating => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
