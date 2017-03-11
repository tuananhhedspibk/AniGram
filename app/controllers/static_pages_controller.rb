class StaticPagesController < ApplicationController
	def home
		if logged_in?
			@micropost = current_user.microposts.build
			@feed_items = current_user.feed.paginate(page: params[:page], per_page: 6)
		end
		if current_user != nil
			@suggestUsersIds = User.find_by_sql(
				"select id from users where id != #{current_user.id} and id not in 
				(select followed_id from relationships 
				where follower_id = #{current_user.id}) limit 3")
		end
	end
end