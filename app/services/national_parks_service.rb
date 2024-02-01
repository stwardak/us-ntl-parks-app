require 'http'

class NationalParksService
  BASE_URI = 'https://developer.nps.gov/api/v1'

  def initialize
    @api_key = Rails.application.credentials.national_parks_api_key
  end

  def parks(page: 1, limit: 50)
    fetch_data(endpoint: "/parks", params: { start: (page - 1) * limit, limit: limit })
  end


  def fetch_images(park_code:)
    response = fetch_data(endpoint: "/parks", params: { parkCode: park_code, fields: 'images'})
    JSON.parse(response.body.to_s)
  end

  private


  def fetch_data(endpoint:, params:)
    url = "#{BASE_URI}#{endpoint}"
    response = HTTP.headers(accept: 'application/json')
      .get(url, params: params.merge(api_key: @api_key))
    response
  end

end



# method for fetching parks data
# def fetch_data(endpoint:, params:)
#   url = "#{BASE_URI}#{endpoint}"
#   response = HTTP.headers(accept: 'application/json')
#     .get(url, params: params.merge(api_key: @api_key))
#   response
# end