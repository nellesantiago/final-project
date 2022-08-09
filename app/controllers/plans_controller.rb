class PlansController < ApplicationController
    before_action :check_plan, except: %i[index]
    def index
        #show link_to redirect plans
    end

    def patron
        @price = 20_000
        #process payment and redirect
        ##
        #redirect
    end
    
    def benefactor
        @price = 50_000
        #process payment and redirect
        ##
        #redirect
    end

    private

    def check_plan
        if current_user.plan == "benefactor" || current_user.plan == action_name
            redirect_to plans_path
        end
    end
end