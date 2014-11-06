class PropertyDetailsController < ApplicationController
  before_action :set_property
  before_action :set_detail_property, only: [:show, :image, :index]

  respond_to :html, :json

  require 'rest_client'
  require 'json'

  def set_property
    # Auth Token generated from RP Data OAuth2
    @auth_token = 'eyJhbGciOiJSUzI1NiJ9.eyJleHAiOiIxNDE1MzQ5MDYwNTI4Iiwic2NvcGUiOiJTVFMgQ1JUIFBUWSBTR1QgVFRMIE1BUCIsInJwLnNydiI6IjI1NTU0MTc2OTM2MDIiLCJpc3MiOiJSUERhdGEub2F1dGgyIiwicnAuY2xpIjoiMGYyZGI4ZGEifQ.UfBJzqdm3FYssNUfHxoQ-c7ZMdAGZodFnVVkfsrHWLgBJWZ0R6iSymH3JWARqjnpExDv9Wxho6QpUUEns4_zN4l_OsWRb68pO6Ted5aqJiBzPfklRa8t4T7fDaHsMTndmCd5KBqrZi2xt61kUK7yBlOVx7bN-dqmOhtwM6l0-TQ'
  end

  def index
#    @address = '1 Shelley Street, Sydney NSW 2000'

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
#    @address = '1 Shelley Street, Sydney NSW 2000'

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
#    @address = '1 Shelley Street, Sydney NSW 2000'
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

  private

  def set_detail_property
    @property = Property.find(params[:id])
  end

end
