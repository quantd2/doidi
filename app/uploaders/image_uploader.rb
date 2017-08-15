class ImageUploader < CarrierWave::Uploader::Base
  # include ::CarrierWave::Backgrounder::Delay
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # include CarrierWave::MimeTypes
  # process :set_content_type

  # Choose what kind of storage to use for this uploader:
  # storage :file
  Rails.env.development? ? (storage :file) : (storage :fog)

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if model.class.to_s.underscore == "form_user"
      name = model.class.to_s.underscore.gsub('form_user','user')
      return "uploads/#{name}/#{mounted_as}/#{model.id}"
    else
      return "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end
  def default_url(*args)
    ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # process resize_to_fit: [300, 300]

  version :thumb do
    process resize_to_fill: [110, 110]
  end

  version :medium do
    process resize_to_fill: [150, 150]
  end

  version :large do
    process resize_to_fit: [960, 640]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg png gif)
  end

  def size_range
    0..2.megabytes
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
