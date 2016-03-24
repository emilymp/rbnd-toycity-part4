require 'csv'
require_relative 'schema'
require_relative 'seeds'


def write(op={})
  CSV.open('./data/data.csv', 'a+b') do |csv|
    csv << op.values
  end
end

def is_there?(op={})
  data = 
    CSV.table('./data/data.csv') do |csv|
      csv.delete_if do |row|
        op.each do |key, value|
          row.fetch(key) == value
        end
      end
    end
  return data
end

def read
  csv = CSV.table('./data/data.csv')
  puts csv
end

db_create
db_seed
write(id: 11, brand: "waltertoys", name: "sticky notes", price: 34.00)
is_there?(brand: "waltertoys", name: "sticky notes", price: 34.00)


