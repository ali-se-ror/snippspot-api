json.id spot.id
json.title spot.title
json.description spot.description
json.location spot.location
json.price spot.price
json.rating spot.spot_rating
json.spot_images spot.spot_images.map { |spot_image| spot_image.present? ? spot_image.blob.url : '' }
json.reviews_count spot.reviews.present? ? spot.reviews.count : 0
json.average_rating spot.reviews.present? ? spot.reviews.average(:rating).round(1) : 0
