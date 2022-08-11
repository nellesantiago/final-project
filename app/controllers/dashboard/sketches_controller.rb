class Dashboard::SketchesController < ApplicationController
    before_action :check_plan
    before_action :confirm_role

    def index
        @posts = Post.where(scope: "patron")
        @liked_posts = current_user.liked_posts
        @like = Like.new
        @total_likes = Like.all.count
        @total_fans = User.where.not(role: "admin").count
        @total_posts = @posts.count
        @creator = User.find_by(role: "admin")
    end
    
    def show
        @like = Like.new
        @post = Post.find(params[:id])
    end

    private

    def check_plan
        redirect_to dashboard_index_path unless current_user.patron? || current_user.benefactor?
    end

    def confirm_role
        redirect_to posts_path if current_user.admin?
    end
end