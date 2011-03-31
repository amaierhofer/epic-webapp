raw_config = File.read("#{Rails.root}/config/app_config.yml")
puts ">>>>>"
puts "Loading APP Config for Rails.env: #{Rails.env}" 
puts ">>>>>"
APP_CONFIG = YAML.load(raw_config)[Rails.env].symbolize_keys

