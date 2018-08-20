# Simple Typeahead for cities
class Api::CitiesController < ApplicationController
  def index
    unless params[:name].present?
      render status: 422, json: {}
      return
    end

    @cities = City.where('name LIKE ?', "#{params[:name].strip}%")
    render status: 200, json: @cities
  end
end
