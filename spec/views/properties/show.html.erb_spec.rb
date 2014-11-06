require 'rails_helper'

RSpec.describe "properties/show", :type => :view do
  before(:each) do
    @property = assign(:property, Property.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Street/)
    expect(rendered).to match(/Post Code/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Country/)
    expect(rendered).to match(/Lat/)
    expect(rendered).to match(/Lon/)
    expect(rendered).to match(/Property Type/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
