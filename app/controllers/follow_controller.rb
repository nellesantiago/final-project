class FollowController < ApplicationController
    before_action :authenticate_user!

    def create
        @follow = Follow.create(follow_params)
        redirect_to request.referer
    end
    
    def destroy
        @follow = Follow.find(params[:id])
        @follow.destroy
        redirect_to request.referer
    end

    private

    def follow_params
        params.require(:follow).permit(:follower_id, :followed_id)
    end
end