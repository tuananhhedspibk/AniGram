module ApplicationHelper
	def full_title page_title = ''
		base_title = "Anigram"
		if page_title.empty?
			base_title
		else
			page_title
		end
	end

	def get_suggest_user_id
		if current_user != nil
			@suggestUsersIds = User.find_by_sql(
				"select id from users where id != #{current_user.id} and id not in 
				(select followed_id from relationships 
				where follower_id = #{current_user.id}) limit 3")
		end
	end
end