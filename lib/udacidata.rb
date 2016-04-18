require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"


  def self.create(attributes={})       
    new_obj = self.new(attributes)
    add_to_csv(new_obj) unless in_csv?(new_obj)
    new_obj  
  end

  def self.create_from_row(row)
    keys = row.headers
    values = row.fields
    self.new(Hash[keys.zip(values)])
  end

  def self.all
    new_array = []
    CSV.table(@@data_path).each do |row|
      new_array << row
    end
    new_array.map! { |row| self.create_from_row(row) }
  end

  def self.first(n=1)
    objects = self.all
    n > 1 ? objects.take(n) : objects[0]

  end

  def self.last(n=1)
    objects = self.all
    range_start = objects.length - n
    n > 1 ? objects[range_start..-1] : objects[-1]
  end
  
  def self.find(id)
    self.all[id - 1]
  end

  def self.destroy(id)
    table = CSV.table(@@data_path)
    deleted_row = table.delete((id - 1))
  
    CSV.open(@@data_path, "w+b") do |csv|
      csv << table.headers
      table.each do |row|
        csv << row
      end
    end
    return self.create_from_row(deleted_row)
  end

  def self.where
  end

  

  def attr_keys
    instance_variables.map { |key| key.to_s[1..-1].to_sym }
  end

  def attr_values
    instance_variables.map { |key| instance_variable_get(key) }
  end


  private

  def self.in_csv?(new_obj)
    selected = false
    CSV.table(@@data_path).each do |row|
      selected = true if row.fields(new_obj.attr_keys.to_s) == new_obj.attr_values
    end
    return selected
  end

  def self.add_to_csv(new_obj)
    CSV.open(@@data_path, 'a+b') do |csv|
      csv << new_obj.attr_values
    end
  end

end

