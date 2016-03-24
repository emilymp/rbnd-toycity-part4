require 'csv'
require_relative 'schema'
require_relative 'seeds'


def write(op={})
  CSV.open('./data/data.csv', 'a+b') do |csv|
    csv << op.values
  end
end

def read
  csv = CSV.table('./data/data.csv')
  puts csv
end

db_create
db_seed
write(id: 11, brand: "waltertoys", name: "sticky notes", price: 34.00)
read

