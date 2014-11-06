require 'rails_helper'

RSpec.describe "properties/edit", :type => :view do
  before(:each) do
    @property = assign(:property, Property.create!(
      :unit_no => 1,
      :street_no => 1,
      :street => "MyString",
      :post_code => "MyString",
      :city => "MyString",
      :country => "MyString",
      :lat => "MyString",
      :lon => "MyString",
      :property_type => "MyString",
      :no_of_beds => 1,
      :no_of_baths => 1,
      :no_of_carspaces => 1
    ))
  end

  it "renders the edit property form" do
    render

    assert_select "form[action=?][method=?]", property_path(@property), "post" do

      assert_select "input#property_unit_no[name=?]", "property[unit_no]"

      assert_select "input#property_street_no[name=?]", "property[street_no]"

      assert_select "input#property_street[name=?]", "property[street]"

      assert_select "input#property_post_code[name=?]", "property[post_code]"

      assert_select "input#property_city[name=?]", "property[city]"

      assert_select "input#property_country[name=?]", "property[country]"

      assert_select "input#property_lat[name=?]", "property[lat]"

      assert_select "input#property_lon[name=?]", "property[lon]"

      assert_select "input#property_property_type[name=?]", "property[property_type]"

      assert_select "input#property_no_of_beds[name=?]", "property[no_of_beds]"

      assert_select "input#property_no_of_baths[name=?]", "property[no_of_baths]"

      assert_select "input#property_no_of_carspaces[name=?]", "property[no_of_carspaces]"
    end
  end
end
