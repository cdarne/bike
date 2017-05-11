if Rails.env.test?
  ActionController::Parameters.action_on_unpermitted_parameters = :raise
end
