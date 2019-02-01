require_relative("../db/sql_runner")
require_relative("star")
require_relative("movie")


class Casting

  attr_reader :id
  attr_accessor :movie_id, :star_id, :fee

  def initialize( details )
    @id = details['id'].to_i if details['id']
    @movie_id = details['movie_id'].to_i
    @star_id = details['star_id'].to_i
    @fee = details['fee'].to_i
  end


  def star()
    sql = "SELECT * FROM stars WHERE id = $1"
    values = [@star_id]
    star = SqlRunner.run(sql, values).first
    return Star.new(star)
  end

  def movie()
    sql = "SELECT * FROM movies WHERE id = $1"
    values = [@movie_id]
    movie= SqlRunner.run(sql, values).first
    return Movie.new(movie)
  end

  def save()
    sql = "INSERT INTO castings (movie_id, star_id, fee)
    VALUES( $1, $2, $3) RETURNING id"
    values = [@movie_id, @star_id, @fee]
    casting = SqlRunner.run(sql, values).first
    @id = casting['id'].to_i
  end

  def update()
    sql = "UPDATE castings SET(movie_id, star_id, fee)
    = ( $1, $2, $3) WHERE id = $4"
    values = [@movie_id, @star_id, @fee, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM castings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM castings"
    values = []
    castings = SqlRunner.run(sql, values)
    return castings.map{|casting| Casting.new(casting)}
  end

  def self.delete_all()
    sql = "DELETE FROM castings"
    values = []
    SqlRunner.run(sql, values)
  end

end
