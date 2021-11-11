class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
    before_action :update_allowed_parameters, if: :devise_controller?
    before_action :authenticate_request, if: :json_request
    before_action :authenticate_user!, unless: :json_request
    include Response
    include ExceptionHandler
    protect_from_forgery unless: -> { request.format.json? }
    private
    # Check for valid request token and return user
    def authenticate_request
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end
    def json_request
      request.format.json?
    end
    protected
    def update_allowed_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :photo, :bio, :posts_counter, :email, :password) }
      devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:name, :photo, :bio, :posts_counter, :email, :password,
                 :current_password)
    end
  end
end