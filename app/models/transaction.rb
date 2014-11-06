class Transaction < ActiveRecord::Base
  belongs_to :property

  INCOME_TYPE = [ :rent, :other]
  OUTGOING_TYPE = [ :rates, :stats, :utilities, :other]
  FREQUENCY = [:weekly, :fortnightly, :monthly, :yearly]

  scope :income, -> { where("income_type IS NOT NULL and income_type != ''") }
  scope :expense, -> { where("outgoing_type IS NOT NULL and outgoing_type != ''") }

  validate :expense_or_income

  validates_presence_of :value

  def expense_or_income
    if !(income_type.blank? ^ outgoing_type.blank?)
      errors.add(:base, "Specify an income type or expense type, not both")
    end
  end
end
