json.extract! event, :id, :title, :description, :strat_date, :duration, :price, :location, :created_at, :updated_at
json.url event_url(event, format: :json)
