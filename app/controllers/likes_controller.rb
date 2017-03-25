class LikesController < ApplicationController
	def create
		@micropost = Micropost.where(id: params[:micropost_id]).first
		@like = Like.create(micropost_id: @micropost.id, user_id: current_user.id)
		if @like.save
			create_notification @micropost, @like
			respond_to do |format|
				format.html {redirect_to :back}
				format.js
			end
		end
	end

	def destroy
		@like = Like.find_by(id: params[:id])
		@micropost = Micropost.find_by(id: @like.micropost_id)
		@notification = Notification.find_by(like_id: @like.id)
		if @notification != nil
			@notification.destroy
		end
		if @like.destroy
			respond_to do |format|
				format.html {redirect_to :back}
				format.js
			end
		end
	end

	private
		def create_notification micropost, like
			return if micropost.user.id == current_user.id
			Notification.create(user_id: micropost.user.id,
								notified_by_id: current_user.id,
								micropost_id: micropost.id,
								like_id: like.id,
								comment_id: "",
								notifi_type: "lik")
		end
end