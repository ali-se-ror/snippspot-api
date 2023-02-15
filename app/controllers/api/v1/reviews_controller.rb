module Api
  module V1
    class ReviewsController < Api::V1::ApiController
      before_action :find_spot, only: %w[index create update]

      def index
        @reviews = @spot.reviews.all.reverse
        return render json: { message: 'No Reviews For This Spot' }, status: :not_found unless @reviews.present?

        render json: { review: @reviews }, status: :ok
      end

      def create
        @review = Review.create(review_params)
        render_error_messages(@review) unless @review.save

        @spot.update(spot_rating: @spot.reviews.average(:rating).round(1))
        render json: { review: @review }, status: :ok
      end

      def update
        @review = Review.find_by(id: params[:id])
        return render json: { message: 'Review Not Found' }, status: :bad_request unless @review.present?

        render_error_messages(@review) unless @review.update(review_params)

        render json: { review: @review }, status: :ok
      end

      private

      def review_params
        params.permit(:description, :spot_id, :rating)
      end

      def find_spot
        @spot = Spot.find_by(id: params[:spot_id])
        return render json: { message: 'Spot Not Found' }, status: :bad_request unless @spot.present?
      end
    end
  end
end
