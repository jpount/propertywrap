class MapsController < ApplicationController
  respond_to :html, :json
  layout 'maps'

  def index
    @properties = Property.where("lat IS NOT NULL")
    @hash = Gmaps4rails.build_markers(@properties) do |prop, marker|
      marker.lat prop.lat
      marker.lng prop.lon
      marker.infowindow prop.get_search_address
    end
  end

end
