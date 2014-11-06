class Transaction < ActiveRecord::Base
  belongs_to :property

  INCOME_TYPE = [ :rent, :other]
  OPUTGOING = [ :rates, :stats, :utilities, :other]
  #
end
