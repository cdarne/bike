module Validators
  class StationsIndex
    include ActiveModel::Validations

    attr_accessor :params, :latitude, :longitude, :radius, :empty

    validates :latitude, presence: true, numericality: true
    validates :longitude, presence: true, numericality: true
    validates :radius, presence: true, numericality: true
    validates :empty, presence: true, inclusion: { in: %w(true false) }

    def initialize(params={})
      (params.respond_to?(:permit) ? params : ActionController::Parameters.new(params)).
        permit(:latitude, :longitude, :radius, :empty, :format)

      @latitude  = params[:latitude]
      @longitude = params[:longitude]
      @radius = params[:radius]
      @empty = params[:empty]
    rescue ActionController::UnpermittedParameters => e
      errors.add(:base, 'unknown_parameters: ' + e.params.join(','))
    end
  end
end
