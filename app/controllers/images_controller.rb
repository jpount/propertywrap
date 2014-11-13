class ImagesController < ApplicationController
  before_action :set_property
  respond_to :html, :json

  require 'rest_client'
  require 'json'


  def set_property
    set_oauth_property
  end

  def lookup(address)
    @json_response = RestClient.get(
        'https://rpgateway-uat.rpdata.com/bsg-au/v1/suggest.json',
        :params => {:q => address, :suggestionTypes => 'address', :returnSuggestion => 'detail'},
        :content_type => :json, :accept => :json, :Authorization => 'Bearer ' + @auth_token)

    @response = JSON.parse(@json_response)

    unless @response['suggestions'].blank?
      puts @response['suggestions'].first['propertyId']
      return @response['suggestions'].first['propertyId']
    end
    return nil
  end

  def index
    @address = params[:address]
    puts @address
    @propertyId = lookup(@address)
    puts @propertyId

    unless @propertyId.blank?
      @json_response = RestClient.get(
          "https://rpgateway-uat.rpdata.com/bsg-au/v1/property/#{@propertyId}.json",
          :params => {:returnFields => 'propertyPhotoList'},
          :content_type => :json, :accept => :json, :Authorization => 'Bearer ' + @auth_token)

      @response = JSON.parse(@json_response)
    end

    if @response['property'].blank?
      respond_with('Not found')
    else
      respond_with(@response['property']['propertyPhotoList'].first['mediumPhotoUrl'])
    end
  end

end
