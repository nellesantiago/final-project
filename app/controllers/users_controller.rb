class UsersController < ApplicationController
    before_action :authenticate_user!
    before_action :check_user
    
    def index
        @users = User.where.not(id: current_user.id)
    end

    private

    def check_user
        redirect_to dashboard_index_path unless current_user.admin?
    end
end