require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather
    @street_address = params.fetch("user_street_address")
    sanitized_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A sanitized version of the street address, with spaces and other illegal
    #   characters removed, is in the string sanitized_street_address.
    # ==========================================================================

    #how can I summon functions from different files?
    
    #first I need the latitude and longtitude
    url_geo = "https://maps.googleapis.com/maps/api/geocode/json?address=#{sanitized_street_address}&key=AIzaSyA5qwIlcKjijP_Ptmv46mk4cCjuWhSzS78"
    
    #because I wrote out how I did this in geocoding, I will take a shortcut
    
    raw_data_geo = open(url_geo).read
    
    parsed_data_geo = JSON.parse(raw_data_geo)
    
    latitude = parsed_data_geo["results"][0]["geometry"]["location"]["lat"]
    longtitude = parsed_data_geo["results"][0]["geometry"]["location"]["lng"]
    
    #I need to get the url for weather
    url_weather = "https://api.darksky.net/forecast/446b31db964ce78081ecc2a40664d9e1/#{latitude},#{longtitude}"
    
    #get the data
    raw_data_weather = open(url_weather).read
    
    #clean up the data
    parsed_data_weather = JSON.parse(raw_data_weather)

    #currently section of data
    currently = parsed_data_weather["currently"]
    
    #minutely section of data
    minutely = parsed_data_weather["minutely"]
    
    #hourly section of data
    hourly = parsed_data_weather["hourly"]
    
    #daily section of data
    daily = parsed_data_weather["daily"]
    
    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    @summary_of_next_several_hours = hourly["summary"]

    @summary_of_next_several_days = daily["summary"]

    render("meteorologist_templates/street_to_weather.html.erb")
  end

  def street_to_weather_form
    render("meteorologist_templates/street_to_weather_form.html.erb")
  end
end
