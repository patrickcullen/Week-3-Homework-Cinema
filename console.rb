require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({
  'name' => 'Craig Gordon',
  'cash' => 50
   })
customer1.save()

customer2 = Customer.new({
  'name' => 'Stuart Kennedy',
  'cash' => 25
   })
customer2.save()

customer3 = Customer.new({
   'name' => 'Alan Rough',
   'cash' => 20
   })
customer3.save()

customer4 = Customer.new({
   'name' => 'Jim Leighton',
   'cash' => 20
   })
customer4.save()

film1 = Film.new({
  'title' => 'Man Bites Dog',
  'price' => 5
  })
film1.save()

film2 = Film.new({
  'title' => 'Hidden',
  'price' => 4
  })
film2.save()

film3 = Film.new({
  'title' => 'Man of Marble',
  'price' => 3
  })
film3.save()

film4 = Film.new({
  'title' => 'Hoop Dreams',
  'price' => 7
  })
film4.save()

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()
ticket2 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film1.id})
ticket2.save()
ticket3 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id})
ticket3.save()
ticket4 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id})
ticket4.save()


binding.pry

nil
