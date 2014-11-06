require 'rails_helper'

RSpec.describe "transactions/edit", :type => :view do
  before(:each) do
    @transaction = assign(:transaction, Transaction.create!(
      :income_type => "MyString",
      :outgoing => "",
      :value => "9.99",
      :fequency => "MyString"
    ))
  end

  it "renders the edit transaction form" do
    render

    assert_select "form[action=?][method=?]", transaction_path(@transaction), "post" do

      assert_select "input#transaction_income_type[name=?]", "transaction[income_type]"

      assert_select "input#transaction_outgoing[name=?]", "transaction[outgoing]"

      assert_select "input#transaction_value[name=?]", "transaction[value]"

      assert_select "input#transaction_fequency[name=?]", "transaction[fequency]"
    end
  end
end
