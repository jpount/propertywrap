require 'rails_helper'

RSpec.describe "properties/index", :type => :view do
  before(:each) do
    assign(:properties, [
      Property.create!(
        :unit_no => 1,
        :street_no => 2,
        :street => "Street",
        :post_code => "Post Code",
        :city => "City",
        :country => "Country",
        :lat => "Lat",
        :lon => "Lon",
        :property_type => "Property Type",
        :no_of_beds => 3,
        :no_of_baths => 4,
        :no_of_carspaces => 5
      ),
      Property.create!(
        :unit_no => 1,
        :street_no => 2,
        :street => "Street",
        :post_code => "Post Code",
        :city => "City",
        :country => "Country",
        :lat => "Lat",
        :lon => "Lon",
        :property_type => "Property Type",
        :no_of_beds => 3,
        :no_of_baths => 4,
        :no_of_carspaces => 5
      )
    ])
  end

  it "renders a list of properties" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "Post Code".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => "Lat".to_s, :count => 2
    assert_select "tr>td", :text => "Lon".to_s, :count => 2
    assert_select "tr>td", :text => "Property Type".to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
