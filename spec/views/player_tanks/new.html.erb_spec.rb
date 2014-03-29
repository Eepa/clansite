require 'spec_helper'

describe "player_tanks/new" do
  before(:each) do
    assign(:player_tank, stub_model(PlayerTank,
      :player_id => 1,
      :tank_id => 1,
      :rating => 1
    ).as_new_record)
  end

  it "renders new player_tank form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", player_tanks_path, "post" do
      assert_select "input#player_tank_player_id[name=?]", "player_tank[player_id]"
      assert_select "input#player_tank_tank_id[name=?]", "player_tank[tank_id]"
      assert_select "input#player_tank_rating[name=?]", "player_tank[rating]"
    end
  end
end
