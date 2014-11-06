class Property < ActiveRecord::Base
  has_many :transactions, :class_name => Transaction,  :dependent => :destroy
end
