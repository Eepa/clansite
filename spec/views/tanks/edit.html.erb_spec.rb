require 'spec_helper'

describe "tanks/edit" do
  before(:each) do
    @tank = assign(:tank, stub_model(Tank,
      :name => "MyString",
      :description => "MyText",
      :country_id => 1
    ))
  end

  it "renders the edit tank form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tank_path(@tank), "post" do
      assert_select "input#tank_name[name=?]", "tank[name]"
      assert_select "textarea#tank_description[name=?]", "tank[description]"
      assert_select "input#tank_country_id[name=?]", "tank[country_id]"
    end
  end
end
