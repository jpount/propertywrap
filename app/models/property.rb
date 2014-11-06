class Property < ActiveRecord::Base
  has_many :transactions, :class_name => Transaction,  :dependent => :destroy
  PROPERTY_TYPE = [:house, :unit, :apartment]


  validates_presence_of :street, :street_no, :city, :country, :post_code, :purchase_date, :state
end
