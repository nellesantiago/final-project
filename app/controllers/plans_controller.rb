class PlansController < ApplicationController
    before_action :confirm_role

    def index
    end

    def patron
        @price = 19_900
    end
    
    def benefactor
        @price = 49_900
    end

    def confirm_role
        redirect_to posts_path if current_user.admin?
    end
end