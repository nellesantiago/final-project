class PaymentsController < ApplicationController
    before_action :check_plan
    
    def card
        @payment = Paymongo::V1::Payment.new
        response = @payment.proceed(payment_info_params)
        if response == 'succeeded'
            current_user.plan = payment_info_params[:plan]
            current_user.save
            redirect_to dashboard_index_path
        elsif response.has_key?("errors") && fraud?(response["errors"].first["detail"])
            redirect_to request.referer, alert: "Something went wrong, please try again later"
        else
            redirect_to request.referer, alert: "#{response["errors"].first["detail"].split("details.").last.gsub("_", " ").capitalize}"
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

    def fraud?(str)
        code = ["fraudulent", "processor_blocked", "lost_card", "stolen_card", "blocked"]
        code.each do |e|
            return true if str.downcase.include? e
        end
        return false
    end
end