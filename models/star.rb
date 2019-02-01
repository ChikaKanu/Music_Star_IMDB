require_relative("../db/sql_runner")

class Star

  attr_reader :id
  attr_accessor :first_name, :last_name

  def initialize( details )
    @id = details['id'].to_i if details['id']
    @first_name = details['first_name']
    @last_name = details['last_name']
  end

  def movie()
    sql = "SELECT movies.* FROM movies
    INNER JOIN castings
    ON castings.movie_id = movies.id
    WHERE castings.star_id = $1"
    values = [@id]
    movies = SqlRunner.run(sql, values)
    result = movies.map{|movie| Movie.new(movie)}
    return result
  end

  def save()
    sql = "INSERT INTO stars (first_name, last_name)
    VALUES( $1, $2) RETURNING id"
    values = [@first_name, @last_name]
    star = SqlRunner.run(sql, values).first
    @id = star['id'].to_i
  end

  def update()
    sql = "UPDATE stars SET(first_name, last_name)
    = ( $1, $2) WHERE id = $3"
    values = [@first_name, @last_name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM stars WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM stars"
    values = []
    stars = SqlRunner.run(sql, values)
    return stars.map{|star| Star.new(star)}
  end



  def self.delete_all()
    sql = "DELETE FROM stars"
    values = []
    SqlRunner.run(sql, values)
  end

end
