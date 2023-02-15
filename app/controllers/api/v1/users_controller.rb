module Api
  module V1
    class UsersController < Api::V1::ApiController
      before_action :authenticate_request, except: %i[create]
      before_action :find_user, only: %i[show update]

      def index
        @users = User.all
        render json: @users, status: :ok
      end

      def show
        return render json: { error: 'User not found' }, status: :not_found unless @user.present?

        render json: { user: UserSerializer.new(@user), user_token: token }, status: :ok
      end

      def create
        @user = User.new(user_params)
        if @user.save
          token = issue_token(@user)
          render json: { user: UserSerializer.new(@user), user_token: token }, status: :ok
        elsif @user.errors.full_messages
          render json: { error: @user.errors.full_messages }
        else
          render json: { error: 'User could not be created. Please try again.' }, status: :bad_request
        end
      end

      def update
        if @user.update(user_params)
          render json: { user: UserSerializer.new(@user), user_token: token }, status: :ok
        else
          render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:email, :password)
      end

      def find_user
        @user = User.find_by_id(params[:id])
      end
    end
  end
end
