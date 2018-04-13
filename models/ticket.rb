require_relative("../db/sql_runner")
require_relative("film.rb")
require_relative("customer.rb")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id  #screening_id here?

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    # @screening_id = options['screening_id']
  end

  def save()
    sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id;"
    values = [@customer_id, @film_id]
    ticket = SqlRunner.run(sql, values ).first
    @id = ticket['id'].to_i

    cash = @id.customer(@customer_id)
    price = @id.film(@film_id)

    # sql = "SELECT * FROM customers WHERE id = $1;"
    # values = [@customer_id]
    # cash = SqlRunner.run(sql, values )[2]

    # sql = "UPDATE customers SET (name, cash) = ($1, $2) WHERE id = $3;"
    # values = [@name, @cash, @id]
    # SqlRunner.run(sql, values)

  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def film()
    sql = "SELECT * FROM films WHERE id = $1"
    values = [@film_id]
    film_hash = SqlRunner.run(sql, values).first()
    return Film.new(film_hash)
  end

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [@customer_id]
    customer_hash = SqlRunner.run(sql, values).first()
    return Customer.new(customer_hash)
  end

end
