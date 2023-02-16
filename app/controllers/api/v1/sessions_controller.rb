module Api
  module V1
    class SessionsController < Api::V1::ApiController
      before_action :authenticate_request, except: %i[login]
      def login
        @user = User.find_by_email(params[:email])
        return render json: { error: 'Invalid email or password' }, status: :not_found unless @user.present?

        user_authentication(@user)
      end

      def user_authentication(user)
        return render json: { error: 'Invalid email or password' }, status: :unauthorized unless user.authenticate(params[:email], params[:password])

        token = JsonWebToken.encode(user_id: user.id)
        time = Time.now + 24.hours.to_i
        render json: {
          user: UserSerializer.new(user),
          user_token: token, exp: time.strftime('%m-%d-%Y %H:%M')
        }, status: :ok
      end

      private

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
