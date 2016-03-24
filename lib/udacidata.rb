require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  @@data_base = {}


  def self.create(attributes={})
    op = attributes
    new_obj = self.new(op)
    CSV.open(@@data_path, 'a+b') do |csv|
      csv << op.values
    end
    add(new_obj)
    
  end 

  def self.all
    @@data_base[self.name.to_sym]
  end

  def self.first(n=1)
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

  private 

  def self.add(new_obj)
    @@data_base.key?(self.name.to_sym) ? @@data_base[self.name.to_sym].push(new_obj) : @@data_base[self.name.to_sym]= [new_obj]
    return new_obj
  end

end
