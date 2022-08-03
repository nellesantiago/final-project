class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        if current_user.role == "fan"
        stored_location_for(resource) || dashboard_index_path
        else
        stored_location_for(resource) || creator_index_path
        end
    end
end
