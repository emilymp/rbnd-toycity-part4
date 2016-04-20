require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata

  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"
  
  class << self
    def create(*attributes)       
      new_obj = new(*attributes)
      append_to_csv(new_obj) unless new_obj.in_csv?
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
      found = all.find { |object| object.send(:id) == id }
      return found ? found : (raise IDNotFoundError, "no object with id: #{id} exists")
    end

    def destroy(id)
      replace(id) || (raise IDNotFoundError, "no object with id: #{id} exists")
    end

    def where(op={})
      objects = all
      found_objects_list = []
      op.each do |key, val|
        found_objects_list << objects.select { |obj| obj.send(key) == val }
      end
      found_objects_list.reduce(:&).flatten 
    end

    def append_to_csv(*objects)
      CSV.open(@@data_path, 'a+b') do |csv|         
        objects.each do |object|      
          csv << object.attr_values
        end
      end
    end

    def clean_csv(headers)
      CSV.open(@@data_path, "w+b") do |csv|
        csv << headers
      end
    end

    def replace(id, new_obj = false)
      objects = all
      i = objects.index { |obj| obj.send(:id) == id }
      return_object = i ? objects.slice!(i) : false
      
      if new_obj
        objects.insert(i, new_obj) 
        return_object = new_obj
      end
      
      clean_csv(objects[0].attr_keys) if return_object
      append_to_csv(*objects) if return_object
      
      return return_object
    end

  end

  def in_csv?
    selected = false
    CSV.table(@@data_path).each do |row|
      selected = true if row.fields(*self.attr_keys) == self.attr_values
    end
    return selected
  end

  def to_s
    self.attr_keys.zip(attr_values).join(", ")
  end

  def attr_keys
    instance_variables.map { |key| key.to_s[1..-1].to_sym }
  end

  def attr_values
    instance_variables.map { |key| instance_variable_get(key) }
  end

  def update(op={})
    old_id = self.attr_values[0]
    op.each do |key, val|
      self.send("#{key}=".to_sym, val)
    end
    self.class.replace(old_id, self)
  end

end
