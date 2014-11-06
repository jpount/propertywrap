require 'rails_helper'

RSpec.describe "transactions/new", :type => :view do
  before(:each) do
    assign(:transaction, Transaction.new(
      :income_type => "MyString",
      :outgoing => "",
      :value => "9.99",
      :fequency => "MyString"
    ))
  end

  it "renders new transaction form" do
    render

    assert_select "form[action=?][method=?]", transactions_path, "post" do

      assert_select "input#transaction_income_type[name=?]", "transaction[income_type]"

      assert_select "input#transaction_outgoing[name=?]", "transaction[outgoing]"

      assert_select "input#transaction_value[name=?]", "transaction[value]"

      assert_select "input#transaction_fequency[name=?]", "transaction[fequency]"
    end
  end
end
