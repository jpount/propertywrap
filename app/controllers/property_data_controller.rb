class PropertyDataController < ApplicationController
  before_action :set_property
  respond_to :html, :json

  require 'rest_client'
  require 'json'


  def set_property
    # Auth Token generated from RP Data OAuth2
    @auth_token = 'eyJhbGciOiJSUzI1NiJ9.eyJleHAiOiIxNDE1Mjk1MzE2NTY3Iiwic2NvcGUiOiJTVFMgQ1JUIFBUWSBTR1QgVFRMIE1BUCIsInJwLnNydiI6IjI1NTU0MTc2OTM2MDIiLCJpc3MiOiJSUERhdGEub2F1dGgyIiwicnAuY2xpIjoiMGYyZGI4ZGEifQ.qAovE6xGAwcNkOaSYhk_Pj6w9PSXWIt3EhPkAD_iqJlT2193CmdnuFx6O236aXKSEeRxV00p_KL47kON3L0lmB6eXKX-9vrLABVN2LzaI-PV32SLt6gWqzWkfoi647DBJzZ073BouvjeuP7gXmRsWYfZY2u8Tpz-Ou-jlWiKcGU'
  end

  def index
    @json_response = RestClient.get(
        'https://rpgateway-uat.rpdata.com/bsg-au/v1/property/14326305.json',
        :params => {:returnFields => 'address,attributes,coordinate,title,saleList,forRentPropertyCampaignList'},
        :content_type => :json, :accept => :json, :Authorization => 'Bearer ' + @auth_token)

    @response = JSON.parse(@json_response)

    respond_with(@response)
  end

  def show
    @json_response = RestClient.get(
        'https://rpgateway-uat.rpdata.com/bsg-au/v1/property/14326305.json',
        :params => {:returnFields => 'propertyPhotoList'},
        :content_type => :json, :accept => :json, :Authorization => 'Bearer ' + @auth_token)

    @response = JSON.parse(@json_response)

    respond_with(@response)
  end

end
