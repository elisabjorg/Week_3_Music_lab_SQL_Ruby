
require_relative('../db/Sql_Runner.rb')
require_relative('album.rb')

class Artist

  attr_reader :id
  attr_accessor :name


  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
  end

  def albums()
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    # results = SqlRunner.run( sql, values)
    # return results.map { |album| Album.new(album)}
    return SqlRunner.run(sql,values).map { |album| Album.new(album)}
  end

  def save()
    sql = "INSERT INTO artists
          (name)
          VALUES
          ($1)
          RETURNING id"

    values = [@name]
    results = SqlRunner.run( sql , values)
    @id = results[0]['id'].to_i
  end

  def find_album
    sql = "SELECT * FROM albums WHERE artist_id = $1"
    values = [@id]
    return SqlRunner.run(sql, values).map {|album| Artist.new(album)}
  end

  # def update()
  #   sql = "UPDATE artists SET
  #         (name) = ($1)
  #         WHERE id = $2"
  #   values = [@name, @id]
  #   SqlRunner.run(sql, values)
  # end



  def self.all()
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return customers.map {|artist| Artist.new(artist)}
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end
end
