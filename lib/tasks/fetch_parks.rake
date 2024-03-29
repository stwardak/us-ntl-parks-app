namespace :fetch do

  # Rake task for fetching parks data
  desc "Fetch parks data from National Parks API"
  task parks: :environment do
    service = NationalParksService.new
    page = 1
    total_records = nil
    limit = 50

    loop do
      response = service.parks(page: page, limit: limit)
      
      if response.status.success?
        parsed_response = JSON.parse(response.body.to_s)
        total_records ||= parsed_response['total'].to_i
        puts "Fetching page #{page} with #{parsed_response['data'].size} records"


        break if parsed_response['data'].empty?

        parsed_response['data'].each do |park_data|
          park = Park.find_or_initialize_by(name: park_data['name'])
          park.api_id = park_data['id']
          park.fullName = park_data['fullName']
          park.description = park_data['description']
          park.states = park_data['states']
          park.designation = park_data['designation']
          park.directionsInfo = park_data['directionsInfo']
          park.directionsUrl = park_data['directionsUrl']
          park.latLong = park_data['latLong']
          park.latitude = park_data['latitude']
          park.longitude = park_data['longitude']
          park.parkCode = park_data['parkCode']
          park.relevanceScore = park_data['relevanceScore'] 
          park.url = park_data['url']
          park.weatherInfo = park_data['weatherInfo']
          
          if park.save
            puts "Successfully saved park: #{park.name}"
          else
            puts "Failed to save park: #{park.name}"
            puts "Errors: #{park.errors.full_messages.join(", ")}"
          end
        end
      else
        puts "Failed to fetch parks data: #{response.status}"
        break
      end

      break if Park.count >= total_records
      page += 1
    end
  end
end


namespace :fetch do
  desc "Fetch and save images for each park"
  task images: :environment do
    service = NationalParksService.new

    Park.find_each do |park|
      puts "Fetching images for #{park.name}..."
      park_data = service.fetch_images(park_code: park.parkCode)
      puts park_data.inspect # debug
      next unless park_data && park_data['data'] && park_data['data'].first['images']

      park_data['data'].first['images'].each do |image_data|
        image = park.images.find_or_initialize_by(url: image_data['url'])
        image.assign_attributes(
          credit: image_data['credit'],
          altText: image_data['altText'],
          title: image_data['title'],
          caption: image_data['caption'],
          api_id: park_data['id']
        )

        if image.save
          puts "Saved image: #{image.title}"
        else
          puts "Failed to save image: #{image.errors.full_messages.join(', ')}"
        end
      end
    end
  end
end