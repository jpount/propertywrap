class Property < ActiveRecord::Base
  has_many :transactions
end
