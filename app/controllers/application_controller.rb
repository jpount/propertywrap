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
    auth_token = ConfigVar.where("config_type = ?", ConfigVar::OAUTH).first
    if !auth_token.nil?
      @auth_token = auth_token.config_value
    else
      @auth_token = "missing"
    end
#    @auth_token = "eyJhbGciOiJSUzI1NiJ9.eyJleHAiOiIxNDE1OTIxMjUxOTkyIiwic2NvcGUiOiJTVFMgQ1JUIFBUWSBTR1QgVFRMIE1BUCIsInJwLnNydiI6IjI1NTU0MTc2OTM2MDIiLCJpc3MiOiJSUERhdGEub2F1dGgyIiwicnAuY2xpIjoiMGYyZGI4ZGEifQ.Taqgk96l0S1TI_STxFI7RVDZYzT0nszwK1yrIo3h9gbVsiNARxK55iHP6GOcXP9Fi1rfMAVndgraUBwKRhw6QhXi_xu70NL_6ThGWwE4OdOQnelFankoegyjlkNYflM51PMe6WoSYrb4SbzIH4je3oNUk0gf_8qk_2BubmkyAtE"
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
