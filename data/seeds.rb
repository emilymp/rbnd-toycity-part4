require 'faker'
require 'csv'
require_relative 'schema'


# This file contains code that populates the database with
# fake data for testing purposes

def db_seed
  data_path = File.dirname(__FILE__) + "/data.csv"
  CSV.open(data_path, "a+b") do |csv|
    10.times do |r|
      brand = Faker::Company.name
      product = Faker::Commerce.product_name
      price = Faker::Commerce.price
      csv << [r+1, brand, name, price]
    end
  end
end
