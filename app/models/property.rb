class Property < ActiveRecord::Base
  has_many :transactions, :class_name => Transaction,  :dependent => :destroy
  PROPERTY_TYPE = [:house, :unit, :apartment]


end
