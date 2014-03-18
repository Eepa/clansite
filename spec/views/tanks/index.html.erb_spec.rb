require 'spec_helper'

describe "tanks/index" do
=begin
  before(:each) do
    assign(:tanks, [
      stub_model(Tank,
        :name => "Name",
        :description => "MyText",
        :country_id => 1
      ),
      stub_model(Tank,
        :name => "Name",
        :description => "MyText",
        :country_id => 1
      )
    ])
  end

  it "renders a list of tanks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
=end
end
