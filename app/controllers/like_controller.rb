class LikeController < ApplicationController

    def create
        @like = Like.create(like_params)
        redirect_to request.referer
    end
    
    def destroy
        @like = Like.find(params[:id])
        @like.destroy
        redirect_to request.referer
    end

    private

    def like_params
        params.require(:like).permit(:user_id, :post_id)
    end
end