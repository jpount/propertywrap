require 'rails_helper'

RSpec.describe "transactions/index", :type => :view do
  before(:each) do
    assign(:transactions, [
      Transaction.create!(
        :income_type => "Income Type",
        :outgoing => "",
        :value => "9.99",
        :fequency => "Fequency"
      ),
      Transaction.create!(
        :income_type => "Income Type",
        :outgoing => "",
        :value => "9.99",
        :fequency => "Fequency"
      )
    ])
  end

  it "renders a list of transactions" do
    render
    assert_select "tr>td", :text => "Income Type".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
    assert_select "tr>td", :text => "Fequency".to_s, :count => 2
  end
end
