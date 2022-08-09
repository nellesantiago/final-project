class PaymentsController < ApplicationController
    before_action :check_plan
    def card
        @payment = Paymongo::V1::Payment.new
        response = @payment.proceed(payment_info_params)
        if response == 'succeeded'
            current_user.plan = payment_info_params[:plan]
            current_user.save
            redirect_to dashboard_index_path
        end

    end

    private

    def payment_info_params
        params.require(:payment_info).permit(:name, :email, :price, :plan, :card_number, :exp_month, :exp_year, :cvc)
    end

    def check_plan
        if current_user.plan == payment_info_params[:plan] || current_user.plan == "benefactor"
            redirect_to plans_path
        end
    end
end