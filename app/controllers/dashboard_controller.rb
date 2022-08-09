class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :check_plan, except: %i[index]

    def index
        @posts = Post.where(scope: "supporter")
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

    def patron
        @posts = Post.where(scope: "#{action_name}")
        @liked_posts = current_user.liked_posts
        @like = Like.new
        @total_likes = Like.all.count
        @total_fans = User.where.not(role: "admin").count
        @total_posts = @posts.count
        @creator = User.find_by(role: "admin")
    end

    def benefactor
        @posts = Post.where(scope: "#{action_name}")
        @liked_posts = current_user.liked_posts
        @like = Like.new
        @total_likes = Like.all.count
        @total_fans = User.where.not(role: "admin").count
        @total_posts = @posts.count
        @creator = User.find_by(role: "admin")
    end

    private

    def check_plan
        redirect_to dashboard_index_path unless current_user.plan == action_name || current_user.plan == "benefactor"
    end

end