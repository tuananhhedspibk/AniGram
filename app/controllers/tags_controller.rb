class TagsController < ApplicationController
	def show
		@micropost = Micropost.tagged_with(params[:id])
	end
end