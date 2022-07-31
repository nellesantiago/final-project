class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
        @followings = current_user.followings
        @posts = current_user.following_posts
    end
end