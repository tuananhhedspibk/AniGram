class MicropostsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy

	def create
		@micropost = current_user.microposts.build(micropost_params)
		if @micropost.save
			redirect_to root_url
		else
			@feed_items = []
			flash[:danger] = @micropost.errors.full_messages.join(" & ")
			redirect_to root_url
		end
	end

	def show
		@micropost = Micropost.find_by(id: params[:id])
	end

	def destroy
		@notification = Notification.find_by(micropost_id: @micropost.id)
		@notification.destroy
		@micropost.destroy
		flash[:success] = "Post deleted"
		redirect_to request.referrer || root_url
	end

	private

		def micropost_params
			params.require(:micropost).permit(:content, :picture)
		end

		def correct_user
			@micropost = current_user.microposts.find_by(id: params[:id])
			redirect_to root_url if @micropost.nil?
		end
end