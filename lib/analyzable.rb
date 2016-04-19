module Analyzable

  def average_price(objects_array)
    sum = objects_array.map { |object| object.price }.reduce(:+)
    return (sum / objects_array.count).round(2)
  end

  def print_report(objects_array)
    objects_array.map { |object| object.print_ready_string }.join("\n")
  end

  def count_by(attribute, objects_array)
    hash_key = objects_array[0].send(attribute)
    return Hash[hash_key, objects_array.count]
  end

  def count_by_name(objects_array)
    count_by(:name, objects_array)
  end

  def count_by_brand(objects_array)
    count_by(:brand, objects_array)
  end


end
