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

    customer_cash = customer().cash.to_i
    film_price = film().price.to_i

    if customer_cash >= film_price

      sql = "INSERT INTO tickets (customer_id, film_id) VALUES ($1, $2) RETURNING id;"
      values = [@customer_id, @film_id]
      ticket = SqlRunner.run(sql, values ).first
      @id = ticket['id'].to_i

      remaining = customer_cash - film_price
      sql = "UPDATE customers SET cash = $1 WHERE id = $2;"
      values = [remaining, @customer_id]
      SqlRunner.run(sql, values)

    end
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
