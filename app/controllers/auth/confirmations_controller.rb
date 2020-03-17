# frozen_literal_string: true

module Auth
  # Controller inherited from devise to redirect to root_path after confirmation
  class ConfirmationsController < Devise::ConfirmationsController

    private

    def after_confirmation_path_for(resource_name, resource)
      root_path
    end
  end
end
