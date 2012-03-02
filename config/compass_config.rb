configure do
  Compass.configuration do |config|
    config.sass_dir = 'views/stylesheets'
    config.images_dir = 'public/images'
    config.http_images_path = File.join(config.http_path, 'images')
    config.line_comments = false
  end
end

