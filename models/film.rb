require_relative("../db/sql_runner")
require_relative("customer.rb")
require_relative("ticket.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save()
    sql = "INSERT INTO films (title,price) VALUES ($1, $2) returning id;"
    values = [@title, @price]
    film = SqlRunner.run( sql, values ).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    films = SqlRunner.run(sql, values)
    result = Film.map_films(films)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    values = []
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3;"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

# Which customers have bought tickets for film?

  def customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON
    customers.id = tickets.customer_id WHERE tickets.film_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    result = Customer.map_customers(customers)
  end

# How many customers have bought tickets for film?

  def how_many_customers()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON
    customers.id = tickets.customer_id WHERE tickets.film_id = $1;"
    values = [@id]
    customers = SqlRunner.run(sql, values)
    result = Customer.map_customers(customers).count
  end

  def self.map_films(film_data)
    return film_data.map {|film_hash| Film.new(film_hash)}
  end

end
