# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

	# Include RMagick or MiniMagick support:
	# include CarrierWave::RMagick
	include CarrierWave::MiniMagick
	process resize_to_limit: [270, 270]

	# Choose what kind of storage to use for this uploader:
	storage :file
	# storage :fog

	# Override the directory where uploaded files will be stored.
	# This is a sensible default for uploaders that are meant to be mounted:
	def store_dir
		"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
	end

	# Provide a default URL as a default if there hasn't been a file uploaded:
	def default_url(args)
		ActionController::Base.helpers.asset_path("default-ava/" + [args].compact.join('_'))
	end

	# Process files as they are uploaded:
	#
	# def scale(width, height)
	#	process :scale => [200, 300]
	# end

	# Create different versions of your uploaded files:
	version :thumb do
		process :resize_to_fit => [150, 150]
	end

	version :thumb_small do
		process :resize_to_fit => [90, 90]
	end

	version :thumb_super_small do
		process :resize_to_fit => [60, 60]
	end

	# Add a white list of extensions which are allowed to be uploaded.
	# For images you might use something like this:
	def extension_white_list
	   %w(jpg jpeg gif png)
	end

	# Override the filename of the uploaded files:
	# Avoid using model.id or version_name here, see uploader/store.rb for details.
	# def filename
	#   "something.jpg" if original_filename
	# end
end