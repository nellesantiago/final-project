class CommentsController < ApplicationController

    def create
        @comment = Comment.new(comment_params)
        @comment.save
        redirect_to request.referer
    end

    private

    def comment_params
        params.require(:comment).permit(:message, :user_id, :post_id)
    end
end