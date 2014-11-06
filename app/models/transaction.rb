class Transaction < ActiveRecord::Base
  belongs_to :property

  INCOME_TYPE = [ :rent, :other]
  OUTGOING_TYPE = [ :rates, :stats, :utilities, :other]
  FREQUENCY = [:weekly, :fortnightly, :monthly, :yearly]
end
