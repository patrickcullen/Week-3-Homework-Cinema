require_relative("../db/sql_runner")
require_relative("film.rb")
require_relative("ticket.rb")

class Customer

  attr_reader :id
  attr_accessor :name, :cash

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @cash = options['cash']
  end

  def save()
    sql = "INSERT INTO customers (name, cash) VALUES ($1, $2) RETURNING id;"
    values = [@name, @cash]
    customer = SqlRunner.run( sql, values ).first
    @id = customer['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = Customer.map_customers(customers)
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

  def update()
    sql = "UPDATE customers SET (name, cash) = ($1, $2) WHERE id = $3;"
    values = [@name, @cash, @id]
    SqlRunner.run(sql, values)
  end

# Customer has bought tickets for which films?

  def films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON
    films.id = tickets.film_id WHERE tickets.customer_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = Film.map_films(films)
  end

# Customer has tickets for how many films?

  def how_many_films()
    sql = "SELECT films.* FROM films INNER JOIN tickets ON
    films.id = tickets.film_id WHERE tickets.customer_id = $1;"
    values = [@id]
    films = SqlRunner.run(sql, values)
    result = Film.map_films(films).count
  end

  # Customer has bought tickets for which films? 

  def tickets_bought()
    sql = "SELECT * FROM tickets WHERE customer_id = $1;"
    values = [@id]
    ticket_hash = SqlRunner.run(sql, values)
    result = Ticket.map_tickets(ticket_hash)
  end

  def self.map_customers(customer_data)
    return customer_data.map {|customer_hash| Customer.new(customer_hash)}
  end

end
