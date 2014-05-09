require 'json'
require 'open-uri'
require 'geocoder'
require_relative 'arduino'

ip = open( 'http://jsonip.com/ ' ){ |s| JSON::parse( s.string())['ip'] }


decoder = Geocoder::Lookup.get :freegeoip
result = decoder.search(ip).first

lat = result.data["latitude"]
lon = result.data["longitude"]

uri = URI.parse("http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&mode=json&units=imperial")
current = JSON::parse(uri.read)

city_name =  current["name"]
current_temp = current["main"]["temp"]


a = Arduino.new
inside = a.get_data
a.close

humidity = inside[0]
temp = ((inside[1].to_f * 9) / 5) + 32

puts "Current IP: #{ip}"
puts "Location: #{lat} #{lon}"
puts "City: #{city_name}"

puts "Outside Temp: #{current_temp} deg"

puts "Inside Humidity: #{humidity}%"
puts "Inside Temp: #{temp} deg"
