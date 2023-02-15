module Api
  module V1
    class ApiController < ActionController::API
      include JsonWebToken

      def render_error_messages(object)
        render json: {
          message: object.errors.messages.map do |msg, desc|
                     "#{msg.to_s.capitalize.to_s.gsub('_', ' ')} #{desc[0]}"
                   end.join(', ')
        }, status: :unprocessable_entity
      end

      def jwt_key
        Rails.application.credentials.secret_key_base
      end

      def issue_token(user)
        JWT.encode({ user_id: user.id }, jwt_key, 'HS256')
      end

      def decoded_token
        JWT.decode(token, jwt_key, true, { algorithm: 'HS256' })
      rescue JWT::DecodeError
        [{ error: 'Invalid Token' }]
      end

      def token
        request.headers['Authorization']
      end

      def user_id
        decoded_token.first['user_id']
      end

      def current_user
        user ||= User.find_by(id: user_id)
      end

      def logged_in?
        !!current_user
      end

      def not_found
        render json: { error: 'Not_Found' }, status: :not_found
      end

      def authenticate_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          @decoded = JsonWebToken.decode(header)
          @current_user = User.find(@decoded[:user_id])
        rescue ActiveRecord::RecordNotFound => e
          render json: { error: e.message }, status: :unauthorized
        rescue JWT::DecodeError
          render json: { error: 'Invalid JWT Token' }, status: :unauthorized
        end
      end
    end
  end
end
