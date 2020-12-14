json.extract! concert, :id, :place, :attendance, :duration, :date, :created_at, :updated_at
json.url concert_url(concert, format: :json)
