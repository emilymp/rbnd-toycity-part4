require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.create(attributes={})
    op = attributes
    new = self.new(op)
    CSV.open(@@data_path, 'a+b') do |csv|
      csv << op.values
    end
    return new
  end 

  def self.all
    #returns array of all objects in database of self's data-type
  end

  def self.first(n=1)
    #returns array of first n products
  end

  def self.last(n=1)
    #returns array of last n products
  end
  
  def self.find(id)
    #returns product with input id
  end
  def self.destroy(id)
    #remove product from database and return product object
  end
  def self.where
  end
end
