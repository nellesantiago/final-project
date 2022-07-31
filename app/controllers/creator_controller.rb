class CreatorController < ApplicationController
    before_action :authenticate_user!
    before_action :handle_user

    def index
        @followers = current_user.followers
        @posts = current_user.posts
    end

    private

    def handle_user
        if current_user.fan?
            redirect_to dashboard_index_path
        end
    end
end