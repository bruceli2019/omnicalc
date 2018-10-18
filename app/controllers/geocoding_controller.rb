require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords
    @street_address = params.fetch("user_street_address")
    sanitized_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A sanitized version of the street address, with spaces and other illegal
    #   characters removed, is in the string sanitized_street_address.
    # ==========================================================================

    # we get the URL of place where the longtitude and latitude are stored
    url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{sanitized_street_address}&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78"
    
    #first we read the data
    raw_data = open(url).read
    
    #then we parse data into usable chunks
    parsed_data = JSON.parse(raw_data)
    
    #parsed data is now in hash form -- we want to get lng and lat
    
    #note that these keys are strings, not symbols -- hence why we use strings in summoning these values
    results_arr = parsed_data["results"]
    
    #observe that results is an array of one thing
    results = results_arr[0]
    
    geometry = results["geometry"]
    
    location = geometry["location"]

    lat = location["lat"]
    lng = location["lng"]
        
    #more concise way of writing it: parsed_data.dig("results", 0, "geometry", "location", "lng")
    
    @latitude = lat

    @longitude = lng

    render("geocoding_templates/street_to_coords.html.erb")
  end

  def street_to_coords_form
    render("geocoding_templates/street_to_coords_form.html.erb")
  end
end
