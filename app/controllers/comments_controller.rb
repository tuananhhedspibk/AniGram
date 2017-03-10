class CommentsController < ApplicationController
	def create
		@micropost = Micropost.find_by(id: params[:micropost_id])
		@comment = Comment.create(micropost_id: @micropost.id, 
			user_id: current_user.id, content: params[:content])
		if @comment.save
			respond_to do |format|
				format.html {redirect_to :back}
				format.js
			end
		end
	end

	def destroy
		@comment = Comment.find_by(id: params[:id])
		if @comment.destroy
			respond_to do |format|
				format.html {redirect_to :back}
				format.js
			end
		end
	end
end