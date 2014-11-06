class ImagesController < ApplicationController
  before_action :set_property
  respond_to :html, :json

  require 'rest_client'
  require 'json'


  def set_property
    # Auth Token generated from RP Data OAuth2
    @auth_token = 'eyJhbGciOiJSUzI1NiJ9.eyJleHAiOiIxNDE1MzQ5MDYwNTI4Iiwic2NvcGUiOiJTVFMgQ1JUIFBUWSBTR1QgVFRMIE1BUCIsInJwLnNydiI6IjI1NTU0MTc2OTM2MDIiLCJpc3MiOiJSUERhdGEub2F1dGgyIiwicnAuY2xpIjoiMGYyZGI4ZGEifQ.UfBJzqdm3FYssNUfHxoQ-c7ZMdAGZodFnVVkfsrHWLgBJWZ0R6iSymH3JWARqjnpExDv9Wxho6QpUUEns4_zN4l_OsWRb68pO6Ted5aqJiBzPfklRa8t4T7fDaHsMTndmCd5KBqrZi2xt61kUK7yBlOVx7bN-dqmOhtwM6l0-TQ'
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
