require_relative("../db/sql_runner")

class Movie

  attr_reader :id
  attr_accessor :title, :genre

  def initialize( details )
    @id = details['id'].to_i if details['id']
    @title = details['title']
    @genre = details['genre']
  end

  def star()
    sql = "SELECT stars.* FROM stars INNER JOIN castings ON castings.star_id = stars.id
  WHERE castings.movie_id = $1"
    values = [@id]
    stars = SqlRunner.run(sql, values)
    result = stars.map {|star| Star.new(star)}
    return result
  end


  def save()
    sql = "INSERT INTO movies (title, genre)
    VALUES( $1, $2) RETURNING id"
    values = [@title, @genre]
    movie = SqlRunner.run(sql, values).first
    @id = movie['id'].to_i
  end

  def update()
    sql = "UPDATE movies SET(title, genre)
    = ( $1, $2) WHERE id = $3"
    values = [@title, @genre, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM movies WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def self.all()
    sql = "SELECT * FROM movies"
    values = []
    movies = SqlRunner.run(sql, values)
    return movies.map{|movie| Movie.new(movie)}
  end

  def self.delete_all()
    sql = "DELETE FROM movies"
    values = []
    SqlRunner.run(sql, values)
  end

end
