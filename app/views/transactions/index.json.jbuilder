json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :income_type, :outgoing, :value, :fequency, :last_due
  json.url transaction_url(transaction, format: :json)
end
