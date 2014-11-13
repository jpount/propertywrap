class ChartsController < ApplicationController
  before_action :set_property
  #before_action :set_detail_property, only: [:index]

  respond_to :html, :json

  require 'rest_client'
  require 'json'

  def set_property
    # Auth Token generated from RP Data OAuth2
    @auth_token = 'eyJhbGciOiJSUzI1NiJ9.eyJleHAiOiIxNDE1MzQ5MDYwNTI4Iiwic2NvcGUiOiJTVFMgQ1JUIFBUWSBTR1QgVFRMIE1BUCIsInJwLnNydiI6IjI1NTU0MTc2OTM2MDIiLCJpc3MiOiJSUERhdGEub2F1dGgyIiwicnAuY2xpIjoiMGYyZGI4ZGEifQ.UfBJzqdm3FYssNUfHxoQ-c7ZMdAGZodFnVVkfsrHWLgBJWZ0R6iSymH3JWARqjnpExDv9Wxho6QpUUEns4_zN4l_OsWRb68pO6Ted5aqJiBzPfklRa8t4T7fDaHsMTndmCd5KBqrZi2xt61kUK7yBlOVx7bN-dqmOhtwM6l0-TQ'
  end

  def index
    @q = Property.find
    puts @q
    #@properties = @q.result
    render :json => @q, :layout => false
  end


  private

  def set_detail_property
    @property = Property.find(params[:id])
  end

end
