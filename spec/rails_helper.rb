ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'stripe_mock'
require "rack_session_access/capybara"

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.before(:each) do 
    5.times do 
      Item.create(
        title: Faker::Commerce.product_name, 
        inventory: 1, 
        price: Faker::Commerce.price
      )
      Category.create(title: Faker::Commerce.department)
      counter = 1
      Item.all.each do |item|
        item.category_id = counter
        item.save
        counter += 1
      end
      Cart.create
    end
  end

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
end

Capybara.javascript_driver = :webkit