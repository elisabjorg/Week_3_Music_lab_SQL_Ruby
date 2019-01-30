require('pry')
require_relative('../models/album.rb')
require_relative('../models/artist.rb')

  Album.delete_all
  Artist.delete_all

artist1 = Artist.new({
    'name' => 'Michael Jackson'
  })

  artist1.save()

  artist2 = Artist.new({
    'name' => 'Shakira'
    })

    artist2.save()

    album1 = Album.new({
      'name' => 'bad',
      'genre' => 'pop',
      'artist_id' => artist1.id
      })

    album1.save()


    binding.pry
    nil
