class CommentsController < ApplicationController

    def create
        @comment = Comment.new(comment_params)
        if @comment.save
        redirect_to request.referer
        else
        redirect_to request.referer, alert: "Message can't be blank"
        end
    end

    def destroy
        @comment = Comment.find(params[:id])
        @comment.destroy

        redirect_to request.referer
    end

    private

    def comment_params
        params.require(:comment).permit(:message, :user_id, :post_id)
    end
end