class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
        @followings = current_user.followings
        @posts = current_user.following_posts
        @liked_posts = current_user.liked_posts
        @like = Like.new
    end
end