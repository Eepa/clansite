require 'spec_helper'

describe "tanks/new" do
  before(:each) do
    assign(:tank, stub_model(Tank,
      :name => "MyString",
      :description => "MyText",
      :country_id => 1
    ).as_new_record)
  end

  it "renders new tank form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", tanks_path, "post" do
      assert_select "input#tank_name[name=?]", "tank[name]"
      assert_select "textarea#tank_description[name=?]", "tank[description]"
      assert_select "input#tank_country_id[name=?]", "tank[country_id]"
    end
  end
end
