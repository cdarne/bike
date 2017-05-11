class StationsController < ApplicationController
  before_action :validate_params

  # GET /stations
  # GET /stations.json
  def index
    @stations = Station.near([params[:latitude], params[:longitude]], params[:radius], units: :km)
    @stations = @stations.where('available_bikes > 0') unless params[:empty] == 'true'
  end

  private

  def validate_params
    validator = Validators::StationsIndex.new(params)
    unless validator.valid?
      message = validator.errors.full_messages.to_sentence
      render json: { error: message }, status: :unprocessable_entity and return
    end
  end
end
