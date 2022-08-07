class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
        @posts = Post.all
        @liked_posts = current_user.liked_posts
        @like = Like.new
        @total_likes = Like.all.count
        @total_fans = User.where.not(role: "admin").count
        @total_posts = @posts.count
        @creator = User.find_by(role: "admin")
    end

    def show
        @post = Post.find(params[:id])
    end

end