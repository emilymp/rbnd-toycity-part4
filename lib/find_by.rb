class Module
  def create_finder_methods(*args)
    args.each do |arg|
      finder_method = %Q{
        def find_by_#{arg.to_s}(val)
          objects = all
          found_obj = objects.find { |obj| obj.#{arg} == val }
          found_obj
        end }
        class_eval(finder_method)      
    end
  end
  create_finder_methods :brand, :price, :name
end

