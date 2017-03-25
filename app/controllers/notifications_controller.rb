class NotificationsController < ApplicationController
	def link_through
		@notification = Notification.find_by(id: params[:id])
		@notification.update read: true
		redirect_to micropost_path(@notification.micropost)
	end

	def index
		@notifications = current_user.notifications.paginate(page: params[:page], 
					per_page: 6)
	end
end