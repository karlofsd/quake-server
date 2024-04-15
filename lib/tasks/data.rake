namespace :data do
	desc "Load data from API"
	task load: :environment do 
		puts "Getting data from external API ..."
		response = RestClient.get("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_month.geojson")
		data = JSON.parse(response)
		if data["features"] != nil
			puts "Loading data to database ..."
			data["features"].each do |feature|
				props = feature["properties"]
				
				Feature.create(
					external_id: feature["id"],
					magnitude: props["mag"],
					place: props["place"],
					time: props["time"],
					external_url: props["url"],
					tsunami: props["tsunami"],
					mag_type: props["magType"],
					title: props["title"],
					type: feature["type"],
					coordinate: Coordinate.create(
						longitude: feature["geometry"]["coordinates"][0],
						latitude: feature["geometry"]["coordinates"][1]
						)
				)
				
			end
			puts "Data load was completed"
		else
			puts "No data found!"
		end
	end

	desc "Load magnitude types"
	task types: :environment do
		types = {"md":"Duration",  "ml":"Local", "ms":"20sec surface wave", "mw": "Moment W-phase", "me":"Energy", "mi":"Integrated p-wave", "mb":"Short-period body wave", "mlg": "Short-period surface wave"}
		types.each do |key, value|
			MagType.create(symbol: key, label: value)
		end
		puts "Type load was completed"
	end
end
