json.spots_by_location @spots.each do |spot|
  json.partial! 'api/v1/spots/show', spot: spot
end