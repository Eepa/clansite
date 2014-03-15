require 'spec_helper'

describe "tanks/show" do
  before(:each) do
    @tank = assign(:tank, stub_model(Tank,
      :name => "Name",
      :description => "MyText",
      :country_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
