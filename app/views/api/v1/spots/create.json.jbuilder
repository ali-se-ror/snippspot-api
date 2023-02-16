json.spots do
  json.partial! 'api/v1/spots/show', spot: @spot
end
