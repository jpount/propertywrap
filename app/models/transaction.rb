class Transaction < ActiveRecord::Base
  belongs_to :property

  INCOME_TYPE = [ :rent, :other]
  OUTGOING_TYPE = [ :rates, :stats, :utilities, :other]
end
