class Property < ActiveRecord::Base
  has_many :transactions, :dependent => :destroy
end
