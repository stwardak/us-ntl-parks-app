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
      puts "Debug: Response class is #{response.class}" #debug line
      
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


#   # Rake task for fetching images
#   desc "Fetch images data for each park"
#   task images: :environment do
#     service = NationalParksService.new
#     Park.find_each do |park|
#       images_data = service.fetch_images(park_code: park.parkCode)
      
#       if images_data.blank? || images_data['data'].blank?
#         puts "No images found for park: #{park.fullName}"
#         next
#       end

#       images_data['data'].each do |image_data|
#         park.images.find_or_create_by(url: image_data['url']) do |image|
#           image.api_id = image_data['id']
#           image.credit = image_data['credit']
#           image.altText = image_data['altText']
#           image.title = image_data['title']
#           image.caption = image_data['caption']
#         end
#       end


#       puts "Fetched and saved images for park: #{park.fullName}"
#     end
#   end


# namespace :fetch do
#   desc "Fetch a single page of parks data from National Parks API for debugging"
#   task debug_fetch_parks: :environment do
#     service = NationalParksService.new
#     page = 1 # Fetch the first page
#     limit = 50 # Limit to 50 records, adjust as necessary

#     puts "Attempting to fetch a single page of parks data..."
#     response = service.parks(page: page, limit: limit)

#     if response.is_a?(Hash) && response.key?('data')
#       puts "Successfully fetched parks data:"
#       puts response['data'].map { |park| park['fullName'] }.join(", ")
#     else
#       puts "Failed to fetch parks data or unexpected response format."
#     end
#   end
# end