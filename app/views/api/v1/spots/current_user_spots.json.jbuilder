json.current_user_spots @spots.each do |single_spot|
  json.partial! 'api/v1/spots/show', spot: single_spot
end
