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
    # Auth Token generated from RP Data OAuth2
    @auth_token = 'eyJhbGciOiJSUzI1NiJ9.eyJleHAiOiIxNDE1MzQ5MDYwNTI4Iiwic2NvcGUiOiJTVFMgQ1JUIFBUWSBTR1QgVFRMIE1BUCIsInJwLnNydiI6IjI1NTU0MTc2OTM2MDIiLCJpc3MiOiJSUERhdGEub2F1dGgyIiwicnAuY2xpIjoiMGYyZGI4ZGEifQ.UfBJzqdm3FYssNUfHxoQ-c7ZMdAGZodFnVVkfsrHWLgBJWZ0R6iSymH3JWARqjnpExDv9Wxho6QpUUEns4_zN4l_OsWRb68pO6Ted5aqJiBzPfklRa8t4T7fDaHsMTndmCd5KBqrZi2xt61kUK7yBlOVx7bN-dqmOhtwM6l0-TQ'
  end

  def lookup(address)
    @json_response = RestClient.get(
        'https://rpgateway-uat.rpdata.com/bsg-au/v1/suggest.json',
        :params => {:q => address, :suggestionTypes => 'address', :returnSuggestion => 'detail'},
        :content_type => :json, :accept => :json, :Authorization => 'Bearer ' + @auth_token)

    @response = JSON.parse(@json_response)
    puts @response['suggestions'].first['propertyId']
    return @response['suggestions'].first['propertyId']
  end

 end
