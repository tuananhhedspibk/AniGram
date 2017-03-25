class CommentsController < ApplicationController
	def create
		@micropost = Micropost.find_by(id: params[:micropost_id])
		@comment = Comment.create(micropost_id: @micropost.id, 
			user_id: current_user.id, content: params[:content])
		if @comment.save
			create_notification @micropost, @comment
			respond_to do |format|
				format.html {redirect_to :back}
				format.js
			end
		end
	end

	def destroy
		@comment = Comment.find_by(id: params[:id])
		@notification = Notification.find_by(comment_id: @comment.id)
		if @notification != nil
			@notification.destroy
		end
		if @comment.destroy
			respond_to do |format|
				format.html {redirect_to :back}
				format.js
			end
		end
	end

	private
		def create_notification micropost, comment
			return if micropost.user.id == current_user.id
			Notification.create(user_id: micropost.user.id,
								notified_by_id: current_user.id,
								micropost_id: micropost.id,
								comment_id: comment.id,
								like_id: "",
								notifi_type: "comment")
		end
end