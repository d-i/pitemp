require 'json'
require 'open-uri'
require 'geocoder'
require_relative 'arduino'

ip = open( 'http://jsonip.com/ ' ){ |s| JSON::parse( s.string())['ip'] }

uri = URI.parse("http://ip-api.com/json/#{ip}")
geoloc = JSON::parse(uri.read)

lat = geoloc["lat"]
lon = geoloc["lon"]

ip_city = [geoloc["city"], geoloc["region"]].join(", ")

uri = URI.parse("http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&mode=json&units=imperial")
current = JSON::parse(uri.read)

current_temp = current["main"]["temp"]
current_humidity = current["main"]["humidity"]

a = Arduino.new
inside = a.get_data
a.close

humidity = inside[0]
temp = ((inside[1].to_f * 9) / 5) + 32

puts "Current IP: #{ip}"
puts "Location: #{ip_city}: #{lat}, #{lon}"

puts "Outside Temp: #{current_temp} deg"
puts "Outside Humidity: #{current_humidity} %"

puts "Inside Temp: #{temp} deg"
puts "Inside Humidity: #{humidity}%"
