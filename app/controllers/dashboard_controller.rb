class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :handle_user

    def index
        @followers = current_user.followers
        @followings = current_user.followings
        @posts = @followings.each
    end

    private

    def handle_user
        if current_user.creator?
            redirect_to creator_index_path
        end
    end
end