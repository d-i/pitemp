require 'json'
require 'open-uri'
require 'geocoder'

ip = open( 'http://jsonip.com/ ' ){ |s| JSON::parse( s.string())['ip'] }

puts ip

decoder = Geocoder::Lookup.get :freegeoip
result = decoder.search(ip).first

lat = result.data["latitude"]
lon = result.data["longitude"]

uri = URI.parse("http://api.openweathermap.org/data/2.5/weather?lat=#{lat}&lon=#{lon}&mode=json&units=imperial")
current = JSON::parse(uri.read)

city_name =  current["name"]
current_temp = current["main"]["temp"]

puts city_name
puts current_temp

