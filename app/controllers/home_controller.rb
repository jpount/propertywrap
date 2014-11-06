class HomeController < ApplicationController
  layout 'application'
  skip_before_filter :verify_authenticity_token

  def index
    @properties = Property.all
  end
  
end
