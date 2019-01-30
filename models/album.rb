

require_relative('../db/Sql_Runner.rb')
require_relative('artist.rb')

class Album

  attr_reader :id
  attr_accessor :name, :genre, :artist_id


  def initialize(details)
    @id = details['id'].to_i if details['id']
    @name = details['name']
    @genre = details['genre']
    @artist_id = details['artist_id']
  end

  def artist
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [@artist_id]
    # results = SqlRunner.run( sql, values )
    # artist_data = results[0]

    artist_data = SqlRunner.run( sql, values)[0]

    return Artist.new( artist_data )
  end

  def save()
    sql = "INSERT INTO albums
          (name, genre, artist_id)
          VALUES
          ($1, $2, $3)
          RETURNING id"

    values = [@name, @genre, @artist_id]
    results = SqlRunner.run( sql , values)
    @id = results[0]['id'].to_i
  end





  def self.delete_all()
    sql = "DELETE FROM albums"
    SqlRunner.run(sql)
  end

end
