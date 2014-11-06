require 'rails_helper'

RSpec.describe "transactions/show", :type => :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      :income_type => "Income Type",
      :outgoing => "",
      :value => "9.99",
      :fequency => "Fequency"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Income Type/)
    expect(rendered).to match(//)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/Fequency/)
  end
end
