class UsersController < ApplicationController
	before_action :find_user, only: [:show, :edit, :update]
	before_action :current_user_check, only: [:edit, :update]

	def new
		if !logged_in?
			@user = User.new
		elsif logged_in?
			redirect_to "/", notice: "You already signed up!"
		end
	end

	def create
		user = User.new(user_params)
  		if user.save
    		session[:user_id] = user.id
    		flash[:success] = "Signed up successfully"
    		redirect_to '/'
  		else
  			# flash[:notice] = "Password confirmation doesn't match password"
  			respond_to do |format|
          		format.html { redirect_to '/sign_up' }
          		format.js 
        	end
    		
  		end
	end

	def show
		@post = Post.where(user_id: @user.id).order(created_at: :desc).page params[:page]
	end

	def edit
	end

	def update
		@user.update(user_params)
		flash[:success] = "Profile has been updated successfully!"
		redirect_to @user
	end

	private

	def find_user
		if @user = User.find_by(id: params[:id])
			return @user  
		else
			redirect_to "/", alert: "User does not exist!"
		end
	end

	def current_user_check
		if logged_in? and current_user.id != @user.id 
    		redirect_to "/", alert: "Hold it right there! You don't have the permission to access!"
    	elsif !logged_in?
    		redirect_to "/", alert: "Hold it right there! You don't have the permission to access!"
    	end
  	end

	def user_params
  		params.require(:user).permit(:name, :email, :role, :password, :password_confirmation)
	end
end
