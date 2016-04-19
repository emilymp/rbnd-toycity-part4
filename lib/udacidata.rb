require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  
  class << self
    def create(attributes={})       
      new_obj = new(attributes)
      add_to_csv(new_obj) unless in_csv?(new_obj)
      new_obj  
    end

    def create_from_row(row)
      keys = row.headers
      values = row.fields
      new(Hash[keys.zip(values)])
    end

    def all
      new_array = []
      CSV.table(@@data_path).each do |row|
        new_array << row
      end
      new_array.map! { |row| create_from_row(row) }
    end

    def first(n=1)
      objects = all
      n > 1 ? objects.take(n) : objects[0]
    end

    def last(n=1)
      objects = all
      range_start = objects.length - n
      n > 1 ? objects[range_start..-1] : objects[-1]
    end
  
    def find(id)
      all[id - 1]
    end

    def destroy(id)
      objects = all
      deleted_object = objects.slice!(id - 1)
  
      CSV.open(@@data_path, "w+b") do |csv|
        csv << objects[0].attr_keys
        objects.each do |object|
          csv << object.attr_values
        end
      end
      return deleted_object
    end

    def where(op={})
      objects = all
      found_objects = []
      op.each do |key, val|
        found_objects << objects.find_all { |obj| obj.send(key) == val }
      end
      found_objects.reduce(:&)
    end

    private

    def in_csv?(new_obj)
      selected = false
      CSV.table(@@data_path).each do |row|
        selected = true if row.fields(new_obj.attr_keys.to_s) == new_obj.attr_values
      end
      return selected
    end

    def add_to_csv(new_obj)
      CSV.open(@@data_path, 'a+b') do |csv|
        csv << new_obj.attr_values
      end
    end
  end


  def attr_keys
    instance_variables.map { |key| key.to_s[1..-1].to_sym }
  end

  def attr_values
    instance_variables.map { |key| instance_variable_get(key) }
  end


end
