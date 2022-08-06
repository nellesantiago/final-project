class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
        @liked_posts = current_user.liked_posts
        @like = Like.new
    end

    def show
        @post = Post.find(params[:id])
    end

end