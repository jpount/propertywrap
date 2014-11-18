class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @q = Property.search(params[:q])
    @properties = @q.result.order(:city).page(params[:page])
    respond_with(@properties)
  end

  def maps
    @properties = Property.all
    @hash = Gmaps4rails.build_markers(@properties) do |prop, marker|
      marker.lat prop.lat
      marker.lng prop.lon
    end
  end

  def show
    respond_with(@property)
  end

  def new
    @property = Property.new
    respond_with(@property)
  end

  def create
    @property = Property.new(property_params)
    get_first_image(@property)
    respond_to do |format|
      if @property.save
        flash[:notice] = 'Property was successfully created.'
        format.html { redirect_to(edit_property_path(@property)) }
        format.json { render xml: @property}
      else
        format.html { render action: "new" }
        format.json { render xml: @property }
      end
    end
  end

  def update

    @property.update(property_params)
    get_first_image(@property)
    respond_to do |format|
      if @property.save
        flash[:notice] = 'Property was successfully updated.'
        format.html { redirect_to(edit_property_path(@property)) }
        format.json { render xml: @property}
      else
        format.html { render action: "new" }
        format.json { render xml: @property }
      end
    end
  end

  def destroy
    @property.destroy
    respond_with(@property)
  end

  private

  def get_first_image(prop)
    begin
      set_oauth_property
      @address = prop.get_search_address
      logger.info "Searching for: #{@address}"
      @propertyId = lookup(@address)
      @json_response = RestClient.get(
          "https://rpgateway-uat.rpdata.com/bsg-au/v1/property/#{@propertyId}.json",
          :params => {:returnFields => 'propertyPhotoList,coordinate'},
          :content_type => :json, :accept => :json, :Authorization => 'Bearer ' + @auth_token)
      @resp = JSON.parse(@json_response)
      if @resp['property'].blank?
        prop.img_url = 'image-missing.png'
      else
        prop.img_url = @resp['property']['propertyPhotoList'].first['mediumPhotoUrl']
        if !@resp['property']['coordinate'].blank?
          prop.lat = @resp['property']['coordinate']['latitude']
          prop.lon = @resp['property']['coordinate']['longitude']
        end
      end
    rescue Exception => e
      logger.warn "Error calling the API: #{e}"
      prop.img_url = 'image-missing.png'
    end
  end

  def set_property
      @property = Property.find(params[:id])
    end

    def property_params
      params.require(:property).permit(:unit_no, :street_no, :street, :post_code, :city, :country, :lat, :lon, :property_type, :no_of_beds, :no_of_baths, :no_of_carspaces, :purchase_date, :state)
    end
end
