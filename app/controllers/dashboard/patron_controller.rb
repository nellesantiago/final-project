class Dashboard::PatronController < ApplicationController
    before_action :check_plan

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
        @post = Post.find(params[:id])
    end

    private

    def check_plan
        redirect_to dashboard_index_path unless current_user.plan == "patron" || current_user.plan == "benefactor"
    end
end