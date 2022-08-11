class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :confirm_role

    def index
        @supporter_posts = Post.where(scope: "supporter")
        @patron_posts = Post.where.not(scope: "benefactor")
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
        @like = Like.new
        @creator = User.find_by(role: "admin")
    end 

    private

    def confirm_role
        redirect_to posts_path if current_user.admin?
    end

end