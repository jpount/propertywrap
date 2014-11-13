class PropertyDetailsController < ApplicationController
  before_action :set_property
  before_action :set_detail_property, only: [:show, :image, :index, :by_state]

  respond_to :html, :json

  require 'rest_client'
  require 'json'

  def set_property
    set_oauth_property
  end

  def index
    begin
      @address = @property.get_search_address
      @propertyId = lookup(@address)

      @json_response = RestClient.get(
          "https://rpgateway-uat.rpdata.com/bsg-au/v1/property/#{@propertyId}.json",
          :params => {:returnFields => 'address,attributes,coordinate,title,saleList,forRentPropertyCampaignList'},
          :content_type => :json, :accept => :json, :Authorization => 'Bearer ' + @auth_token)

      @response = JSON.parse(@json_response)
    rescue Exception => e
      logger.warn "Error calling the API: #{e}"
      @response = {}
    end

    respond_with(@response)
  end

  def show
    begin
      @address = @property.get_search_address
      @propertyId = lookup(@address)

      @json_response = RestClient.get(
          "https://rpgateway-uat.rpdata.com/bsg-au/v1/property/#{@propertyId}.json",
          :params => {:returnFields => 'propertyPhotoList,address,attributes,coordinate,title,saleList,forRentPropertyCampaignList'},
          :content_type => :json, :accept => :json, :Authorization => 'Bearer ' + @auth_token)

      @response = JSON.parse(@json_response)
    rescue Exception => e
      logger.warn "Error calling the API: #{e}"
      @response = {}
    end

    respond_with(@response)
  end

  def image
    begin
      @address = @property.get_search_address
      @propertyId = lookup(@address)

      @json_response = RestClient.get(
          "https://rpgateway-uat.rpdata.com/bsg-au/v1/property/#{@propertyId}.json",
          :params => {:returnFields => 'propertyPhotoList'},
          :content_type => :json, :accept => :json, :Authorization => 'Bearer ' + @auth_token)

      @response = JSON.parse(@json_response)
    rescue Exception => e
      logger.warn "Error calling the API: #{e}"
      @response = {}
    end
    render :json => @response, :layout => false
  end

  def by_state
    @q = Property.find(:all)
    @properties = @q.result
    render :json => @properties, :layout => false
  end

  private

  def set_detail_property
    @property = Property.find(params[:id])
  end

end
