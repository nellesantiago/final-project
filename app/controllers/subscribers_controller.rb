class SubscribersController < ApplicationController
    before_action :check_user
    
    def index
        @paymongo = Paymongo::V1::Payment.new
        @payments = @paymongo.get_payments
    end

    private

    def check_user
        redirect_to dashboard_index_path unless current_user.admin?
    end

end