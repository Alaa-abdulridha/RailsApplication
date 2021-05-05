class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #before_action :block_array_parameters

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def logged_in?
    !current_user.nil?
  end
  helper_method :logged_in?

  def sign_in(user)
    session[:user_id] = user.id
  end

  def cities
    render json: CS.cities(params[:state], :my).to_json
  end
  
      def block_array_parameters
      params.each do |key, value|
        if key != 'controller' && key != 'action'
          if params[key].is_a? Array
		    key = key.gsub(/\W/, "")
            render status: 403, json: JSON.pretty_generate({ error: "`#{key}` parameter can't be an array." })
          end
        end
      end
    end
end
