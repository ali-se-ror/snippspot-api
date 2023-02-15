json.spots do
  # render json.partial'api/v1/spots/show', spot: @spot
  json.partial! 'api/v1/spots/show', spot: @spot
end