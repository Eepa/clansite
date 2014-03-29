require 'spec_helper'

describe "player_tanks/show" do
  before(:each) do
    @player_tank = assign(:player_tank, stub_model(PlayerTank,
      :player_id => 1,
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
