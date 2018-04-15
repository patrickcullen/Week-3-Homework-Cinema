require_relative("../db/sql_runner")
require_relative("film.rb")
require_relative("customer.rb")
require_relative("screening.rb")

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :screening_id

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end

  def save()

# Save number of tickets sold for particular screening

    sql = "SELECT * FROM tickets WHERE screening_id = $1;"
    values = [@screening_id]
    tickets = SqlRunner.run(sql, values )
    ticket_count = Ticket.map_tickets(tickets).count

# Save amount of cash customer has and price of ticket for film customer wants to see

    customer_cash = customer().cash.to_i
    film_price = film().price.to_i

# Sell ticket only if customer has enough money and there are enough seats

    if customer_cash >= film_price && ticket_count < screening.ticket_limit.to_i

      sql = "INSERT INTO tickets (customer_id, film_id, screening_id) VALUES ($1, $2, $3) RETURNING id;"
      values = [@customer_id, @film_id, @screening_id]
      ticket = SqlRunner.run(sql, values ).first
      @id = ticket['id'].to_i

# Subtract price of ticket from customer's cash

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
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

# Tickets have been sold for which films?

  def film()
    sql = "SELECT * FROM films WHERE id = $1;"
    values = [@film_id]
    film_hash = SqlRunner.run(sql, values).first()
    return Film.new(film_hash)
  end

# Customers have tickets for which films?

  def customer()
    sql = "SELECT * FROM customers WHERE id = $1;"
    values = [@customer_id]
    customer_hash = SqlRunner.run(sql, values).first()
    return Customer.new(customer_hash)
  end

# Tickets have been sold for which screenings?

  def screening()
    sql = "SELECT * FROM screenings WHERE id = $1;"
    values = [@screening_id]
    screening_hash = SqlRunner.run(sql, values).first()
    return Screening.new(screening_hash)
  end

  def self.map_tickets(ticket_data)
    return ticket_data.map {|ticket_hash| Ticket.new(ticket_hash)}
  end

end
