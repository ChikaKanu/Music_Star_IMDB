require_relative( 'models/casting' )
require_relative( 'models/star' )
require_relative( 'models/movie' )

require( 'pry' )

Casting.delete_all()
Star.delete_all()
Movie.delete_all()

star1 = Star.new({ 'first_name' => 'Brad', 'last_name' =>'Pitt' })
star1.save()
star2 = Star.new({ 'first_name' => 'Julia', 'last_name' =>'Roberts' })
star2.save()


movie1 = Movie.new({ 'title' => 'Benjamin Button', 'genre' => 'Drama'})
movie1.save()
movie2 = Movie.new({ 'title' => 'Pretty Woman', 'genre' => 'Romantic Comedy'})
movie2.save()
movie3 = Movie.new({ 'title' => 'Oceans11', 'genre' => 'Comedy'})
movie3.save()

casting1 = Casting.new({'movie_id' => movie1.id, 'star_id' => star1.id, 'fee' => 1000000})
casting1.save()
casting2 = Casting.new({'movie_id' => movie2.id, 'star_id' => star2.id, 'fee' => 2000000})
casting2.save()
casting3 = Casting.new({'movie_id' => movie3.id, 'star_id' => star1.id, 'fee' => 2000000})
casting3.save()
casting4 = Casting.new({'movie_id' => movie3.id, 'star_id' => star2.id, 'fee' => 4000000})
casting4.save()

stars = Star.all()
movie = Movie.all()
# star1.delete()
# movie1.delete()
# casting1.delete()
# star1.first_name = 'chika'
# star1.update
# movie1.title = 'Pretty Woman 2'
# movie1.update
# casting2.fee = 100000000
# casting2.update


binding.pry
nil
