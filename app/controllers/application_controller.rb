class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout 'rails'

  rescue_from ActiveRecord::RecordNotFound do
    respond_to do |type|
      type.all  { render :nothing => true, :status => 404 }
    end
  end

  def set_oauth_property
    # Credentials supplied by RP Data
    @client_id = '0f2db8da'
    @client_secret = '26ff02b8b3372932cbffb9dd0f590711'

    json_response = RestClient.get(
        "https://rpgateway-oauth-uat.rpdata.com/auth/oauth/token",
        :params => {:grant_type => 'client_credentials', :client_id => @client_id, :client_secret => @client_secret},
        :content_type => :json, :accept => :json
    )

    response = JSON.parse(json_response)

    @auth_token = response['access_token']
    if @auth_token.nil?
      @auth_token = "missing"
    end
  end

  def lookup(address)
    json_response = RestClient.get(
        'https://rpgateway-uat.rpdata.com/bsg-au/v1/suggest.json',
        :params => {:q => address, :suggestionTypes => 'address', :returnSuggestion => 'detail'},
        :content_type => :json, :accept => :json, :Authorization => 'Bearer ' + @auth_token)

    response = JSON.parse(json_response)
    puts response['suggestions'].first['propertyId']
    return response['suggestions'].first['propertyId']
  end

 end
