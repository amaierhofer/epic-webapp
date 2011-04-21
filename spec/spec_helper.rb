require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/core'
  require 'rspec/expectations'
  require 'rspec/core/expecting/with_rspec'
  require 'rspec/core/formatters/progress_formatter'
  require 'rspec/core/formatters/base_text_formatter'
  require 'rspec/rails'

  RSpec.configure do |config|
    config.mock_with :rspec
  end

end

Spork.each_run do
  Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
end

