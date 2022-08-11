class HomeController < ApplicationController
    before_action :check_user

    def index
    end

    private

    def check_user
        redirect_to dashboard_index_path if user_signed_in?
    end
end