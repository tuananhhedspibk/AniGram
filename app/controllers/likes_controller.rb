class LikesController < ApplicationController
	def create
		@micropost = Micropost.where(id: params[:micropost_id]).first
		@like = Like.create(micropost_id: @micropost.id, user_id: current_user.id)
		if @like.save
			respond_to do |format|
				format.html {redirect_to :back}
				format.js
			end
		end
	end

	def destroy
		@like = Like.find_by(id: params[:id])
		@micropost = Micropost.find_by(id: @like.micropost_id)
		if @like.destroy
			respond_to do |format|
				format.html {redirect_to :back}
				format.js
			end
		end
	end
end