module Analyzable

  def average_price(objects_array)
    sum = objects_array.map { |object| object.price }.reduce(:+)
    return (sum / objects_array.count).round(2)
  end

  def print_report(objects_array)
    objects_array.map { |object| object.to_s }.join("\n")
  end

  def count_by(attribute, objects_array)
    new_hash = {}
    objects_array.each do |object|
      attribute_name = object.send(attribute)
      if new_hash.key?(attribute_name)
        new_hash["#{attribute_name}"] += 1
      else
        new_hash["#{attribute_name}"] = 1
      end
    end
    return new_hash
  end

  def count_by_name(objects_array)
    count_by(:name, objects_array)
  end

  def count_by_brand(objects_array)
    count_by(:brand, objects_array)
  end


end
