require 'http'

class NationalParksService
  BASE_URI = 'https://developer.nps.gov/api/v1'

  def initialize
    @api_key = Rails.application.credentials.national_parks_api_key
  end

  def parks(page: 1, limit: 50)
    url = "#{BASE_URI}/parks"
    response = HTTP.headers(accept: 'application/json')
      .get(url, params: { start: (page - 1) * limit, limit: limit, api_key: @api_key })
    response
  end
end