require_relative("../db/sql_runner")
require_relative("film.rb")
require_relative("customer.rb")
require_relative("ticket.rb")
# require_relative("dummyscreening.rb")

class Screening

  attr_reader :id
  attr_accessor :film_id, :time, :ticket_limit

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @film_time = options['film_time']
    @ticket_limit = options['ticket_limit']
  end

  def save()
    sql = "INSERT INTO screenings (film_id, film_time, ticket_limit) VALUES ($1, $2, $3) RETURNING id;"
    values = [@film_id, @film_time, @ticket_limit]
    ticket = SqlRunner.run(sql, values ).first
    @id = ticket['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM screenings;"
    screenings = SqlRunner.run(sql)
    result = screenings.map { |screening| Screening.new( screening ) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end

# How many tickets have been sold for screening

  def how_many_tickets()
    sql = "SELECT * FROM tickets WHERE screening_id = $1;"
    values = [@id]
    tickets = SqlRunner.run(sql, values)
    result = Ticket.map_tickets(tickets).count
  end

  # def self.film_screenings
  #   sql = "SELECT films.title, screenings.film_time FROM films
  #    INNER JOIN screenings ON screenings.film_id = films.id;"
  #   values = []
  #   screenings = SqlRunner.run(sql, values)
  #   result = Film.map_screenings(screenings)
  # end

  def self.map_screenings(screening_data)
    return screening_data.map {|screening_hash| Film.new(screening_hash)}
  end


end
