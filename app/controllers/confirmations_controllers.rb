class ConfirmationsController < Devise::ConfirmationsController

  private
    def after_confirmation_path_for(resource_name, resource)
      sign_in(resource)
      new_confirmation_path(resource_name)
    end
    end
end
