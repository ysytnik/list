class CoordinatesController < ApplicationController

  def index
    @coordinates = Coordinate.order(:first_name).all

  end

  def show
    @coordinates = Coordinate.order(:first_name).all

  end


  def import
    Coordinate.import(params[:file])
    flash.notice = "List successfully imported"
    redirect_to root_url
  end


end
