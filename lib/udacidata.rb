require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  @@data_base = {}


  def self.create(attributes={})    
    id = get_id_csv(attributes)
    attributes[:id] = id if id
    
    new_obj = self.new(attributes)
    
    add_to_csv(new_obj) 
    add_to_class_db(new_obj)
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

  def to_csv_row
    CSV::Row.new(attr_keys, attr_values)
  end

  def attr_keys
    instance_variables.map { |key| key.to_s[1..-1].to_sym }
  end

  def attr_values
    instance_variables.map { |key| instance_variable_get(key) }
  end

  private

  
  def self.add_to_class_db(new_obj)
    @@data_base.key?(self.name.to_sym) ? @@data_base[self.name.to_sym].push(new_obj) : @@data_base[self.name.to_sym] = [new_obj]
    return new_obj
  end

  def self.get_id_csv(attributes)
    selected = {}
    CSV.table(@@data_path).each do |row|
      selected = row if row.fields(attributes.keys.to_s) == attributes.values
    end
    return selected[:id]
  end

  def self.add_to_csv(new_obj)
    CSV.open(@@data_path, 'a+b') do |csv|
      csv << new_obj.attr_values
    end
  end

end

