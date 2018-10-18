require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather
    @lat = params.fetch("user_latitude").strip
    @lng = params.fetch("user_longitude").strip

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    #first I need to get the url
    url = "https://api.darksky.net/forecast/446b31db964ce78081ecc2a40664d9e1/#{@lat},#{@lng}"
    
    #get the data
    raw_data = open(url).read
    
    #clean up the data
    parsed_data = JSON.parse(raw_data)

    #currently section of data -- everything is in hash, everything in curly braces is in hash, everything in square brackets is array
    currently = parsed_data["currently"]
    
    #minutely section of data
    minutely = parsed_data["minutely"]
    
    #hourly section of data
    hourly = parsed_data["hourly"]
    
    #daily section of data
    daily = parsed_data["daily"]

    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    @summary_of_next_several_hours = hourly["summary"]

    @summary_of_next_several_days = daily["summary"]

    render("forecast_templates/coords_to_weather.html.erb")
  end

  def coords_to_weather_form
    render("forecast_templates/coords_to_weather_form.html.erb")
  end
  
end
