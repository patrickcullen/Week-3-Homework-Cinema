require_relative( 'models/customer' )
require_relative( 'models/film' )
require_relative( 'models/ticket' )
require_relative( 'models/screening')

require( 'pry-byebug' )

Ticket.delete_all()
Film.delete_all()
Customer.delete_all()
Screening.delete_all()

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

screening1 = Screening.new({
  'film_id' => film1.id,
  'film_time' => '19:00',
  'ticket_limit' => 1
  })
screening1.save()
screening2 = Screening.new({
  'film_id' => film1.id,
  'film_time' => '21.30',
  'ticket_limit' => 4
  })
screening2.save()
screening3 = Screening.new({
  'film_id' => film2.id,
  'film_time' => '19:15',
  'ticket_limit' => 4
  })
screening3.save()
screening4 = Screening.new({
  'film_id' => film2.id,
  'film_time' => '21:00',
  'ticket_limit' => 4
  })
screening4.save()
screening5 = Screening.new({
  'film_id' => film3.id,
  'film_time' => '19:30',
  'ticket_limit' => 4
  })
screening5.save()
screening6 = Screening.new({
  'film_id' => film3.id,
  'film_time' => '21:15',
  'ticket_limit' => 4
  })
screening6.save()
screening7 = Screening.new({
  'film_id' => film4.id,
  'film_time' => '16:15',
  'ticket_limit' => 4
  })
screening7.save()
screening8 = Screening.new({
  'film_id' => film2.id,
  'film_time' => '18:00',
  'ticket_limit' => 4
  })
screening8.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening2.id
  })
ticket1.save()
ticket2 = Ticket.new({
  'customer_id' => customer3.id, 'film_id' => film1.id,  'screening_id' => screening1.id
  })
ticket2.save()
ticket3 = Ticket.new({
  'customer_id' => customer1.id, 'film_id' => film4.id,  'screening_id' => screening7.id
  })
ticket3.save()
ticket4 = Ticket.new({
  'customer_id' => customer2.id, 'film_id' => film2.id,  'screening_id' => screening3.id
  })
ticket4.save()
ticket5 = Ticket.new({
  'customer_id' => customer4.id, 'film_id' => film1.id,  'screening_id' => screening1.id
  })
ticket5.save()

binding.pry

nil
