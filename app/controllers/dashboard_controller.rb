class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :handle_user

    def index
    end

    private

    def handle_user
        if current_user.creator?
            redirect_to creator_index_path
        end
    end
end