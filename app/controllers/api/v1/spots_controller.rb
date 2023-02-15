class Api::V1::SpotsController < Api::V1::ApiController
  before_action :authenticate_request, only: %w[create update]
  before_action :find_spot, only: %w[update show]
  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  def index
    @spots = Spot.order('price DESC')
  end

  def show
    return render json: { message: 'Spot Not Found' }, status: :not_found unless @spot.present?
  end

  def create
    @spot = Spot.create(spot_params)
    @spot.user_id = current_user.id
    render_error_messages(@spot) unless @spot.save
  end

  def update
    render_error_messages(@spot) unless @spot.update(spot_params)

    render json: { spot: @spot }, status: :ok
  end

  def locations
    @locations = Spot.distinct.pluck(:location)
    return render json: { message: 'No Location Present' }, status: :not_found unless @locations.present?

    render json: { locations: @locations }, status: :ok
  end

  def spots_by_location
    @spots = Spot.where(location: params[:location])
    render json: { message: 'No Spots For This Location' }, status: :not_found unless @spots.present?
  end

  def current_user_spots
    @spots = Spot.where(user_id: current_user.id)
    render json: { message: 'No Spots Present' }, status: :not_found unless @spots.present?
  end

  private

  def spot_params
    params.permit(:title, :description, :price, :location, spot_images: [])
  end

  def find_spot
    @spot = Spot.find_by(id: params[:id])
    return render json: { message: 'Spot Not Found' }, status: :bad_request unless @spot.present?
  end
end