class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  def index
    @q = Property.search(params[:q])
    @properties = @q.result.order(:city).page(params[:page])
    respond_with(@properties)

  end

  def show
    respond_with(@property)
  end

  def new
    @property = Property.new
    respond_with(@property)
  end


  def create
    @property = Property.new(property_params)

    respond_to do |format|
      if @property.save
        flash[:notice] = 'Property was successfully created.'
        format.html { redirect_to(edit_property_path(@property)) }
        format.json { render xml: @property}
      else
        format.html { render action: "new" }
        format.json { render xml: @property }
      end
    end
  end

  def update
    respond_to do |format|
      if @property.update(property_params)
        flash[:notice] = 'Property was successfully updated.'
        format.html { redirect_to(edit_property_path(@property)) }
        format.json { render xml: @property}
      else
        format.html { render action: "new" }
        format.json { render xml: @property }
      end
    end
  end

  def destroy
    @property.destroy
    respond_with(@property)
  end

  private
    def set_property
      @property = Property.find(params[:id])
    end

    def property_params
      params.require(:property).permit(:unit_no, :street_no, :street, :post_code, :city, :country, :lat, :lon, :property_type, :no_of_beds, :no_of_baths, :no_of_carspaces, :purchase_date, :state)
    end
end
