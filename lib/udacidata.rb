require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  def self.create(attributes = nil)
  # If the object's data is already in the database
  # create the object
  # return the object

  # If the object's data is not in the database
  # create the object
  # save the data in the database
  # return the object
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
