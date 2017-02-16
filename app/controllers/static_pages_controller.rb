class StaticPagesController < ApplicationController
	def home
		if logged_in?
			@micropost = current_user.micropost.build
			@feed_items = current_user.feed
		end
	end
end