json.array!(@properties) do |property|
  json.extract! property, :id, :unit_no, :street_no, :street, :post_code, :city, :country, :lat, :lon, :property_type, :no_of_beds, :no_of_baths, :no_of_carspaces, :purcahse_date
  json.url property_url(property, format: :json)
end
